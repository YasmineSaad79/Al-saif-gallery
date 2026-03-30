// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:async';
import 'dart:html' as html;
import 'dart:ui_web' as ui;
import 'dart:js_util' as js_util;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ── Global load queue: stagger loads to avoid hammering the CDN ─────────────
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
  // Desktop: 800ms stagger — fast enough to feel instant
  // Mobile: same, widgets are loaded lazily so fewer concurrent loads
  Future.delayed(const Duration(milliseconds: 800), _processQueue);
}
// ────────────────────────────────────────────────────────────────────────────

/// Wraps [ExternalScriptWidget] and only initializes the iframe
/// once the placeholder enters the viewport (lazy loading).
/// On mobile the iframe is KEPT ALIVE once loaded — never destroyed — to
/// prevent cache-miss reloads when the user scrolls back.
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

class _LazyExternalScriptWidgetState extends State<LazyExternalScriptWidget> {
  bool _show = false;
  bool _queued = false;
  final _key = GlobalKey();
  Timer? _visibilityTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkVisibility());
  }

  @override
  void dispose() {
    _visibilityTimer?.cancel();
    super.dispose();
  }

  bool _isNearViewport(BuildContext ctx) {
    final box = ctx.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return false;
    final pos = box.localToGlobal(Offset.zero);
    final screenH = MediaQuery.of(ctx).size.height;
    // Load when within 400px of viewport
    return pos.dy < screenH + 400 && pos.dy > -(widget.fallbackHeight + 400);
  }

  void _checkVisibility() {
    if (!mounted) return;

    final ctx = _key.currentContext;
    if (ctx == null) {
      _scheduleCheck(300);
      return;
    }

    final near = _isNearViewport(ctx);

    if (!_queued && near) {
      _queued = true;
      _enqueueLoad(() { if (mounted) setState(() => _show = true); });
      return; // once loaded, never destroy — fixes cache issue on mobile
    }

    if (!_show) _scheduleCheck(500);
  }

  void _scheduleCheck(int ms) {
    _visibilityTimer?.cancel();
    _visibilityTimer = Timer(Duration(milliseconds: ms), _checkVisibility);
  }

  @override
  Widget build(BuildContext context) {
    if (!_show) {
      return _SkeletonPlaceholder(key: _key, height: widget.fallbackHeight);
    }
    return _HoverWrapper(
      child: ExternalScriptWidget(
        key: ValueKey(widget.viewId),
        viewId: widget.viewId,
        widgetType: widget.widgetType,
        fallbackHeight: widget.fallbackHeight,
        lang: widget.lang,
      ),
    );
  }
}

class _HoverWrapper extends StatefulWidget {
  final Widget child;
  const _HoverWrapper({required this.child});

  @override
  State<_HoverWrapper> createState() => _HoverWrapperState();
}

