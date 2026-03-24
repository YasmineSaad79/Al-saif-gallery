import 'package:flutter/material.dart';
import 'external_script_widget.dart';
import '../main.dart';

class PeerGroupAnalysisWidget extends StatefulWidget {
  const PeerGroupAnalysisWidget({super.key});
  @override
  State<PeerGroupAnalysisWidget> createState() => _PeerGroupAnalysisWidgetState();
}

class _PeerGroupAnalysisWidgetState extends State<PeerGroupAnalysisWidget> {
  @override
  void initState() { super.initState(); localeProvider.addListener(_rebuild); }
  void _rebuild() { if (mounted) setState(() {}); }
  @override
  void dispose() { localeProvider.removeListener(_rebuild); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final isAr = localeProvider.isArabic;
    return Stack(children: [
      Offstage(offstage: isAr,  child: const LazyExternalScriptWidget(viewId: 'peer-group-analysis-view-en', widgetType: 'peer-group-analysis', fallbackHeight: 400, lang: 'en')),
      Offstage(offstage: !isAr, child: const LazyExternalScriptWidget(viewId: 'peer-group-analysis-view-ar', widgetType: 'peer-group-analysis', fallbackHeight: 400, lang: 'ar')),
    ]);
  }
}




