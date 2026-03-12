import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';

class StatsSection extends StatelessWidget {
  const StatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = Responsive.getHorizontalPadding(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: horizontalPadding,
        right: horizontalPadding,
        top: 35,
        bottom: 35,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFFF8FAFB),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 900) {
            final availableWidth = constraints.maxWidth - 14; // نقص 14 بكسل (7 من كل جهة)
            final cardWidth = (availableWidth - (3 * 24)) / 4;
            
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: cardWidth,
                  child: const _StatCard(
                    number: '18',
                    title: 'Showrooms',
                    subtitle: 'Across 5 GCC markets',
                  ),
                ),
                const SizedBox(width: 24),
                SizedBox(
                  width: cardWidth,
                  child: const _StatCard(
                    number: 'SAR 189.7M',
                    title: 'SAR 758.8M Revenue',
                    subtitle: 'FY 2025 performance',
                  ),
                ),
                const SizedBox(width: 24),
                SizedBox(
                  width: cardWidth,
                  child: const _StatCard(
                    number: '22%',
                    title: '~88% Proprietary Revenue',
                    subtitle: 'Owned & exclusive brands',
                  ),
                ),
                const SizedBox(width: 24),
                SizedBox(
                  width: cardWidth,
                  child: const _StatCard(
                    number: '9%',
                    title: '37% E-Commerce Growth',
                    subtitle: 'SAR 94M digital sales',
                  ),
                ),
              ],
            );
          } else {
            return Column(
              children: const [
                _StatCard(
                  number: '18',
                  title: 'Showrooms',
                  subtitle: 'Across 5 GCC markets',
                ),
                SizedBox(height: 24),
                _StatCard(
                  number: 'SAR 189.7M',
                  title: 'SAR 758.8M Revenue',
                  subtitle: 'FY 2025 performance',
                ),
                SizedBox(height: 24),
                _StatCard(
                  number: '22%',
                  title: '~88% Proprietary Revenue',
                  subtitle: 'Owned & exclusive brands',
                ),
                SizedBox(height: 24),
                _StatCard(
                  number: '9%',
                  title: '37% E-Commerce Growth',
                  subtitle: 'SAR 94M digital sales',
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
  final String number;
  final String title;
  final String subtitle;

  const _StatCard({
    required this.number,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 1,
          color: const Color(0xFFE5E7EB),
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 2,
            offset: Offset(0, 1),
            spreadRadius: -1,
          ),
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 3,
            offset: Offset(0, 1),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            number,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFFC62030),
              fontSize: 27,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              height: 1.15,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF101727),
              fontSize: 10,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              height: 1.48,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF495565),
              fontSize: 8,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              height: 1.40,
            ),
          ),
        ],
      ),
    );
  }
}
