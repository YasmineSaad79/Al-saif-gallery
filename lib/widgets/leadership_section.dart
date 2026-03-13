import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';

class LeadershipSection extends StatelessWidget {
  const LeadershipSection({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = Responsive.getHorizontalPadding(context);

    return Container(
      width: double.infinity,
      color: const Color(0xFFF8FAFB),
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 35,
      ),
      child: Column(
        children: [
          const Text(
            'Leadership',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 28,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 30),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 900) {
                return Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 320, // عرض محدد للكارت
                        child: const _LeadershipCard(
                          title: 'Board of Directors',
                          description:
                              'The Board provides strategic oversight, safeguards stakeholder interests, and ensures that management accountability aligns with our obligations as a Tadawul-listed company. The current board was re-elected in October 2025 for the 2025 to 2028 term.',
                          linkText: 'View Board Profiles',
                        ),
                      ),
                      const SizedBox(width: 24),
                      SizedBox(
                        width: 320, // عرض محدد للكارت
                        child: const _LeadershipCard(
                          title: 'Executive Management',
                          description:
                              'Our executive team is responsible for delivering the operational and financial performance that creates value for all stakeholders. Led by CEO Ahmed bin Saleh Al Sultan, the executive team brings specialist expertise across retail operations, finance, and digital commerce.',
                          linkText: 'View Executive Profiles',
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Column(
                  children: const [
                    _LeadershipCard(
                      title: 'Board of Directors',
                      description:
                          'The Board provides strategic oversight, safeguards stakeholder interests, and ensures that management accountability aligns with our obligations as a Tadawul-listed company.',
                      linkText: 'View Board Profiles',
                    ),
                    SizedBox(height: 24),
                    _LeadershipCard(
                      title: 'Executive Management',
                      description:
                          'Our executive team is responsible for delivering the operational and financial performance that creates value for all stakeholders.',
                      linkText: 'View Executive Profiles',
                    ),
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
      height: 220, // تقليل الارتفاع
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
          Expanded(
            child: Text(
              description,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 11,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 1.4,
              ),
              maxLines: 6,
              overflow: TextOverflow.ellipsis,
            ),
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
