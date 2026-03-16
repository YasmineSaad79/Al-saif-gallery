import 'package:flutter/material.dart';
import 'external_script_widget.dart';

class SharePriceWidget extends StatelessWidget {
  const SharePriceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const ExternalScriptWidget(
      viewId: 'share-price-view',
      widgetType: 'share-price',
      fallbackHeight: 200,
    );
  }
}
