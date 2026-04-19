// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html' as html;
import 'dart:ui_web' as ui;
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

/// Modal يعرض الـ widget في popup كبير
class WidgetModal extends StatefulWidget {
  final String title;
  final String widgetType;
  final String lang;

  const WidgetModal({
    super.key,
    required this.title,
    required this.widgetType,
    required this.lang,
  });

  static void show(BuildContext context, {
    required String title,
    required String widgetType,
    required String lang,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => WidgetModal(
          title: title,
          widgetType: widgetType,
          lang: lang,
        ),
      ),
    );
  }

  @override
  State<WidgetModal> createState() => _WidgetModalState();
}

class _WidgetModalState extends State<WidgetModal> {
  html.IFrameElement? _iframe;
  final String _viewId = 'modal-widget-${DateTime.now().millisecondsSinceEpoch}';
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _createIframe();
    _setupMessageListener();
  }

  void _createIframe() {
    _iframe = html.IFrameElement()
      ..style.border = 'none'
      ..style.width = '100%'
      ..style.height = '100%'
      ..style.display = 'block'
      ..style.touchAction = 'pan-y pan-x'
      ..allowFullscreen = true
      ..src = '${html.window.location.origin}/widget.html?type=${widget.widgetType}&lang=${widget.lang}&id=$_viewId';

    try {
      ui.platformViewRegistry.registerViewFactory(_viewId, (int id) => _iframe!);
    } catch (_) {
      // already registered
    }
  }

  void _setupMessageListener() {
    html.window.onMessage.listen((event) {
      if (event.data is Map && event.data['type'] == 'scroll') {
        final deltaY = event.data['deltaY'] as num?;
        if (deltaY != null && _scrollController.hasClients) {
          final newOffset = _scrollController.offset + deltaY;
          _scrollController.jumpTo(newOffset.clamp(
            _scrollController.position.minScrollExtent,
            _scrollController.position.maxScrollExtent,
          ));
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8FAFB),
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Color(0xFF1A1A1A)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A1A1A),
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 2,
          child: HtmlElementView(viewType: _viewId),
        ),
      ),
    );
  }
}
