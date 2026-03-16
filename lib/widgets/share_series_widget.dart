import 'package:flutter/material.dart';
import 'external_script_widget.dart';

class ShareSeriesWidget extends StatelessWidget {
  const ShareSeriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const ExternalScriptWidget(
      viewId: 'share-series-view',
      widgetType: 'share-series',
      fallbackHeight: 400,
    );
  }
}
