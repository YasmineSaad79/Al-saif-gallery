import 'package:flutter/material.dart';
import '../widgets/top_bar.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/ig_hero_section.dart';
import '../widgets/ig_intro_section.dart';
import '../widgets/ig_investment_case_section.dart';
import '../widgets/stock_ticker_widget.dart';
import '../widgets/company_snapshot_widget.dart';
import '../widgets/fact_sheet_table_widget.dart';
import '../widgets/fact_sheet_charts_widget.dart';
import '../widgets/stock_activity_simple_widget.dart';
import '../widgets/stock_activity_advanced_widget.dart';
import '../widgets/corporate_actions_widget.dart';
import '../widgets/corporate_news_widget.dart';
import '../widgets/company_financials_widget.dart';
import '../widgets/investment_calculator_widget.dart';
import '../widgets/share_price_widget.dart';
import '../widgets/email_subscription_widget.dart';
import '../widgets/peer_group_analysis_widget.dart';
import '../widgets/performance_widget.dart';
import '../widgets/share_series_widget.dart';
import '../widgets/footer_section.dart';
import '../utils/responsive.dart';
import '../main.dart';

class InvestorsGovernanceScreen extends StatelessWidget {
  const InvestorsGovernanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SelectionArea(
        child: Center(
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
                      children: const [
                        IGHeroSection(),
                        IGIntroSection(),
                        IGInvestmentCaseSection(),
                        _StockTickerSection(),
                        _CompanySnapshotSection(),
                        _CorporateNewsSection(),
                        _FactSheetSection(),
                        _StockActivitySection(),
                        _CorporateActionsSection(),
                        _CompanyFinancialsSection(),
                        _InvestmentCalculatorSection(),
                        _SharePriceSection(),
                        _PeerGroupAnalysisSection(),
                        _PerformanceSection(),
                        _ShareSeriesSection(),
                        _EmailSubscriptionSection(),
                        FooterSection(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ===== مساعد لبناء section بعنوان =====
class _SectionWithTitle extends StatefulWidget {
  final String titleEn;
  final String titleAr;
  final Widget child;
  final double topPad;
  final bool showTitle;

  const _SectionWithTitle({
    required this.titleEn,
    required this.titleAr,
    required this.child,
    this.topPad = 8,
    this.showTitle = true,
  });

  @override
  State<_SectionWithTitle> createState() => _SectionWithTitleState();
}

class _SectionWithTitleState extends State<_SectionWithTitle> {
  @override
  void initState() { super.initState(); localeProvider.addListener(_rebuild); }
  void _rebuild() { if (mounted) setState(() {}); }
  @override
  void dispose() { localeProvider.removeListener(_rebuild); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final hp = Responsive.getHorizontalPadding(context);
    final isArabic = localeProvider.isArabic;
    final title = isArabic ? widget.titleAr : widget.titleEn;

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(hp, widget.topPad, hp, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.showTitle) ...[
            SizedBox(
              width: double.infinity,
              child: Text(
                title,
                textAlign: isArabic ? TextAlign.right : TextAlign.left,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 8),
          ],
          Directionality(
            textDirection: TextDirection.ltr,
            child: widget.child,
          ),
        ],
      ),
    );
  }
}

// ===== Stock Ticker (بدون عنوان) =====
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

// ===== Company Snapshot =====
class _CompanySnapshotSection extends StatelessWidget {
  const _CompanySnapshotSection();
  @override
  Widget build(BuildContext context) {
    return const _SectionWithTitle(
      titleEn: 'Company Snapshot',
      titleAr: 'نظرة عامة عن الشركة',
      child: CompanySnapshotWidget(),
    );
  }
}

// ===== Announcements =====
class _CorporateNewsSection extends StatelessWidget {
  const _CorporateNewsSection();
  @override
  Widget build(BuildContext context) {
    return const _SectionWithTitle(
      titleEn: 'Announcements',
      titleAr: 'الإعلانات',
      child: CorporateNewsWidget(),
    );
  }
}

// ===== Fact Sheet =====
class _FactSheetSection extends StatefulWidget {
  const _FactSheetSection();
  @override
  State<_FactSheetSection> createState() => _FactSheetSectionState();
}

class _FactSheetSectionState extends State<_FactSheetSection> {
  int _tab = 0;

  @override
  void initState() { super.initState(); localeProvider.addListener(_rebuild); }
  void _rebuild() { if (mounted) setState(() {}); }
  @override
  void dispose() { localeProvider.removeListener(_rebuild); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final hp = Responsive.getHorizontalPadding(context);
    final isArabic = localeProvider.isArabic;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        width: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(hp, 8, hp, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(isArabic ? 'نشرة المعلومات' : 'Fact Sheet',
                  textAlign: isArabic ? TextAlign.right : TextAlign.left,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: isArabic ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                _TabButton(label: isArabic ? 'جدول' : 'Table', selected: _tab == 0, onTap: () => setState(() => _tab = 0)),
                const SizedBox(width: 8),
                _TabButton(label: isArabic ? 'رسم بياني' : 'Chart', selected: _tab == 1, onTap: () => setState(() => _tab = 1)),
              ],
            ),
            const SizedBox(height: 16),
            if (_tab == 0) const FactSheetTableWidget(),
            if (_tab == 1) const FactSheetChartsWidget(),
          ],
        ),
      ),
    );
  }
}

