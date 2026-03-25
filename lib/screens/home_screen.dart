import 'package:flutter/material.dart';
import '../widgets/top_bar.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/hero_section.dart';
import '../widgets/stats_section.dart';
import '../widgets/brands_section.dart';
import '../widgets/footer_section.dart';
import '../utils/page_meta.dart';
import '../main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    localeProvider.addListener(_rebuild);
    setPageMeta(
      title: "Al Saif Gallery | Saudi Arabia's Home & Kitchen Retail Leader | Tadawul 4192",
      description: "Al Saif Gallery -- Saudi Arabia's dominant specialty retailer in household and kitchen appliances. 73 stores, SAR 758.8M revenue, approximately 88% proprietary brands. Tadawul-listed since 2022.",
    );
  }

  @override
  void dispose() {
    localeProvider.removeListener(_rebuild);
    super.dispose();
  }

  void _rebuild() => setState(() {});

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(const AssetImage('assets/images/modern_kitchen.jpeg'), context);
  }

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
              HeroSection(),
              StatsSection(),
              BrandsSection(),
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

