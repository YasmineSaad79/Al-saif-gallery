import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/home_screen.dart';
import '../screens/about_us_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/about-us',
      name: 'about-us',
      builder: (context, state) => const AboutUsScreen(),
    ),
    GoRoute(
      path: '/strategy-operations',
      name: 'strategy-operations',
      builder: (context, state) => const PlaceholderScreen(title: 'Strategy & Operations'),
    ),
    GoRoute(
      path: '/investors-governance',
      name: 'investors-governance',
      builder: (context, state) => const PlaceholderScreen(title: 'Investors & Governance'),
    ),
    GoRoute(
      path: '/news-careers',
      name: 'news-careers',
      builder: (context, state) => const PlaceholderScreen(title: 'News & Careers'),
    ),
    GoRoute(
      path: '/documents-library',
      name: 'documents-library',
      builder: (context, state) => const PlaceholderScreen(title: 'Documents Library'),
    ),
    GoRoute(
      path: '/whistleblowing',
      name: 'whistleblowing',
      builder: (context, state) => const PlaceholderScreen(title: 'Whistleblowing'),
    ),
    GoRoute(
      path: '/contact',
      name: 'contact',
      builder: (context, state) => const PlaceholderScreen(title: 'Contact'),
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
