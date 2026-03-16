import 'package:flutter/material.dart';
import 'external_script_widget.dart';

class StockActivitySimpleWidget extends StatelessWidget {
  const StockActivitySimpleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const ExternalScriptWidget(
      viewId: 'stock-activity-simple-view',
      widgetType: 'stock-activity-simple',
      fallbackHeight: 200,
    );
  }
}
