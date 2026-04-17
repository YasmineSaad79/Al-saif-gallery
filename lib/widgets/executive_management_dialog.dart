import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';
import '../utils/app_localizations.dart';
import '../utils/responsive.dart';

class ExecutiveManagementDialog extends StatelessWidget {
  const ExecutiveManagementDialog({super.key});

  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) => const ExecutiveManagementDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final isMobile = Responsive.isMobile(context);
    final size = MediaQuery.of(context).size;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : size.width * 0.1,
        vertical: isMobile ? 20 : 40,
      ),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: isMobile ? double.infinity : 1200,
        ),
        height: size.height * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: SelectionArea(
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        l.isArabic ? 'الإدارة التنفيذية العليا' : 'Senior Executive Management',
                        style: GoogleFonts.amiri(
                          fontSize: 21,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SelectionContainer.disabled(
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                        tooltip: 'Close',
                      ),
                    ),
                  ],
                ),
              ),
              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _ExecutiveProfile(
                        nameEn: 'Ahmad bin Saleh bin Mohammed Al-Sultan',
                        nameAr: 'أحمد بن صالح بن محمد السلطان',
                        titleEn: 'Chief Executive Officer (CEO)',
                        titleAr: 'الرئيس التنفيذي',
                        appointedYear: '2024G',
                        nationalityEn: 'Saudi',
                        nationalityAr: 'سعودي',
                        academicQualificationsEn: 'Master of Business Administration, Brunel University, United Kingdom, 2010G\nBachelor\'s in Finance, Qassim University, Kingdom of Saudi Arabia, 2006G',
                        academicQualificationsAr: 'ماجستير في إدارة الأعمال، جامعة برونيل، المملكة المتحدة، 2010م\nبكالوريوس في المالية، جامعة القصيم، المملكة العربية السعودية، 2006م',
                        currentPositions: [
                          _Position(
                            organizationEn: 'Cenomi Retail',
                            organizationAr: 'سنومي للتجزئة',
                            positionEn: 'Board Member and Audit Committee Member',
                            positionAr: 'عضو مجلس الإدارة وعضو لجنة المراجعة',
                            since: '2023G',
                            sectorEn: 'Wholesale & Retail of Clothing & Furniture',
                            sectorAr: 'تجارة الجملة والتجزئة للملابس والأثاث',
                          ),
                        ],
                        previousExperience: [
                          _Experience(
                            organizationEn: 'Thob Al-Aseel Company',
                            organizationAr: 'شركة ثوب الأصيل',
                            positionEn: 'Chief Executive Officer',
                            positionAr: 'الرئيس التنفيذي',
                            from: '2018G',
                            to: '2024G',
                            sectorEn: 'Premium Consumer Goods',
                            sectorAr: 'السلع الاستهلاكية الفاخرة',
                          ),
                          _Experience(
                            organizationEn: 'Al-Saif Stores for Development and Investment Company',
                            organizationAr: 'شركة السيف للتنمية والاستثمار',
                            positionEn: 'Executive Committee Member and Board Member',
                            positionAr: 'عضو اللجنة التنفيذية وعضو مجلس الإدارة',
                            from: '2021G',
                            to: '2024G',
                            sectorEn: 'Household Goods Retail',
                            sectorAr: 'تجزئة السلع المنزلية',
                          ),
                          _Experience(
                            organizationEn: 'Nusk Commercial Projects Company',
                            organizationAr: 'شركة نسك للمشاريع التجارية',
                            positionEn: 'Executive Vice President',
                            positionAr: 'نائب الرئيس التنفيذي',
                            from: '2012G',
                            to: '2018G',
                            sectorEn: 'International Fashion',
                            sectorAr: 'الأزياء العالمية',
                          ),
                          _Experience(
                            organizationEn: 'Nusk Commercial Projects Company',
                            organizationAr: 'شركة نسك للمشاريع التجارية',
                            positionEn: 'Operations Manager',
                            positionAr: 'مدير العمليات',
                            from: '2010G',
                            to: '2012G',
                            sectorEn: 'International Fashion',
                            sectorAr: 'الأزياء العالمية',
                          ),
                        ],
                        isArabic: l.isArabic,
                      ),
                      const SizedBox(height: 32),
                      _ExecutiveProfile(
                        nameEn: 'Mu\'ataz Ali Al-Ashqar',
                        nameAr: 'معتز علي الأشقر',
                        titleEn: 'Chief Financial Officer (CFO)',
                        titleAr: 'المدير المالي التنفيذي',
                        appointedYear: '2025G',
                        nationalityEn: 'Jordanian',
                        nationalityAr: 'أردني',
                        academicQualificationsEn: 'Bachelor\'s in Accounting, Applied Sciences University, Hashemite Kingdom of Jordan, 2001',
                        academicQualificationsAr: 'بكالوريوس في المحاسبة، جامعة العلوم التطبيقية، المملكة الأردنية الهاشمية، 2001م',
                        currentPositions: [
                          _Position(
                            organizationEn: 'Al Saif Gallery',
                            organizationAr: 'السيف غاليري',
                            positionEn: 'Chief Financial Officer',
                            positionAr: 'المدير المالي التنفيذي',
                            since: '2021G to date',
                            sectorEn: 'Household Goods Retail',
                            sectorAr: 'تجزئة السلع المنزلية',
                          ),
                        ],
                        previousExperience: [
                          _Experience(
                            organizationEn: 'Tri Spectrum Company',
                            organizationAr: 'شركة تراي سبكتروم',
                            positionEn: 'CFO',
                            positionAr: 'المدير المالي',
                            from: '2019G',
                            to: '2021G',
                            sectorEn: 'Specialized in electrical building products',
                            sectorAr: 'متخصصة في منتجات البناء الكهربائية',
                          ),
                          _Experience(
                            organizationEn: 'Al-Mazraa Dairy Company',
                            organizationAr: 'شركة المزرعة للألبان',
                            positionEn: 'CFO',
                            positionAr: 'المدير المالي',
                            from: '2018G',
                            to: '2019G',
                            sectorEn: 'Specialized in dairy and cheese products',
                            sectorAr: 'متخصصة في منتجات الألبان والأجبان',
                          ),
                          _Experience(
                            organizationEn: 'Abu Qudara Holding Group',
                            organizationAr: 'مجموعة أبو قدرة القابضة',
                            positionEn: 'CFO',
                            positionAr: 'المدير المالي',
                            from: '2016G',
                            to: '2018G',
                            sectorEn: 'Operating in contracting and building materials',
                            sectorAr: 'تعمل في المقاولات ومواد البناء',
                          ),
                          _Experience(
                            organizationEn: 'Freio Lays Pepsi',
                            organizationAr: 'فريتو ليز بيبسي',
                            positionEn: 'CFO',
                            positionAr: 'المدير المالي',
                            from: '2014G',
                            to: '2016G',
                            sectorEn: 'Food Products Company',
                            sectorAr: 'شركة منتجات غذائية',
                          ),
                          _Experience(
                            organizationEn: 'National Integrated Industries Complex',
                            organizationAr: 'مجمع الصناعات الوطنية المتكاملة',
                            positionEn: 'Head of Accounting',
                            positionAr: 'رئيس المحاسبة',
                            from: '2009G',
                            to: '2012G',
                            sectorEn: 'Specialized in manufacturing air conditioners, washing machines, and refrigerators',
                            sectorAr: 'متخصص في تصنيع المكيفات وغسالات الملابس والثلاجات',
                          ),
                          _Experience(
                            organizationEn: 'BASF',
                            organizationAr: 'باسف',
                            positionEn: 'Senior Accountant',
                            positionAr: 'محاسب أول',
                            from: '2007G',
                            to: '2008G',
                            sectorEn: 'Global construction chemicals company',
                            sectorAr: 'شركة كيماويات البناء العالمية',
                          ),
                        ],
                        isArabic: l.isArabic,
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

class _ExecutiveProfile extends StatelessWidget {
  final String nameEn;
  final String nameAr;
  final String titleEn;
  final String titleAr;
  final String appointedYear;
  final String nationalityEn;
  final String nationalityAr;
  final String academicQualificationsEn;
  final String academicQualificationsAr;
  final List<_Position> currentPositions;
  final List<_Experience> previousExperience;
  final bool isArabic;

  const _ExecutiveProfile({
    required this.nameEn,
    required this.nameAr,
    required this.titleEn,
    required this.titleAr,
    required this.appointedYear,
    required this.nationalityEn,
    required this.nationalityAr,
    required this.academicQualificationsEn,
    required this.academicQualificationsAr,
    required this.currentPositions,
    required this.previousExperience,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name
          Text(
            isArabic ? nameAr : nameEn,
            style: GoogleFonts.amiri(
              fontSize: 19,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 12),
          // Title and Appointed Year
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFDC2626).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  isArabic ? titleAr : titleEn,
                  style: GoogleFonts.cairo(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFDC2626),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '${isArabic ? 'تم التعيين' : 'Appointed'}: $appointedYear',
                  style: GoogleFonts.cairo(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF6B7280),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Nationality
          Text(
            '${isArabic ? 'الجنسية' : 'Nationality'}: ${isArabic ? nationalityAr : nationalityEn}',
            style: GoogleFonts.cairo(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF6B7280),
            ),
          ),
          const SizedBox(height: 24),
          // Academic Qualifications
          Text(
            isArabic ? 'المؤهلات الأكاديمية:' : 'Academic Qualifications:',
            style: GoogleFonts.cairo(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Text(
              isArabic ? academicQualificationsAr : academicQualificationsEn,
              style: GoogleFonts.cairo(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF4B5563),
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Current Positions
          Text(
            isArabic ? 'المناصب الحالية:' : 'Current Positions:',
            style: GoogleFonts.cairo(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 12),
          ...currentPositions.map((position) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _PositionItem(position: position, isArabic: isArabic),
              )),
          const SizedBox(height: 12),
          // Previous Experience
          Text(
            isArabic ? 'الخبرات المهنية السابقة:' : 'Key Previous Professional Experience:',
            style: GoogleFonts.cairo(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 12),
          ...previousExperience.map((exp) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _ExperienceItem(experience: exp, isArabic: isArabic),
              )),
        ],
      ),
    );
  }
}

class _Position {
  final String organizationEn;
  final String organizationAr;
  final String positionEn;
  final String positionAr;
  final String since;
  final String sectorEn;
  final String sectorAr;

  const _Position({
    required this.organizationEn,
    required this.organizationAr,
    required this.positionEn,
    required this.positionAr,
    required this.since,
    required this.sectorEn,
    required this.sectorAr,
  });
}

class _PositionItem extends StatelessWidget {
  final _Position position;
  final bool isArabic;

  const _PositionItem({required this.position, required this.isArabic});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: GoogleFonts.cairo(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
                    children: [
                      TextSpan(
                        text: '${isArabic ? 'المنظمة' : 'Organization'}: ',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                      TextSpan(
                        text: isArabic ? position.organizationAr : position.organizationEn,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: GoogleFonts.cairo(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
                    children: [
                      TextSpan(
                        text: '${isArabic ? 'المنصب' : 'Position'}: ',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                      TextSpan(
                        text: isArabic ? position.positionAr : position.positionEn,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: GoogleFonts.cairo(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF6B7280),
                      height: 1.5,
                    ),
                    children: [
                      const TextSpan(
                        text: 'منذ: ',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      TextSpan(
                        text: position.since,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: GoogleFonts.cairo(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF6B7280),
                      height: 1.5,
                    ),
                    children: [
                      TextSpan(
                        text: '${isArabic ? 'القطاع' : 'Sector'}: ',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      TextSpan(
                        text: isArabic ? position.sectorAr : position.sectorEn,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Experience {
  final String organizationEn;
  final String organizationAr;
  final String positionEn;
  final String positionAr;
  final String from;
  final String to;
  final String sectorEn;
  final String sectorAr;

  const _Experience({
    required this.organizationEn,
    required this.organizationAr,
    required this.positionEn,
    required this.positionAr,
    required this.from,
    required this.to,
    required this.sectorEn,
    required this.sectorAr,
  });
}

class _ExperienceItem extends StatelessWidget {
  final _Experience experience;
  final bool isArabic;

  const _ExperienceItem({required this.experience, required this.isArabic});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  isArabic ? experience.organizationAr : experience.organizationEn,
                  style: GoogleFonts.cairo(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1A1A1A),
                  ),
                ),
              ),
              Text(
                '${experience.from} — ${experience.to}',
                style: GoogleFonts.cairo(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF6B7280),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              style: GoogleFonts.cairo(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF4B5563),
                height: 1.5,
              ),
              children: [
                const TextSpan(
                  text: 'المنصب: ',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                TextSpan(
                  text: isArabic ? experience.positionAr : experience.positionEn,
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          RichText(
            text: TextSpan(
              style: GoogleFonts.cairo(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF4B5563),
                height: 1.5,
              ),
              children: [
                TextSpan(
                  text: '${isArabic ? 'القطاع' : 'Sector'}: ',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                TextSpan(
                  text: isArabic ? experience.sectorAr : experience.sectorEn,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
