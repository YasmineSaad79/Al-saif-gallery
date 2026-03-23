import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/responsive.dart';
import '../main.dart';

class NCCareersSection extends StatefulWidget {
  const NCCareersSection({super.key});
  @override
  State<NCCareersSection> createState() => _NCCareersSectionState();
}

class _NCCareersSectionState extends State<NCCareersSection> {
  @override
  void initState() { super.initState(); localeProvider.addListener(_rebuild); }
  void _rebuild() { if (mounted) setState(() {}); }
  @override
  void dispose() { localeProvider.removeListener(_rebuild); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final isArabic = localeProvider.isArabic;
    final hp = Responsive.getHorizontalPadding(context);

    return Container(
      width: double.infinity,
      color: const Color(0xFFF8FAFB),
      padding: EdgeInsets.symmetric(horizontal: hp, vertical: 56),
      child: Directionality(
        textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        child: Column(
          children: [
            // ── Title & subtitle ──
            Text(
              isArabic ? 'الوظائف في السيف غاليري' : 'Careers at Al Saif Gallery',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                fontFamily: 'Inter',
                color: Color(0xFF1A1A1A),
              ),
            ),
            const SizedBox(height: 12),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: Text(
                isArabic
                    ? 'ابنِ مسيرتك المهنية مع الرائد السعودي في مستلزمات المنزل. نبحث عن أفراد موهوبين للانضمام إلى فريقنا المتنامي الذي يضم أكثر من 1,280 موظفاً في خمسة أسواق.'
                    : "Build your career with Saudi Arabia's leading household essentials retailer. We're looking for talented individuals to join our growing team of 1,280+ employees across five markets.",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF555555),
                  fontFamily: 'Inter',
                  height: 1.6,
                ),
              ),
            ),
            const SizedBox(height: 40),

            // ── Stats row ──
            LayoutBuilder(builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 600;
              final stats = [
                _StatItem(
                  icon: 'assets/images/Customer.svg',
                  value: '1,280+',
                  label: isArabic ? 'موظف' : 'Employees',
                  sub: isArabic ? 'في 5 أسواق' : 'Across 5 markets',
                ),
                _StatItem(
                  icon: 'assets/images/location.svg',
                  value: '73',
                  label: isArabic ? 'صالة عرض' : 'Showrooms',
                  sub: isArabic ? 'السعودية ودول الخليج' : 'KSA & GCC',
                ),
                _StatItem(
                  icon: 'assets/images/strategy.svg',
                  value: '30+',
                  label: isArabic ? 'سنة' : 'Years',
                  sub: isArabic ? 'من النمو' : 'Of growth',
                ),
                _StatItem(
                  icon: 'assets/images/department.svg',
                  value: isArabic ? 'متعددة' : 'Multiple',
                  label: isArabic ? 'أقسام' : 'Departments',
                  sub: isArabic ? 'أدوار متنوعة' : 'Diverse roles',
                ),
              ];
              if (isNarrow) {
                return GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.4,
                  children: stats.map((s) => _StatCard(item: s)).toList(),
                );
              }
              return IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (int i = 0; i < stats.length; i++) ...[
                      if (i > 0) const SizedBox(width: 16),
                      Expanded(child: _StatCard(item: stats[i])),
                    ],
                  ],
                ),
              );
            }),
            const SizedBox(height: 24),

            // ── Why Join Us + Our Departments ──
            LayoutBuilder(builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 700;
              final whyJoin = _InfoCard(
                title: isArabic ? 'لماذا تنضم إلينا' : 'Why Join Us',
                bullets: isArabic
                    ? [
                        'العمل في شركة مدرجة في تداول ذات مسار نمو قوي',
                        'كن جزءاً من الرائد السعودي في مستلزمات المنزل',
                        'برامج تدريب منظّمة وتطوير مهني',
                        'حزمة تعويضات ومزايا تنافسية',
                        'فرص التقدم الوظيفي عبر أقسام متعددة',
                        'ثقافة عمل شاملة وموجّهة نحو الأداء',
                      ]
                    : [
                        'Work for a Tadawul-listed company with strong growth trajectory',
                        "Be part of Saudi Arabia's household essentials leader",
                        'Structured training and professional development programs',
                        'Competitive compensation and benefits package',
                        'Career advancement opportunities across multiple departments',
                        'Inclusive, performance-oriented workplace culture',
                      ],
              );
              final depts = _InfoCard(
                title: isArabic ? 'أقسامنا' : 'Our Departments',
                bullets: isArabic
                    ? [
                        'العمليات التجارية: إدارة صالات العرض، خدمة العملاء، المبيعات',
                        'اللوجستيات وسلسلة التوريد: المستودعات، التوزيع، إدارة المخزون',
                        'الرقمي والتجارة الإلكترونية: تطوير المنصات، التسويق الرقمي، التحليلات',
                        'خدمة ما بعد البيع: معالجة الضمانات، الإصلاح، دعم العملاء',
                        'الوظائف المؤسسية: المالية، الموارد البشرية، القانونية، الحوكمة',
                        'تطوير العلامات والمنتجات: التوريد، ضبط الجودة، الابتكار',
                      ]
                    : [
                        'Retail Operations: Showroom management, customer service, sales',
                        'Logistics & Supply Chain: Warehouse, distribution, inventory management',
                        'Digital & E-Commerce: Platform development, digital marketing, analytics',
                        'After-Sales Service: Warranty processing, repairs, customer support',
                        'Corporate Functions: Finance, HR, legal, compliance, governance',
                        'Brand & Product Development: Sourcing, quality control, innovation',
                      ],
                boldFirst: true,
              );
              if (isNarrow) {
                return Column(children: [whyJoin, const SizedBox(height: 16), depts]);
              }
              return IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: whyJoin),
                    const SizedBox(width: 16),
                    Expanded(child: depts),
                  ],
                ),
              );
            }),
            const SizedBox(height: 32),

            // ── CTA Banner ──
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFC62030),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 48),
              child: Column(
                children: [
                  Text(
                    isArabic ? 'هل أنت مستعد لبناء مسيرتك معنا؟' : 'Ready to Build Your Career with Us?',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    isArabic
                        ? 'نبحث دائماً عن أفراد موهوبين يشاركوننا التزامنا بالجودة وخدمة العملاء والتميز التشغيلي.'
                        : "We're always looking for talented individuals who share our commitment to quality, customer service, and operational excellence.",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.white70,
                      fontFamily: 'Inter',
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 24),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white, width: 1.5),
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    ),
                    child: Text(
                      isArabic ? 'عرض الوظائف المتاحة' : 'View Open Positions',
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Stat item model ──
class _StatItem {
  final String icon;
  final String value;
  final String label;
  final String sub;
  const _StatItem({required this.icon, required this.value, required this.label, required this.sub});
}

// ── Stat card ──
class _StatCard extends StatelessWidget {
  final _StatItem item;
  const _StatCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE8E8E8)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(item.icon, width: 32, height: 32, colorFilter: const ColorFilter.mode(Color(0xFFC62030), BlendMode.srcIn)),
          const SizedBox(height: 10),
          Text(
            item.value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              fontFamily: 'Inter',
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            item.label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF333333), fontFamily: 'Inter'),
          ),
          const SizedBox(height: 2),
          Text(
            item.sub,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 11, color: Color(0xFF888888), fontFamily: 'Inter'),
          ),
        ],
      ),
    );
  }
}

