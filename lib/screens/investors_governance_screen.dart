import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import '../widgets/top_bar.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/ig_hero_section.dart';
import '../widgets/ig_intro_section.dart';
import '../widgets/ig_investment_case_section.dart';
import '../widgets/stock_ticker_widget.dart';
import '../widgets/company_snapshot_widget.dart';
import '../widgets/corporate_news_widget.dart';
import '../widgets/fact_sheet_widget.dart';
import '../widgets/stock_activity_widget.dart';
import '../widgets/corporate_actions_widget.dart';
import '../widgets/company_financials_widget.dart';
import '../widgets/investment_calculator_widget.dart';
import '../widgets/share_price_widget.dart';
import '../widgets/peer_group_analysis_widget.dart';
import '../widgets/performance_widget.dart';
import '../widgets/share_series_widget.dart';
import '../widgets/email_subscription_widget.dart';
import '../widgets/footer_section.dart';
import '../utils/responsive.dart';
import '../utils/page_meta.dart';
import '../utils/scroll_keys.dart';
import '../main.dart';

class InvestorsGovernanceScreen extends StatefulWidget {
  const InvestorsGovernanceScreen({super.key});

  @override
  State<InvestorsGovernanceScreen> createState() => _InvestorsGovernanceScreenState();
}

class _InvestorsGovernanceScreenState extends State<InvestorsGovernanceScreen> {
  ScrollController get _scrollController => irScrollController;
  final GlobalKey _irSectionKey = GlobalKey();
  bool _showFab = false;

  @override
  void initState() {
    super.initState();
    localeProvider.addListener(_rebuild);
    _scrollController.addListener(_checkFabVisibility);
    setPageMeta(
      title: 'Al Saif Gallery Investor Relations | Tadawul 4192 | السيف غاليري',
      description: 'Official investor relations for Al Saif Gallery (Tadawul: 4192). Financial results, governance documents, shareholder services, and regulatory disclosures for Saudi Exchange investors.',
    );
  }

  void _checkFabVisibility() {
    final ctx = _irSectionKey.currentContext;
    if (ctx == null) return;
    final box = ctx.findRenderObject() as RenderBox?;
    if (box == null) return;
    final pos = box.localToGlobal(Offset.zero);
    final screenH = MediaQuery.of(context).size.height;
    final visible = pos.dy < screenH && pos.dy + box.size.height > 0;
    if (visible != _showFab) setState(() => _showFab = visible);
  }

  @override
  void dispose() {
    localeProvider.removeListener(_rebuild);
    _scrollController.removeListener(_checkFabVisibility);
    super.dispose();
  }

  void _rebuild() => setState(() {});

  @override
  Widget build(BuildContext context) {
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
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const IGHeroSection(),
                    const IGIntroSection(),
                    const IGInvestmentCaseSection(),
                    const _StockTickerSection(),
                    _IRWidgetsSection(key: _irSectionKey, scrollController: _scrollController),
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
      floatingActionButton: _showFab ? _ScrollFab(scrollController: _scrollController) : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

// ── Stock Ticker ──────────────────────────────────────────────────────────────
class _StockTickerSection extends StatelessWidget {
  const _StockTickerSection();

  @override
  Widget build(BuildContext context) {
    final hp = Responsive.getHorizontalPadding(context);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        width: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(hp, 16, hp, 8),
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
            color: Color(0xFFF8F9FA),
            border: Border(
              top: BorderSide(color: Color(0xFFE53935), width: 2),
              bottom: BorderSide(color: Color(0xFFE53935), width: 2),
            ),
          ),
          height: 70,
          child: const StockTickerWidget(),
        ),
      ),
    );
  }
}

// ── Scroll FAB ────────────────────────────────────────────────────────────────
class _ScrollFab extends StatefulWidget {
  final ScrollController scrollController;
  const _ScrollFab({required this.scrollController});

  @override
  State<_ScrollFab> createState() => _ScrollFabState();
}

