// ignore_for_file: avoid_web_libraries_in_flutter
import 'dart:html' as html;
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
import '../utils/app_colors.dart';
import '../utils/app_localizations.dart';
import '../utils/responsive.dart';
import '../main.dart';
import '../widgets/external_script_widget.dart';

// Global key عشان الـ navbar يقدر يغير الـ tab
final GlobalKey<_IRTabBodyState> irTabBodyKey = GlobalKey<_IRTabBodyState>();

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
                  child: CustomScrollView(
                    controller: irScrollController,
                    slivers: [
                      // ── Non-sticky content ──
                      const SliverToBoxAdapter(child: IGHeroSection()),
                      const SliverToBoxAdapter(child: IGIntroSection()),
                      const SliverToBoxAdapter(child: IGInvestmentCaseSection()),
                      const SliverToBoxAdapter(child: _StockTickerSection()),
                      // ── Sticky Tab Bar ──
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: _IRTabBarDelegate(tabBodyKey: irTabBodyKey),
                      ),
                      // ── Tab Content ──
                      SliverToBoxAdapter(child: _IRTabContent(key: irTabBodyKey)),
                      const SliverToBoxAdapter(child: FooterSection()),
                    ],
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

// ── Shared Tab State ──────────────────────────────────────────────────────────
class _IRTabBodyState extends State<_IRTabContent> {
  int _selectedTab = 0;

  void switchTab(int index) {
    if (mounted) setState(() => _selectedTab = index);
  }

  @override
  void initState() {
    super.initState();
    localeProvider.addListener(_rebuild);
  }

  void _rebuild() { if (mounted) setState(() {}); }

  @override
  void dispose() {
    localeProvider.removeListener(_rebuild);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final isArabic = l.isArabic;
    final hp = Responsive.getHorizontalPadding(context);

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(color: Colors.white),
      padding: EdgeInsets.symmetric(horizontal: hp, vertical: 16),
      child: _buildTabContent(_selectedTab, isArabic),
    );
  }

  Widget _buildTabContent(int index, bool isArabic) {
    final titles = isArabic ? [
      'نظرة عامة عن الشركة', 'الإعلانات', 'نشرة المعلومات', 'نشاط السهم',
      'الإجراءات النظامية', 'البيانات المالية', 'سعر السهم', 'الأداء',
      'حاسبة الاستثمار', 'سلسلة الأسهم', 'تحليل المجموعة المماثلة', 'الاشتراك بالبريد الإلكتروني',
    ] : [
      'Company Snapshot', 'Announcements', 'Fact Sheet', 'Stock Activity',
      'Corporate Actions', 'Company Financials', 'Share Price', 'Performance',
      'Investment Calculator', 'Share Series', 'Peer Group Analysis', 'Email Subscription',
    ];

    final widgets = [
      const CompanySnapshotWidget(),
      const CorporateNewsWidget(),
      _FactSheetContent(isArabic: isArabic),
      _StockActivityContent(isArabic: isArabic),
      const CorporateActionsWidget(),
      const CompanyFinancialsWidget(),
      const SharePriceWidget(),
      const PerformanceWidget(),
      const InvestmentCalculatorWidget(),
      const ShareSeriesWidget(),
      const PeerGroupAnalysisWidget(),
      const EmailSubscriptionWidget(),
    ];

    if (index < 0 || index >= titles.length) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Directionality(
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              titles[index],
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A1A1A),
              ),
            ),
          ),
        ),
        widgets[index],
      ],
    );
  }
}

class _IRTabContent extends StatefulWidget {
  const _IRTabContent({super.key});
  @override
  State<_IRTabContent> createState() => _IRTabBodyState();
}

// ── Tab Bar Delegate (Sticky) ─────────────────────────────────────────────────
class _IRTabBarDelegate extends SliverPersistentHeaderDelegate {
  final GlobalKey<_IRTabBodyState> tabBodyKey;
  _IRTabBarDelegate({required this.tabBodyKey});

  @override
  double get minExtent => 64;
  @override
  double get maxExtent => 64;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return MouseRegion(
      onEnter: (_) => setAllIframesPointerEvents(false),
      onExit:  (_) => setAllIframesPointerEvents(true),
      child: _IRStickyTabBar(tabBodyKey: tabBodyKey),
    );
  }

  @override
  bool shouldRebuild(_IRTabBarDelegate oldDelegate) => false;
}

