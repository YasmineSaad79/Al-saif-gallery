// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:async';
import 'dart:html' as html;
import 'dart:js_util' as js_util;
import 'dart:ui_web' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../utils/app_colors.dart';

// ── Global load queue: max 1 iframe loaded every 1.5s ──────────────────────
final List<VoidCallback> _loadQueue = [];
bool _queueRunning = false;

void _enqueueLoad(VoidCallback load, {bool priority = false}) {
  if (priority) {
    // تحميل فوري بدون انتظار (للـ Stock Ticker)
    load();
  } else {
    _loadQueue.add(load);
    if (!_queueRunning) _processQueue();
  }
}

void _processQueue() {
  if (_loadQueue.isEmpty) { _queueRunning = false; return; }
  _queueRunning = true;
  final next = _loadQueue.removeAt(0);
  next();
  // تحميل فوري بدون تأخير
  Future.delayed(const Duration(milliseconds: 0), _processQueue);
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

/// حذف كل الـ iframes القديمة من الـ DOM
void removeAllOldIframes() {
  final iframes = html.document.querySelectorAll('iframe');
  for (final el in iframes) {
    // احذف الـ iframes اللي pointer-events تبعها auto (يعني كانت مفعّلة)
    if ((el as html.HtmlElement).style.pointerEvents == 'auto') {
      el.remove();
    }
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
  final bool priority; // للتحميل الفوري
  final Widget? customPlaceholder; // placeholder مخصص

  const LazyExternalScriptWidget({
    super.key,
    required this.viewId,
    required this.widgetType,
    this.fallbackHeight = 200,
    this.lang = 'en',
    this.priority = false,
    this.customPlaceholder,
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
    
    // إذا كان priority (مثل Stock Ticker)، حمّل بعد تأخير بسيط لإظهار الـ loading
    if (widget.priority) {
      _queued = true;
      Future.delayed(const Duration(milliseconds: 600), () {
        _enqueueLoad(() {
          if (mounted) setState(() => _visible = true);
        }, priority: true);
      });
      return;
    }
    
    // حمّل الويدجتات الأولى فوراً، والباقي لما يظهروا
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ctx = _key.currentContext;
      if (ctx == null) return;
      
      final box = ctx.findRenderObject() as RenderBox?;
      if (box == null || !box.hasSize) return;
      
      final pos = box.localToGlobal(Offset.zero);
      final screenH = MediaQuery.of(ctx).size.height;
      
      // حمّل فوراً إذا كان في أول 4 شاشات (زيادة من 3 إلى 4)
      if (pos.dy < screenH * 4) {
        _queued = true;
        _enqueueLoad(() {
          if (mounted) setState(() => _visible = true);
        });
      } else {
        // الباقي انتظر لما يظهروا
        _checkVisibility();
      }
    });
  }

  void _checkVisibility() {
    if (!mounted || _queued) return;
    final ctx = _key.currentContext;
    if (ctx == null) {
      Future.delayed(const Duration(milliseconds: 250), _checkVisibility);
      return;
    }
    final box = ctx.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) {
      Future.delayed(const Duration(milliseconds: 250), _checkVisibility);
      return;
    }
    final pos = box.localToGlobal(Offset.zero);
    final screenH = MediaQuery.of(ctx).size.height;
    
    // حمّل لما يكون قريب من الشاشة (2.5 شاشات)
    if (pos.dy >= 0 && pos.dy < screenH * 2.5) {
      _queued = true;
      _enqueueLoad(() {
        if (mounted) setState(() => _visible = true);
      });
    } else {
      Future.delayed(const Duration(milliseconds: 500), _checkVisibility);
    }
  }

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
    // استخدم placeholder مخصص إذا كان موجود
    if (widget.customPlaceholder != null) {
      return Container(
        key: _key,
        child: widget.customPlaceholder!,
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
  final bool priority;
  final bool showLoadingIndicator; // إظهار loading indicator
  final bool showBorder; // إظهار البوردر

  const ExternalScriptWidget({
    super.key,
    required this.viewId,
    required this.widgetType,
    this.fallbackHeight = 200,
    this.lang = 'en',
    this.priority = false,
    this.showLoadingIndicator = false,
    this.showBorder = true, // البوردر مفعّل افتراضياً
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
  Timer? _enableTimer;
  bool _isScrolling = false;
  bool _isLoading = true; // حالة التحميل
  late String _uniqueViewId; // viewId فريد لكل instance

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) return;

    _height = widget.fallbackHeight;
    
    // اعمل viewId فريد باستخدام timestamp
    _uniqueViewId = '${widget.viewId}-${DateTime.now().millisecondsSinceEpoch}';

    // احذف أي iframe قديم بنفس الـ viewId الأساسي
    final oldIframes = html.document.querySelectorAll('iframe');
    for (final el in oldIframes) {
      final iframe = el as html.IFrameElement;
      // احذف الـ iframes اللي في الـ platform view بنفس الـ ID الأساسي
      final parent = iframe.parent;
      if (parent != null && parent.id.contains(widget.viewId)) {
        iframe.remove();
      }
    }

    _iframe = html.IFrameElement()
      ..style.border = 'none'
      ..style.width = '100%'
      ..style.height = '100%'
      ..style.pointerEvents = 'none' // ابدأ معطّل
      ..srcdoc = _buildHtml();
    
    // تأكد من تعطيل pointer-events عند إنشاء الويدجت (عدة مرات)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_iframe != null && mounted) {
        _iframe!.style.pointerEvents = 'none';
      }
    });
    
    Future.delayed(const Duration(milliseconds: 10), () {
      if (_iframe != null && mounted) {
        _iframe!.style.pointerEvents = 'none';
      }
    });
    Future.delayed(const Duration(milliseconds: 50), () {
      if (_iframe != null && mounted) {
        _iframe!.style.pointerEvents = 'none';
      }
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_iframe != null && mounted) {
        _iframe!.style.pointerEvents = 'none';
      }
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      if (_iframe != null && mounted) {
        _iframe!.style.pointerEvents = 'none';
      }
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      if (_iframe != null && mounted) {
        _iframe!.style.pointerEvents = 'none';
      }
    });
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (_iframe != null && mounted) {
        _iframe!.style.pointerEvents = 'none';
      }
    });

    // أخفي الـ loading بعد 300ms فقط (الويدجتات محملة مسبقاً)
    if (widget.showLoadingIndicator) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) setState(() => _isLoading = false);
      });
    } else {
      _isLoading = false;
    }

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
        _uniqueViewId, // استخدم الـ viewId الفريد
        (int id) => _iframe!,
      );
    } catch (e) {
      // إذا فشل التسجيل، حاول مرة ثانية بـ viewId مختلف
      _uniqueViewId = '${widget.viewId}-${DateTime.now().millisecondsSinceEpoch}-retry';
      try {
        ui.platformViewRegistry.registerViewFactory(
          _uniqueViewId,
          (int id) => _iframe!,
        );
      } catch (_) {}
    }
  }

  void _onPointerDown() {
    // لما المستخدم يضغط = فعّل الـ iframe
    if (_iframe != null) {
      _iframe!.style.pointerEvents = 'auto';
    }
    _isScrolling = false;
    
    // بعد 3 ثواني من آخر ضغطة، عطّله
    _enableTimer?.cancel();
    _enableTimer = Timer(const Duration(seconds: 3), () {
      if (_iframe != null && mounted && !_isScrolling) {
        _iframe!.style.pointerEvents = 'none';
      }
    });
  }

  void _onScroll() {
    // لما المستخدم يعمل scroll = عطّل الـ iframe
    _isScrolling = true;
    if (_iframe != null) {
      _iframe!.style.pointerEvents = 'none';
    }
    
    // بعد 500ms من آخر scroll، خليه جاهز للتفعيل
    _enableTimer?.cancel();
    _enableTimer = Timer(const Duration(milliseconds: 500), () {
      _isScrolling = false;
    });
  }

  String _buildHtml() {
    return '''<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
  html, body { 
    overflow: hidden; 
    margin: 0; 
    padding: 0;
    width: 100%;
    height: 100%;
  }
  body::-webkit-scrollbar { display: none; }
  body { -ms-overflow-style: none; scrollbar-width: none; }
</style>
<script src="https://irp.atnmo.com/v3/widget/widget-loader.js"></script>
</head>
<body>
<div id="${widget.widgetType}-widget"></div>
<script>
(function() {
  window.addEventListener('wheel', function(e) {
    window.parent.postMessage({ type: 'iframe-wheel', deltaY: e.deltaY }, '*');
  }, { passive: true });

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
  var updateCount = 0;
  var maxUpdates = 10; // أقصى عدد تحديثات

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
    return Math.ceil(h);
  }

  function reportDebounced() {
    if (updateCount >= maxUpdates) return; // توقف بعد 10 تحديثات
    
    clearTimeout(debounceTimer);
    debounceTimer = setTimeout(function() {
      var h = getTrueHeight();
      if (h > 20 && Math.abs(h - lastSent) > 5) {
        lastSent = h;
        updateCount++;
        window.parent.postMessage({ type: 'widget-height', id: ID, height: h }, '*');
      }
    }, 100);
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
    reportDebounced();
    setTimeout(reportDebounced, 100);
    setTimeout(reportDebounced, 300);
    setTimeout(reportDebounced, 600);
    setTimeout(reportDebounced, 1000);
  });

  window.addEventListener('load', function() {
    if (typeof loadWidget === 'function') {
      loadWidget(
        '${widget.widgetType}',
        "5be9c146-613e-4141-a351-1f5e13fc5513",
        "${widget.lang}",
        "81a06c05-1a48-4d1b-8dbd-bcf60a76730f",
        "v3"
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
    _enableTimer?.cancel(); // إلغاء الـ timer قبل الـ dispose
    if (_messageListener != null) {
      html.window.removeEventListener('message', _messageListener!);
    }
    // تأكد من تعطيل الـ iframe قبل الـ dispose
    if (_iframe != null) {
      _iframe!.style.pointerEvents = 'none';
    }
    super.dispose();
  }

  @override
  void deactivate() {
    // لما تطلع من الصفحة، عطّل الـ iframe فوراً
    _enableTimer?.cancel();
    if (_iframe != null) {
      _iframe!.style.pointerEvents = 'none';
    }
    super.deactivate();
  }

  @override
  void didUpdateWidget(ExternalScriptWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // لما الـ widget يتحدث، تأكد إنه الـ iframe معطّل
    if (_iframe != null) {
      _iframe!.style.pointerEvents = 'none';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) return const SizedBox.shrink();
    
    final content = Stack(
          children: [
            Listener(
              onPointerDown: (_) => _onPointerDown(),
              onPointerMove: (event) {
                // إذا في حركة سريعة = scroll
                if (event.delta.dy.abs() > 2 || event.delta.dx.abs() > 2) {
                  _onScroll();
                }
              },
              onPointerSignal: (signal) {
                if (signal is PointerScrollEvent) {
                  _onScroll();
                }
              },
              child: SizedBox(
                width: double.infinity,
                height: _height,
                child: HtmlElementView(viewType: _uniqueViewId),
              ),
            ),
            // Loading indicator
            if (widget.showLoadingIndicator && _isLoading)
              Positioned.fill(
                child: Container(
                  color: const Color(0xFFF8F9FA),
                  child: Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
    
    // إذا البوردر مطلوب، لفّه بـ Container
    if (widget.showBorder) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFE5E7EB),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: content,
        ),
      );
    }
    
    return content;
  }
}
