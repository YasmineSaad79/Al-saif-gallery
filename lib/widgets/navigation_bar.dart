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
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 2,
            offset: const Offset(0, 1),
            spreadRadius: -1,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 3,
            offset: const Offset(0, 1),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          // اللوجو دائماً في اليسار
          SizedBox(
            width: 144,
            height: 59,
            child: SvgPicture.asset(
              'assets/images/Al_Saif_Logo.svg',
              fit: BoxFit.contain,
            ),
          ),
          const Spacer(),
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
              icon: const Icon(Icons.menu),
              onPressed: () {},
            ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String text;
  final bool isActive;
  final VoidCallback? onTap;

  const _NavItem({
    required this.text,
    this.isActive = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isActive ? AppColors.textPrimary : AppColors.textSecondary,
                fontSize: 13.1,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 1.53,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              height: 2,
              width: 40,
              color: isActive ? AppColors.primary : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}
