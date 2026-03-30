// ignore_for_file: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:ui_web' as ui;
import 'dart:async';
import 'dart:js_util' as js_util;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../widgets/top_bar.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/ig_hero_section.dart';
import '../widgets/ig_intro_section.dart';
import '../widgets/ig_investment_case_section.dart';
import '../widgets/footer_section.dart';
import '../utils/page_meta.dart';
import '../main.dart';

const String _irWidgetsBase = String.fromEnvironment(
  'IR_PAGE_URL',
  defaultValue: 'http://localhost:3001/ir',
);

class InvestorsGovernanceScreen extends StatefulWidget {
  const InvestorsGovernanceScreen({super.key});

  @override
  State<InvestorsGovernanceScreen> createState() => _InvestorsGovernanceScreenState();
}

class _InvestorsGovernanceScreenState extends State<InvestorsGovernanceScreen> {
  @override
  void initState() {
    super.initState();
    localeProvider.addListener(_rebuild);
    setPageMeta(
      title: 'Al Saif Gallery Investor Relations | Tadawul 4192 | السيف غاليري',
      description: 'Official investor relations for Al Saif Gallery (Tadawul: 4192). Financial results, governance documents, shareholder services, and regulatory disclosures for Saudi Exchange investors.',
    );
  }

  @override
  void dispose() {
    localeProvider.removeListener(_rebuild);
    super.dispose();
  }

  void _rebuild() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final lang = localeProvider.isArabic ? 'ar' : 'en';
    final content = Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1880),
        color: const Color(0xFFF8FAFB),
        child: Column(
          children: [
            const TopBar(),
            const CustomNavigationBar(),
            Expanded(
              child: SingleChildScrollView(
                controller: irScrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const IGHeroSection(),
                    const IGIntroSection(),
                    const IGInvestmentCaseSection(),
                    _IRIframeSection(lang: lang),
                    const FooterSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SelectionArea(child: content),
    );
  }
}

class _IRIframeSection extends StatefulWidget {
  final String lang;
  const _IRIframeSection({required this.lang});

  @override
  State<_IRIframeSection> createState() => _IRIframeSectionState();
}

class _IRIframeSectionState extends State<_IRIframeSection> {
  static const _viewId = 'ir-widgets-iframe';
  html.IFrameElement? _iframe;
  double _height = 800;
  html.EventListener? _msgListener;
  Timer? _debounce;
  bool _registered = false;

  String get _iframeUrl {
    final host = html.window.location.host;
    final base = host.contains('localhost') ? 'http://localhost:3001/ir' : 'https://al-saif-ir-widgets.onrender.com/ir';
    return '$base?lang=${widget.lang}';
  }

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) return;
    _buildIframe();
  }

  void _buildIframe() {
    _iframe = html.IFrameElement()
      ..style.border = 'none'
      ..style.width = '100%'
      ..style.height = '100%'
      ..style.pointerEvents = 'auto'
      ..src = _iframeUrl;

    _msgListener = (event) {
      final msg = (event as html.MessageEvent).data;
      if (msg == null) return;
      try {
        final type = js_util.getProperty(msg, 'type');
        if (type == 'ir-page-height') {
          final h = (js_util.getProperty(msg, 'height') as num?)?.toDouble() ?? 0;
          if (h > 100) {
            _debounce?.cancel();
            _debounce = Timer(const Duration(milliseconds: 200), () {
              if (mounted && (h - _height).abs() > 4) {
                setState(() => _height = h);
              }
            });
          }
        }
        if (type == 'iframe-wheel') {
          final dy = (js_util.getProperty(msg, 'deltaY') as num?)?.toDouble() ?? 0;
          if (irScrollController.hasClients) {
            final next = (irScrollController.offset + dy)
                .clamp(0.0, irScrollController.position.maxScrollExtent);
            irScrollController.jumpTo(next);
          }
        }
      } catch (_) {}
    };
    html.window.addEventListener('message', _msgListener!);

    localeProvider.addListener(_onLangChange);

    try {
      ui.platformViewRegistry.registerViewFactory(_viewId, (int id) => _iframe!);
      _registered = true;
    } catch (_) {
      _registered = true;
    }
  }

  void _onLangChange() {
    if (_iframe?.contentWindow == null) return;
    final lang = localeProvider.isArabic ? 'ar' : 'en';
    js_util.callMethod(_iframe!.contentWindow!, 'postMessage',
        [js_util.jsify({'type': 'set-lang', 'lang': lang}), '*']);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    localeProvider.removeListener(_onLangChange);
    if (_msgListener != null) html.window.removeEventListener('message', _msgListener!);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) return const SizedBox.shrink();
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: SizedBox(
        width: double.infinity,
        height: _height,
        child: HtmlElementView(viewType: _viewId),
      ),
    );
  }
}
