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

class InvestorsGovernanceScreen extends StatelessWidget {
  const InvestorsGovernanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          constraints: const BoxConstraints(maxWidth: 1880),
          color: const Color(0xFFF8FAFB),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                TopBar(),
                CustomNavigationBar(),
                IGHeroSection(),
                IGIntroSection(),
                IGInvestmentCaseSection(),
                _StockTickerSection(),
                _CompanySnapshotSection(),
                _FactSheetSection(),
                _StockActivitySection(),
                _CorporateActionsSection(),
                _CorporateNewsSection(),
                _CompanyFinancialsSection(),
                _InvestmentCalculatorSection(),
                _SharePriceSection(),
                _EmailSubscriptionSection(),
                _PeerGroupAnalysisSection(),
                _PerformanceSection(),
                _ShareSeriesSection(),
                FooterSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ===== Stock Ticker =====
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Stock Ticker', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            SizedBox(
              height: 66,
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  color: Color(0xFFF8F9FA),
                  border: Border(
                    top: BorderSide(color: Color(0xFFE53935), width: 2),
                    bottom: BorderSide(color: Color(0xFFE53935), width: 2),
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: const StockTickerWidget(),
              ),
            ),
          ],
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
    final hp = Responsive.getHorizontalPadding(context);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        width: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(hp, 8, hp, 0),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Company Snapshot', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            CompanySnapshotWidget(),
          ],
        ),
      ),
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
  Widget build(BuildContext context) {
    final hp = Responsive.getHorizontalPadding(context);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        width: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(hp, 8, hp, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Fact Sheet', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Row(
              children: [
                _TabButton(label: 'Table', selected: _tab == 0, onTap: () => setState(() => _tab = 0)),
                const SizedBox(width: 8),
                _TabButton(label: 'Chart', selected: _tab == 1, onTap: () => setState(() => _tab = 1)),
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
  Widget build(BuildContext context) {
    final hp = Responsive.getHorizontalPadding(context);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        width: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(hp, 8, hp, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Stock Activity', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Row(
              children: [
                _TabButton(label: 'Simple', selected: _tab == 0, onTap: () => setState(() => _tab = 0)),
                const SizedBox(width: 8),
                _TabButton(label: 'Advanced', selected: _tab == 1, onTap: () => setState(() => _tab = 1)),
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
    final hp = Responsive.getHorizontalPadding(context);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        width: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(hp, 8, hp, 0),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Corporate Actions', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            CorporateActionsWidget(),
          ],
        ),
      ),
    );
  }
}

// ===== Corporate News =====
class _CorporateNewsSection extends StatelessWidget {
  const _CorporateNewsSection();
  @override
  Widget build(BuildContext context) {
    final hp = Responsive.getHorizontalPadding(context);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        width: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(hp, 8, hp, 0),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Corporate News', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            CorporateNewsWidget(),
          ],
        ),
      ),
    );
  }
}

// ===== Company Financials =====
class _CompanyFinancialsSection extends StatelessWidget {
  const _CompanyFinancialsSection();
  @override
  Widget build(BuildContext context) {
    final hp = Responsive.getHorizontalPadding(context);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        width: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(hp, 8, hp, 0),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Company Financials', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            CompanyFinancialsWidget(),
          ],
        ),
      ),
    );
  }
}

// ===== Investment Calculator =====
class _InvestmentCalculatorSection extends StatelessWidget {
  const _InvestmentCalculatorSection();
  @override
  Widget build(BuildContext context) {
    final hp = Responsive.getHorizontalPadding(context);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        width: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(hp, 8, hp, 0),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Investment Calculator', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            InvestmentCalculatorWidget(),
          ],
        ),
      ),
    );
  }
}

// ===== Share Price =====
class _SharePriceSection extends StatelessWidget {
  const _SharePriceSection();
  @override
  Widget build(BuildContext context) {
    final hp = Responsive.getHorizontalPadding(context);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        width: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(hp, 8, hp, 0),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Share Price', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            SharePriceWidget(),
          ],
        ),
      ),
    );
  }
}

// ===== Email Subscription =====
class _EmailSubscriptionSection extends StatelessWidget {
  const _EmailSubscriptionSection();
  @override
  Widget build(BuildContext context) {
    final hp = Responsive.getHorizontalPadding(context);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        width: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(hp, 8, hp, 0),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Email Subscription', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            EmailSubscriptionWidget(),
          ],
        ),
      ),
    );
  }
}

// ===== Share Series =====
class _ShareSeriesSection extends StatelessWidget {
  const _ShareSeriesSection();
  @override
  Widget build(BuildContext context) {
    final hp = Responsive.getHorizontalPadding(context);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        width: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(hp, 8, hp, 0),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Share Series', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            ShareSeriesWidget(),
          ],
        ),
      ),
    );
  }
}

// ===== Performance =====
class _PerformanceSection extends StatelessWidget {
  const _PerformanceSection();
  @override
  Widget build(BuildContext context) {
    final hp = Responsive.getHorizontalPadding(context);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        width: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(hp, 8, hp, 0),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Performance', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            PerformanceWidget(),
          ],
        ),
      ),
    );
  }
}

// ===== Peer Group Analysis =====
class _PeerGroupAnalysisSection extends StatelessWidget {
  const _PeerGroupAnalysisSection();
  @override
  Widget build(BuildContext context) {
    final hp = Responsive.getHorizontalPadding(context);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        width: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(hp, 8, hp, 0),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Peer Group Analysis', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            PeerGroupAnalysisWidget(),
          ],
        ),
      ),
    );
  }
}

// ===== Tab Button مخصص =====
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
