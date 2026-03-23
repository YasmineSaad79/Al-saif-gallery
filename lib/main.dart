// ignore_for_file: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'utils/app_theme.dart';
import 'utils/app_router.dart';
import 'utils/locale_provider.dart';
import 'utils/app_localizations.dart';

void main() {
  runApp(const AlSaifGalleryApp());
}

// Global LocaleProvider instance accessible from widgets
final LocaleProvider localeProvider = LocaleProvider();

class AlSaifGalleryApp extends StatefulWidget {
  const AlSaifGalleryApp({super.key});

  @override
  State<AlSaifGalleryApp> createState() => _AlSaifGalleryAppState();
}

class _AlSaifGalleryAppState extends State<AlSaifGalleryApp> {
  html.EventListener? _wheelListener;

  @override
  void initState() {
    super.initState();
    localeProvider.addListener(_onLocaleChanged);
    // Forward wheel events from iframes to the Flutter app's scroll
    _wheelListener = (event) {
      final msg = (event as html.MessageEvent).data;
      if (msg is Map && msg['type'] == 'iframe-wheel') {
        final dy = (msg['deltaY'] as num?)?.toDouble() ?? 0;
        // Use native browser scroll — works regardless of Flutter scroll controller
        html.window.scrollBy(0, dy);
      }
    };
    html.window.addEventListener('message', _wheelListener!);
  }

  void _onLocaleChanged() => setState(() {});

  @override
  void dispose() {
    localeProvider.removeListener(_onLocaleChanged);
    if (_wheelListener != null) {
      html.window.removeEventListener('message', _wheelListener!);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Al Saif Gallery',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: appRouter,
      builder: (context, child) => AppLocalizationsProvider(
        provider: localeProvider,
        child: child!,
      ),
    );
  }
}
