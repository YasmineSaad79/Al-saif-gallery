import 'package:flutter/material.dart';
import 'external_script_widget.dart';
import '../main.dart';

class FactSheetChartsWidget extends StatefulWidget {
  const FactSheetChartsWidget({super.key});
  @override
  State<FactSheetChartsWidget> createState() => _FactSheetChartsWidgetState();
}

class _FactSheetChartsWidgetState extends State<FactSheetChartsWidget> {
  @override
  void initState() { super.initState(); localeProvider.addListener(_rebuild); }
  void _rebuild() { if (mounted) setState(() {}); }
  @override
  void dispose() { localeProvider.removeListener(_rebuild); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final isAr = localeProvider.isArabic;
    return Stack(children: [
      Offstage(offstage: isAr,  child: const LazyExternalScriptWidget(viewId: 'fact-sheet-charts-view-en', widgetType: 'fact-sheet-charts', lang: 'en')),
      Offstage(offstage: !isAr, child: const LazyExternalScriptWidget(viewId: 'fact-sheet-charts-view-ar', widgetType: 'fact-sheet-charts', lang: 'ar')),
    ]);
  }
}




