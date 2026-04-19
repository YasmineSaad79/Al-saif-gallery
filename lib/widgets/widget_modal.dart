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

  @override
  void initState() {
    super.initState();
    _createIframe();
  }

  void _createIframe() {
    _iframe = html.IFrameElement()
      ..style.border = 'none'
      ..style.width = '100%'
      ..style.height = '100%'
      ..style.display = 'block'
      ..allowFullscreen = true
      ..src = '${html.window.location.origin}/widget.html?type=${widget.widgetType}&lang=${widget.lang}&id=$_viewId';

    try {
      ui.platformViewRegistry.registerViewFactory(_viewId, (int id) => _iframe!);
    } catch (_) {
      // already registered
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final appBarHeight = AppBar().preferredSize.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final availableHeight = screenHeight - appBarHeight - statusBarHeight;

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
      body: Container(
        height: availableHeight,
        width: double.infinity,
        color: Colors.white,
        child: HtmlElementView(viewType: _viewId),
      ),
    );
  }
}
