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

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  void initState() {
    super.initState();
    localeProvider.addListener(_rebuild);
  }

  @override
  void dispose() {
    localeProvider.removeListener(_rebuild);
    super.dispose();
  }

  void _rebuild() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final content = Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1880),
        color: const Color(0xFFF8FAFB),
        child: SingleChildScrollView(
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
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SelectionContainer.disabled(child: content),
    );
  }
}






