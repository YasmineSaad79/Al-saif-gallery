import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = Responsive.getHorizontalPadding(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 24),
      decoration: const BoxDecoration(
        color: AppColors.backgroundLight,
        border: Border(
          top: BorderSide(color: AppColors.border, width: 1),
        ),
      ),
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 900) {
                // نفس توزيع Services Section
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
                        items: [
                          'Financial Reports',
                          'Governance',
                          'Shareholder Info'
                        ],
                      ),
                    ),
                    SizedBox(width: 24),
                    Expanded(
                      child: _FooterColumn(
                        title: 'Resources',
                        items: [
                          'Documents Library',
                          'Whistleblowing',
                          'Contact Us'
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                // للشاشات الصغيرة
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
                        items: [
                          'Financial Reports',
                          'Governance',
                          'Shareholder Info'
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: _FooterColumn(
                        title: 'Resources',
                        items: [
                          'Documents Library',
                          'Whistleblowing',
                          'Contact Us'
                        ],
                      ),
                    ),
                  ],
                );
              }
            },
          ),
          const SizedBox(height: 24),
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
            color: Color(0xFF101727),
            fontSize: 15.8,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            height: 1.52,
          ),
        ),
        SizedBox(height: 19),
        Text(
          'A Saudi-born retail organization focused on dependable quality, operational excellence, and long-term value.',
          style: TextStyle(
            color: Color(0xFF495565),
            fontSize: 13,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            height: 1.54,
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
            color: Color(0xFF101727),
            fontSize: 15.1,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            height: 1.59,
          ),
        ),
        const SizedBox(height: 12),
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              item,
              style: const TextStyle(
                color: Color(0xFF495565),
                fontSize: 13,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 1.54,
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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 16),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Color(0xFFE5E7EB), width: 1),
        ),
      ),
      child: Column(
        children: const [
          Text(
            '© 2025 Al Saif Gallery. All rights reserved.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF697282),
              fontSize: 13.1,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              height: 1.53,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Looking to shop? Visit our eCommerce site.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF99A1AE),
              fontSize: 11.3,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              height: 1.42,
            ),
          ),
        ],
      ),
    );
  }
}
