import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/app_colors.dart';
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

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.only(
        left: horizontalPadding,
        right: horizontalPadding,
        top: 35,
        bottom: 35,
      ),
      child: Column(
        children: [
          const Text(
            'Heritage & Milestones',
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
            'Three decades of disciplined growth and strategic evolution.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 30),
          // الخط الأفقي مع النقاط الحمراء - يتحرك مع السكرول
          SizedBox(
            height: 10,
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: 11 * 240 + 10 * 20, // عرض كل الكروت + المسافات بينهم
                child: Stack(
                  children: [
                    // الخط الأفقي
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 4,
                      child: Container(
                        height: 2,
                        color: const Color(0xFF101828),
                      ),
                    ),
                    // النقاط الحمراء
                    Row(
                      children: [
                        for (int i = 0; i < 11; i++) ...[
                          SvgPicture.asset(
                            'assets/images/red ball.svg',
                            width: 10,
                            height: 10,
                          ),
                          if (i < 10) const SizedBox(width: 250),
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
            height: 180, // تقليل الارتفاع من 200 إلى 180
            child: ListView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              children: const [
                _MilestoneCard(
                  year: '1993',
                  title: 'Foundation in Riyadh',
                  description:
                      'Suleiman Al Saif establishes the business as a sole proprietorship, combining imported product expertise with deep knowledge of Saudi household needs.',
                ),
                SizedBox(width: 20),
                _MilestoneCard(
                  year: '2000s',
                  title: 'National Expansion',
                  description:
                      'Category leadership built in kitchen appliances and serveware. The store network grows across major Saudi cities, establishing a loyal customer base built on value and reliability.',
                ),
                SizedBox(width: 20),
                _MilestoneCard(
                  year: '2014',
                  title: 'Corporate Transformation',
                  description:
                      'Conversion to a closed joint stock company. Governance infrastructure begins formal development ahead of eventual public listing.',
                ),
                SizedBox(width: 20),
                _MilestoneCard(
                  year: '2015',
                  title: 'Edison Brand Launch',
                  description:
                      'The Edison proprietary brand is introduced, a strategic pivot toward brand ownership and product innovation tailored for Gulf households.',
                ),
                SizedBox(width: 20),
                _MilestoneCard(
                  year: '2016',
                  title: 'E-Commerce Platform',
                  description:
                      'The online platform and mobile application are launched alongside a customer loyalty program, establishing the foundation for omni-channel operations.',
                ),
                SizedBox(width: 20),
                _MilestoneCard(
                  year: '2018-2022',
                  title: 'Edison Brand Leadership',
                  description:
                      'Proprietary brand platform scaled and deepened. Launch of the Edison large appliance extension, including refrigerators, washing machines, and air conditioning, expands the offering from small appliances into whole-home solutions.',
                ),
                SizedBox(width: 20),
                _MilestoneCard(
                  year: 'Dec 27, 2022',
                  title: 'Tadawul IPO',
                  description:
                      'Al Saif Gallery lists on the Saudi Exchange Main Market at SAR 115 per share (pre-split). The offering is 269% oversubscribed, reflecting strong market demand for a pure-play specialist in Saudi household essentials.',
                ),
                SizedBox(width: 20),
                _MilestoneCard(
                  year: 'July 2023',
                  title: 'Capital Structure Expansion',
                  description:
                      '10-for-1 stock split increases shares outstanding to 350 million, improving market liquidity.',
                ),
                SizedBox(width: 20),
                _MilestoneCard(
                  year: '2024',
                  title: 'GCC Expansion',
                  description:
                      'New showrooms open in Doha (December 2024, 1,392 m²), Al Ain (December 2024, 1,700 m²), and Muscat, bringing the GCC network to seven locations across UAE, Kuwait, Oman, and Qatar.',
                ),
                SizedBox(width: 20),
                _MilestoneCard(
                  year: 'Dec 2024',
                  title: 'Leadership Transition',
                  description:
                      'Ahmed bin Saleh Al Sultan appointed as CEO, the first professional, non-family CEO in the Company\'s history, marking a new phase of operational focus and governance maturity.',
                ),
                SizedBox(width: 20),
                _MilestoneCard(
                  year: '2025',
                  title: 'Financial Recovery & Digital Acceleration',
                  description:
                      'Revenue of SAR 758.8M, net profit of SAR 58M (+54.6% year-on-year), and e-commerce growth of 37% to SAR 94M demonstrate the platform\'s operational resilience and digital momentum.',
                ),
              ],
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

  const _MilestoneCard({
    required this.year,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      padding: const EdgeInsets.all(14), // تقليل الـ padding من 16 إلى 14
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
            year,
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 16, // تقليل من 18 إلى 16
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6), // تقليل من 8 إلى 6
          Text(
            title,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 12, // تقليل من 13 إلى 12
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700, // bold
            ),
          ),
          const SizedBox(height: 4), // تقليل من 6 إلى 4
          Expanded(
            child: Text(
              description,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 10, // تقليل من 11 إلى 10
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 1.4,
              ),
              maxLines: 7,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
