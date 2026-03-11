import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';

class StatsSection extends StatelessWidget {
  const StatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = Responsive.getHorizontalPadding(context);

    return Padding(
      padding: EdgeInsets.only(
        left: horizontalPadding,
        right: horizontalPadding,
        top: 32,
        bottom: 32,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 900) {
            return Row(
              children: const [
                Expanded(
                  child: _StatCard(
                    title: 'Founded 1993',
                    subtitle: 'Over 30 years of heritage',
                  ),
                ),
                SizedBox(width: 24),
                Expanded(
                  child: _StatCard(
                    title: 'KSA + GCC footprint',
                    subtitle: 'Regional retail presence',
                  ),
                ),
                SizedBox(width: 24),
                Expanded(
                  child: _StatCard(
                    title: 'Store-led, omni-connected',
                    subtitle: 'Integrated shopping model',
                  ),
                ),
                SizedBox(width: 24),
                Expanded(
                  child: _StatCard(
                    title: 'Service & governance',
                    subtitle: 'Commitment to excellence',
                  ),
                ),
              ],
            );
          } else {
            return Column(
              children: const [
                _StatCard(
                  title: 'Founded 1993',
                  subtitle: 'Over 30 years of heritage',
                ),
                SizedBox(height: 24),
                _StatCard(
                  title: 'KSA + GCC footprint',
                  subtitle: 'Regional retail presence',
                ),
                SizedBox(height: 24),
                _StatCard(
                  title: 'Store-led, omni-connected',
                  subtitle: 'Integrated shopping model',
                ),
                SizedBox(height: 24),
                _StatCard(
                  title: 'Service & governance',
                  subtitle: 'Commitment to excellence',
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const _StatCard({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,  // غيرت من 102 لـ 85
      padding: const EdgeInsets.all(18),  // غيرت من 24 لـ 18
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 14,  // غيرت من 15.4 لـ 14
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              height: 1.4,  // غيرت من 1.56 لـ 1.4
            ),
          ),
          const SizedBox(height: 4),  // غيرت من 6 لـ 4
          Text(
            subtitle,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,  // غيرت من 13 لـ 12
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              height: 1.4,  // غيرت من 1.54 لـ 1.4
            ),
          ),
        ],
      ),
    );
  }
}
