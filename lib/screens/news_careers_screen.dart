import 'package:flutter/material.dart';
import '../widgets/top_bar.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/nc_hero_section.dart';
import '../widgets/nc_news_section.dart';
import '../widgets/nc_careers_section.dart';
import '../widgets/nc_contact_section.dart';
import '../widgets/footer_section.dart';
import '../main.dart';

class NewsCareersScreen extends StatefulWidget {
  const NewsCareersScreen({super.key});

  @override
  State<NewsCareersScreen> createState() => _NewsCareersScreenState();
}

class _NewsCareersScreenState extends State<NewsCareersScreen> {
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
              NCHeroSection(),
              NCNewsSection(),
              NCCareersSection(),
              NCContactSection(),
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





