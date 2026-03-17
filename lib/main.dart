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
  @override
  void initState() {
    super.initState();
    localeProvider.addListener(_onLocaleChanged);
  }

  void _onLocaleChanged() => setState(() {});

  @override
  void dispose() {
    localeProvider.removeListener(_onLocaleChanged);
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
