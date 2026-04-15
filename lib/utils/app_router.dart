// ignore_for_file: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/home_screen.dart';
import '../screens/about_us_screen.dart';
import '../screens/strategy_screen.dart';
import '../screens/investors_governance_screen.dart';
import '../screens/news_careers_screen.dart';

CustomTransitionPage _fadePage(BuildContext context, GoRouterState state, Widget child) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 200),
    transitionsBuilder: (context, animation, _, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      pageBuilder: (context, state) => _fadePage(context, state, const HomeScreen()),
    ),
    GoRoute(
      path: '/about-us',
      name: 'about-us',
      pageBuilder: (context, state) => _fadePage(context, state, const AboutUsScreen()),
    ),
    GoRoute(
      path: '/strategy-operations',
      name: 'strategy-operations',
      pageBuilder: (context, state) => _fadePage(context, state, const StrategyScreen()),
    ),
    GoRoute(
      path: '/investors-governance',
      name: 'investors-governance',
      pageBuilder: (context, state) => _fadePage(context, state, const InvestorsGovernanceScreen()),
    ),
    GoRoute(
      path: '/news-careers',
      name: 'news-careers',
      pageBuilder: (context, state) => _fadePage(context, state, const NewsCareersScreen()),
    ),
    GoRoute(
      path: '/documents-library',
      name: 'documents-library',
      pageBuilder: (context, state) => _fadePage(context, state, const PlaceholderScreen(title: 'Documents Library')),
    ),
    GoRoute(
      path: '/whistleblowing',
      name: 'whistleblowing',
      pageBuilder: (context, state) => _fadePage(context, state, const PlaceholderScreen(title: 'Whistleblowing')),
    ),
    GoRoute(
      path: '/contact',
      name: 'contact',
      pageBuilder: (context, state) => _fadePage(context, state, const PlaceholderScreen(title: 'Contact')),
    ),
  ],
);

// Placeholder screen for pages that don't exist yet
class PlaceholderScreen extends StatelessWidget {
  final String title;

  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1880),
          color: const Color(0xFFF8FAFB),
          child: Column(
            children: [
              Container(
                height: 56,
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => html.window.location.replace('/'),
                        child: const Icon(Icons.arrow_back, size: 22, color: Color(0xFF1A1A1A)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF1A1A1A))),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(title, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 20),
                      const Text('This page is under construction'),
                      const SizedBox(height: 20),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () => html.window.location.replace('/'),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                            decoration: BoxDecoration(
                              border: Border.all(color: const Color(0xFFE53935)),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text('Back to Home', style: TextStyle(color: Color(0xFFE53935), fontSize: 13)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




