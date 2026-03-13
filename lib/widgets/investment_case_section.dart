import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';

class InvestmentCaseSection extends StatelessWidget {
  const InvestmentCaseSection({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = Responsive.getHorizontalPadding(context);

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 35,
      ),
      child: Column(
        children: [
          const Text(
            'Investment Case',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 28,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6), // قللت من 8 إلى 6
          const Text(
            'Four structural advantages that are difficult to replicate.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 30), // قللت من 40 إلى 30
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 900) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Expanded(
                      child: _InvestmentCard(
                        number: '1',
                        title: 'Saudi-Focused Brand Ownership',
                        description:
                            'Approximately 28% of our revenue comes from proprietary and exclusive brands we control: Edison, Tornado, Robust, and Rocky. Proprietary brands—Lorena, iRoast, Timpano, Royal, Falcon, and Glory. Direct manufacturing relationships eliminate wholesale intermediaries, enabling tighter cost efficiency and the ability to specify products for Saudi cultural preferences. When our customers open an Edison product, they are not opening a generic import. They are opening something engineered with Saudi households in mind.',
                      ),
                    ),
                    SizedBox(width: 16), // تقليل من 40 إلى 16
                    Expanded(
                      child: _InvestmentCard(
                        number: '2',
                        title: 'National Reach with Service Depth',
                        description:
                            '73 showrooms across Saudi Arabia and five GCC markets, supported by distribution infrastructure in Riyadh with a continued and expanding 30,000 m² and a dedicated fulfillment center in Jeddah. Delivery commitment of 1 to 3 days across Riyadh, 3 to 5 days across the Kingdom, and 5 to 10 days internationally (through an Iran retail competition with third-party logistics as an afterthought). Our network is not just a distribution asset. It is a service and learning platform.',
                      ),
                    ),
                  ],
                );
              } else {
                return Column(
                  children: const [
                    _InvestmentCard(
                      number: '1',
                      title: 'Saudi-Focused Brand Ownership',
                      description:
                          'Approximately 28% of our revenue comes from proprietary and exclusive brands we control: Edison, Tornado, Robust, and Rocky. Proprietary brands—Lorena, iRoast, Timpano, Royal, Falcon, and Glory. Direct manufacturing relationships eliminate wholesale intermediaries, enabling tighter cost efficiency and the ability to specify products for Saudi cultural preferences.',
                    ),
                    SizedBox(height: 24),
                    _InvestmentCard(
                      number: '2',
                      title: 'National Reach with Service Depth',
                      description:
                          '73 showrooms across Saudi Arabia and five GCC markets, supported by distribution infrastructure in Riyadh with a continued and expanding 30,000 m² and a dedicated fulfillment center in Jeddah.',
                    ),
                  ],
                );
              }
            },
          ),
          const SizedBox(height: 16), // تقليل من 40 إلى 16
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 900) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Expanded(
                      child: _InvestmentCard(
                        number: '3',
                        title: 'Post-Purchase Commitment',
                        description:
                            'We have invested deliberately in after-sales infrastructure. Multi-year warranty on all our own-brand electrical products, centralized service processing, and improving availability of spare parts across channels. This commitment presents a competitive moat, a durable relationship. In Saudi retail, the quality of service after the sale is often the deciding factor in whether a customer returns.',
                      ),
                    ),
                    SizedBox(width: 16), // تقليل من 40 إلى 16
                    Expanded(
                      child: _InvestmentCard(
                        number: '4',
                        title: 'Omni-Channel Integration',
                        description:
                            'Our digital channels are not a parallel business. They are an integrated extension of our showrooms. In H1FY25, digital sales rose 9.0% year-on-year (YoY), representing 12.2% of total revenue and growing. 47% year-on-year. Click and collect, in-store returns, unified warranty processing, and multiple payment options including installment and smart device payment collection. The showroom is not the endpoint. It is a single customer journey.',
                      ),
                    ),
                  ],
                );
              } else {
                return Column(
                  children: const [
                    _InvestmentCard(
                      number: '3',
                      title: 'Post-Purchase Commitment',
                      description:
                          'We have invested deliberately in after-sales infrastructure. Multi-year warranty on all our own-brand electrical products, centralized service processing, and improving availability of spare parts across channels.',
                    ),
                    SizedBox(height: 24),
                    _InvestmentCard(
                      number: '4',
                      title: 'Omni-Channel Integration',
                      description:
                          'Our digital channels are not a parallel business. They are an integrated extension of our showrooms. In H1FY25, digital sales rose 9.0% year-on-year.',
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

class _InvestmentCard extends StatelessWidget {
  final String number;
  final String title;
  final String description;

  const _InvestmentCard({
    required this.number,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200, // رجعت من 240 إلى 200
      padding: const EdgeInsets.all(16),
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
              maxLines: 8, // زيادة من 10 إلى 8
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
