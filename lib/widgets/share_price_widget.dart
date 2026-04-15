import 'package:flutter/material.dart';
import 'external_script_widget.dart';
import '../main.dart';

class SharePriceWidget extends StatefulWidget {
  const SharePriceWidget({super.key});
  @override
  State<SharePriceWidget> createState() => _SharePriceWidgetState();
}

class _SharePriceWidgetState extends State<SharePriceWidget> {
  @override
  void initState() { super.initState(); localeProvider.addListener(_rebuild); }
  void _rebuild() { if (mounted) setState(() {}); }
  @override
  void dispose() { localeProvider.removeListener(_rebuild); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final isAr = localeProvider.isArabic;
    return Stack(children: [
      Offstage(offstage: isAr,  child: const LazyExternalScriptWidget(viewId: 'share-price-view-en', widgetType: 'share-price', lang: 'en')),
      Offstage(offstage: !isAr, child: const LazyExternalScriptWidget(viewId: 'share-price-view-ar', widgetType: 'share-price', lang: 'ar')),
    ]);
  }
}




