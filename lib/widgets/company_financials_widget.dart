import 'package:flutter/material.dart';
import 'external_script_widget.dart';

class CompanyFinancialsWidget extends StatelessWidget {
  const CompanyFinancialsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const ExternalScriptWidget(
      viewId: 'company-financials-view',
      widgetType: 'company-financials',
      fallbackHeight: 200,
    );
  }
}
