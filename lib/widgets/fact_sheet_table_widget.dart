import 'package:flutter/material.dart';
import 'external_script_widget.dart';

class FactSheetTableWidget extends StatelessWidget {
  const FactSheetTableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const ExternalScriptWidget(
      viewId: 'fact-sheet-table-view',
      widgetType: 'fact-sheet-table',
      fallbackHeight: 200,
    );
  }
}