class _ScrollFabState extends State<_ScrollFab> {
  bool _atBottom = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final atBottom = widget.scrollController.offset >=
        widget.scrollController.position.maxScrollExtent - 100;
    if (atBottom != _atBottom) setState(() => _atBottom = atBottom);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _scroll() {
    final current = widget.scrollController.offset;
    final max = widget.scrollController.position.maxScrollExtent;
    final target = _atBottom ? 0.0 : (current + 400).clamp(0.0, max);
    widget.scrollController.animateTo(
      target,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SelectionContainer.disabled(
      child: FloatingActionButton.small(
        onPressed: _scroll,
        backgroundColor: const Color(0xFFC62030),
        tooltip: _atBottom ? 'Scroll to top' : 'Scroll down',
        child: Icon(
          _atBottom ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
          color: Colors.white,
        ),
      ),
    );
  }
}

// ── All IR Widgets ────────────────────────────────────────────────────────────
class _IRWidgetsSection extends StatefulWidget {
  final ScrollController scrollController;
  const _IRWidgetsSection({super.key, required this.scrollController});

  @override
  State<_IRWidgetsSection> createState() => _IRWidgetsSectionState();
}

class _IRWidgetsSectionState extends State<_IRWidgetsSection> {
  @override
  void initState() {
    super.initState();
    localeProvider.addListener(_rebuild);
  }

  @override
  void dispose() {
    localeProvider.removeListener(_rebuild);
    super.dispose();
  }

  void _rebuild() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final hp = Responsive.getHorizontalPadding(context);
    final isAr = localeProvider.isArabic;

    final sections = isAr ? [
      ('نظرة عامة عن الشركة',        const CompanySnapshotWidget(),   'company-snapshot'),
      ('الإعلانات',                   const CorporateNewsWidget(),     'announcements'),
      ('نشرة المعلومات',              const FactSheetWidget(),         'fact-sheet'),
      ('نشاط السهم',                  const StockActivityWidget(),     'stock-activity'),
      ('الإجراءات النظامية',          const CorporateActionsWidget(),  'corporate-actions'),
      ('البيانات المالية',            const CompanyFinancialsWidget(), 'financials'),
      ('حاسبة الاستثمار',             const InvestmentCalculatorWidget(), 'investment-calculator'),
      ('سعر السهم',                   const SharePriceWidget(),        'share-price'),
      ('تحليل المجموعة المماثلة',     const PeerGroupAnalysisWidget(), 'peer-group'),
      ('الأداء',                      const PerformanceWidget(),       'performance'),
      ('سلسلة الأسهم',                const ShareSeriesWidget(),       'share-series'),
      ('الاشتراك بالبريد الإلكتروني', const EmailSubscriptionWidget(), 'email-subscription'),
    ] : [
      ('Company Snapshot',       const CompanySnapshotWidget(),    'company-snapshot'),
      ('Announcements',          const CorporateNewsWidget(),      'announcements'),
      ('Fact Sheet',             const FactSheetWidget(),          'fact-sheet'),
      ('Stock Activity',         const StockActivityWidget(),      'stock-activity'),
      ('Corporate Actions',      const CorporateActionsWidget(),   'corporate-actions'),
      ('Company Financials',     const CompanyFinancialsWidget(),  'financials'),
      ('Investment Calculator',  const InvestmentCalculatorWidget(), 'investment-calculator'),
      ('Share Price',            const SharePriceWidget(),         'share-price'),
      ('Peer Group Analysis',    const PeerGroupAnalysisWidget(),  'peer-group'),
      ('Performance',            const PerformanceWidget(),        'performance'),
      ('Share Series',           const ShareSeriesWidget(),        'share-series'),
      ('Email Subscription',     const EmailSubscriptionWidget(),  'email-subscription'),
    ];

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(hp, 0, hp, 40),
      child: Directionality(
        textDirection: isAr ? TextDirection.rtl : TextDirection.ltr,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: sections.map((s) => Padding(
            padding: const EdgeInsets.only(top: 32),
            child: Column(
              key: ScrollKeys.get(s.$3),
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(s.$1, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xFF101727))),
                const SizedBox(height: 12),
                Listener(
                  onPointerSignal: (event) {
                    if (event is PointerScrollEvent) {
                      final newOffset = (widget.scrollController.offset + event.scrollDelta.dy)
                          .clamp(0.0, widget.scrollController.position.maxScrollExtent);
                      widget.scrollController.jumpTo(newOffset);
                    }
                  },
                  child: s.$2,
                ),
              ],
            ),
          )).toList(),
        ),
      ),
    );
  }
}





