import 'package:flutter/material.dart';
import 'external_script_widget.dart';
import '../main.dart';
import '../utils/app_colors.dart';

class StockTickerWidget extends StatefulWidget {
  const StockTickerWidget({super.key});
  @override
  State<StockTickerWidget> createState() => _StockTickerWidgetState();
}

class _StockTickerWidgetState extends State<StockTickerWidget> {
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    localeProvider.addListener(_rebuild);
    // حمّل فوراً بدون انتظار
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted) setState(() => _loaded = true);
      });
    });
  }

  void _rebuild() { if (mounted) setState(() {}); }
  
  @override
  void dispose() {
    localeProvider.removeListener(_rebuild);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = localeProvider.isArabic ? 'ar' : 'en';
    
    if (!_loaded) {
      return _StockTickerLoader();
    }
    
    return ExternalScriptWidget(
      key: ValueKey('stock-ticker-$lang'),
      viewId: 'stock-ticker-view-$lang',
      widgetType: 'stock-ticker',
      fallbackHeight: 46,
      lang: lang,
      priority: true, // تحميل فوري بدون انتظار
    );
  }
}

class _StockTickerLoader extends StatefulWidget {
  @override
  State<_StockTickerLoader> createState() => _StockTickerLoaderState();
}

class _StockTickerLoaderState extends State<_StockTickerLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
    _animation = Tween<double>(begin: -1, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 46,
      color: const Color(0xFFF8F9FA),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Stack(
            children: [
              // خلفية ثابتة
              Positioned.fill(
                child: Row(
                  children: List.generate(5, (i) => Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  )),
                ),
              ),
              // شريط متحرك (shimmer effect)
              Positioned.fill(
                child: Transform.translate(
                  offset: Offset(_animation.value * MediaQuery.of(context).size.width, 0),
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.white.withOpacity(0.3),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // أيقونة loading في المنتصف
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.primary.withOpacity(0.6),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Loading stock data...',
                      style: TextStyle(
                        fontSize: 12,
                        color: const Color(0xFF6B7280).withOpacity(0.8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}





