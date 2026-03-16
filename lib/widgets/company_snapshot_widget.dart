import 'package:flutter/material.dart';
import 'external_script_widget.dart';

class CompanySnapshotWidget extends StatelessWidget {
  const CompanySnapshotWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const ExternalScriptWidget(
      viewId: 'company-snapshot-view',
      widgetType: 'company-snapshot',
      fallbackHeight: 200,
    );
  }
}