// ── Sticky Tab Bar ────────────────────────────────────────────────────────────
class _IRStickyTabBar extends StatefulWidget {
  final GlobalKey<_IRTabBodyState> tabBodyKey;
  const _IRStickyTabBar({required this.tabBodyKey});
  @override
  State<_IRStickyTabBar> createState() => _IRStickyTabBarState();
}

class _IRStickyTabBarState extends State<_IRStickyTabBar> {
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    localeProvider.addListener(_rebuild);
  }

  void _rebuild() { if (mounted) setState(() {}); }

  @override
  void dispose() {
    localeProvider.removeListener(_rebuild);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final isArabic = l.isArabic;
    final hp = Responsive.getHorizontalPadding(context);

    final tabs = isArabic ? [
      'نظرة عامة', 'الإعلانات', 'نشرة المعلومات', 'نشاط السهم',
      'الإجراءات', 'البيانات المالية', 'سعر السهم', 'الأداء',
    ] : [
      'Company Snapshot', 'Announcements', 'Fact Sheet', 'Stock Activity',
      'Corporate Actions', 'Company Financials', 'Share Price', 'Performance',
    ];

    final analyticsItems = isArabic ? [
      'حاسبة الاستثمار', 'سلسلة الأسهم', 'تحليل المجموعة المماثلة',
    ] : [
      'Investment Calculator', 'Share Series', 'Peer Group Analysis',
    ];

    // كل الـ tabs مجمعة
    final allTabs = [
      ...tabs,
      isArabic ? 'تحليلات: حاسبة الاستثمار' : 'Analytics: Investment Calculator',
      isArabic ? 'تحليلات: سلسلة الأسهم' : 'Analytics: Share Series',
      isArabic ? 'تحليلات: تحليل المجموعة' : 'Analytics: Peer Group Analysis',
      isArabic ? 'الاشتراك' : 'Subscribe',
    ];

    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFB),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Directionality(
        textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        child: isMobile
            ? _MobileTabDropdown(
                selectedIndex: _selectedTab,
                allTabs: allTabs,
                onSelect: (i) {
                  setState(() => _selectedTab = i);
                  widget.tabBodyKey.currentState?.switchTab(i);
                },
                isArabic: isArabic,
                hp: hp,
              )
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: hp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ...List.generate(tabs.length, (i) {
                      return _IRTab(
                        label: tabs[i],
                        isActive: _selectedTab == i,
                        onTap: () {
                          setState(() => _selectedTab = i);
                          widget.tabBodyKey.currentState?.switchTab(i);
                        },
                      );
                    }),
                    _IRDropdownTab(
                      label: isArabic ? 'تحليلات' : 'Analytics',
                      isActive: _selectedTab >= 8 && _selectedTab <= 10,
                      items: analyticsItems,
                      onSelect: (i) {
                        setState(() => _selectedTab = 8 + i);
                        widget.tabBodyKey.currentState?.switchTab(8 + i);
                      },
                    ),
                    _IRTab(
                      label: isArabic ? 'الاشتراك' : 'Subscribe',
                      isActive: _selectedTab == 11,
                      onTap: () {
                        setState(() => _selectedTab = 11);
                        widget.tabBodyKey.currentState?.switchTab(11);
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

// ── Mobile Tab Dropdown ───────────────────────────────────────────────────────
class _MobileTabDropdown extends StatelessWidget {
  final int selectedIndex;
  final List<String> allTabs;
  final void Function(int) onSelect;
  final bool isArabic;
  final double hp;

  const _MobileTabDropdown({
    required this.selectedIndex,
    required this.allTabs,
    required this.onSelect,
    required this.isArabic,
    required this.hp,
  });

  @override
  Widget build(BuildContext context) {
    final label = selectedIndex < allTabs.length ? allTabs[selectedIndex] : allTabs[0];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: hp, vertical: 8),
      child: SelectionContainer.disabled(
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => _showSheet(context),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.primary, width: 1.5),
              ),
              child: Row(
                mainAxisAlignment: isArabic ? MainAxisAlignment.end : MainAxisAlignment.spaceBetween,
                children: [
                  if (!isArabic) Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.primary)),
                  const Icon(Icons.keyboard_arrow_down, color: AppColors.primary, size: 18),
                  if (isArabic) Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.primary)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (_) => SelectionContainer.disabled(
        child: Directionality(
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2))),
              const SizedBox(height: 8),
              ...List.generate(allTabs.length, (i) {
                final isActive = selectedIndex == i;
                return InkWell(
                  onTap: () { Navigator.pop(context); onSelect(i); },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    decoration: BoxDecoration(
                      color: isActive ? AppColors.primary.withOpacity(0.05) : Colors.white,
                      border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
                    ),
                    child: Row(
                      children: [
                        if (isActive) Container(width: 3, height: 16, color: AppColors.primary, margin: const EdgeInsets.only(right: 10)),
                        Text(allTabs[i], style: TextStyle(
                          fontSize: 14,
                          fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                          color: isActive ? AppColors.primary : const Color(0xFF1A1A1A),
                        )),
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Old _IRTabBody removed ────────────────────────────────────────────────────

// ── Fact Sheet Tab ────────────────────────────────────────────────────────────
class _FactSheetContent extends StatefulWidget {
  final bool isArabic;
  const _FactSheetContent({required this.isArabic});
  @override
  State<_FactSheetContent> createState() => _FactSheetContentState();
}

class _FactSheetContentState extends State<_FactSheetContent> {
  int _tab = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _SubTab(label: widget.isArabic ? 'جدول' : 'Table', selected: _tab == 0, onTap: () => setState(() => _tab = 0)),
            const SizedBox(width: 8),
            _SubTab(label: widget.isArabic ? 'رسم بياني' : 'Chart', selected: _tab == 1, onTap: () => setState(() => _tab = 1)),
          ],
        ),
        const SizedBox(height: 16),
        if (_tab == 0) const FactSheetTableWidget(),
        if (_tab == 1) const FactSheetChartsWidget(),
      ],
    );
  }
}

// ── Stock Activity Tab ────────────────────────────────────────────────────────
class _StockActivityContent extends StatefulWidget {
  final bool isArabic;
  const _StockActivityContent({required this.isArabic});
  @override
  State<_StockActivityContent> createState() => _StockActivityContentState();
}

class _StockActivityContentState extends State<_StockActivityContent> {
  int _tab = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _SubTab(label: widget.isArabic ? 'بسيط' : 'Simple', selected: _tab == 0, onTap: () => setState(() => _tab = 0)),
            const SizedBox(width: 8),
            _SubTab(label: widget.isArabic ? 'متقدم' : 'Advanced', selected: _tab == 1, onTap: () => setState(() => _tab = 1)),
          ],
        ),
        const SizedBox(height: 16),
        if (_tab == 0) const StockActivitySimpleWidget(),
        if (_tab == 1) const StockActivityAdvancedWidget(),
      ],
    );
  }
}

