import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,  // غيرت من 429 لـ 280 (أكبر من النصف بقليل)
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/Background_HorizontalBorder.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primary.withOpacity(0.4),  // غيرت من 0.8 لـ 0.4
              AppColors.primaryDark.withOpacity(0.3),  // غيرت من 0.6 لـ 0.3
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: Responsive.getHorizontalPadding(context),
            top: 72,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Al Saif Gallery',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 38,  // غيرت من 47.4 لـ 38
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  height: 1.01,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 16),  // غيرت من 20 لـ 16
              const SizedBox(
                width: 505,
                child: Text(
                  'A Saudi-born retail organization focused on dependable\nquality, operational excellence, and long-term value.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.1,  // غيرت من 18.6 لـ 16
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.51,
                  ),
                ),
              ),
              const SizedBox(height: 30),  // غيرت من 44 لـ 30
              Row(
                children: [
                  InkWell(
                    onTap: () => context.go('/about-us'),
                    child: Container(
                      height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF101727),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            'Learn About Us',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(width: 6),
                          Icon(Icons.arrow_forward, size: 13, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  InkWell(
                    onTap: () => context.go('/investors-governance'),
                    child: Container(
                      height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: const Color(0xFFD0D5DB),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          'Investors & Governance',
                          style: TextStyle(
                            color: Color(0xFF101727),
                            fontSize: 13,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
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
      ),
    );
  }
}
