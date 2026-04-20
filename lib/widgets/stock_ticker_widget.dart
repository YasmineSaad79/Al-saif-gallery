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
  @override
  void initState() {
    super.initState();
    localeProvider.addListener(_rebuild);
  }

  void _rebuild() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    localeProvider.removeListener(_rebuild);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = localeProvider.isArabic ? 'ar' : 'en';
    // استخدم ExternalScriptWidget مباشرة (بدون lazy loading)
    return ExternalScriptWidget(
      key: ValueKey('stock-ticker-$lang'),
      viewId: 'stock-ticker-view-$lang',
      widgetType: 'stock-ticker',
      fallbackHeight: 46,
      lang: lang,
      priority: true,
      showLoadingIndicator: true,
    );
  }
}

class _StockTickerPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 46,
      color: const Color(0xFFF8F9FA),
      child: Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
        ),
      ),
    );
  }
}






