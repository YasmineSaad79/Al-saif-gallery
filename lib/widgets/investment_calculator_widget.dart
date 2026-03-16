import 'package:flutter/material.dart';
import 'external_script_widget.dart';

class InvestmentCalculatorWidget extends StatelessWidget {
  const InvestmentCalculatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const ExternalScriptWidget(
      viewId: 'investment-calculator-view',
      widgetType: 'investment-calculator',
      fallbackHeight: 200,
    );
  }
}