// ── More Tab ──────────────────────────────────────────────────────────────────
class _MoreContent extends StatelessWidget {
  final bool isArabic;
  const _MoreContent({required this.isArabic});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PerformanceWidget(),
        const SizedBox(height: 24),
        Text(isArabic ? 'حاسبة الاستثمار' : 'Investment Calculator',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        const InvestmentCalculatorWidget(),
        const SizedBox(height: 24),
        Text(isArabic ? 'تحليل المجموعة المماثلة' : 'Peer Group Analysis',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        const PeerGroupAnalysisWidget(),
        const SizedBox(height: 24),
        Text(isArabic ? 'سلسلة الأسهم' : 'Share Series',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        const ShareSeriesWidget(),
        const SizedBox(height: 24),
        const EmailSubscriptionWidget(),
      ],
    );
  }
}

// ── IR Dropdown Tab ───────────────────────────────────────────────────────────
class _IRDropdownTab extends StatefulWidget {
  final String label;
  final bool isActive;
  final List<String> items;
  final void Function(int) onSelect;
  const _IRDropdownTab({required this.label, required this.isActive, required this.items, required this.onSelect});
  @override
  State<_IRDropdownTab> createState() => _IRDropdownTabState();
}

class _IRDropdownTabState extends State<_IRDropdownTab> {
  bool _hovered = false;
  OverlayEntry? _overlay;
  final _key = GlobalKey();

