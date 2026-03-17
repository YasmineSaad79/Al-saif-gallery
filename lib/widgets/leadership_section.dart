import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/app_colors.dart';
import '../utils/app_localizations.dart';
import '../utils/responsive.dart';

class LeadershipSection extends StatelessWidget {
  const LeadershipSection({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = Responsive.getHorizontalPadding(context);
    final l = AppLocalizations.of(context);

    return Container(
      width: double.infinity,
      color: const Color(0xFFF8FAFB),
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 35),
      child: Column(
        children: [
          Text(l.leadershipTitle, textAlign: TextAlign.center, style: const TextStyle(color: AppColors.textPrimary, fontSize: 28, fontFamily: 'Inter', fontWeight: FontWeight.w700)),
          const SizedBox(height: 30),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 900) {
                return Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 320, child: _LeadershipCard(title: l.boardTitle, description: l.boardDesc, linkText: l.boardLink)),
                      const SizedBox(width: 24),
                      SizedBox(width: 320, child: _LeadershipCard(title: l.execTitle, description: l.execDesc, linkText: l.execLink)),
                    ],
                  ),
                );
              } else {
                return Column(
                  children: [
                    _LeadershipCard(title: l.boardTitle, description: l.boardDesc, linkText: l.boardLink),
                    const SizedBox(height: 24),
                    _LeadershipCard(title: l.execTitle, description: l.execDesc, linkText: l.execLink),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class _LeadershipCard extends StatelessWidget {
  final String title;
  final String description;
  final String linkText;

  const _LeadershipCard({
    required this.title,
    required this.description,
    required this.linkText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 15,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 13,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              height: 1.4,
            ),
            maxLines: 6,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8), // تقليل المسافة
          InkWell(
            onTap: () {
              // TODO: Navigate to profiles page
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  linkText,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 11,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 6),
                SvgPicture.asset(
                  'assets/images/arrow.svg',
                  width: 14,
                  height: 14,
                  colorFilter: const ColorFilter.mode(
                    AppColors.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
