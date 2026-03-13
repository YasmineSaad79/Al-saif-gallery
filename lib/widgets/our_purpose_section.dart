import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';

class OurPurposeSection extends StatelessWidget {
  const OurPurposeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = Responsive.getHorizontalPadding(context);

    return Container(
      width: double.infinity,
      color: const Color(0xFFF8FAFB), // خلفية رمادية
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 20, // قللت من 30 إلى 20
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: const [
              Text(
                'Our Purpose',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 28,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'We exist to make trusted, well-designed household essentials accessible to Saudi families, backed by honest value, consistent service, and a commitment that extends well beyond the point of purchase.',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 15,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Since our founding in 1993, that purpose has not changed. The platform around it has grown from a single showroom to a national network, from a trading operation to a vertically integrated retail model, and from a private enterprise to a Tadawul-listed company serving the public interest as well as our customers.',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 15,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Our purpose creates alignment across everything we do: product specifications that serve Saudi cooking and hospitality traditions; after-sales infrastructure that protects customer trust; a governance framework designed for a listed company; and a strategy built to deliver long-term value for all stakeholders.',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 15,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
