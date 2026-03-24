import 'package:flutter/material.dart';
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
import '../main.dart';

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
  }

  @override
  void dispose() {
    localeProvider.removeListener(_rebuild);
    super.dispose();
  }

  void _rebuild() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final content = Center(
      child: Container(
        margin: const EdgeInsets.all(20),
        constraints: const BoxConstraints(maxWidth: 1880),
        color: const Color(0xFFF8FAFB),
        child: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopBar(),
              CustomNavigationBar(),
              IGHeroSection(),
              IGIntroSection(),
              IGInvestmentCaseSection(),
              _StockTickerSection(),
              _IRWidgetsSection(),
              FooterSection(),
            ],
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: localeProvider.isArabic
          ? SelectionContainer.disabled(child: content)
          : SelectionArea(child: content),
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

// ── All IR Widgets ────────────────────────────────────────────────────────────
class _IRWidgetsSection extends StatefulWidget {
  const _IRWidgetsSection();

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
      ('نظرة عامة عن الشركة',        const CompanySnapshotWidget()),
      ('الإعلانات',                   const CorporateNewsWidget()),
      ('نشرة المعلومات',              const FactSheetWidget()),
      ('نشاط السهم',                  const StockActivityWidget()),
      ('الإجراءات النظامية',          const CorporateActionsWidget()),
      ('البيانات المالية',            const CompanyFinancialsWidget()),
      ('حاسبة الاستثمار',             const InvestmentCalculatorWidget()),
      ('سعر السهم',                   const SharePriceWidget()),
      ('تحليل المجموعة المماثلة',     const PeerGroupAnalysisWidget()),
      ('الأداء',                      const PerformanceWidget()),
      ('سلسلة الأسهم',                const ShareSeriesWidget()),
      ('الاشتراك بالبريد الإلكتروني', const EmailSubscriptionWidget()),
    ] : [
      ('Company Snapshot',       const CompanySnapshotWidget()),
      ('Announcements',          const CorporateNewsWidget()),
      ('Fact Sheet',             const FactSheetWidget()),
      ('Stock Activity',         const StockActivityWidget()),
      ('Corporate Actions',      const CorporateActionsWidget()),
      ('Company Financials',     const CompanyFinancialsWidget()),
      ('Investment Calculator',  const InvestmentCalculatorWidget()),
      ('Share Price',            const SharePriceWidget()),
      ('Peer Group Analysis',    const PeerGroupAnalysisWidget()),
      ('Performance',            const PerformanceWidget()),
      ('Share Series',           const ShareSeriesWidget()),
      ('Email Subscription',     const EmailSubscriptionWidget()),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  s.$1,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF101727),
                  ),
                ),
                const SizedBox(height: 12),
                s.$2,
              ],
            ),
          )).toList(),
        ),
      ),
    );
  }
}




