import 'package:flutter/material.dart';
import 'external_script_widget.dart';

class CorporateActionsWidget extends StatelessWidget {
  const CorporateActionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const ExternalScriptWidget(
      viewId: 'corporate-actions-view',
      widgetType: 'corporate-actions',
      fallbackHeight: 200,
    );
  }
}
