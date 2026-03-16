import 'package:flutter/material.dart';
import 'external_script_widget.dart';

class StockTickerWidget extends StatelessWidget {
  const StockTickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const ExternalScriptWidget(
      viewId: 'stock-ticker-view',
      widgetType: 'stock-ticker',
      fallbackHeight: 46,
    );
  }
}
