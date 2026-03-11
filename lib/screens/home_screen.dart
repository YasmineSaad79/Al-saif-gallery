import 'package:flutter/material.dart';
import '../widgets/top_bar.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/hero_section.dart';
import '../widgets/stats_section.dart';
import '../widgets/what_we_do_section.dart';
import '../widgets/services_section.dart';
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
    // تحميل الصور مسبقاً
    precacheImage(const AssetImage('assets/images/Background_HorizontalBorder.png'), context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1920),
            child: Column(
              children: const [
                TopBar(),
                CustomNavigationBar(),
                HeroSection(),
                StatsSection(),
                WhatWeDoSection(),
                ServicesSection(),
                FooterSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
