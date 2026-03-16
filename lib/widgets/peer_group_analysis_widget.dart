import 'package:flutter/material.dart';
import 'external_script_widget.dart';

class PeerGroupAnalysisWidget extends StatelessWidget {
  const PeerGroupAnalysisWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const ExternalScriptWidget(
      viewId: 'peer-group-analysis-view',
      widgetType: 'peer-group-analysis',
      fallbackHeight: 400,
    );
  }
}
