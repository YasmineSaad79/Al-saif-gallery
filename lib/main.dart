// ignore_for_file: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:js_util' as js_util;
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

// Global scroll controller for IR page - receives iframe wheel events
final ScrollController irScrollController = ScrollController();

// Global notifier for contact section highlight
final ValueNotifier<bool> contactHighlightNotifier = ValueNotifier(false);

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
    
    // تحميل الويدجتات في الخلفية أول ما يفتح التطبيق
    _preloadIRWidgets();
    
    // استمع على الـ window للـ message من الـ iframes
    _wheelListener = (event) {
      final msg = (event as html.MessageEvent).data;
      if (msg == null) return;
      try {
        final type = js_util.getProperty(msg, 'type');
        if (type == 'iframe-wheel') {
          final dy = (js_util.getProperty(msg, 'deltaY') as num?)?.toDouble() ?? 0;
          if (irScrollController.hasClients && dy != 0) {
            final current = irScrollController.offset;
            final max = irScrollController.position.maxScrollExtent;
            final next = (current + dy).clamp(0.0, max);
            irScrollController.jumpTo(next);
          }
        }
      } catch (_) {}
    };
    html.window.addEventListener('message', _wheelListener!);
  }
  
  void _preloadIRWidgets() {
    // انتظر 2 ثانية بعد فتح التطبيق، ثم حمّل الويدجتات في الخلفية
    Future.delayed(const Duration(seconds: 2), () {
      final container = html.DivElement()
        ..id = 'ir-widgets-preload'
        ..style.position = 'fixed'
        ..style.left = '-9999px'
        ..style.top = '-9999px'
        ..style.width = '1000px'
        ..style.height = '5000px'
        ..style.opacity = '0'
        ..style.pointerEvents = 'none'
        ..style.overflow = 'hidden';
      
      html.document.body?.append(container);
      
      final widgets = [
        'stock-ticker', 'company-snapshot', 'corporate-news', 'fact-sheet',
        'stock-activity', 'corporate-actions', 'company-financials', 'share-price',
        'performance', 'investment-calculator', 'share-series', 'zakat-calculator',
        'share-view', 'price-lookup', 'peer-group-analysis', 'email-subscription'
      ];
      
      // حمّل كل ويدجت بتأخير بسيط
      for (var i = 0; i < widgets.length; i++) {
        Future.delayed(Duration(milliseconds: i * 300), () {
          final widgetDiv = html.DivElement()
            ..id = '${widgets[i]}-widget-preload'
            ..style.marginBottom = '20px';
          container.append(widgetDiv);
          
          // استدعي loadWidget من JavaScript
          try {
            js_util.callMethod(
              html.window,
              'loadWidget',
              [widgets[i], "5be9c146-613e-4141-a351-1f5e13fc5513", "en", "81a06c05-1a48-4d1b-8dbd-bcf60a76730f", "v3"]
            );
            print('Preloaded: ${widgets[i]}');
          } catch (e) {
            print('Failed to preload ${widgets[i]}: $e');
          }
        });
      }
    });
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
        child: MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: localeProvider.isArabic ? 0.9 : 1.0,
          ),
          child: Directionality(
            textDirection: localeProvider.isArabic
                ? TextDirection.rtl
                : TextDirection.ltr,
            child: child!,
          ),
        ),
      ),
    );
  }
}