class _HoverWrapperState extends State<_HoverWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _shadow;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _shadow = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) { setState(() => _hovered = true); _ctrl.forward(); },
      onExit:  (_) { setState(() => _hovered = false); _ctrl.reverse(); },
      child: AnimatedBuilder(
        animation: _shadow,
        builder: (_, child) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFC62030).withOpacity(0.08 * _shadow.value),
                blurRadius: 16 * _shadow.value,
                offset: Offset(0, 4 * _shadow.value),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.04 * _shadow.value),
                blurRadius: 8 * _shadow.value,
                offset: Offset(0, 2 * _shadow.value),
              ),
            ],
          ),
          child: child,
        ),
        child: widget.child,
      ),
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
  html.DivElement? _wrapper;
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
      ..style.pointerEvents = 'auto'
      ..style.transition = 'box-shadow 0.2s ease'
      ..srcdoc = _buildHtml();

    // Wrap iframe in hover div
    _wrapper = html.DivElement()
      ..className = 'iframe-hover-wrapper'
      ..style.width = '100%'
      ..style.height = '100%'
      ..style.transition = 'box-shadow 0.25s ease'
      ..style.borderRadius = '8px'
      ..append(_iframe!);

    _messageListener = (event) {
      final msg = (event as html.MessageEvent).data;
      if (msg is Map) {
        final id = msg['id'];
        final type = msg['type'];

        // Height reporting
        if (type == 'widget-height' && id == widget.viewId) {
          final h = (msg['height'] as num).toDouble();
          if (h > 20) {
            _pendingHeight = h;
            _debounce?.cancel();
            _debounce = Timer(const Duration(milliseconds: 300), () {
              if (mounted && (_pendingHeight - _height).abs() > 2) {
                setState(() => _height = _pendingHeight);
              }
            });
          }
        }

        // Hover shadow effect
        if (type == 'iframe-hover' && id == widget.viewId) {
          final hovered = msg['hovered'] == true;
          _wrapper?.style.boxShadow = hovered
              ? '0 4px 24px rgba(198,32,48,0.13), 0 2px 8px rgba(0,0,0,0.07)'
              : 'none';
        }

        // ✅ FIX: Forward vertical scroll from iframe to Flutter page
        if (type == 'iframe-wheel') {
          final dy = (msg['deltaY'] as num?)?.toDouble() ?? 0;
          final glassPane = html.document.querySelector('flt-glass-pane');
          final target = glassPane ?? html.window as dynamic;
          js_util.callMethod(target, 'dispatchEvent', [
            js_util.callConstructor(
              js_util.getProperty(html.window, 'WheelEvent') as Object,
              ['wheel', js_util.jsify({'deltaY': dy, 'deltaMode': 0, 'bubbles': true, 'cancelable': true})],
            ),
          ]);
        }
      }
    };
    html.window.addEventListener('message', _messageListener!);

    try {
      ui.platformViewRegistry.registerViewFactory(
        widget.viewId,
        (int id) => _wrapper!,
      );
    } catch (_) {}
  }

  String _buildHtml() {
    return '''<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
<style>
  * { box-sizing: border-box; margin: 0; padding: 0; }
  html {
    overflow-x: auto;
    overflow-y: hidden;
    background: #ffffff;
    width: 100%;
    -webkit-overflow-scrolling: touch;
  }
  body {
    overflow-x: auto;
    overflow-y: hidden;
    background: #ffffff;
    margin: 0; padding: 0;
    width: 100%;
    -webkit-overflow-scrolling: touch;
    touch-action: pan-x pan-y;
  }
  body > div {
    margin: 0 !important;
    padding: 0 !important;
    width: 100% !important;
    max-width: 100% !important;
  }
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

  // ✅ Forward vertical wheel to Flutter so page scrolls normally
  window.addEventListener('wheel', function(e) {
    window.parent.postMessage({ type: 'iframe-wheel', id: ID, deltaY: e.deltaY }, '*');
  }, { passive: true });

  // Hover events - send to parent to apply shadow
  document.documentElement.addEventListener('mouseenter', function() {
    window.parent.postMessage({ type: 'iframe-hover', id: ID, hovered: true }, '*');
  });
  document.documentElement.addEventListener('mouseleave', function() {
    window.parent.postMessage({ type: 'iframe-hover', id: ID, hovered: false }, '*');
  });

  // ✅ Forward vertical touch scroll to Flutter ONLY when gesture is vertical
  // Horizontal gestures are handled natively by the browser (pan-x)
  var touchStartX = 0;
  var touchStartY = 0;
  var scrollDirection = null; // 'v' | 'h' | null

  window.addEventListener('touchstart', function(e) {
    touchStartX = e.touches[0].clientX;
    touchStartY = e.touches[0].clientY;
    scrollDirection = null;
  }, { passive: true });

  window.addEventListener('touchmove', function(e) {
    var dx = Math.abs(e.touches[0].clientX - touchStartX);
    var dy = e.touches[0].clientY - touchStartY;
    var absDy = Math.abs(dy);

    // Lock direction on first significant move
    if (scrollDirection === null && (dx > 5 || absDy > 5)) {
      scrollDirection = dx > absDy ? 'h' : 'v';
    }

    // Only forward to Flutter if vertical gesture
    if (scrollDirection === 'v') {
      var delta = touchStartY - e.touches[0].clientY;
      touchStartY = e.touches[0].clientY;
      window.parent.postMessage({ type: 'iframe-wheel', id: ID, deltaY: delta }, '*');
    }
    // Horizontal: let browser handle it natively (pan-x)
  }, { passive: true });

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
    }, 200);
  }

  new MutationObserver(function() {
    reportDebounced();
    document.querySelectorAll('iframe').forEach(function(f) {
      if (!f._w) {
        f._w = true;
        f.addEventListener('load', function() {
          setTimeout(reportDebounced, 300);
          setTimeout(reportDebounced, 1000);
          setTimeout(reportDebounced, 2500);
        });
      }
    });
  }).observe(document.body, { childList: true, subtree: true, attributes: true });

  if (window.ResizeObserver) {
    new ResizeObserver(reportDebounced).observe(document.body);
  }

  document.addEventListener('click', function() {
    setTimeout(reportDebounced, 400);
    setTimeout(reportDebounced, 1200);
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
    [500, 1500, 3000, 6000].forEach(function(t) {
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