// ===== Stock Activity =====
class _StockActivitySection extends StatefulWidget {
  const _StockActivitySection();
  @override
  State<_StockActivitySection> createState() => _StockActivitySectionState();
}

class _StockActivitySectionState extends State<_StockActivitySection> {
  int _tab = 0;

  @override
  void initState() { super.initState(); localeProvider.addListener(_rebuild); }
  void _rebuild() { if (mounted) setState(() {}); }
  @override
  void dispose() { localeProvider.removeListener(_rebuild); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final hp = Responsive.getHorizontalPadding(context);
    final isArabic = localeProvider.isArabic;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        width: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(hp, 8, hp, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(isArabic ? 'نشاط السهم' : 'Stock Activity',
                  textAlign: isArabic ? TextAlign.right : TextAlign.left,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: isArabic ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                _TabButton(label: isArabic ? 'بسيط' : 'Simple', selected: _tab == 0, onTap: () => setState(() => _tab = 0)),
                const SizedBox(width: 8),
                _TabButton(label: isArabic ? 'متقدم' : 'Advanced', selected: _tab == 1, onTap: () => setState(() => _tab = 1)),
              ],
            ),
            const SizedBox(height: 16),
            if (_tab == 0) const StockActivitySimpleWidget(),
            if (_tab == 1) const StockActivityAdvancedWidget(),
          ],
        ),
      ),
    );
  }
}

// ===== Corporate Actions =====
class _CorporateActionsSection extends StatelessWidget {
  const _CorporateActionsSection();
  @override
  Widget build(BuildContext context) {
    return const _SectionWithTitle(
      titleEn: 'Corporate Actions',
      titleAr: 'الإجراءات النظامية',
      child: CorporateActionsWidget(),
    );
  }
}

// ===== Company Financials =====
class _CompanyFinancialsSection extends StatelessWidget {
  const _CompanyFinancialsSection();
  @override
  Widget build(BuildContext context) {
    return const _SectionWithTitle(
      titleEn: 'Company Financials',
      titleAr: 'البيانات المالية',
      child: CompanyFinancialsWidget(),
    );
  }
}

// ===== Investment Calculator =====
class _InvestmentCalculatorSection extends StatelessWidget {
  const _InvestmentCalculatorSection();
  @override
  Widget build(BuildContext context) {
    return const _SectionWithTitle(
      titleEn: 'Investment Calculator',
      titleAr: 'حاسبة الاستثمار',
      child: InvestmentCalculatorWidget(),
    );
  }
}

// ===== Share Price =====
class _SharePriceSection extends StatelessWidget {
  const _SharePriceSection();
  @override
  Widget build(BuildContext context) {
    return const _SectionWithTitle(
      titleEn: 'Share Price',
      titleAr: 'سعر السهم',
      child: SharePriceWidget(),
    );
  }
}

// ===== Peer Group Analysis =====
class _PeerGroupAnalysisSection extends StatelessWidget {
  const _PeerGroupAnalysisSection();
  @override
  Widget build(BuildContext context) {
    return const _SectionWithTitle(
      titleEn: 'Peer Group Analysis',
      titleAr: 'تحليل المجموعة المماثلة',
      child: PeerGroupAnalysisWidget(),
    );
  }
}

// ===== Performance =====
class _PerformanceSection extends StatelessWidget {
  const _PerformanceSection();
  @override
  Widget build(BuildContext context) {
    return const _SectionWithTitle(
      titleEn: 'Performance',
      titleAr: 'الأداء',
      child: PerformanceWidget(),
    );
  }
}

// ===== Share Series =====
class _ShareSeriesSection extends StatelessWidget {
  const _ShareSeriesSection();
  @override
  Widget build(BuildContext context) {
    return const _SectionWithTitle(
      titleEn: 'Share Series',
      titleAr: 'سلسلة الأسهم',
      child: ShareSeriesWidget(),
    );
  }
}

// ===== Email Subscription =====
class _EmailSubscriptionSection extends StatelessWidget {
  const _EmailSubscriptionSection();
  @override
  Widget build(BuildContext context) {
    return const _SectionWithTitle(
      titleEn: 'Email Subscription',
      titleAr: 'الاشتراك بالبريد الإلكتروني',
      child: EmailSubscriptionWidget(),
    );
  }
}

// ===== Tab Button =====
class _TabButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _TabButton({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(6),
          border: selected
              ? Border.all(color: Colors.red, width: 2)
              : Border.all(color: Colors.transparent),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.black : Colors.grey,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
