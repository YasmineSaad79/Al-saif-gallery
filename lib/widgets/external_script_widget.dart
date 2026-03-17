// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:async';
import 'dart:html' as html;
import 'dart:ui_web' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ExternalScriptWidget extends StatefulWidget {
  final String viewId;
  final String widgetType;
  final double fallbackHeight;
  final String lang;

  const ExternalScriptWidget({
    super.key,
    required this.viewId,
    required this.widgetType,
    this.fallbackHeight = 200,
    this.lang = 'en',
  });

  @override
  State<ExternalScriptWidget> createState() => _ExternalScriptWidgetState();
}

class _ExternalScriptWidgetState extends State<ExternalScriptWidget> {
  html.IFrameElement? _iframe;
  double _height = 0;
  html.EventListener? _messageListener;
  Timer? _debounce;
  double _pendingHeight = 0;

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) return;

    _height = widget.fallbackHeight;

    _iframe = html.IFrameElement()
      ..style.border = 'none'
      ..style.width = '100%'
      ..style.height = '100%'
      ..srcdoc = _buildHtml();

    _messageListener = (event) {
      final msg = (event as html.MessageEvent).data;
      if (msg is Map &&
          msg['type'] == 'widget-height' &&
          msg['id'] == widget.viewId) {
        final h = (msg['height'] as num).toDouble();
        if (h > 20) {
          // debounce: انتظر 400ms بعد آخر رسالة قبل التطبيق
          _pendingHeight = h;
          _debounce?.cancel();
          _debounce = Timer(const Duration(milliseconds: 400), () {
            if (mounted && (_pendingHeight - _height).abs() > 2) {
              setState(() => _height = _pendingHeight);
            }
          });
        }
      }
    };
    html.window.addEventListener('message', _messageListener!);

    try {
      ui.platformViewRegistry.registerViewFactory(
        widget.viewId,
        (int id) => _iframe!,
      );
    } catch (_) {}
  }

  String _buildHtml() {
    return '''<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
  * { box-sizing: border-box; margin: 0; padding: 0; }
  html, body { overflow: hidden; background: #ffffff; margin: 0; padding: 0; }
  body > div { margin: 0 !important; padding: 0 !important; }
</style>
<script src="https://irp.atnmo.com/v2/widget/widget-loader.js"></script>
</head>
<body>
<div id="${widget.widgetType}-widget"></div>
<script>
(function() {
  var ID = '${widget.viewId}';
  var debounceTimer = null;
  var lastSent = 0;

  function getTrueHeight() {
    var h = Math.max(
      document.body.scrollHeight,
      document.body.offsetHeight,
      document.documentElement.scrollHeight,
      document.documentElement.offsetHeight
    );
    var frames = document.querySelectorAll('iframe');
    for (var j = 0; j < frames.length; j++) {
      var fRect = frames[j].getBoundingClientRect();
      h = Math.max(h, fRect.bottom + window.pageYOffset);
      try {
        var fDoc = frames[j].contentDocument || frames[j].contentWindow.document;
        h = Math.max(h, fDoc.body.scrollHeight + fRect.top + window.pageYOffset);
      } catch(e) {}
    }
    return Math.ceil(h) + 4;
  }

  // debounce في الـ JS أيضاً - لا يرسل إلا بعد استقرار الارتفاع
  function reportDebounced() {
    clearTimeout(debounceTimer);
    debounceTimer = setTimeout(function() {
      var h = getTrueHeight();
      if (h > 20 && Math.abs(h - lastSent) > 2) {
        lastSent = h;
        window.parent.postMessage({ type: 'widget-height', id: ID, height: h }, '*');
      }
    }, 300);
  }

  new MutationObserver(function() {
    reportDebounced();
    document.querySelectorAll('iframe').forEach(function(f) {
      if (!f._w) {
        f._w = true;
        f.addEventListener('load', function() {
          setTimeout(reportDebounced, 500);
          setTimeout(reportDebounced, 1500);
          setTimeout(reportDebounced, 3000);
        });
      }
    });
  }).observe(document.body, { childList: true, subtree: true, attributes: true });

  if (window.ResizeObserver) {
    new ResizeObserver(reportDebounced).observe(document.body);
  }

  document.addEventListener('click', function() {
    setTimeout(reportDebounced, 500);
    setTimeout(reportDebounced, 1500);
  });

  window.addEventListener('load', function() {
    if (typeof loadWidget === 'function') {
      loadWidget(
        '${widget.widgetType}',
        "5be9c146-613e-4141-a351-1f5e13fc5513",
        "${widget.lang}",
        "81a06c05-1a48-4d1b-8dbd-bcf60a76730f",
        "v2"
      );
    }
    [1000, 2000, 4000, 7000, 12000].forEach(function(t) {
      setTimeout(reportDebounced, t);
    });
  });
})();
</script>
</body>
</html>''';
  }

  @override
  void dispose() {
    _debounce?.cancel();
    if (_messageListener != null) {
      html.window.removeEventListener('message', _messageListener!);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) return const SizedBox.shrink();

    return SizedBox(
      width: double.infinity,
      height: _height,
      child: HtmlElementView(viewType: widget.viewId),
    );
  }
}
