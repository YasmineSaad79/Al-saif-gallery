import 'package:flutter/material.dart';
import 'external_script_widget.dart';
import '../utils/responsive.dart';
import '../main.dart';

class CompanySnapshotWidget extends StatefulWidget {
  const CompanySnapshotWidget({super.key});
  @override
  State<CompanySnapshotWidget> createState() => _CompanySnapshotWidgetState();
}

class _CompanySnapshotWidgetState extends State<CompanySnapshotWidget> {
  @override
  void initState() { super.initState(); localeProvider.addListener(_rebuild); }
  void _rebuild() { if (mounted) setState(() {}); }
  @override
  void dispose() { localeProvider.removeListener(_rebuild); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final isAr = localeProvider.isArabic;
    final isMobile = Responsive.isMobile(context);
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: isMobile ? 600 : 400),
      child: Stack(children: [
        Visibility(visible: !isAr, maintainState: true, child: LazyExternalScriptWidget(viewId: 'company-snapshot-view-en', widgetType: 'company-snapshot', fallbackHeight: isMobile ? 600 : 400, lang: 'en')),
        Visibility(visible: isAr,  maintainState: true, child: LazyExternalScriptWidget(viewId: 'company-snapshot-view-ar', widgetType: 'company-snapshot', fallbackHeight: isMobile ? 600 : 400, lang: 'ar')),
      ]),
    );
  }
}




