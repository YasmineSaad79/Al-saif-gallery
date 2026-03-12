import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';

class BrandsSection extends StatelessWidget {
  const BrandsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = Responsive.getHorizontalPadding(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 3),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Stack(
        children: [
          // صورة الخلفية JUG في الوسط
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Center(
              child: Opacity(
                opacity: 0.08,
                child: SvgPicture.asset(
                  'assets/images/JUG.svg',
                  width: 700,
                  height: 700,
                  fit: BoxFit.contain,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFFD91F36),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
          // المحتوى
          Column(
            children: [
              // What We Do Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                  left: horizontalPadding,
                  right: horizontalPadding,
                  top: 51,
                  bottom: 32,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Built on Brands Customers Return To',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 32,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: screenWidth > 1600 ? 1000 : screenWidth * 0.6,
                      child: const Text(
                        'We build, design, and deliver household essentials across categories customers buy repeatedly and rely on daily. Our platform is structured around three pillars: planning, execution, and accountability—supported by specifications tailored to Saudi households, a national showroom footprint, a supply led by our proprietary warehousing and a robust fulfillment capability, and integrated omni-channel capability, expert repair, and spare parts. Our brand portfolio spans a defined collection.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 15,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 1.68,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: screenWidth > 1600 ? 1000 : screenWidth * 0.6,
                      child: const Text(
                        'This is not generic retail. Al Saif Gallery operates in a carefully defined sector: the household goods and kitchen appliance categories where we hold a leading position in Saudi Arabia, delivering dependable quality at competitive price. Our brand portfolio—including Edison, Tornado, Robust, and Rocky—is designed for Saudi homes and Saudi hospitality needs, including showrooms, wearing materials, air conditioning, and built-in kitchen solutions.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 15,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 1.68,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Services Cards Section
              Padding(
                padding: EdgeInsets.only(
                  left: horizontalPadding,
                  right: horizontalPadding,
                  top: 20,
                  bottom: 60,
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth > 900) {
                      final availableWidth = constraints.maxWidth - 14; // نقص 14 بكسل (7 من كل جهة)
                      final cardWidth = (availableWidth - (3 * 24)) / 4;
                      
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: cardWidth,
                            child: const _ServiceCard(
                              iconPath: 'assets/images/strategy.svg',
                              title: 'Strategy & Operations',
                              description:
                                  'Disciplined growth, operational excellence, and omni-channel capabilities.',
                              linkText: 'Explore Strategy',
                            ),
                          ),
                          const SizedBox(width: 24),
                          SizedBox(
                            width: cardWidth,
                            child: const _ServiceCard(
                              iconPath: 'assets/images/investors.svg',
                              title: 'Investors & Governance',
                              description:
                                  'Financial reports, shareholder information, and governance framework.',
                              linkText: 'Investor Center',
                            ),
                          ),
                          const SizedBox(width: 24),
                          SizedBox(
                            width: cardWidth,
                            child: const _ServiceCard(
                              iconPath: 'assets/images/brands.svg',
                              title: 'Our Brands',
                              description:
                                  'Edison, Tornado, Robust, and Rocky. Innovation, precision, and trust engineered for Saudi homes.',
                              linkText: 'Brand Portfolio',
                            ),
                          ),
                          const SizedBox(width: 24),
                          SizedBox(
                            width: cardWidth,
                            child: const _ServiceCard(
                              iconPath: 'assets/images/career.svg',
                              title: 'Careers & Culture',
                              description:
                                  'Join our team. Work with a customer-first culture. Opportunities across all functions.',
                              linkText: 'Explore Roles',
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          Row(
                            children: const [
                              Expanded(
                                child: _ServiceCard(
                                  iconPath: 'assets/images/strategy.svg',
                                  title: 'Strategy & Operations',
                                  description:
                                      'Disciplined growth, operational excellence, and omni-channel capabilities.',
                                  linkText: 'Explore Strategy',
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: _ServiceCard(
                                  iconPath: 'assets/images/investors.svg',
                                  title: 'Investors & Governance',
                                  description:
                                      'Financial reports, shareholder information, and governance framework.',
                                  linkText: 'Investor Center',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: const [
                              Expanded(
                                child: _ServiceCard(
                                  iconPath: 'assets/images/brands.svg',
                                  title: 'Our Brands',
                                  description:
                                      'Edison, Tornado, Robust, and Rocky. Innovation, precision, and trust engineered for Saudi homes.',
                                  linkText: 'Brand Portfolio',
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: _ServiceCard(
                                  iconPath: 'assets/images/career.svg',
                                  title: 'Careers & Culture',
                                  description:
                                      'Join our team. Work with a customer-first culture. Opportunities across all functions.',
                                  linkText: 'Explore Roles',
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final String description;
  final String linkText;

  const _ServiceCard({
    required this.iconPath,
    required this.title,
    required this.description,
    required this.linkText,
  });

  String _getRouteFromTitle() {
    if (title.contains('Strategy')) return '/strategy-operations';
    if (title.contains('Investors')) return '/investors-governance';
    if (title.contains('Careers')) return '/news-careers';
    if (title.contains('Brands')) return '/brands';
    return '/';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 32,
            height: 32,
            child: SvgPicture.asset(
              iconPath,
              fit: BoxFit.contain,
              colorFilter: const ColorFilter.mode(
                AppColors.primary,
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF111827),
              fontSize: 15,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Text(
              description,
              style: const TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 12,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 12),
          _LearnMoreLink(
            route: _getRouteFromTitle(),
            text: linkText,
          ),
        ],
      ),
    );
  }
}

class _LearnMoreLink extends StatefulWidget {
  final String route;
  final String text;

  const _LearnMoreLink({
    required this.route,
    required this.text,
  });

  @override
  State<_LearnMoreLink> createState() => _LearnMoreLinkState();
}

class _LearnMoreLinkState extends State<_LearnMoreLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => context.go(widget.route),
        child: Row(
          children: [
            Text(
              widget.text,
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 12,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                height: 1.5,
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
    );
  }
}
