import 'package:flutter/material.dart';
import 'external_script_widget.dart';
import '../main.dart';

class CorporateActionsWidget extends StatefulWidget {
  const CorporateActionsWidget({super.key});
  @override
  State<CorporateActionsWidget> createState() => _CorporateActionsWidgetState();
}

class _CorporateActionsWidgetState extends State<CorporateActionsWidget> {
  @override
  void initState() { super.initState(); localeProvider.addListener(_rebuild); }
  void _rebuild() { if (mounted) setState(() {}); }
  @override
  void dispose() { localeProvider.removeListener(_rebuild); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final isAr = localeProvider.isArabic;
    return Stack(children: [
      Offstage(offstage: isAr,  child: const LazyExternalScriptWidget(viewId: 'corporate-actions-view-en', widgetType: 'corporate-actions', fallbackHeight: 200, lang: 'en')),
      Offstage(offstage: !isAr, child: const LazyExternalScriptWidget(viewId: 'corporate-actions-view-ar', widgetType: 'corporate-actions', fallbackHeight: 200, lang: 'ar')),
    ]);
  }
}




