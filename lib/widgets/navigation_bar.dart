// ignore_for_file: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../utils/app_colors.dart';
import '../utils/app_localizations.dart';
import '../utils/ir_section_keys.dart';
import '../utils/scroll_keys.dart';
import '../utils/responsive.dart';
import '../main.dart';
import '../widgets/external_script_widget.dart';
import '../screens/investors_governance_screen.dart';

// ── Global Nav Dropdown Manager ───────────────────────────────────────────────
VoidCallback? _activeNavDropdownCloser;

void _closeActiveNavDropdown() {
  _activeNavDropdownCloser?.call();
  _activeNavDropdownCloser = null;
}
const String _irPageBase = String.fromEnvironment(
  'IR_PAGE_URL',
  defaultValue: 'http://localhost:3001/ir',
);

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  @override
  void initState() {
    super.initState();
    localeProvider.addListener(_onLocaleChanged);
  }

  void _onLocaleChanged() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    localeProvider.removeListener(_onLocaleChanged);
    super.dispose();
  }

  void _goToIR(BuildContext context) {
    context.go('/investors-governance');
  }

  void _openMenu(BuildContext context) {
    final l = AppLocalizations.of(context);
    final currentRoute = GoRouterState.of(context).uri.path;
    final isArabic = localeProvider.isArabic;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return SelectionContainer.disabled(
          child: Directionality(
            textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 8),
                  Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2))),
                  const SizedBox(height: 8),
                  _mobileItem(l.navHome, '/', currentRoute, isArabic, () { Navigator.pop(context); context.go('/'); }),
                  _mobileItem(l.navAboutUs, '/about-us', currentRoute, isArabic, () { Navigator.pop(context); context.go('/about-us'); }),
                  _mobileItem(l.navStrategy, '/strategy-operations', currentRoute, isArabic, () { Navigator.pop(context); context.go('/strategy-operations'); }),
                  _mobileItem(l.navInvestors, '/investors-governance', currentRoute, isArabic, () { Navigator.pop(context); _goToIR(context); }),
                  _mobileItem(l.navNewsroom, '/news-careers', currentRoute, isArabic, () { Navigator.pop(context); context.go('/news-careers'); }),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _mobileItem(String label, String route, String currentRoute, bool isArabic, VoidCallback onTap) {
    final isActive = currentRoute == route;
    return InkWell(
      mouseCursor: SystemMouseCursors.click,
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
          color: isActive ? AppColors.primary.withOpacity(0.05) : Colors.white,
        ),
        child: Row(
          children: [
            if (isActive)
              Container(width: 3, height: 18, color: AppColors.primary,
                margin: EdgeInsets.only(left: isArabic ? 12 : 0, right: isArabic ? 0 : 12)),
            Text(label, style: TextStyle(
              fontSize: 15,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              color: isActive ? AppColors.primary : AppColors.textPrimary,
            )),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = Responsive.getHorizontalPadding(context);
    final isMobile = Responsive.isMobile(context);
    final currentRoute = GoRouterState.of(context).uri.path;
    final l = AppLocalizations.of(context);
    final isAr = l.isArabic;

    return Container(
      height: 70,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(bottom: BorderSide(width: 1, color: AppColors.border)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 2, offset: const Offset(0, 1), spreadRadius: -1),
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 3, offset: const Offset(0, 1), spreadRadius: 0),
        ],
      ),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          children: [
            if (!isAr) ...[
              if (!isMobile) ...[
                _NavItem(text: l.navHome, isActive: currentRoute == '/', onTap: () => context.go('/')),
                const SizedBox(width: 32),
                _AboutDropdownNavItem(isActive: currentRoute == '/about-us', l: l),
                const SizedBox(width: 32),
                _StrategyDropdownNavItem(isActive: currentRoute == '/strategy-operations', l: l),
                const SizedBox(width: 32),
                _IRDropdownNavItem(isActive: currentRoute == '/investors-governance', l: l, onPage: currentRoute == '/investors-governance'),
                const SizedBox(width: 32),
                _NewsroomDropdownNavItem(isActive: currentRoute == '/news-careers', l: l),
              ] else
                IconButton(icon: const Icon(Icons.menu, color: AppColors.textPrimary), onPressed: () => _openMenu(context)),
              const Spacer(),
            ],
            SizedBox(
              width: 144, height: 59,
              child: SvgPicture.asset('assets/images/Al_Saif_Logo.svg', fit: BoxFit.contain),
            ),
            if (isAr) ...[
              const Spacer(),
              if (!isMobile) ...[
                _NewsroomDropdownNavItem(isActive: currentRoute == '/news-careers', l: l),
                const SizedBox(width: 32),
                _IRDropdownNavItem(isActive: currentRoute == '/investors-governance', l: l, onPage: currentRoute == '/investors-governance'),
                const SizedBox(width: 32),
                _StrategyDropdownNavItem(isActive: currentRoute == '/strategy-operations', l: l),
                const SizedBox(width: 32),
                _AboutDropdownNavItem(isActive: currentRoute == '/about-us', l: l),
                const SizedBox(width: 32),
                _NavItem(text: l.navHome, isActive: currentRoute == '/', onTap: () => context.go('/')),
              ] else
                IconButton(icon: const Icon(Icons.menu, color: AppColors.textPrimary), onPressed: () => _openMenu(context)),
            ],
          ],
        ),
      ),
    );
  }
}

