import 'package:flutter/material.dart';
import '../widgets/top_bar.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/strategy_hero_section.dart';
import '../widgets/strategy_intro_section.dart';
import '../widgets/strategy_pillars_section.dart';
import '../widgets/strategy_roadmap_section.dart';
import '../widgets/strategy_risk_section.dart';
import '../utils/page_meta.dart';
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
    setPageMeta(
      title: 'Strategy & Operations | Al Saif Gallery | Disciplined Growth in Saudi Retail',
      description: "Al Saif Gallery's three-phase strategy: brand ownership, national reach, digital integration, and after-sales depth. A disciplined operating model built for sustainable value.",
    );
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
      body: SelectionContainer.disabled(child: content),
    );
  }
}






