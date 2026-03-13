import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';

class OurValuesSection extends StatelessWidget {
  const OurValuesSection({super.key});

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
            'Our Values',
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
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Expanded(
                      child: _ValueCard(
                        iconPath: 'assets/images/Quality.svg',
                        title: 'Quality & Reliability',
                        description:
                            'We never compromise on product standards. Every item we sell—from our proprietary brands to third-party products—undergoes rigorous quality control. Our customers trust us not because we are the cheapest, but because we are consistent, including in compliance.',
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: _ValueCard(
                        iconPath: 'assets/images/Customer.svg',
                        title: 'Customer First',
                        description:
                            'Every operational decision from store layout to delivery windows to warranty terms, is made through the lens of the customer experience. The showroom is not a sales channel. It is a service environment, reflected in our Net Promoter Score (NPS) and repeat purchase rates, which are among the best in the category.',
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: _ValueCard(
                        iconPath: 'assets/images/Integrity.svg',
                        title: 'Integrity & Transparency',
                        description:
                            'We operate with full accountability to our stakeholders, to our customers, we are committed to transparent financial disclosures, consistent governance practices, and ethical business conduct. We report what we measure. We measure what matters. And we hold ourselves accountable for both.',
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: _ValueCard(
                        iconPath: 'assets/images/strategy.svg',
                        title: 'Continuous Improvement',
                        description:
                            'We invest in our infrastructure through enhanced inventory systems, optimized warehouse operations, and refined customer service protocols. We do not chase headlines or set up vanity initiatives. We pursue measurable, disciplined gain. Incremental progress and the quality-compounding that turns customer loyalty.',
                      ),
                    ),
                  ],
                );
              } else {
                return Column(
                  children: const [
                    _ValueCard(
                      iconPath: 'assets/images/Quality.svg',
                      title: 'Quality & Reliability',
                      description:
                          'We never compromise on product standards. Every item we sell undergoes rigorous quality control.',
                    ),
                    SizedBox(height: 20),
                    _ValueCard(
                      iconPath: 'assets/images/Customer.svg',
                      title: 'Customer First',
                      description:
                          'Every operational decision is made through the lens of the customer experience.',
                    ),
                    SizedBox(height: 20),
                    _ValueCard(
                      iconPath: 'assets/images/Integrity.svg',
                      title: 'Integrity & Transparency',
                      description:
                          'We operate with full accountability to our stakeholders and customers.',
                    ),
                    SizedBox(height: 20),
                    _ValueCard(
                      iconPath: 'assets/images/strategy.svg',
                      title: 'Continuous Improvement',
                      description:
                          'We invest in our infrastructure through enhanced systems and optimized operations.',
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

class _ValueCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final String description;

  const _ValueCard({
    required this.iconPath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280, // تقليل الارتفاع
      padding: const EdgeInsets.all(16), // تقليل الـ padding
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          SvgPicture.asset(
            iconPath,
            width: 32, // تقليل حجم الأيقونة
            height: 32,
            colorFilter: const ColorFilter.mode(
              AppColors.primary,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 14, // تقليل حجم الخط
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 11, // تقليل حجم الخط
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 1.4, // تقليل المسافة بين الأسطر
              ),
              maxLines: 12,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
