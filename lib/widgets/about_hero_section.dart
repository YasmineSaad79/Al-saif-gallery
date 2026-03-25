import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_localizations.dart';
import '../utils/responsive.dart';

class AboutHeroSection extends StatelessWidget {
  const AboutHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final isArabic = l.isArabic;
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      height: isMobile ? 160 : 240,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        image: DecorationImage(
          image: AssetImage('assets/images/Background_HorizontalBorder.png'),
          fit: BoxFit.cover,
          alignment: Alignment(1.0, 0.44),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.getHorizontalPadding(context),
        vertical: isMobile ? 32 : 60,
      ),
      child: Directionality(
        textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              l.aboutHeroTitle,
              style: TextStyle(
                color: Colors.white,
                fontSize: isMobile ? 22 : 32,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l.aboutHeroSubtitle,
              style: TextStyle(
                color: Colors.white,
                fontSize: isMobile ? 12 : 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}





