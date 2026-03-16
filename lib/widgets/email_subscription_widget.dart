import 'package:flutter/material.dart';
import 'external_script_widget.dart';

class EmailSubscriptionWidget extends StatelessWidget {
  const EmailSubscriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const ExternalScriptWidget(
      viewId: 'email-subscription-view',
      widgetType: 'email-subscription',
      fallbackHeight: 400,
    );
  }
}
