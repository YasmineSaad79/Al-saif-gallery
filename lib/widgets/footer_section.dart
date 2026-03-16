// ignore_for_file: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Red CTA Section
        Container(
          width: double.infinity,
          color: AppColors.primary,
          padding: const EdgeInsets.symmetric(vertical: 28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/bag.svg',
                width: 28,
                height: 28,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Looking to shop our full range of 15,000+ products?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Visit the Al Saif Gallery online store for fast delivery across the Kingdom and the GCC.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 14),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => html.window.open('https://alsaifgallery.com/', '_blank'),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 9),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: const Text(
                      'Visit the Online Store',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Black Footer Section
        _BlackFooter(),
      ],
    );
  }
}

class _BlackFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final horizontalPadding = Responsive.getHorizontalPadding(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final availableWidth = screenWidth - (horizontalPadding * 2);

    return Container(
      width: double.infinity,
      color: const Color(0xFF1A1A1A),
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 28),
      child: Column(
        children: [
          // Footer Columns
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 900) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Expanded(
                      child: _FooterAbout(),
                    ),
                    SizedBox(width: 24),
                    Expanded(
                      child: _FooterColumn(
                        title: 'Company',
                        items: ['About Us', 'Strategy', 'Careers'],
                      ),
                    ),
                    SizedBox(width: 24),
                    Expanded(
                      child: _FooterColumn(
                        title: 'Investors',
                        items: ['Annual Reports', 'Governance', 'Reports & Filings'],
                      ),
                    ),
                    SizedBox(width: 24),
                    Expanded(
                      child: _FooterColumn(
                        title: 'Contact',
                        items: [
                          'Investor Relations',
                          'ir@alsaifgallery.com',
                          '+966 11 406 4444'
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return Wrap(
                  spacing: 40,
                  runSpacing: 32,
                  children: const [
                    SizedBox(
                      width: 250,
                      child: _FooterAbout(),
                    ),
                    SizedBox(
                      width: 150,
                      child: _FooterColumn(
                        title: 'Company',
                        items: ['About Us', 'Strategy', 'Careers'],
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: _FooterColumn(
                        title: 'Investors',
                        items: ['Annual Reports', 'Governance', 'Reports & Filings'],
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: _FooterColumn(
                        title: 'Contact',
                        items: [
                          'Investor Relations',
                          'ir@alsaifgallery.com',
                          '+966 11 406 4444'
                        ],
                      ),
                    ),
                  ],
                );
              }
            },
          ),
          const SizedBox(height: 28),
          // Divider Line
          Container(
            height: 1,
            color: const Color(0xFF374151),
          ),
          const SizedBox(height: 20),
          // Copyright Section
          const _FooterCopyright(),
        ],
      ),
    );
  }
}

class _FooterAbout extends StatelessWidget {
  const _FooterAbout();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Al Saif Gallery',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Established in 1989',
          style: TextStyle(
            color: Color(0xFF9CA3AF),
            fontSize: 11,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 2),
        Text(
          'Tadawul: 4240',
          style: TextStyle(
            color: Color(0xFF9CA3AF),
            fontSize: 11,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class _FooterColumn extends StatelessWidget {
  final String title;
  final List<String> items;

  const _FooterColumn({
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              item,
              style: const TextStyle(
                color: Color(0xFF9CA3AF),
                fontSize: 11,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _FooterCopyright extends StatelessWidget {
  const _FooterCopyright();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 900) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '© 2025 Al Saif Gallery. All rights reserved.',
                style: TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
              Wrap(
                spacing: 24,
                children: const [
                  Text(
                    'Privacy Policy',
                    style: TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'Terms of Service',
                    style: TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'Corporate Governance',
                    style: TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                '© 2025 Al Saif Gallery. All rights reserved.',
                style: TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Privacy Policy',
                style: TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Terms of Service',
                style: TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Corporate Governance',
                style: TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
