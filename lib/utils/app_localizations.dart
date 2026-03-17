import 'package:flutter/material.dart';
import 'locale_provider.dart';

class AppLocalizations {
  final bool isArabic;
  const AppLocalizations({required this.isArabic});

  static AppLocalizations of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<_LocalizationsScope>();
    return scope?.localizations ?? const AppLocalizations(isArabic: false);
  }

  // ── Top Bar ──────────────────────────────────────────────────────────────
  String get topBarDocuments => isArabic ? 'مكتبة الوثائق' : 'Documents Library';
  String get topBarContact   => isArabic ? 'تواصل معنا'    : 'Contact';
  String get topBarSearch    => isArabic ? 'بحث'           : 'Search';
  String get topBarLangToggle => isArabic ? 'English'      : 'العربية';

  // ── Navigation ───────────────────────────────────────────────────────────
  String get navHome      => isArabic ? 'الرئيسية'              : 'Home';
  String get navAboutUs   => isArabic ? 'من نحن'                : 'About Us';
  String get navStrategy  => isArabic ? 'الاستراتيجية والعمليات' : 'Strategy & Operations';
  String get navInvestors => isArabic ? 'المستثمرون والحوكمة'   : 'Investors & Governance';
  String get navNewsroom  => isArabic ? 'الأخبار والوظائف'      : 'Newsroom & Careers';


  // ── Hero Section ─────────────────────────────────────────────────────────
  String get heroTitle => isArabic
      ? 'بيت الأسرة السعودية\nمنذ 1993.'
      : "Saudi Arabia's Home\nSince 1993.";
  String get heroSubtitle => isArabic
      ? 'ثلاثة عقود في خدمة الأسرة السعودية. هدفنا واحد: جودة تُبنى عليها الثقة، كل يوم'
      : 'Thirty years of serving Saudi households. One purpose: trusted quality, every day.';
  String get heroDesc1 => isArabic
      ? 'السيف غاليري وجهة متخصصة في المملكة العربية السعودية لمستلزمات المنزل وأجهزة المطبخ، انطلقت من معرض واحد في الرياض لتصبح اليوم منصة تجزئة وطنية تضم 73 صالة عرض عبر المملكة ودول مجلس التعاون الخليجي. ومنذ إدراجها في السوق المالية السعودية (تداول) عام 2022، تجمع السيف غاليري بين مزايا الشركة المدرجة وانضباط التشغيل الذي بنى ثقة الأسر السعودية على مدى ثلاثة عقود.'
      : "Al Saif Gallery is Saudi Arabia's specialist in household essentials and kitchen appliances, built from a single Riyadh showroom into a national retail platform of 73 locations across the Kingdom and the GCC. Listed on Tadawul since 2022, we combine the scale of a public company with the discipline of an operator that has earned household trust for three decades.";
  String get heroDesc2 => isArabic
      ? 'يقوم نموذج أعمالنا على علامات تجارية مملوكة وحصرية، في مقدمتها إيدسون وتورنادو وروبست وروكي، صُمّمت ووُضّعت مواصفاتها للبيت السعودي ومطبخه وضيافته. وكل منتج نقدمه هو اختيار مدروس: جودة تكسب الولاء، وقيمة تحترم العميل.'
      : 'Our model is powered by proprietary and exclusive brands, including Edison, Tornado, Robust, and Rocky, designed and specified for Saudi homes, Saudi kitchens, and Saudi hospitality traditions. Every product we carry reflects a deliberate choice: quality that earns loyalty, value that respects the customer.';
  String get heroExploreStory    => isArabic ? 'اكتشف قصتنا'       : 'Explore Our Story';
  String get heroInvestorRelations => isArabic ? 'علاقات المستثمرين' : 'Investor Relations';


  // ── Stats Section ────────────────────────────────────────────────────────
  String get statsShowrooms         => isArabic ? '73 صالة عرض'                    : 'Showrooms';
  String get statsShowroomsSubtitle => isArabic ? 'في 5 أسواق خليجية'           : 'Across 5 GCC markets';
  String get statsRevenue           => isArabic ? '758.8 مليون ريال إيرادات'     : 'SAR 758.8M Revenue';
  String get statsRevenueSubtitle   => isArabic ? 'الأداء المالي لعام 2025'       : 'FY 2025 performance';
  String get statsPropRevenue       => isArabic ? 'نحو 88% إيرادات العلامات الخاصة' : '~88% Proprietary Revenue';
  String get statsPropRevenueSubtitle => isArabic ? 'علامات مملوكة وحصرية'        : 'Owned & exclusive brands';
  String get statsEcommerce         => isArabic ? '37% نمو التجارة الإلكترونية'  : '37% E-Commerce Growth';
  String get statsEcommerceSubtitle => isArabic ? '94 مليون ريال مبيعات رقمية'   : 'SAR 94M digital sales';

  // ── Brands Section ───────────────────────────────────────────────────────
  String get brandsTitle => isArabic
      ? 'علامات تجارية يثق بها العملاء ويعودون إليها'
      : 'Built on Brands Customers Return To';
  String get brandsDesc1 => isArabic
      ? 'نقوم بتصميم وتوريد وتقديم مستلزمات المنزل عبر فئات يعتمد عليها العملاء في حياتهم اليومية ويعودون لشرائها باستمرار. ويقوم نموذج أعمالنا على ثلاث ركائز رئيسية متكاملة: محفظة من العلامات التجارية المملوكة المصممة خصيصًا لتلبية احتياجات الأسر السعودية، وشبكة وطنية من صالات العرض مدعومة بمستودع مركزي ومركز توزيع في جدة، ومنظومة متكاملة لخدمات ما بعد البيع تشمل الضمان والصيانة وتوفير قطع الغيار؛ بما يحوّل عملية الشراء إلى علاقة طويلة الأمد مع العميل.'
      : 'We source, design, and deliver household essentials across categories customers buy repeatedly and rely on daily. Our platform is structured around three reinforcing strengths: a proprietary brand portfolio with specifications tailored to Saudi households; a national showroom network supported by centralized warehousing and a Jeddah fulfillment center; and integrated service infrastructure covering warranty, repair, and spare parts that transforms a purchase into a lasting relationship.';
  String get brandsDesc2 => isArabic
      ? 'هذا ليس نموذج تجارة تجزئة تقليدي، إذ تعمل السيف غاليري في قطاع متخصص محدد المعالم، في فئات الأدوات المنزلية وأجهزة المطبخ حيث نتمتع بموقع ريادي في المملكة العربية السعودية، ونقدم فيها جودة موثوقة بقيمة تنافسية. وتطورت علامة إديسون -من أكثر العلامات شهرة في الأجهزة المنزلية الصغيرة في المملكة- إلى منظومة متكاملة للأجهزة المنزلية، تشمل الثلاجات والغسالات وأنظمة التكييف وحلول المطابخ المدمجة.'
      : 'This is not generic retail. Al Saif Gallery operates in a carefully defined niche: the household goods and kitchen appliances categories where we hold a leading position in Saudi Arabia, delivering dependable quality at competitive value. Our Edison brand has grown from the country\'s most recognized small appliance label into a full home ecosystem, including refrigerators, washing machines, air conditioning, and built-in kitchen solutions.';

  // ── Service Cards (Brands Section) ───────────────────────────────────────
  String get cardStrategyTitle => isArabic ? 'الاستراتيجية والعمليات' : 'Strategy & Operations';
  String get cardStrategyDesc  => isArabic
      ? 'كيف ننمو بانضباط: شبكة الفروع، محفظة العلامات التجارية، القنوات الرقمية، وخدمات ما بعد البيع.'
      : 'Disciplined growth, operational excellence, and omni-channel capabilities.';
  String get cardStrategyLink  => isArabic ? 'اكتشف الاستراتيجية' : 'Explore Strategy';

  String get cardInvestorsTitle => isArabic ? 'المستثمرون والحوكمة' : 'Investors & Governance';
  String get cardInvestorsDesc  => isArabic
      ? 'النتائج المالية، والإفصاحات التنظيمية، وهيكل مجلس الإدارة، وخدمات المساهمين لمستثمري تداول.'
      : 'Financial reports, shareholder information, and governance framework.';
  String get cardInvestorsLink  => isArabic ? 'مركز المستثمرين' : 'Investor Center';

  String get cardBrandsTitle => isArabic ? 'علاماتنا التجارية' : 'Our Brands';
  String get cardBrandsDesc  => isArabic
      ? 'إيدسون، تورنادو، روبست، روكي وغيرها. علامات خاصة وحصرية صُمّمت للبيت السعودي والضيافة الخليجية.'
      : 'Edison, Tornado, Robust, and Rocky. Innovation, precision, and trust engineered for Saudi homes.';
  String get cardBrandsLink  => isArabic ? 'محفظة العلامات التجارية' : 'Brand Portfolio';

  String get cardCareersTitle => isArabic ? 'الوظائف والثقافة المؤسسية' : 'Careers & Culture';
  String get cardCareersDesc  => isArabic
      ? 'انضم إلى فريق يخدم الأسرة السعودية عبر 73 صالة عرض. فرص في التجزئة واللوجستيات والرقمي والوظائف المؤسسية.'
      : 'Join our team. Work with a customer-first culture. Opportunities across all functions.';
  String get cardCareersLink  => isArabic ? 'استكشف الوظائف' : 'Explore Roles';


  // ── Our Purpose Section ──────────────────────────────────────────────────
  String get purposeTitle => isArabic ? 'غايتنا' : 'Our Purpose';
  String get purposeDesc1 => isArabic
      ? 'نعمل على إتاحة مستلزمات منزلية موثوقة ومصممة بعناية للأسر السعودية، بقيمة عادلة وخدمة مستمرة والتزام يتجاوز لحظة الشراء. ومنذ تأسيسنا عام 1993، لم تتغير هذه الرسالة؛ وما تطوّر هو حجمنا وقدراتنا: من معرض واحد إلى شبكة وطنية، ومن نشاط تجاري تقليدي إلى نموذج متكامل للتجزئة، ومن شركة خاصة إلى شركة مدرجة في "تداول" تخدم مصلحة مساهميها جنباً إلى جنب مع عملائها.'
      : 'We exist to make trusted, well-designed household essentials accessible to Saudi families, backed by honest value, consistent service, and a commitment that extends well beyond the point of purchase.';
  String get purposeDesc2 => isArabic
      ? 'تنعكس هذه الغاية في جميع جوانب عملنا: مواصفات المنتجات المصمّمة لفنون الطبخ والضيافة السعودية، ومنظومة خدمة ما بعد البيع التي تصون ثقة العميل، وإطار حوكمة يليق بشركة مدرجة، واستراتيجية بُنيت لخلق قيمة طويلة الأمد لجميع أصحاب المصلحة.'
      : 'Since our founding in 1993, that purpose has not changed. The platform around it has grown from a single showroom to a national network, from a trading operation to a vertically integrated retail model, and from a private enterprise to a Tadawul-listed company serving the public interest as well as our customers.';
  String get purposeDesc3 => isArabic
      ? ''
      : 'Our purpose creates alignment across everything we do: product specifications that serve Saudi cooking and hospitality traditions; after-sales infrastructure that protects customer trust; a governance framework designed for a listed company; and a strategy built to deliver long-term value for all stakeholders.';

  // ── Our Values Section ───────────────────────────────────────────────────
  String get valuesTitle => isArabic ? 'قيمنا' : 'Our Values';

  String get valueQualityTitle => isArabic ? 'الجودة والموثوقية' : 'Quality & Reliability';
  String get valueQualityDesc  => isArabic
      ? 'نضع معايير صارمة لكل منتج نصمّمه أو نورّده أو نبيعه. مواصفات المنتجات وبروتوكولات الموردين وعمليات ضبط الجودة جميعها تضمن أن يصل إلى العميل ما وُعد به بالضبط. لا تهاون في معايير السلامة ولا في متطلبات الامتثال.'
      : 'We never compromise on product standards. Every item we sell—from our proprietary brands to third-party products—undergoes rigorous quality control. Our customers trust us not because we are the cheapest, but because we are consistent, including in compliance.';

  String get valueCustomerTitle => isArabic ? 'العميل أولاً' : 'Customer First';
  String get valueCustomerDesc  => isArabic
      ? 'كل قرار تشغيلي، من تصميم صالة العرض إلى مواعيد التوصيل وشروط الضمان، يُتّخذ من منظور تجربة العميل. ثقافتنا المُشبَعة بقيم الضيافة العربية الأصيلة تجعل خدمة الزائر ليست شعاراً نرفعه، بل المقياس الذي نُحاسب أنفسنا به.'
      : 'Every operational decision from store layout to delivery windows to warranty terms, is made through the lens of the customer experience. The showroom is not a sales channel. It is a service environment, reflected in our Net Promoter Score (NPS) and repeat purchase rates, which are among the best in the category.';

  String get valueIntegrityTitle => isArabic ? 'النزاهة والشفافية' : 'Integrity & Transparency';
  String get valueIntegrityDesc  => isArabic
      ? 'ندير أعمالنا بالمساءلة تجاه جميع أصحاب المصلحة. وبوصفنا شركة مدرجة، نلتزم بالإفصاح المالي الشفاف والحوكمة الرشيدة ومعايير التواصل التي تحترم المساهمين والموظفين والشركاء والجهات التنظيمية على حدٍّ سواء.'
      : 'We operate with full accountability to our stakeholders, to our customers, we are committed to transparent financial disclosures, consistent governance practices, and ethical business conduct. We report what we measure. We measure what matters. And we hold ourselves accountable for both.';

  String get valueImprovementTitle => isArabic ? 'التطوير المستمر' : 'Continuous Improvement';
  String get valueImprovementDesc  => isArabic
      ? 'نستثمر في موظفينا من خلال برامج تدريب منظّمة ومعايير تشغيلية ومسارات تطوير وظيفي واضحة. نراجع عملياتنا بموضوعية ونتصرف بناءً على ما نجده. وهذا الانضباط هو وقود كفاءاتنا التشغيلية وصانع الاتساق في الجودة الذي يكسب ولاء العملاء.'
      : 'We invest in our infrastructure through enhanced inventory systems, optimized warehouse operations, and refined customer service protocols. We do not chase headlines or set up vanity initiatives. We pursue measurable, disciplined gain. Incremental progress and the quality-compounding that turns customer loyalty.';


  // ── Heritage & Milestones Section ────────────────────────────────────────
  String get heritageTitle    => isArabic ? 'المسيرة والمحطات الكبرى' : 'Heritage & Milestones';
  String get heritageSubtitle => isArabic
      ? 'ثلاثة عقود من النمو والتطور في قطاع التجزئة المتخصص'
      : 'Three decades of growth and evolution in specialized retail';

  // milestones
  String get m1993year  => '1993';
  String get m1993title => isArabic ? 'التأسيس في الرياض' : 'Foundation in Riyadh';
  String get m1993desc  => isArabic
      ? 'أسّس سليمان بن محمد السيف الشركة كمنشأة فردية، جمعت خبرة المنتجات المستوردة مع المعرفة العميقة باحتياجات الأسرة السعودية.'
      : 'Suleiman Al Saif establishes the business as a sole proprietorship, combining imported product expertise with deep knowledge of Saudi household needs.';

  String get m2006year  => '2006';
  String get m2006title => isArabic ? 'أول صالة عرض بهوية السيف غاليري' : 'Al Saif Gallery Brand Launch';
  String get m2006desc  => isArabic
      ? 'انطلقت التجزئة بهوية متميزة وتجربة موحّدة.'
      : 'Retail operations launch under a distinct brand identity with a unified customer experience.';

  String get m2010year  => '2010';
  String get m2010title => isArabic ? 'الشبكة تبلغ 10 صالات عرض' : 'Network Reaches 10 Showrooms';
  String get m2010desc  => isArabic
      ? 'أثبت النموذج التجاري قابليته للتكرار والتوسع.'
      : 'The business model proves its scalability and replicability across the Kingdom.';

  String get m2014year  => '2014';
  String get m2014title => isArabic ? 'التحوّل المؤسسي' : 'Corporate Transformation';
  String get m2014desc  => isArabic
      ? 'تحويل الشركة إلى شركة مساهمة سعودية مقفلة مع البدء في تطوير إطار الحوكمة تمهيداً للإدراج.'
      : 'Conversion to a closed joint stock company. Governance infrastructure begins formal development ahead of eventual public listing.';

  String get m2015year  => '2015';
  String get m2015title => isArabic ? 'إطلاق علامة إيدسون' : 'Edison Brand Launch';
  String get m2015desc  => isArabic
      ? 'نقطة تحوّل استراتيجية نحو ملكية العلامات التجارية وابتكار المنتجات المُعدّة للبيت السعودي والخليجي.'
      : 'The Edison proprietary brand is introduced, a strategic pivot toward brand ownership and product innovation tailored for Gulf households.';

  String get m2016year  => '2016';
  String get m2016title => isArabic ? 'منصة التجارة الإلكترونية' : 'E-Commerce Platform';
  String get m2016desc  => isArabic
      ? 'إطلاق الموقع والتطبيق إلى جانب برنامج ولاء العملاء، مما أرسى أسس نموذج متعدد القنوات.'
      : 'The online platform and mobile application are launched alongside a customer loyalty program, establishing the foundation for omni-channel operations.';

  String get m2018year  => '2018-2022';
  String get m2018title => isArabic ? 'ريادة إيدسون في الأجهزة المنزلية الكبيرة' : 'Edison Brand Leadership';
  String get m2018desc  => isArabic
      ? 'توسّع وتعمّق منصة العلامات الخاصة. إطلاق إيدسون للأجهزة الكبيرة، من ثلاجات وغسالات ومكيفات هواء، يُوسّع المنظومة من الأجهزة الصغيرة إلى حلول المنزل كاملاً.'
      : 'Proprietary brand platform scaled and deepened. Launch of the Edison large appliance extension, including refrigerators, washing machines, and air conditioning, expands the offering from small appliances into whole-home solutions.';

  String get m2022year  => '27 ديسمبر 2022';
  String get m2022title => isArabic ? 'الطرح العام الأولي في تداول' : 'Tadawul IPO';
  String get m2022desc  => isArabic
      ? 'إدراج السيف غاليري في السوق الرئيسية للسوق المالية السعودية بسعر 115 ريالاً للسهم قبل التجزئة، بتغطية 269%، مما يعكس الطلب الواسع من السوق على متخصص متميز في مستلزمات المنزل السعودي.'
      : 'Al Saif Gallery lists on the Saudi Exchange Main Market at SAR 115 per share (pre-split). The offering is 269% oversubscribed, reflecting strong market demand for a pure-play specialist in Saudi household essentials.';

  String get m2023year  => isArabic ? 'يوليو 2023' : 'July 2023';
  String get m2023title => isArabic ? 'توسيع الهيكل الرأسمالي' : 'Capital Structure Expansion';
  String get m2023desc  => isArabic
      ? 'تجزئة الأسهم بنسبة 10 إلى 1 ترفع عدد الأسهم إلى 350 مليون سهم، مما يُعزز سيولة السهم في السوق.'
      : '10-for-1 stock split increases shares outstanding to 350 million, improving market liquidity.';

  String get m2024year  => '2024';
  String get m2024title => isArabic ? 'التوسع الخليجي' : 'GCC Expansion';
  String get m2024desc  => isArabic
      ? 'افتتاح صالات عرض جديدة في الدوحة (ديسمبر 2024، 1,392 م²) والعين (ديسمبر 2024، 1,700 م²) ومسقط، ليبلغ مجموع صالات دول الخليج سبعة مواقع في الإمارات والكويت وعُمان وقطر.'
      : 'New showrooms open in Doha (December 2024, 1,392 m²), Al Ain (December 2024, 1,700 m²), and Muscat, bringing the GCC network to seven locations across UAE, Kuwait, Oman, and Qatar.';

  String get m2024bYear  => isArabic ? 'ديسمبر 2024' : 'Dec 2024';
  String get m2024bTitle => isArabic ? 'مرحلة قيادة جديدة' : 'Leadership Transition';
  String get m2024bDesc  => isArabic
      ? 'تعيين أحمد بن صالح آل سلطان رئيساً تنفيذياً، وهو أول رئيس تنفيذي محترف من خارج الأسرة المؤسِّسة في تاريخ الشركة، إيذاناً بمرحلة جديدة من التركيز التشغيلي ونضج الحوكمة.'
      : 'Ahmed bin Saleh Al Sultan appointed as CEO, the first professional, non-family CEO in the Company\'s history, marking a new phase of operational focus and governance maturity.';

  String get m2025year  => '2025';
  String get m2025title => isArabic ? 'الانتعاش المالي والتسارع الرقمي' : 'Financial Recovery & Digital Acceleration';
  String get m2025desc  => isArabic
      ? 'إيرادات 758.8 مليون ريال، وصافي ربح 58 مليون ريال بنمو 54.6% مقارنة بالعام السابق، ونمو التجارة الإلكترونية 37% لتبلغ 94 مليون ريال، مما يجسّد متانة النموذج التشغيلي وزخم التحول الرقمي.'
      : 'Revenue of SAR 758.8M, net profit of SAR 58M (+54.6% year-on-year), and e-commerce growth of 37% to SAR 94M demonstrate the platform\'s operational resilience and digital momentum.';

  // ── Leadership Section ───────────────────────────────────────────────────
  String get leadershipTitle => isArabic ? 'القيادة' : 'Leadership';

  String get boardTitle => isArabic ? 'مجلس الإدارة' : 'Board of Directors';
  String get boardDesc  => isArabic
      ? 'يتولى مجلس الإدارة الإشراف الاستراتيجي وصون حقوق المساهمين وضمان مساءلة الإدارة وفق التزامات الشركة بوصفها مدرجة في تداول. أُعيد انتخاب المجلس الحالي في أكتوبر 2025 للفترة من 2025 إلى 2028.'
      : 'The Board provides strategic oversight, safeguards stakeholder interests, and ensures that management accountability aligns with our obligations as a Tadawul-listed company. The current board was re-elected in October 2025 for the 2025 to 2028 term.';
  String get boardLink  => isArabic ? 'عرض السير الذاتية لأعضاء المجلس' : 'View Board Profiles';

  String get execTitle => isArabic ? 'الإدارة التنفيذية' : 'Executive Management';
  String get execDesc  => isArabic
      ? 'يتولى الفريق التنفيذي مسؤولية تحقيق الأداء التشغيلي والمالي الذي يُنشئ قيمة حقيقية لجميع أصحاب المصلحة. يقوده الرئيس التنفيذي أحمد بن صالح آل سلطان، ويضم خبرات متخصصة في العمليات التجارية والشؤون المالية والتجارة الإلكترونية.'
      : 'Our executive team is responsible for delivering the operational and financial performance that creates value for all stakeholders. Led by CEO Ahmed bin Saleh Al Sultan, the executive team brings specialist expertise across retail operations, finance, and digital commerce.';
  String get execLink  => isArabic ? 'عرض السير الذاتية التنفيذية' : 'View Executive Profiles';

  // ── Investment Case Section (Home) ───────────────────────────────────────
  String get investmentTitle    => isArabic ? 'مقومات الاستثمار' : 'Investment Case';
  String get investmentSubtitle => isArabic
      ? 'أربع مزايا هيكلية يصعب تكرارها.'
      : 'Four structural advantages that are difficult to replicate.';

  String get invest1Title => isArabic ? 'ملكية العلامات التجارية بهوية سعودية' : 'Saudi-Focused Brand Ownership';
  String get invest1Desc  => isArabic
      ? 'تأتي نحو 88% من إيراداتنا من علامات تجارية نملكها أو نوزّعها حصرياً: إيدسون، تورنادو، روبست، روكي، إيفرست، إيليغانس، ليما، راين، تايم ليس، رويال، فالكون وغلوري. علاقاتنا المباشرة مع المصنّعين تُتيح لنا تجاوز الوسطاء، مما يمنحنا كفاءة في التكلفة ومرونة في تحديد مواصفات المنتجات وفق متطلبات الأسرة السعودية. وحين يفتح عميلنا منتجاً من إديسون، فهو لا يفتح منتجاً مستورداً عاماً، بل منتجاً صُمّم خصيصاً للبيت السعودي.'
      : 'Approximately 28% of our revenue comes from proprietary and exclusive brands we control: Edison, Tornado, Robust, and Rocky. Proprietary brands—Lorena, iRoast, Timpano, Royal, Falcon, and Glory. Direct manufacturing relationships eliminate wholesale intermediaries, enabling tighter cost efficiency and the ability to specify products for Saudi cultural preferences. When our customers open an Edison product, they are not opening a generic import. They are opening something engineered with Saudi households in mind.';

  String get invest2Title => isArabic ? 'الانتشار الوطني وعمق الخدمة' : 'National Reach with Service Depth';
  String get invest2Desc  => isArabic
      ? '73 صالة عرض في المملكة العربية السعودية وخمسة أسواق خليجية، تدعمها مستودعات مركزية في الرياض ومركز توزيع متخصص في جدة. التزامات التوصيل من يوم إلى 3 أيام داخل الرياض، ومن 3 إلى 5 أيام في أرجاء المملكة، ومن 5 إلى 10 أيام دولياً. شبكتنا ليست مجرد بنية توزيع، بل منصة خدمة وضمان متكاملة.'
      : '73 showrooms across Saudi Arabia and five GCC markets, supported by distribution infrastructure in Riyadh with a continued and expanding 30,000 m² and a dedicated fulfillment center in Jeddah. Delivery commitment of 1 to 3 days across Riyadh, 3 to 5 days across the Kingdom, and 5 to 10 days internationally. Our network is not just a distribution asset. It is a service and learning platform.';

  String get invest3Title => isArabic ? 'الالتزام بخدمة ما بعد البيع' : 'Post-Purchase Commitment';
  String get invest3Desc  => isArabic
      ? 'استثمرنا بوعي في منظومة خدمة ما بعد البيع: ضمانات متعددة السنوات على منتجاتنا الكهربائية، ومعالجة مركزية لطلبات الخدمة، وتحسين متواصل في توافر قطع الغيار عبر جميع القنوات. هذا الالتزام يحوّل صفقة البيع إلى علاقة تمتد. وفي سوق التجزئة السعودي، جودة الخدمة بعد البيع هي غالباً العامل الحاسم في قرار العميل بالعودة.'
      : 'We have invested deliberately in after-sales infrastructure. Multi-year warranty on all our own-brand electrical products, centralized service processing, and improving availability of spare parts across channels. This commitment presents a competitive moat, a durable relationship. In Saudi retail, the quality of service after the sale is often the deciding factor in whether a customer returns.';

  String get invest4Title => isArabic ? 'التكامل بين القنوات الرقمية والمادية' : 'Omni-Channel Integration';
  String get invest4Desc  => isArabic
      ? 'قنواتنا الرقمية ليست نشاطاً موازياً، بل امتداد حقيقي لصالات عرضنا. في عام 2025، بلغت مبيعات التجارة الإلكترونية 94 مليون ريال، أي 12.4% من إجمالي الإيرادات، بنمو 37% مقارنة بالعام السابق. خدمة الاستلام من المعرض، والإرجاع داخل الفروع، والمعالجة الموحّدة للضمانات، وخيارات الدفع المتعددة بما فيها التقسيط والدفع الذكي، تربط المعرض بالشاشة في رحلة عميل واحدة متسقة.'
      : 'Our digital channels are not a parallel business. They are an integrated extension of our showrooms. In H1FY25, digital sales rose 9.0% year-on-year (YoY), representing 12.2% of total revenue and growing. 47% year-on-year. Click and collect, in-store returns, unified warranty processing, and multiple payment options including installment and smart device payment collection. The showroom is not the endpoint. It is a single customer journey.';


  // ── Footer Section ───────────────────────────────────────────────────────
  String get footerCtaTitle    => isArabic ? 'تبحث عن تسوّق من أكثر من 15,000 منتج؟' : 'Looking to shop our full range of 15,000+ products?';
  String get footerCtaSubtitle => isArabic
      ? 'زُر متجر السيف غاليري الإلكتروني للتوصيل السريع في المملكة ودول الخليج.'
      : 'Visit the Al Saif Gallery online store for fast delivery across the Kingdom and the GCC.';
  String get footerCtaButton   => isArabic ? 'تسوق الآن' : 'Visit the Online Store';

  String get footerEstablished  => isArabic ? 'تأسست عام 1993' : 'Established in 1989';
  String get footerCompany      => isArabic ? 'الشركة'          : 'Company';
  String get footerAboutUs      => isArabic ? 'من نحن'          : 'About Us';
  String get footerStrategy     => isArabic ? 'الاستراتيجية'    : 'Strategy';
  String get footerCareers      => isArabic ? 'الوظائف'         : 'Careers';
  String get footerInvestors    => isArabic ? 'المستثمرون'      : 'Investors';
  String get footerAnnualReports => isArabic ? 'التقارير السنوية' : 'Annual Reports';
  String get footerGovernance   => isArabic ? 'الحوكمة'         : 'Governance';
  String get footerReports      => isArabic ? 'التقارير'        : 'Reports & Filings';
  String get footerContact      => isArabic ? 'تواصل معنا'      : 'Contact';
  String get footerIR           => isArabic ? 'علاقات المستثمرين' : 'Investor Relations';
  String get footerCopyright    => isArabic
      ? '© 2025 معرض السيف للأجهزة المنزلية. جميع الحقوق محفوظة.'
      : '© 2025 Al Saif Gallery. All rights reserved.';
  String get footerPrivacy      => isArabic ? 'سياسة الخصوصية'  : 'Privacy Policy';
  String get footerTerms        => isArabic ? 'الشروط والأحكام'  : 'Terms of Service';
  String get footerCorporateGov => isArabic ? 'حوكمة الشركات'   : 'Corporate Governance';

  // ── About Hero Section ──────────────────────────────────────────────────
  String get aboutHeroTitle => isArabic
      ? 'من نحن — السيف غاليري'
      : 'About Al Saif Gallery';
  String get aboutHeroSubtitle => isArabic
      ? 'ثلاثة عقود والأسر السعودية تختارنا. وهذه الثقة هي أثمن ما نحرص على صونه.'
      : 'Thirty years of household trust. One purpose: quality that earns loyalty.';

  // ── IG Hero Section ──────────────────────────────────────────────────────
  String get igHeroTitle    => isArabic ? 'المستثمرون والحوكمة' : 'Investors & Governance';
  String get igHeroSubtitle => isArabic
      ? 'إفصاح شفاف. رقابة فعّالة. وقيمة مستدامة لجميع المساهمين.'
      : 'Transparency, accountability, and long-term value creation';

  // ── IG Intro Section ─────────────────────────────────────────────────────
  String get igIntroDesc1 => isArabic
      ? 'تلتزم السيف غاليري بأعلى معايير الإفصاح والتواصل مع المستثمرين الذين وضعوا ثقتهم في الشركة. يتيح هذا القسم وصولاً كاملاً إلى نتائجنا المالية وهيكل الحوكمة والإفصاحات التنظيمية وخدمات المساهمين والسياسات المؤسسية، باللغتين العربية والإنجليزية، انسجاماً مع التزاماتنا بوصفنا شركة مدرجة في السوق المالية السعودية.'
      : 'Al Saif Gallery is a Saudi joint stock company listed on the Saudi Exchange (Tadawul) under ticker 4192. Founded in 1993, the company operates in the specialized retail sector for household essentials, with an extensive network of showrooms across Saudi Arabia and the GCC.';
  String get igIntroDesc2 => isArabic
      ? 'ندرك أن الثقة بين الشركة المدرجة ومساهميها تُبنى بالاتساق والوضوح والمساءلة، لا بالوعود. هدفنا أن تكون كل المعلومات التي يحتاجها المستثمر متاحة بوضوح وسهولة، ومطابقة تمامًا لمتطلبات هيئة السوق المالية.'
      : 'The company is committed to the highest standards of good governance and transparency in dealing with all stakeholders. We seek to achieve sustainable returns for our shareholders through a clear growth strategy based on network expansion, proprietary brand development, and enhancing digital capabilities.';

  // ── IG Investment Case Section ───────────────────────────────────────────
  String get igInvestTitle    => isArabic ? 'مقومات الاستثمار' : 'Investment Case';
  String get igInvestSubtitle => isArabic
      ? 'مبررات الاستثمار في السيف غاليري'
      : 'Six reasons that make Al Saif Gallery a distinctive investment opportunity in the Saudi retail sector';

  String get igInvest1Title => isArabic ? 'موقع ريادي في قطاع متخصص' : 'Specialized Market Leadership';
  String get igInvest1Desc  => isArabic
      ? 'نحتل مكانة متقدمة في أدوات المطبخ وأدوات التقديم والأجهزة المنزلية الصغيرة المتخصصة في المملكة العربية السعودية، مدعومين بشبكة توزيع وطنية وقدرة كاملة على التحكم في مواصفات المنتجات. هذا القطاع ليس من قطاعات التجزئة ذات المنافسة الواسعة؛ بل قطاع متخصص محدد المعالم تُشكّل فيه خبرتنا المتخصصة على مدى ثلاثة عقود وبنيتنا في العلامات الخاصة وعمق خدمتنا حواجز دخول يصعب تجاوزها.'
      : 'Al Saif Gallery is the leader in the specialized retail sector for household essentials in Saudi Arabia, with an established market share and a trusted brand among Saudi families for more than three decades.';

  String get igInvest2Title => isArabic ? 'جودة الأرباح مصدرها العمليات' : 'Proprietary Brand Portfolio';
  String get igInvest2Desc  => isArabic
      ? 'حقّقت السيف غاليري صافي ربح قدره 58 مليون ريال في عام 2025 بنمو 54.6% على أساس سنوي، مدفوعاً كلياً بتحسينات تشغيلية. لم يعتمد هذا الانتعاش على مبيعات أصول أو بنود استثنائية. وتعكس إيرادات بلغت 758.8 مليون ريال وهامش مجمل ربح بنسبة 23.5% وتدفق نقدي تشغيلي بقيمة 78.7 مليون ريال؛ القوة الربحية الكامنة للنموذج التشغيلي للشركة. وأنهت الشركة عام 2025 بصافي نقد 25.9 مليون ريال بعد السداد الكامل لجميع التزامات الدين قصير الأجل.'
      : 'The company owns a diverse portfolio of proprietary brands including Edison, Tornado, Robust, Rocky, Everest, and Elegance, providing higher profit margins and strong competitive differentiation.';

  String get igInvest3Title => isArabic ? 'ميزة هوامش العلامات التجارية الخاصة' : 'Integrated Distribution Network';
  String get igInvest3Desc  => isArabic
      ? 'تأتي نحو 88% من الإيرادات من علامات تجارية نملكها أو نمتلك توزيعها الحصري. ويُتيح التوريد المباشر من شركاء التصنيع هوامش ربح على المنتجات الخاصة تتفوق هيكلياً على نموذج البيع بالجملة والتجزئة التقليدي. كما يرفع التوسع المستمر لعلامة إيدسون نحو الأجهزة الكبيرة من فرص الإيرادات ويُحسّن مزيج الهوامش معاً.'
      : 'A growing network of showrooms in Saudi Arabia and GCC countries, covering major cities and serving millions of customers annually.';

  String get igInvest4Title => isArabic ? 'رؤية 2030 رافعة نمو هيكلية' : 'E-Commerce Growth';
  String get igInvest4Desc  => isArabic
      ? 'تُولّد طفرة الإسكان في المملكة العربية السعودية، ارتفاع نسبة تملّك المسكن من 47% عام 2016 إلى 65.4% عام 2024 مع أكثر من 660,000 وحدة سكنية قيد التطوير وبرنامج سكني دعم أكثر من 122,000 أسرة عام 2024، طلباً متيناً ومستداماً على مستلزمات المنزل. كل منزل سعودي جديد يحتاج إلى تجهيز مطبخ متكامل. وتتموضع السيف غاليري بوصفها الوجهة المتخصصة لتلك اللحظة.'
      : 'Strong growth in the e-commerce channel at 37% annually, with continuous investments in developing the digital platform and improving the online customer experience.';

  String get igInvest5Title => isArabic ? 'تسارع التجارة الإلكترونية مع الرافعة التشغيلية' : 'Strong Financial Performance';
  String get igInvest5Desc  => isArabic
      ? 'نمت التجارة الإلكترونية 37% في 2025 مُسهِمةً بـ 94 مليون ريال، أي 12.4% من الإيرادات، عبر تطبيق يتجاوز عدد تنزيلاته 500,000. وتعمل القناة الرقمية بالاعتماد على البنية اللوجستية المشتركة وخدمة ما بعد البيع مع الشبكة المادية، مما يُنشئ رافعة تشغيلية حقيقية مع نمو الإيرادات الرقمية ضمن شبكة الفروع والبنية التشغيلية القائمة.'
      : 'Revenue of SAR 758.8M and net profit of SAR 58M with 54.6% year-on-year growth, reflecting the robustness of the operational model and its ability to achieve sustainable growth.';

  String get igInvest6Title => isArabic ? 'قيادة محترفة في لحظة محورية' : 'Sound Governance & Transparency';
  String get igInvest6Desc  => isArabic
      ? 'تم تعيين أحمد بن صالح آل سلطان رئيساً تنفيذياً في ديسمبر 2024، وهو أول رئيس تنفيذي محترف من خارج الأسرة المؤسِّسة في تاريخ الشركة، ويمثّل ذلك خطوة نضوج حوكمي مقصودة. إطاره الاستراتيجي ثلاثي المحاور، تجربة العميل وجودة الأرباح والتوسع المدروس، يتجلى بالفعل في نتائج 2025. هذا التحوّل يعكس التزام مجلس الإدارة بمعايير الانضباط التشغيلي والشفافية التي يتطلبها الإدراج في تداول لحماية حقوق مساهمي الأقلية.'
      : 'A firm commitment to the highest standards of good governance, disclosure, and transparency, with a diverse board of directors that ensures the protection of shareholder rights and the achievement of all stakeholders\' interests.';
}


// ── InheritedWidget ──────────────────────────────────────────────────────────
class _LocalizationsScope extends InheritedWidget {
  final AppLocalizations localizations;

  const _LocalizationsScope({
    required this.localizations,
    required super.child,
  });

  @override
  bool updateShouldNotify(_LocalizationsScope old) =>
      localizations.isArabic != old.localizations.isArabic;
}

// ── Provider Widget ──────────────────────────────────────────────────────────
class AppLocalizationsProvider extends StatelessWidget {
  final LocaleProvider provider;
  final Widget child;

  const AppLocalizationsProvider({
    super.key,
    required this.provider,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: provider.textDirection,
      child: _LocalizationsScope(
        localizations: AppLocalizations(isArabic: provider.isArabic),
        child: child,
      ),
    );
  }
}
