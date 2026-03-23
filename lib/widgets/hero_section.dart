import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../utils/app_colors.dart';
import '../utils/app_localizations.dart';
import '../utils/responsive.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final isArabic = l.isArabic;
    final hPad = Responsive.getHorizontalPadding(context);
    final isMobile = Responsive.isMobile(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final height = isMobile
            ? null
            : constraints.maxWidth / (1920 / 800);
        return Container(
          width: double.infinity,
          height: height,
          constraints: isMobile ? const BoxConstraints(minHeight: 420) : null,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/images/modern_kitchen.jpeg',
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
              Positioned.fill(
                child: Container(color: Colors.red.shade900.withOpacity(0.7)),
              ),
              Positioned(
                top: 80,
                left: hPad,
                right: hPad,
                bottom: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: isArabic ? Alignment.centerRight : Alignment.centerLeft,
                      child: Text(
                        l.heroTitle,
                        textAlign: isArabic ? TextAlign.right : TextAlign.left,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isMobile ? 28 : 38,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          height: 1.2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Align(
                      alignment: isArabic ? Alignment.centerRight : Alignment.centerLeft,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 700),
                        child: Text(
                          l.heroSubtitle,
                          textAlign: isArabic ? TextAlign.right : TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isMobile ? 14 : 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Align(
                      alignment: isArabic ? Alignment.centerRight : Alignment.centerLeft,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 750),
                        child: Text(
                          l.heroDesc1,
                          textAlign: isArabic ? TextAlign.right : TextAlign.left,
                          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                          style: const TextStyle(
                            color: Color(0xFFDAEAFE),
                            fontSize: 13,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 1.6,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Align(
                      alignment: isArabic ? Alignment.centerRight : Alignment.centerLeft,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 750),
                        child: Text(
                          l.heroDesc2,
                          textAlign: isArabic ? TextAlign.right : TextAlign.left,
                          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                          style: const TextStyle(
                            color: Color(0xFFDAEAFE),
                            fontSize: 13,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 1.6,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: isArabic ? Alignment.centerRight : Alignment.centerLeft,
                      child: Wrap(
                        spacing: 16,
                        runSpacing: 12,
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
                                child: Center(
                                  child: Text(
                                    l.heroExploreStory,
                                    style: const TextStyle(
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
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () => context.go('/investors-governance'),
                              child: Container(
                                height: 48,
                                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF8B0000),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    l.heroInvestorRelations,
                                    style: const TextStyle(
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
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
