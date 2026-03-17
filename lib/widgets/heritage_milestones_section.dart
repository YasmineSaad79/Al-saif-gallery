import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/app_colors.dart';
import '../utils/app_localizations.dart';
import '../utils/responsive.dart';

class HeritageMilestonesSection extends StatefulWidget {
  const HeritageMilestonesSection({super.key});

  @override
  State<HeritageMilestonesSection> createState() => _HeritageMilestonesSectionState();
}

class _HeritageMilestonesSectionState extends State<HeritageMilestonesSection> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = Responsive.getHorizontalPadding(context);
    final l = AppLocalizations.of(context);
    final isArabic = l.isArabic;

    final milestones = [
      (year: l.m1993year,  title: l.m1993title,  desc: l.m1993desc),
      (year: l.m2006year,  title: l.m2006title,  desc: l.m2006desc),
      (year: l.m2010year,  title: l.m2010title,  desc: l.m2010desc),
      (year: l.m2014year,  title: l.m2014title,  desc: l.m2014desc),
      (year: l.m2015year,  title: l.m2015title,  desc: l.m2015desc),
      (year: l.m2016year,  title: l.m2016title,  desc: l.m2016desc),
      (year: l.m2018year,  title: l.m2018title,  desc: l.m2018desc),
      (year: l.m2022year,  title: l.m2022title,  desc: l.m2022desc),
      (year: l.m2023year,  title: l.m2023title,  desc: l.m2023desc),
      (year: l.m2024year,  title: l.m2024title,  desc: l.m2024desc),
      (year: l.m2024bYear, title: l.m2024bTitle, desc: l.m2024bDesc),
      (year: l.m2025year,  title: l.m2025title,  desc: l.m2025desc),
    ];

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.only(left: horizontalPadding, right: horizontalPadding, top: 35, bottom: 35),
      child: Column(
        children: [
          Text(l.heritageTitle, textAlign: TextAlign.center, style: const TextStyle(color: AppColors.textPrimary, fontSize: 28, fontFamily: 'Inter', fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Text(l.heritageSubtitle, textAlign: TextAlign.center, style: const TextStyle(color: AppColors.textSecondary, fontSize: 14, fontFamily: 'Inter', fontWeight: FontWeight.w400)),
          const SizedBox(height: 30),
          SizedBox(
            height: 10,
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: milestones.length * 240 + (milestones.length - 1) * 20.0,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 4,
                      child: Container(height: 2, color: const Color(0xFF101828)),
                    ),
                    Row(
                      children: [
                        for (int i = 0; i < milestones.length; i++) ...[
                          SvgPicture.asset('assets/images/red ball.svg', width: 10, height: 10),
                          if (i < milestones.length - 1) const SizedBox(width: 250),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 260,
            child: ListView.separated(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: milestones.length,
              separatorBuilder: (_, __) => const SizedBox(width: 20),
              itemBuilder: (context, index) {
                final m = milestones[index];
                return _MilestoneCard(
                  year: m.year,
                  title: m.title,
                  description: m.desc,
                  isArabic: isArabic,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _MilestoneCard extends StatelessWidget {
  final String year;
  final String title;
  final String description;
  final bool isArabic;

  const _MilestoneCard({
    required this.year,
    required this.title,
    required this.description,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
      ),
      child: Column(
        crossAxisAlignment: isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            year,
            textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
            style: const TextStyle(color: AppColors.primary, fontSize: 18, fontFamily: 'Inter', fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
            textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
            style: const TextStyle(color: AppColors.textPrimary, fontSize: 14, fontFamily: 'Inter', fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          Expanded(
            child: Text(
              description,
              textAlign: isArabic ? TextAlign.right : TextAlign.left,
              textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
              style: const TextStyle(color: AppColors.textSecondary, fontSize: 12, fontFamily: 'Inter', fontWeight: FontWeight.w400, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}
