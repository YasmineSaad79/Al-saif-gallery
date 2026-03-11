import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = Responsive.getHorizontalPadding(context);
    final showAllItems = !Responsive.isMobile(context);
    
    return Container(
      width: double.infinity,
      height: 37,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      decoration: const BoxDecoration(
        color: AppColors.backgroundLight,
        border: Border(
          bottom: BorderSide(width: 1, color: AppColors.border),
        ),
      ),
      child: Row(
        children: [
          // مسافة فارغة بنفس عرض اللوجو
          const SizedBox(width: 144),
          const Spacer(),
          // Top bar items
          if (showAllItems) ...[
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  _TopBarItem(iconPath: 'assets/images/document.svg', text: 'Documents Library', onTap: () => context.go('/documents-library')),
                  const SizedBox(width: 24),
                  _TopBarItem(iconPath: 'assets/images/Whistleblowing.svg', text: 'Whistleblowing', onTap: () => context.go('/whistleblowing')),
                  const SizedBox(width: 24),
                  _TopBarItem(iconPath: 'assets/images/contact.svg', text: 'Contact', onTap: () => context.go('/contact')),
                  const SizedBox(width: 24),
                  const _TopBarItem(iconPath: 'assets/images/search.svg', text: 'Search'),
                  const SizedBox(width: 24),
                  const _TopBarItem(iconPath: 'assets/images/language.svg', text: 'عربي'),
                ],
              ),
            ),
          ] else
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                children: const [
                  _TopBarItem(iconPath: 'assets/images/search.svg', text: ''),
                  SizedBox(width: 16),
                  _TopBarItem(iconPath: 'assets/images/language.svg', text: 'عربي'),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _TopBarItem extends StatelessWidget {
  final String iconPath;
  final String text;
  final VoidCallback? onTap;

  const _TopBarItem({
    required this.iconPath,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 16,
            height: 16,
            margin: const EdgeInsets.only(top: 2),
            child: SvgPicture.asset(
              iconPath,
              width: 16,
              height: 16,
              fit: BoxFit.contain,
              colorFilter: const ColorFilter.mode(
                AppColors.textSecondary,
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(width: 6),
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 1.53,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
