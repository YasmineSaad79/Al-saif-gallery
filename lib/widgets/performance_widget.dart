import 'package:flutter/material.dart';
import 'external_script_widget.dart';

class PerformanceWidget extends StatelessWidget {
  const PerformanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const ExternalScriptWidget(
      viewId: 'performance-view',
      widgetType: 'performance',
      fallbackHeight: 400,
    );
  }
}
