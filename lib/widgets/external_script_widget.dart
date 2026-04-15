// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:async';
import 'dart:html' as html;
import 'dart:ui_web' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../main.dart';

// ── Global load queue: max 1 iframe loaded every 1.5s ──────────────────────
final List<VoidCallback> _loadQueue = [];
bool _queueRunning = false;

void _enqueueLoad(VoidCallback load) {
  _loadQueue.add(load);
  if (!_queueRunning) _processQueue();
}

void _processQueue() {
  if (_loadQueue.isEmpty) { _queueRunning = false; return; }
  _queueRunning = true;
  final next = _loadQueue.removeAt(0);
  next();
  Future.delayed(const Duration(milliseconds: 1500), _processQueue);
}

/// Interface عام عشان نقدر نستدعي loadNow من ملفات ثانية
abstract class LazyLoadable {
  void loadNow();
}

/// تعطيل/تفعيل pointer events على كل الـ iframes في الصفحة
void setAllIframesPointerEvents(bool enabled) {
  final iframes = html.document.querySelectorAll('iframe');
  for (final el in iframes) {
    (el as html.HtmlElement).style.pointerEvents = enabled ? 'auto' : 'none';
  }
}
// ────────────────────────────────────────────────────────────────────────────

/// Wraps [ExternalScriptWidget] and only initializes the iframe
/// once the placeholder enters the viewport (lazy loading).
class LazyExternalScriptWidget extends StatefulWidget {
  final String viewId;
  final String widgetType;
  final double fallbackHeight;
  final String lang;

  const LazyExternalScriptWidget({
    super.key,
    required this.viewId,
    required this.widgetType,
    this.fallbackHeight = 200,
    this.lang = 'en',
  });

  @override
  State<LazyExternalScriptWidget> createState() => _LazyExternalScriptWidgetState();
}

class _LazyExternalScriptWidgetState extends State<LazyExternalScriptWidget> implements LazyLoadable {
  bool _visible = false;
  bool _queued = false;
  final _key = GlobalKey();

  // public method للاستدعاء من الخارج
  // ignore: library_private_types_in_public_api
  void loadNow() {
    if (_queued || _visible) return;
    _queued = true;
    _enqueueLoad(() {
      if (mounted) setState(() => _visible = true);
    });
  }

  @override
  void initState() {
    super.initState();
    // لا تحمل تلقائياً، انتظر السكرول اليدوي أو الطلب من الـ dropdown
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkVisibility());
  }

  void _checkVisibility() {
    if (!mounted || _queued) return;
    final ctx = _key.currentContext;
    if (ctx == null) {
      Future.delayed(const Duration(milliseconds: 400), _checkVisibility);
      return;
    }
    final box = ctx.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) {
      Future.delayed(const Duration(milliseconds: 400), _checkVisibility);
      return;
    }
    final pos = box.localToGlobal(Offset.zero);
    final screenH = MediaQuery.of(ctx).size.height;
    // حمّل بس لما تكون على الشاشة فعلاً (بدون buffer)
    if (pos.dy >= 0 && pos.dy < screenH) {
      _queued = true;
      _enqueueLoad(() {
        if (mounted) setState(() => _visible = true);
      });
    } else {
      Future.delayed(const Duration(milliseconds: 800), _checkVisibility);
    }
  }

  /// يُستدعى من الخارج عشان يحمل الـ widget فوراً (من الـ dropdown)
  // (handled above in loadNow)

  @override
  Widget build(BuildContext context) {
    if (_visible) {
      return ExternalScriptWidget(
        viewId: widget.viewId,
        widgetType: widget.widgetType,
        fallbackHeight: widget.fallbackHeight,
        lang: widget.lang,
      );
    }
    return _SkeletonPlaceholder(
      key: _key,
      height: widget.fallbackHeight,
    );
  }
}

class _SkeletonPlaceholder extends StatefulWidget {
  final double height;
  const _SkeletonPlaceholder({super.key, required this.height});

  @override
  State<_SkeletonPlaceholder> createState() => _SkeletonPlaceholderState();
}

class _SkeletonPlaceholderState extends State<_SkeletonPlaceholder>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))
      ..repeat(reverse: true);
    _anim = Tween<double>(begin: 0.3, end: 0.7).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) => Container(
        width: double.infinity,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color.lerp(const Color(0xFFE5E7EB), const Color(0xFFF3F4F6), _anim.value),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _bar(0.4),
            const SizedBox(height: 12),
            _bar(0.7),
            const SizedBox(height: 8),
            _bar(0.6),
            const SizedBox(height: 8),
            _bar(0.5),
          ],
        ),
      ),
    );
  }

  Widget _bar(double widthFactor) => FractionallySizedBox(
        widthFactor: widthFactor,
        child: Container(
          height: 12,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.6),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      );
}

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
  bool _hovered = false;

  void _setPointerEvents(bool enabled) {
    _iframe?.style.pointerEvents = enabled ? 'auto' : 'none';
    if (_hovered != enabled) {
      setState(() => _hovered = enabled);
    }
  }

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) return;

    _height = widget.fallbackHeight;

    _iframe = html.IFrameElement()
      ..style.border = 'none'
      ..style.width = '100%'
      ..style.height = '100%'
      ..style.pointerEvents = 'auto'
      ..srcdoc = _buildHtml();

    _messageListener = (event) {
      final msg = (event as html.MessageEvent).data;
      if (msg is Map &&
          msg['type'] == 'widget-height' &&
          msg['id'] == widget.viewId) {
        final h = (msg['height'] as num).toDouble();
        if (h > 20) {
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
  // Forward wheel events to parent Flutter page
  window.addEventListener('wheel', function(e) {
    window.parent.postMessage({ type: 'iframe-wheel', deltaY: e.deltaY }, '*');
  }, { passive: true });

  // Forward touch scroll to parent Flutter page
  var _touchStartY = 0;
  window.addEventListener('touchstart', function(e) {
    _touchStartY = e.touches[0].clientY;
  }, { passive: true });
  window.addEventListener('touchmove', function(e) {
    var dy = _touchStartY - e.touches[0].clientY;
    _touchStartY = e.touches[0].clientY;
    window.parent.postMessage({ type: 'iframe-wheel', deltaY: dy }, '*');
  }, { passive: true });

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
