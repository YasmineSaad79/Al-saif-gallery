import 'package:flutter/material.dart';
import '../widgets/top_bar.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/about_hero_section.dart';
import '../widgets/our_purpose_section.dart';
import '../widgets/investment_case_section.dart';
import '../widgets/our_values_section.dart';
import '../widgets/heritage_milestones_section.dart';
import '../widgets/leadership_section.dart';
import '../widgets/footer_section.dart';
import '../main.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          constraints: const BoxConstraints(maxWidth: 1880),
          color: const Color(0xFFF8FAFB),
          child: SingleChildScrollView(
            controller: globalScrollController,
            child: Column(
              children: const [
                TopBar(),
                CustomNavigationBar(),
                AboutHeroSection(),
                OurPurposeSection(),
                InvestmentCaseSection(),
                OurValuesSection(),
                HeritageMilestonesSection(),
                LeadershipSection(),
                FooterSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
