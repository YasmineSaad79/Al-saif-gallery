import 'package:flutter/material.dart';
import '../widgets/top_bar.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/hero_section.dart';
import '../widgets/stats_section.dart';
import '../widgets/brands_section.dart';
import '../widgets/footer_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(const AssetImage('assets/images/modern_kitchen.jpeg'), context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // خلفية بيضاء
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20), // مسافة بيضاء من جميع الجهات
          constraints: const BoxConstraints(maxWidth: 1880), // 1920 - 40 للـ margin
          color: const Color(0xFFF8FAFB),
          child: SingleChildScrollView(
            child: Column(
              children: const [
                SizedBox(height: 20),
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
      ),
    );
  }
}