// ── Info card (Why Join / Departments) ──
class _InfoCard extends StatelessWidget {
  final String title;
  final List<String> bullets;
  final bool boldFirst;
  const _InfoCard({required this.title, required this.bullets, this.boldFirst = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE8E8E8)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              fontFamily: 'Inter',
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 16),
          ...bullets.map((b) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: CircleAvatar(radius: 3, backgroundColor: Color(0xFFC62030)),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: boldFirst
                          ? _BoldFirstText(text: b)
                          : Text(b, style: const TextStyle(fontSize: 13, color: Color(0xFF444444), fontFamily: 'Inter', height: 1.5)),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

// Renders "Bold Part: rest" for department bullets
class _BoldFirstText extends StatelessWidget {
  final String text;
  const _BoldFirstText({required this.text});

  @override
  Widget build(BuildContext context) {
    final idx = text.indexOf(':');
    if (idx == -1) {
      return Text(text, style: const TextStyle(fontSize: 13, color: Color(0xFF444444), fontFamily: 'Inter', height: 1.5));
    }
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 13, color: Color(0xFF444444), fontFamily: 'Inter', height: 1.5),
        children: [
          TextSpan(text: text.substring(0, idx + 1), style: const TextStyle(fontWeight: FontWeight.w700)),
          TextSpan(text: text.substring(idx + 1)),
        ],
      ),
    );
  }
}
