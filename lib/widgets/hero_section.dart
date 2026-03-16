import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1920 / 800,
      child: Stack(
        children: [
          // الصورة
          Positioned.fill(
            child: Image.asset(
              'assets/images/modern_kitchen.jpeg',
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          // طبقة اللون الأحمر
          Positioned.fill(
            child: Container(
              color: Colors.red.withOpacity(0.66),
            ),
          ),
          // المحتوى
          Padding(
            padding: EdgeInsets.only(
              left: Responsive.getHorizontalPadding(context),
              top: 80,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Saudi Arabia's Home\nSince 1993.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 38,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 14),
                const SizedBox(
                  width: 700,
                  child: Text(
                    'Thirty years of serving Saudi households. One purpose: trusted quality, every day.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                const SizedBox(
                  width: 750,
                  child: Text(
                    "Al Saif Gallery is Saudi Arabia's specialist in household essentials and kitchen appliances, built from a single Riyadh showroom into a national retail platform of 73 locations across the Kingdom and the GCC. Listed on Tadawul since 2022, we combine the scale of a public company with the discipline of an operator that has earned household trust for three decades.",
                    style: TextStyle(
                      color: Color(0xFFDAEAFE),
                      fontSize: 13,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 1.6,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                const SizedBox(
                  width: 750,
                  child: Text(
                    'Our model is powered by proprietary and exclusive brands, including Edison, Tornado, Robust, and Rocky, designed and specified for Saudi homes, Saudi kitchens, and Saudi hospitality traditions. Every product we carry reflects a deliberate choice: quality that earns loyalty, value that respects the customer.',
                    style: TextStyle(
                      color: Color(0xFFDAEAFE),
                      fontSize: 13,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 1.6,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => context.go('/about-us'),
                        child: Container(
                          height: 48,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Text(
                              'Explore Our Story',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => context.go('/investors-governance'),
                        child: Container(
                          height: 48,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Text(
                              'Investor Relations',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