// ── About Us Dropdown Nav Item ────────────────────────────────────────────────
class _AboutDropdownNavItem extends StatefulWidget {
  final bool isActive;
  final AppLocalizations l;
  const _AboutDropdownNavItem({required this.isActive, required this.l});
  @override
  State<_AboutDropdownNavItem> createState() => _AboutDropdownNavItemState();
}

class _AboutDropdownNavItemState extends State<_AboutDropdownNavItem> {
  bool _hovered = false;
  OverlayEntry? _overlay;
  final _key = GlobalKey();

  void _show() {
    _closeActiveNavDropdown();
    _remove();
    _activeNavDropdownCloser = _remove;
    final box = _key.currentContext!.findRenderObject() as RenderBox;
    final offset = box.localToGlobal(Offset.zero);
    final isArabic = widget.l.isArabic;

    final items = isArabic ? [
      ('هدفنا',              'our-purpose'),
      ('قيمنا',              'our-values'),
      ('المسيرة والمحطات',   'heritage'),
      ('القيادة',            'leadership'),
    ] : [
      ('Our Purpose',        'our-purpose'),
      ('Our Values',         'our-values'),
      ('Heritage & Milestones', 'heritage'),
      ('Leadership',         'leadership'),
    ];

    _overlay = OverlayEntry(
      builder: (_) => Stack(
        children: [
          Positioned(
            left: isArabic ? null : offset.dx,
            right: isArabic ? MediaQuery.of(context).size.width - offset.dx - box.size.width : null,
            top: offset.dy + box.size.height + 4,
            child: MouseRegion(
              onExit: (_) => _remove(),
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFE8E8E8)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: items.map((item) {
                      return InkWell(
                        onTap: () {
                          _remove();
                          final currentPath = GoRouter.of(context).routerDelegate.currentConfiguration.uri.path;
                          if (currentPath != '/about-us') {
                            GoRouter.of(context).go('/about-us');
                            Future.delayed(const Duration(milliseconds: 400), () => ScrollKeys.scrollTo(item.$2));
                          } else {
                            ScrollKeys.scrollTo(item.$2);
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
                          ),
                          child: Text(item.$1,
                            textAlign: isArabic ? TextAlign.right : TextAlign.left,
                            style: const TextStyle(fontSize: 13, color: Color(0xFF1A1A1A))),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    Overlay.of(context).insert(_overlay!);
  }

  void _remove() { _overlay?.remove(); _overlay = null; if (_activeNavDropdownCloser == _remove) _activeNavDropdownCloser = null; }

  @override
  void dispose() { _remove(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return SelectionContainer.disabled(
      child: MouseRegion(
        key: _key,
        cursor: SystemMouseCursors.click,
        onEnter: (_) { setState(() => _hovered = true); _show(); },
        onExit:  (_) { setState(() => _hovered = false); },
        child: GestureDetector(
          onTap: () => GoRouter.of(context).go('/about-us'),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(widget.l.navAboutUs,
                    style: TextStyle(
                      color: (widget.isActive || _hovered) ? AppColors.textPrimary : AppColors.textSecondary,
                      fontSize: 13.1, fontWeight: FontWeight.w400,
                    )),
                ],
              ),
              const SizedBox(height: 4),
              Container(height: 2, width: 40, color: widget.isActive ? AppColors.primary : Colors.transparent),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Strategy Dropdown Nav Item ────────────────────────────────────────────────
class _StrategyDropdownNavItem extends StatefulWidget {
  final bool isActive;
  final AppLocalizations l;
  const _StrategyDropdownNavItem({required this.isActive, required this.l});
  @override
  State<_StrategyDropdownNavItem> createState() => _StrategyDropdownNavItemState();
}

class _StrategyDropdownNavItemState extends State<_StrategyDropdownNavItem> {
  bool _hovered = false;
  OverlayEntry? _overlay;
  final _key = GlobalKey();

  void _show() {
    _closeActiveNavDropdown();
    _remove();
    _activeNavDropdownCloser = _remove;
    final box = _key.currentContext!.findRenderObject() as RenderBox;
    final offset = box.localToGlobal(Offset.zero);
    final isArabic = widget.l.isArabic;

    final items = isArabic ? [
      ('مقدمة الاستراتيجية',   'strategy-intro'),
      ('ركائز الاستراتيجية',   'strategy-pillars'),
      ('خارطة الطريق',         'strategy-roadmap'),
      ('إدارة المخاطر',        'strategy-risk'),
    ] : [
      ('Strategy Overview',    'strategy-intro'),
      ('Strategic Pillars',    'strategy-pillars'),
      ('Roadmap',              'strategy-roadmap'),
      ('Risk Management',      'strategy-risk'),
    ];

    _overlay = OverlayEntry(
      builder: (_) => Stack(
        children: [
          Positioned(
            left: isArabic ? null : offset.dx,
            right: isArabic ? MediaQuery.of(context).size.width - offset.dx - box.size.width : null,
            top: offset.dy + box.size.height + 4,
            child: MouseRegion(
              onExit: (_) => _remove(),
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFE8E8E8)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: items.map((item) {
                      return InkWell(
                        onTap: () {
                          _remove();
                          final currentPath = GoRouter.of(context).routerDelegate.currentConfiguration.uri.path;
                          if (currentPath != '/strategy-operations') {
                            GoRouter.of(context).go('/strategy-operations');
                            Future.delayed(const Duration(milliseconds: 400), () => ScrollKeys.scrollTo(item.$2));
                          } else {
                            ScrollKeys.scrollTo(item.$2);
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
                          ),
                          child: Text(item.$1,
                            textAlign: isArabic ? TextAlign.right : TextAlign.left,
                            style: const TextStyle(fontSize: 13, color: Color(0xFF1A1A1A))),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    Overlay.of(context).insert(_overlay!);
  }

  void _remove() { _overlay?.remove(); _overlay = null; if (_activeNavDropdownCloser == _remove) _activeNavDropdownCloser = null; }

  @override
  void dispose() { _remove(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return SelectionContainer.disabled(
      child: MouseRegion(
        key: _key,
        cursor: SystemMouseCursors.click,
        onEnter: (_) { setState(() => _hovered = true); _show(); },
        onExit:  (_) { setState(() => _hovered = false); },
        child: GestureDetector(
          onTap: () => GoRouter.of(context).go('/strategy-operations'),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(widget.l.navStrategy,
                    style: TextStyle(
                      color: (widget.isActive || _hovered) ? AppColors.textPrimary : AppColors.textSecondary,
                      fontSize: 13.1, fontWeight: FontWeight.w400,
                    )),
                ],
              ),
              const SizedBox(height: 4),
              Container(height: 2, width: 40, color: widget.isActive ? AppColors.primary : Colors.transparent),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Newsroom Dropdown Nav Item ────────────────────────────────────────────────
class _NewsroomDropdownNavItem extends StatefulWidget {
  final bool isActive;
  final AppLocalizations l;
  const _NewsroomDropdownNavItem({required this.isActive, required this.l});
  @override
  State<_NewsroomDropdownNavItem> createState() => _NewsroomDropdownNavItemState();
}

class _NewsroomDropdownNavItemState extends State<_NewsroomDropdownNavItem> {
  bool _hovered = false;
  OverlayEntry? _overlay;
  final _key = GlobalKey();

  void _show() {
    _closeActiveNavDropdown();
    _remove();
    _activeNavDropdownCloser = _remove;
    final box = _key.currentContext!.findRenderObject() as RenderBox;
    final offset = box.localToGlobal(Offset.zero);
    final isArabic = widget.l.isArabic;

    final items = isArabic ? [
      ('آخر الأخبار',   'news'),
      ('الوظائف',       'careers'),
      ('تواصل معنا',    'contact'),
    ] : [
      ('Latest News',   'news'),
      ('Careers',       'careers'),
      ('Contact Us',    'contact'),
    ];

    _overlay = OverlayEntry(
      builder: (_) => Stack(
        children: [
          Positioned(
            left: isArabic ? null : offset.dx,
            right: isArabic ? MediaQuery.of(context).size.width - offset.dx - box.size.width : null,
            top: offset.dy + box.size.height + 4,
            child: MouseRegion(
              onExit: (_) => _remove(),
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 180,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFE8E8E8)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: items.map((item) {
                      return InkWell(
                        onTap: () {
                          _remove();
                          final currentPath = GoRouter.of(context).routerDelegate.currentConfiguration.uri.path;
                          if (currentPath != '/news-careers') {
                            GoRouter.of(context).go('/news-careers');
                            Future.delayed(const Duration(milliseconds: 400), () => ScrollKeys.scrollTo(item.$2));
                          } else {
                            ScrollKeys.scrollTo(item.$2);
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
                          ),
                          child: Text(item.$1,
                            textAlign: isArabic ? TextAlign.right : TextAlign.left,
                            style: const TextStyle(fontSize: 13, color: Color(0xFF1A1A1A))),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    Overlay.of(context).insert(_overlay!);
  }

  void _remove() { _overlay?.remove(); _overlay = null; if (_activeNavDropdownCloser == _remove) _activeNavDropdownCloser = null; }

  @override
  void dispose() { _remove(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return SelectionContainer.disabled(
      child: MouseRegion(
        key: _key,
        cursor: SystemMouseCursors.click,
        onEnter: (_) { setState(() => _hovered = true); _show(); },
        onExit:  (_) { setState(() => _hovered = false); },
        child: GestureDetector(
          onTap: () => GoRouter.of(context).go('/news-careers'),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(widget.l.navNewsroom,
                    style: TextStyle(
                      color: (widget.isActive || _hovered) ? AppColors.textPrimary : AppColors.textSecondary,
                      fontSize: 13.1, fontWeight: FontWeight.w400,
                    )),
                ],
              ),
              const SizedBox(height: 4),
              Container(height: 2, width: 40, color: widget.isActive ? AppColors.primary : Colors.transparent),
            ],
          ),
        ),
      ),
    );
  }
}

// ── IR Dropdown Nav Item ──────────────────────────────────────────────────────
class _IRDropdownNavItem extends StatefulWidget {
  final bool isActive;
  final bool onPage;
  final AppLocalizations l;
  const _IRDropdownNavItem({required this.isActive, required this.l, required this.onPage});

  @override
  State<_IRDropdownNavItem> createState() => _IRDropdownNavItemState();
}

class _IRDropdownNavItemState extends State<_IRDropdownNavItem> {
  bool _hovered = false;
  OverlayEntry? _overlay;
  final _key = GlobalKey();

  void _showDropdown() {
    _closeActiveNavDropdown();
    _removeDropdown();
    _activeNavDropdownCloser = _removeDropdown;
    setAllIframesPointerEvents(false);
    final ctx = _key.currentContext ?? context;
    final box = ctx.findRenderObject() as RenderBox;
    final offset = box.localToGlobal(Offset.zero);
    final isArabic = widget.l.isArabic;

    final items = isArabic ? [
      ('مقومات الاستثمار',       -1),
      ('نظرة عامة',              0),
      ('الإعلانات',              1),
      ('نشرة المعلومات',         2),
      ('نشاط السهم',             3),
      ('الإجراءات النظامية',     4),
      ('البيانات المالية',       5),
      ('سعر السهم',              6),
      ('الأداء',                 7),
      ('حاسبة الاستثمار',        8),
      ('سلسلة الأسهم',           9),
      ('تحليل المجموعة المماثلة', 10),
      ('الاشتراك',               11),
    ] : [
      ('Investment Case',        -1),
      ('Company Snapshot',       0),
      ('Announcements',          1),
      ('Fact Sheet',             2),
      ('Stock Activity',         3),
      ('Corporate Actions',      4),
      ('Company Financials',     5),
      ('Share Price',            6),
      ('Performance',            7),
      ('Investment Calculator',  8),
      ('Share Series',           9),
      ('Peer Group Analysis',    10),
      ('Subscribe',              11),
    ];

    _overlay = OverlayEntry(
      builder: (_) => Stack(
        children: [
          Positioned(
            left: isArabic ? null : offset.dx,
            right: isArabic ? MediaQuery.of(context).size.width - offset.dx - box.size.width : null,
            top: offset.dy + box.size.height + 4,
            child: MouseRegion(
              onExit: (_) => _removeDropdown(),
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 220,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFE8E8E8)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: items.map((item) {
                      return InkWell(
                        onTap: () {
                          final tabIndex = item.$2;
                          _removeDropdown();
                          final currentPath = GoRouter.of(context).routerDelegate.currentConfiguration.uri.path;
                          if (currentPath != '/investors-governance') {
                            GoRouter.of(context).go('/investors-governance');
                            Future.delayed(const Duration(milliseconds: 600), () {
                              if (tabIndex == -1) {
                                // سكرول للـ Investment Case
                                ScrollKeys.scrollTo('ig-investment-case');
                              } else {
                                irTabBodyKey.currentState?.switchTab(tabIndex);
                                Future.delayed(const Duration(milliseconds: 200), () {
                                  ScrollKeys.scrollTo('ir-widgets');
                                });
                              }
                            });
                          } else {
                            if (tabIndex == -1) {
                              ScrollKeys.scrollTo('ig-investment-case');
                            } else {
                              irTabBodyKey.currentState?.switchTab(tabIndex);
                              Future.delayed(const Duration(milliseconds: 100), () {
                                ScrollKeys.scrollTo('ir-widgets');
                              });
                            }
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
                          ),
                          child: Text(
                            item.$1,
                            textAlign: isArabic ? TextAlign.right : TextAlign.left,
                            style: const TextStyle(fontSize: 13, color: Color(0xFF1A1A1A)),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    Overlay.of(context).insert(_overlay!);
  }

  void _removeDropdown() {
    _overlay?.remove();
    _overlay = null;
    setAllIframesPointerEvents(true);
    if (_activeNavDropdownCloser == _removeDropdown) _activeNavDropdownCloser = null;
  }

  @override
  void dispose() {
    _removeDropdown();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SelectionContainer.disabled(
      child: MouseRegion(
        key: _key,
        cursor: SystemMouseCursors.click,
        onEnter: (_) { setState(() => _hovered = true); _showDropdown(); },
        onExit:  (_) { setState(() => _hovered = false); },
        child: GestureDetector(
          onTap: () => GoRouter.of(context).go('/investors-governance'),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.l.navInvestors,
                style: TextStyle(
                  color: (widget.isActive || _hovered) ? AppColors.textPrimary : AppColors.textSecondary,
                  fontSize: 13.1,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 4),
              Container(height: 2, width: 40, color: widget.isActive ? AppColors.primary : Colors.transparent),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {  final String text;
  final bool isActive;
  final VoidCallback? onTap;

  const _NavItem({required this.text, this.isActive = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SelectionContainer.disabled(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.opaque,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isActive ? AppColors.textPrimary : AppColors.textSecondary,
                  fontSize: 13.1,
                  fontWeight: FontWeight.w400,
                  height: 1.53,
                ),
              ),
              const SizedBox(height: 4),
              Container(height: 2, width: 40, color: isActive ? AppColors.primary : Colors.transparent),
            ],
          ),
        ),
      ),
    );
  }
}
