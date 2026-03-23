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
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text('This page is under construction'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
