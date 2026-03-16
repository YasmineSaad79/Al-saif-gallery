import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';

class IGIntroSection extends StatelessWidget {
  const IGIntroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = Responsive.getHorizontalPadding(context);

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 60,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: const Column(
            children: [
              Text(
                'Al Saif Gallery is committed to the highest standards of disclosure and communication for the investors who have placed their trust in our company. This section provides full access to our financial results, governance structure, regulatory filings, shareholder services, and corporate policies, in both Arabic and English, consistent with our obligations as a company listed on the Saudi Exchange.',
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
                'We understand that trust between a listed company and its shareholders is earned through consistency, clarity, and accountability, not promises. Our goal is to make every piece of information an investor needs readily accessible, clearly presented, and fully compliant with CMA requirements.',
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
