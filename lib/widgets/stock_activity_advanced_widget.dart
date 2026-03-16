import 'package:flutter/material.dart';
import 'external_script_widget.dart';

class StockActivityAdvancedWidget extends StatelessWidget {
  const StockActivityAdvancedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const ExternalScriptWidget(
      viewId: 'stock-activity-advanced-view',
      widgetType: 'stock-activity-advanced',
      fallbackHeight: 200,
    );
  }
}
