import 'package:flutter/material.dart';
import '../utils/app_localizations.dart';
import '../utils/responsive.dart';
import '../main.dart';

class NCNewsSection extends StatefulWidget {
  const NCNewsSection({super.key});
  @override
  State<NCNewsSection> createState() => _NCNewsSectionState();
}

class _NCNewsSectionState extends State<NCNewsSection> {
  @override
  void initState() { super.initState(); localeProvider.addListener(_rebuild); }
  void _rebuild() { if (mounted) setState(() {}); }
  @override
  void dispose() { localeProvider.removeListener(_rebuild); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final isArabic = localeProvider.isArabic;
    final hp = Responsive.getHorizontalPadding(context);

    final items = [
      _NewsItem(
        date:     isArabic ? 'مارس \u200E2026\u200F'    : 'March 2026',
        tag:      isArabic ? 'نتائج مالية'  : 'Financial Results',
        tagColor: const Color(0xFFE53935),
        title:    isArabic
            ? 'نتائج الربع الأول \u200E2026\u200F'
            : 'Q1 2026 Financial Results',
        desc:     isArabic
            ? 'تعلن السيف غاليري عن نتائج الربع الأول، مع استمرار زخم نمو القنوات الرقمية وتحسينات الكفاءة التشغيلية.'
            : 'Al Saif Gallery announces first quarter results, continuing momentum in digital channel growth and operational efficiency improvements.',
      ),
      _NewsItem(
        date:     isArabic ? 'ديسمبر \u200E2024\u200F'  : 'December 2024',
        tag:      isArabic ? 'قيادة'         : 'Leadership',
        tagColor: const Color(0xFFE53935),
        title:    isArabic
            ? 'تعيين رئيس تنفيذي جديد'
            : 'New CEO Appointment',
        desc:     isArabic
            ? 'تعيين أحمد بن صالح آل سلطان رئيساً تنفيذياً، وهو أول رئيس تنفيذي محترف من خارج الأسرة المؤسِّسة في تاريخ الشركة.'
            : 'Ahmed bin Saleh Al Sultan appointed as CEO, marking the first professional, non-family CEO in the Company\'s history.',
      ),
      _NewsItem(
        date:     isArabic ? 'ديسمبر \u200E2024\u200F'  : 'December 2024',
        tag:      isArabic ? 'توسع'          : 'Expansion',
        tagColor: const Color(0xFFE53935),
        title:    isArabic
            ? 'التوسع الخليجي مستمر'
            : 'GCC Expansion Continues',
        desc:     isArabic
            ? 'افتتاح صالات عرض جديدة في الدوحة (\u200E1,392\u200F م²) والعين (\u200E1,700\u200F م²)، مما يعزز حضورنا الخليجي إلى سبعة مواقع.'
            : 'New showrooms opened in Doha (1,392 m²) and Al Ain (1,700 m²), strengthening our GCC presence to seven locations.',
      ),
    ];

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: hp, vertical: 56),
      child: Column(
        children: [
          // Title
          SizedBox(
            width: double.infinity,
            child: Text(
              isArabic ? 'آخر الأخبار والإعلانات' : 'Latest News & Announcements',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A1A),
              ),
            ),
          ),
          const SizedBox(height: 40),
          // Cards row — wraps on small screens
          LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 700;
              if (isNarrow) {
                return Column(
                  children: items
                      .map((item) => Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: _NewsCard(item: item, isArabic: isArabic),
                          ))
                      .toList(),
                );
              }
              return IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (int i = 0; i < items.length; i++) ...[
                      if (i > 0) const SizedBox(width: 20),
                      Expanded(child: _NewsCard(item: items[i], isArabic: isArabic)),
                    ],
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _NewsItem {
  final String date;
  final String tag;
  final Color tagColor;
  final String title;
  final String desc;
  const _NewsItem({
    required this.date,
    required this.tag,
    required this.tagColor,
    required this.title,
    required this.desc,
  });
}

class _NewsCard extends StatefulWidget {
  final _NewsItem item;
  final bool isArabic;
  const _NewsCard({required this.item, required this.isArabic});
  @override
  State<_NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<_NewsCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isArabic = widget.isArabic;
    final item = widget.item;

    return SelectionContainer.disabled(
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit:  (_) => setState(() => _hovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE8E8E8)),
            boxShadow: _hovered
                ? [BoxShadow(color: Colors.black.withOpacity(0.10), blurRadius: 16, offset: const Offset(0, 4))]
                : [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0, 2))],
          ),
          padding: const EdgeInsets.all(24),
          child: Directionality(
            textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item.date, style: const TextStyle(fontSize: 12, color: Color(0xFF888888))),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: item.tagColor.withOpacity(0.10),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(item.tag, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: item.tagColor)),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(item.title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Color(0xFF1A1A1A), height: 1.3)),
                const SizedBox(height: 10),
                Text(item.desc, style: const TextStyle(fontSize: 13, color: Color(0xFF555555), height: 1.6)),
                const SizedBox(height: 20),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isArabic ? 'اقرأ المزيد' : 'Read More',
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFFE53935)),
                    ),
                    const SizedBox(width: 4),
                    Icon(isArabic ? Icons.chevron_left : Icons.chevron_right, size: 16, color: const Color(0xFFE53935)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}





