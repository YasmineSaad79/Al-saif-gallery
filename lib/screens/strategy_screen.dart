import 'package:flutter/material.dart';
import '../widgets/top_bar.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/strategy_hero_section.dart';
import '../widgets/strategy_intro_section.dart';
import '../widgets/strategy_pillars_section.dart';
import '../widgets/strategy_roadmap_section.dart';
import '../widgets/strategy_risk_section.dart';
import '../widgets/footer_section.dart';

class StrategyScreen extends StatelessWidget {
  const StrategyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          constraints: const BoxConstraints(maxWidth: 1880),
          color: const Color(0xFFF8FAFB),
          child: const SingleChildScrollView(
            child: Column(
              children: [
                TopBar(),
                CustomNavigationBar(),
                StrategyHeroSection(),
                StrategyIntroSection(),
                StrategyPillarsSection(),
                StrategyRoadmapSection(),
                StrategyRiskSection(),
                FooterSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
