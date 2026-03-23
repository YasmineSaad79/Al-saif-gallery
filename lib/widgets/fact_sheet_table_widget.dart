import 'package:flutter/material.dart';
import 'external_script_widget.dart';
import '../main.dart';

class FactSheetTableWidget extends StatefulWidget {
  const FactSheetTableWidget({super.key});
  @override
  State<FactSheetTableWidget> createState() => _FactSheetTableWidgetState();
}

class _FactSheetTableWidgetState extends State<FactSheetTableWidget> {
  @override
  void initState() { super.initState(); localeProvider.addListener(_rebuild); }
  void _rebuild() { if (mounted) setState(() {}); }
  @override
  void dispose() { localeProvider.removeListener(_rebuild); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final lang = localeProvider.isArabic ? 'ar' : 'en';
    return LazyExternalScriptWidget(
      key: ValueKey('fact-sheet-table-$lang'),
      viewId: 'fact-sheet-table-view-$lang',
      widgetType: 'fact-sheet-table',
      fallbackHeight: 200,
      lang: lang,
    );
  }
}
