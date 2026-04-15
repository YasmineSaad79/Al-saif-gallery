import 'package:flutter/material.dart';
import 'external_script_widget.dart';
import '../main.dart';

class CompanyFinancialsWidget extends StatefulWidget {
  const CompanyFinancialsWidget({super.key});
  @override
  State<CompanyFinancialsWidget> createState() => _CompanyFinancialsWidgetState();
}

class _CompanyFinancialsWidgetState extends State<CompanyFinancialsWidget> {
  @override
  void initState() { super.initState(); localeProvider.addListener(_rebuild); }
  void _rebuild() { if (mounted) setState(() {}); }
  @override
  void dispose() { localeProvider.removeListener(_rebuild); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final isAr = localeProvider.isArabic;
    return Stack(children: [
      Offstage(offstage: isAr,  child: const LazyExternalScriptWidget(viewId: 'company-financials-view-en', widgetType: 'company-financials', lang: 'en')),
      Offstage(offstage: !isAr, child: const LazyExternalScriptWidget(viewId: 'company-financials-view-ar', widgetType: 'company-financials', lang: 'ar')),
    ]);
  }
}




