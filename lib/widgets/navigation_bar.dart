import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../utils/app_colors.dart';
import '../utils/app_localizations.dart';
import '../utils/responsive.dart';
import '../main.dart';

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
        final items = [
          (l.navHome, '/'),
          (l.navAboutUs, '/about-us'),
          (l.navStrategy, '/strategy-operations'),
          (l.navInvestors, '/investors-governance'),
          (l.navNewsroom, '/news-careers'),
        ];
        return Directionality(
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 8),
                Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2))),
                const SizedBox(height: 8),
                ...items.map((item) {
                  final isActive = currentRoute == item.$2;
                  return InkWell(
                    mouseCursor: SystemMouseCursors.click,
                    onTap: () {
                      Navigator.pop(context);
                      context.go(item.$2);
                    },
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
                            Container(width: 3, height: 18, color: AppColors.primary, margin: EdgeInsets.only(left: isArabic ? 12 : 0, right: isArabic ? 0 : 12)),
                          Text(
                            item.$1,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                              color: isActive ? AppColors.primary : AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = Responsive.getHorizontalPadding(context);
    final isMobile = Responsive.isMobile(context);
    final currentRoute = GoRouterState.of(context).uri.path;
    final l = AppLocalizations.of(context);

    return Container(
      height: 70,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(
          bottom: BorderSide(width: 1, color: AppColors.border),
        ),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 2, offset: const Offset(0, 1), spreadRadius: -1),
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 3, offset: const Offset(0, 1), spreadRadius: 0),
        ],
      ),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          children: [
            if (!l.isArabic) ...[
              if (!isMobile) ...[
                _NavItem(text: l.navHome, isActive: currentRoute == '/', onTap: () => context.go('/')),
                const SizedBox(width: 32),
                _NavItem(text: l.navAboutUs, isActive: currentRoute == '/about-us', onTap: () => context.go('/about-us')),
                const SizedBox(width: 32),
                _NavItem(text: l.navStrategy, isActive: currentRoute == '/strategy-operations', onTap: () => context.go('/strategy-operations')),
                const SizedBox(width: 32),
                _NavItem(text: l.navInvestors, isActive: currentRoute == '/investors-governance', onTap: () => context.go('/investors-governance')),
                const SizedBox(width: 32),
                _NavItem(text: l.navNewsroom, isActive: currentRoute == '/news-careers', onTap: () => context.go('/news-careers')),
              ] else
                IconButton(
                  icon: const Icon(Icons.menu, color: AppColors.textPrimary),
                  onPressed: () => _openMenu(context),
                ),
              const Spacer(),
            ],
            SizedBox(
              width: 144,
              height: 59,
              child: SvgPicture.asset('assets/images/Al_Saif_Logo.svg', fit: BoxFit.contain),
            ),
            if (l.isArabic) ...[
              const Spacer(),
              if (!isMobile) ...[
                _NavItem(text: l.navNewsroom, isActive: currentRoute == '/news-careers', onTap: () => context.go('/news-careers')),
                const SizedBox(width: 32),
                _NavItem(text: l.navInvestors, isActive: currentRoute == '/investors-governance', onTap: () => context.go('/investors-governance')),
                const SizedBox(width: 32),
                _NavItem(text: l.navStrategy, isActive: currentRoute == '/strategy-operations', onTap: () => context.go('/strategy-operations')),
                const SizedBox(width: 32),
                _NavItem(text: l.navAboutUs, isActive: currentRoute == '/about-us', onTap: () => context.go('/about-us')),
                const SizedBox(width: 32),
                _NavItem(text: l.navHome, isActive: currentRoute == '/', onTap: () => context.go('/')),
              ] else
                IconButton(
                  icon: const Icon(Icons.menu, color: AppColors.textPrimary),
                  onPressed: () => _openMenu(context),
                ),
            ],
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String text;
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





