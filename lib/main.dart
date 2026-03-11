import 'package:flutter/material.dart';
import 'utils/app_theme.dart';
import 'utils/app_router.dart';

void main() {
  runApp(const AlSaifGalleryApp());
}

class AlSaifGalleryApp extends StatelessWidget {
  const AlSaifGalleryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Al Saif Gallery',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: appRouter,
    );
  }
}
