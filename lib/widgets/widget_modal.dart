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
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.7),
      builder: (context) => WidgetModal(
        title: title,
        widgetType: widgetType,
        lang: lang,
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
      ..src = '${html.window.location.origin}/widget.html?type=${widget.widgetType}&lang=${widget.lang}&id=$_viewId';

    try {
      ui.platformViewRegistry.registerViewFactory(_viewId, (int id) => _iframe!);
    } catch (_) {
      // already registered
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 40,
        vertical: isMobile ? 20 : 40,
      ),
      child: Container(
        width: double.infinity,
        height: size.height * (isMobile ? 0.85 : 0.9),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFB),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                border: Border(
                  bottom: BorderSide(color: const Color(0xFFE5E7EB)),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                    color: const Color(0xFF6B7280),
                    tooltip: 'Close',
                  ),
                ],
              ),
            ),
            // Content
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                child: HtmlElementView(viewType: _viewId),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
