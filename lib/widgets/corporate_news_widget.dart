import 'package:flutter/material.dart';
import 'external_script_widget.dart';
import '../main.dart';

class CorporateNewsWidget extends StatefulWidget {
  const CorporateNewsWidget({super.key});
  @override
  State<CorporateNewsWidget> createState() => _CorporateNewsWidgetState();
}

class _CorporateNewsWidgetState extends State<CorporateNewsWidget> {
  @override
  void initState() { super.initState(); localeProvider.addListener(_rebuild); }
  void _rebuild() { if (mounted) setState(() {}); }
  @override
  void dispose() { localeProvider.removeListener(_rebuild); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final isAr = localeProvider.isArabic;
    return Stack(children: [
      Offstage(offstage: isAr,  child: const LazyExternalScriptWidget(viewId: 'corporate-news-view-en', widgetType: 'corporate-news', lang: 'en')),
      Offstage(offstage: !isAr, child: const LazyExternalScriptWidget(viewId: 'corporate-news-view-ar', widgetType: 'corporate-news', lang: 'ar')),
    ]);
  }
}




