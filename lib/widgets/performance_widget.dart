import 'package:flutter/material.dart';
import 'external_script_widget.dart';
import '../main.dart';

class PerformanceWidget extends StatefulWidget {
  const PerformanceWidget({super.key});
  @override
  State<PerformanceWidget> createState() => _PerformanceWidgetState();
}

class _PerformanceWidgetState extends State<PerformanceWidget> {
  @override
  void initState() { super.initState(); localeProvider.addListener(_rebuild); }
  void _rebuild() { if (mounted) setState(() {}); }
  @override
  void dispose() { localeProvider.removeListener(_rebuild); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final isAr = localeProvider.isArabic;
    return Stack(children: [
      Offstage(offstage: isAr,  child: const LazyExternalScriptWidget(viewId: 'performance-view-en', widgetType: 'performance', fallbackHeight: 400, lang: 'en')),
      Offstage(offstage: !isAr, child: const LazyExternalScriptWidget(viewId: 'performance-view-ar', widgetType: 'performance', fallbackHeight: 400, lang: 'ar')),
    ]);
  }
}




