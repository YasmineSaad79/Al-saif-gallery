import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';

class WhatWeDoSection extends StatelessWidget {
  const WhatWeDoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = Responsive.getHorizontalPadding(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: horizontalPadding,
        right: horizontalPadding,
        top: 32,
        bottom: 32,
      ),
      decoration: const BoxDecoration(
        color: AppColors.backgroundLight,
        border: Border(
          top: BorderSide(color: AppColors.border, width: 1),
          bottom: BorderSide(color: AppColors.border, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'What We Do',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 26.9,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: screenWidth > 1600 ? 900 : screenWidth * 0.55,  // عرض أكبر للفقرة
            child: const Text(
              'We design, source, and distribute household essentials through a store-led, digitally connected platform—supported by robust service and disciplined governance. Our focus is on delivering dependable quality and value to customers across the region.',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 1.68,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
