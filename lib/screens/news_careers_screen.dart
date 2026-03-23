import 'package:flutter/material.dart';
import '../widgets/top_bar.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/nc_hero_section.dart';
import '../widgets/nc_news_section.dart';
import '../widgets/nc_careers_section.dart';
import '../widgets/nc_contact_section.dart';
import '../widgets/footer_section.dart';

class NewsCareersScreen extends StatelessWidget {
  const NewsCareersScreen({super.key});

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
              children: const [
                TopBar(),
                CustomNavigationBar(),
                NCHeroSection(),
                NCNewsSection(),
                NCCareersSection(),
                NCContactSection(),
                FooterSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
