import 'package:flutter/material.dart';
import '../utils/app_localizations.dart';
import '../utils/responsive.dart';

class StatsSection extends StatelessWidget {
  const StatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = Responsive.getHorizontalPadding(context);
    final l = AppLocalizations.of(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: horizontalPadding,
        right: horizontalPadding,
        top: 35,
        bottom: 35,
      ),
      decoration: const BoxDecoration(color: Color(0xFFF8FAFB)),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 900) {
            final cardWidth = (constraints.maxWidth - 14 - (3 * 24)) / 4;
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: cardWidth, child: _StatCard(number: '73', title: l.statsShowrooms, subtitle: l.statsShowroomsSubtitle)),
                const SizedBox(width: 24),
                SizedBox(width: cardWidth, child: _StatCard(number: 'SAR 758.8M', title: l.statsRevenue, subtitle: l.statsRevenueSubtitle)),
                const SizedBox(width: 24),
                SizedBox(width: cardWidth, child: _StatCard(number: '~88%', title: l.statsPropRevenue, subtitle: l.statsPropRevenueSubtitle)),
                const SizedBox(width: 24),
                SizedBox(width: cardWidth, child: _StatCard(number: '37%', title: l.statsEcommerce, subtitle: l.statsEcommerceSubtitle)),
              ],
            );
          } else {
            return Column(
              children: [
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(child: _StatCard(number: '73', title: l.statsShowrooms, subtitle: l.statsShowroomsSubtitle)),
                      const SizedBox(width: 16),
                      Expanded(child: _StatCard(number: 'SAR 758.8M', title: l.statsRevenue, subtitle: l.statsRevenueSubtitle)),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(child: _StatCard(number: '~88%', title: l.statsPropRevenue, subtitle: l.statsPropRevenueSubtitle)),
                      const SizedBox(width: 16),
                      Expanded(child: _StatCard(number: '37%', title: l.statsEcommerce, subtitle: l.statsEcommerceSubtitle)),
                    ],
                  ),
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
              fontWeight: FontWeight.w400,
              height: 1.40,
            ),
          ),
        ],
      ),
    );
  }
}





