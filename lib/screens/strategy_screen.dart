import 'package:flutter/material.dart';
import '../widgets/top_bar.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/strategy_hero_section.dart';
import '../widgets/strategy_intro_section.dart';
import '../widgets/strategy_pillars_section.dart';
import '../widgets/strategy_roadmap_section.dart';
import '../widgets/strategy_risk_section.dart';
import '../main.dart';
import '../widgets/footer_section.dart';

class StrategyScreen extends StatefulWidget {
  const StrategyScreen({super.key});

  @override
  State<StrategyScreen> createState() => _StrategyScreenState();
}

class _StrategyScreenState extends State<StrategyScreen> {
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
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: localeProvider.isArabic
          ? SelectionContainer.disabled(child: content)
          : SelectionArea(child: content),
    );
  }
}