  void _show() {
    _remove();
    setAllIframesPointerEvents(false);
    final box = _key.currentContext!.findRenderObject() as RenderBox;
    final offset = box.localToGlobal(Offset.zero);

    // بناء الـ dropdown كـ HTML element مباشرة فوق كل شي
    final dropdown = html.DivElement()
      ..id = 'ir-dropdown'
      ..style.position = 'fixed'
      ..style.left = '${offset.dx}px'
      ..style.top = '${offset.dy + box.size.height}px'
      ..style.background = 'white'
      ..style.borderRadius = '8px'
      ..style.boxShadow = '0 4px 16px rgba(0,0,0,0.12)'
      ..style.border = '1px solid #E8E8E8'
      ..style.zIndex = '99999'
      ..style.minWidth = '200px'
      ..style.overflow = 'hidden';

    for (var i = 0; i < widget.items.length; i++) {
      final item = html.DivElement()
        ..text = widget.items[i]
        ..style.padding = '12px 16px'
        ..style.cursor = 'pointer'
        ..style.fontSize = '13px'
        ..style.color = '#1A1A1A'
        ..style.borderBottom = i < widget.items.length - 1 ? '1px solid #F3F4F6' : 'none';

      final idx = i;
      item.onMouseEnter.listen((_) => item.style.background = '#F8FAFB');
      item.onMouseLeave.listen((_) => item.style.background = 'white');
      item.onClick.listen((_) {
        _remove();
        widget.onSelect(idx);
      });
      dropdown.append(item);
    }

    // كبسة خارج الـ dropdown تغلقه
    _outsideClickListener = (html.Event e) {
      if (!dropdown.contains(e.target as html.Node?)) {
        _remove();
      }
    };
    html.document.addEventListener('click', _outsideClickListener!);
    html.document.body!.append(dropdown);
    _htmlDropdown = dropdown;
  }

  html.DivElement? _htmlDropdown;
  html.EventListener? _outsideClickListener;

  void _remove() {
    _htmlDropdown?.remove();
    _htmlDropdown = null;
    if (_outsideClickListener != null) {
      html.document.removeEventListener('click', _outsideClickListener!);
      _outsideClickListener = null;
    }
    setAllIframesPointerEvents(true);
    _overlay?.remove();
    _overlay = null;
  }

  @override
  void dispose() { _remove(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final highlight = widget.isActive || _hovered;
    return MouseRegion(
      key: _key,
      cursor: SystemMouseCursors.click,
      onEnter: (_) { setState(() => _hovered = true); _show(); },
      onExit:  (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: _show,
        child: SelectionContainer.disabled(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: widget.isActive ? Colors.white : (highlight ? Colors.white.withOpacity(0.6) : Colors.transparent),
              border: Border(
                top: BorderSide(color: widget.isActive ? AppColors.primary : Colors.transparent, width: 2),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: widget.isActive ? FontWeight.w600 : FontWeight.w400,
                    color: highlight ? AppColors.primary : const Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(width: 3),
                Icon(Icons.keyboard_arrow_down, size: 14,
                  color: highlight ? AppColors.primary : const Color(0xFF6B7280)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── IR Tab ────────────────────────────────────────────────────────────────────
class _IRTab extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  const _IRTab({required this.label, required this.isActive, required this.onTap});
  @override
  State<_IRTab> createState() => _IRTabState();
}

class _IRTabState extends State<_IRTab> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          margin: const EdgeInsets.only(top: 8),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: widget.isActive ? Colors.white : (_hovered ? Colors.white.withOpacity(0.6) : Colors.transparent),
            border: Border(
              top: BorderSide(
                color: widget.isActive ? AppColors.primary : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: SelectionContainer.disabled(
            child: Text(
              widget.label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.visible,
              softWrap: false,
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: widget.isActive ? FontWeight.w600 : FontWeight.w400,
                color: widget.isActive
                    ? AppColors.primary
                    : _hovered
                        ? AppColors.primary
                        : const Color(0xFF6B7280),
              ),
            ),
          ),
        ),
      ),
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

// ── Sub Tab Button ────────────────────────────────────────────────────────────
class _SubTab extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _SubTab({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
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
      ),
    );
  }
}
