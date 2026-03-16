import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';

class IGInvestmentCaseSection extends StatelessWidget {
  const IGInvestmentCaseSection({super.key});

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
            'The Al Saif Gallery Investment Case',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 28,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Investment Highlights',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 30),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 900) {
                return const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _IGInvestmentCard(number: '1', title: 'A Niche Where We Lead', description: 'We hold an advanced market position in kitchen tools, serveware, and specialized small household appliances in Saudi Arabia, supported by national distribution reach and sector-level product specification. This is not a broadly contested mass-retail category. It is a focused niche where our three decades of category expertise, owned-brand infrastructure, and service depth create barriers that are difficult to replicate.')),
                    SizedBox(width: 16),
                    Expanded(child: _IGInvestmentCard(number: '2', title: 'Earnings Quality Rooted in Operations', description: 'In 2025, Al Saif Gallery delivered SAR 5B in net profit, a 54.0% increase year-on-year, driven entirely by operational improvements. Revenue of SAR 768.8 million, a gross margin of 23.5%, and operating cash flow of SAR 78.7 million reflect the underlying quality power of the platform. The Company ended 2025 with net cash of SAR 25.9 million.')),
                    SizedBox(width: 16),
                    Expanded(child: _IGInvestmentCard(number: '3', title: 'Proprietary Brand Margin Advantage', description: 'Approximately 88% of revenue flows through brands we own or exclusively hold. Direct sourcing from manufacturing partners enables gross margins on proprietary products that are structurally superior to the standard wholesale-retail model. The ongoing extension of the Edison brand into large appliances expands both revenue opportunity and margin mix.')),
                  ],
                );
              } else {
                return const Column(
                  children: [
                    _IGInvestmentCard(number: '1', title: 'A Niche Where We Lead', description: 'We hold an advanced market position in kitchen tools, serveware, and specialized small household appliances in Saudi Arabia, supported by national distribution reach and sector-level product specification.'),
                    SizedBox(height: 16),
                    _IGInvestmentCard(number: '2', title: 'Earnings Quality Rooted in Operations', description: 'In 2025, Al Saif Gallery delivered SAR 5B in net profit, a 54.0% increase year-on-year, driven entirely by operational improvements.'),
                    SizedBox(height: 16),
                    _IGInvestmentCard(number: '3', title: 'Proprietary Brand Margin Advantage', description: 'Approximately 88% of revenue flows through brands we own or exclusively hold.'),
                  ],
                );
              }
            },
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 900) {
                return const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _IGInvestmentCard(number: '4', title: 'Vision 2030 as Structural Tailwind', description: "Saudi Arabia's housing boom, with homeownership rising from 47% in 2016 to 63.4% in 2024, with 693,000+ new units in the pipeline and Sakani supporting 122,000+ families in 2024, creates a durable demand tailwind for household essentials. Every new Saudi home requires a full kitchen outfitting.")),
                    SizedBox(width: 16),
                    Expanded(child: _IGInvestmentCard(number: '5', title: 'Digital Acceleration with Operating Leverage', description: 'E-commerce grew 37% in 2025, contributing SAR 94 million (12.4% of revenue) through an app with 500,000+ downloads. The digital channel operates with shared logistics and after-sales infrastructure, creating operating leverage as digital revenue grows while the existing physical footprint.')),
                    SizedBox(width: 16),
                    Expanded(child: _IGInvestmentCard(number: '6', title: 'Professional Leadership at a Pivotal Moment', description: 'The appointment of CEO Ahmed bin Saleh Al Sultan in December 2024, the first professional, non-family CEO in the Company\'s history, marks a deliberate governance maturation step. His three-pillar strategic framework: in-store experience, category quality, reasoned expansion is already reflected in the 2025 results.')),
                  ],
                );
              } else {
                return const Column(
                  children: [
                    _IGInvestmentCard(number: '4', title: 'Vision 2030 as Structural Tailwind', description: "Saudi Arabia's housing boom, with homeownership rising from 47% in 2016 to 63.4% in 2024, creates a durable demand tailwind for household essentials."),
                    SizedBox(height: 16),
                    _IGInvestmentCard(number: '5', title: 'Digital Acceleration with Operating Leverage', description: 'E-commerce grew 37% in 2025, contributing SAR 94 million (12.4% of revenue) through an app with 500,000+ downloads.'),
                    SizedBox(height: 16),
                    _IGInvestmentCard(number: '6', title: 'Professional Leadership at a Pivotal Moment', description: 'The appointment of CEO Ahmed bin Saleh Al Sultan in December 2024, the first professional, non-family CEO in the Company\'s history, marks a deliberate governance maturation step.'),
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

class _IGInvestmentCard extends StatelessWidget {
  final String number;
  final String title;
  final String description;

  const _IGInvestmentCard({
    required this.number,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            number,
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 26,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 13,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
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
              maxLines: 8,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
