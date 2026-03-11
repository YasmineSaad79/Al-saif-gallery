import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = Responsive.getHorizontalPadding(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 48),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 900) {
            // شاشات كبيرة: 4 كروت في صف واحد
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Expanded(
                  child: _ServiceCard(
                    iconPath: 'assets/images/strategy.svg',
                    title: 'Strategy & Operations',
                    description:
                        'Disciplined growth, operational\nexcellence, and omni-channel\ncapabilities.',
                  ),
                ),
                SizedBox(width: 24),
                Expanded(
                  child: _ServiceCard(
                    iconPath: 'assets/images/investors.svg',
                    title: 'Investors & Governance',
                    description:
                        'Financial reports, shareholder\ninformation, and governance\nframework.',
                  ),
                ),
                SizedBox(width: 24),
                Expanded(
                  child: _ServiceCard(
                    iconPath: 'assets/images/career.svg',
                    title: 'Careers & Culture',
                    description:
                        'Join a customer-first culture with\nopportunities across all functions.',
                  ),
                ),
                SizedBox(width: 24),
                Expanded(
                  child: _ServiceCard(
                    iconPath: 'assets/images/document.svg',
                    title: 'Documents Library',
                    description:
                        'Access charters, policies, financial\nstatements, and presentations.',
                  ),
                ),
              ],
            );
          } else {
            // شاشات صغيرة: صفين، كل صف فيه 2 كروت
            return Column(
              children: [
                Row(
                  children: const [
                    Expanded(
                      child: _ServiceCard(
                        iconPath: 'assets/images/strategy.svg',
                        title: 'Strategy & Operations',
                        description:
                            'Disciplined growth, operational excellence, and omni-channel capabilities.',
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: _ServiceCard(
                        iconPath: 'assets/images/investors.svg',
                        title: 'Investors & Governance',
                        description:
                            'Financial reports, shareholder information, and governance framework.',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: const [
                    Expanded(
                      child: _ServiceCard(
                        iconPath: 'assets/images/career.svg',
                        title: 'Careers & Culture',
                        description:
                            'Join a customer-first culture with opportunities across all functions.',
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: _ServiceCard(
                        iconPath: 'assets/images/document.svg',
                        title: 'Documents Library',
                        description:
                            'Access charters, policies, financial statements, and presentations.',
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final String description;

  const _ServiceCard({
    required this.iconPath,
    required this.title,
    required this.description,
  });

  String _getRouteFromTitle() {
    if (title.contains('Strategy')) return '/strategy-operations';
    if (title.contains('Investors')) return '/investors-governance';
    if (title.contains('Careers')) return '/news-careers';
    if (title.contains('Documents')) return '/documents-library';
    return '/';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220, // زدت من 200 لـ 220
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 32,
            height: 32,
            child: SvgPicture.asset(
              iconPath,
              fit: BoxFit.contain,
              allowDrawingOutsideViewBox: true,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF111827),
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Text(
              description,
              style: const TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 12,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
              maxLines: 4, // زدت من 3 لـ 4
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 10),
          _LearnMoreLink(route: _getRouteFromTitle()),
        ],
      ),
    );
  }
}

class _LearnMoreLink extends StatefulWidget {
  final String route;

  const _LearnMoreLink({required this.route});

  @override
  State<_LearnMoreLink> createState() => _LearnMoreLinkState();
}

class _LearnMoreLinkState extends State<_LearnMoreLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => context.go(widget.route),
        child: Row(
          children: [
            Text(
              'Learn more',
              style: TextStyle(
                color: _isHovered ? AppColors.primary : const Color(0xFF374151),
                fontSize: 12,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.arrow_forward,
              size: 12,
              color: _isHovered ? AppColors.primary : const Color(0xFF374151),
            ),
          ],
        ),
      ),
    );
  }
}
