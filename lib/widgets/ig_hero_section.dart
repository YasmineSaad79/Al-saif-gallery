import 'package:flutter/material.dart';
import '../utils/app_localizations.dart';
import '../utils/responsive.dart';
import '../main.dart';

class IGHeroSection extends StatefulWidget {
  const IGHeroSection({super.key});

  @override
  State<IGHeroSection> createState() => _IGHeroSectionState();
}

class _IGHeroSectionState extends State<IGHeroSection> {
  @override
  void initState() {
    super.initState();
    localeProvider.addListener(_rebuild);
  }

  void _rebuild() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    localeProvider.removeListener(_rebuild);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final isArabic = localeProvider.isArabic;

    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxWidth / (1600 / 475);
        final horizontalPadding = Responsive.getHorizontalPadding(context);

        return SizedBox(
          width: double.infinity,
          height: height,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/images/ig_hero.jpeg',
                fit: BoxFit.cover,
                alignment: Alignment.center,
                errorBuilder: (context, error, stackTrace) => Container(color: const Color(0xFF8B1520)),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: isArabic ? 0 : horizontalPadding,
                  right: isArabic ? horizontalPadding : 0,
                ),
                child: Align(
                  alignment: isArabic ? Alignment.centerRight : Alignment.centerLeft,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            l.igHeroTitle,
                            textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                            textAlign: isArabic ? TextAlign.right : TextAlign.left,
                            style: const TextStyle(color: Colors.white, fontSize: 28, fontFamily: 'Inter', fontWeight: FontWeight.w700),
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            l.igHeroSubtitle,
                            textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                            textAlign: isArabic ? TextAlign.right : TextAlign.left,
                            style: const TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Inter', fontWeight: FontWeight.w400, height: 1.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
