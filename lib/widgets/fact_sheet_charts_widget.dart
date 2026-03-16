import 'package:flutter/material.dart';
import 'external_script_widget.dart';

class FactSheetChartsWidget extends StatelessWidget {
  const FactSheetChartsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const ExternalScriptWidget(
      viewId: 'fact-sheet-charts-view',
      widgetType: 'fact-sheet-charts',
      fallbackHeight: 200,
    );
  }
}
