import 'package:flutter/material.dart';
import 'external_script_widget.dart';

class CorporateNewsWidget extends StatelessWidget {
  const CorporateNewsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const ExternalScriptWidget(
      viewId: 'corporate-news-view',
      widgetType: 'corporate-news',
      fallbackHeight: 200,
    );
  }
}
