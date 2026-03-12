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
    final isMobile = Responsive.isMobile(context);
    
    return Container(
      width: double.infinity,
      height: 15,
      color: AppColors.backgroundLight,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Row(
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width * 0.49), // 40% من عرض الشاشة

                  
                  if (!isMobile) ...[
                    _buildItem(
                      context,
                      'assets/images/document.svg',
                      'Documents Library',
                      () => context.go('/documents-library'),
                    ),
                    const SizedBox(width: 24),
                    _buildItem(
                      context,
                      'assets/images/contact.svg',
                      'Contact',
                      () => context.go('/contact'),
                    ),
                    const SizedBox(width: 24),
                    _buildItem(
                      context,
                      'assets/images/search.svg',
                      'Search',
                      null,
                    ),
                    const SizedBox(width: 24),
                    _buildItem(
                      context,
                      'assets/images/language.svg',
                      'العربية',
                      null,
                    ),
                  ] else ...[
                    _buildItem(context, 'assets/images/search.svg', '', null),
                    const SizedBox(width: 16),
                    _buildItem(context, 'assets/images/language.svg', 'العربية', null),
                  ],
                ],
              ),
            ),
          ),
          Container(
            height: 1,
            color: AppColors.border,
          ),
        ],
      ),
    );
  }

  Widget _buildItem(
    BuildContext context,
    String iconPath,
    String text,
    VoidCallback? onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Transform.translate(
        offset: const Offset(0, -8),
        child: SizedBox(
          height: 20,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                iconPath,
                width: 14,
                height: 14,
                colorFilter: const ColorFilter.mode(
                  AppColors.textSecondary,
                  BlendMode.srcIn,
                ),
              ),
              if (text.isNotEmpty) ...[
                const SizedBox(width: 6),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.0,
                    leadingDistribution: TextLeadingDistribution.even,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
