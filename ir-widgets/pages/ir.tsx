'use client';
import { useEffect, useRef, useState } from 'react';
import Head from 'next/head';
import Script from 'next/script';

// ── Config ───────────────────────────────────────────────────────────────────
const CLIENT_ID = '5be9c146-613e-4141-a351-1f5e13fc5513';
const THEME_ID  = '81a06c05-1a48-4d1b-8dbd-bcf60a76730f';
const VERSION   = 'v2';

const COLORS = {
  primary:    '#C62030',
  textPrimary:'#101727',
  textSec:    '#495565',
  border:     '#E5E7EB',
  bg:         '#F8FAFB',
  dark:       '#1A1A1A',
};

// Matches Flutter's getHorizontalPadding exactly:
// mobile(<600): 12px | tablet(600-1200): 52px | desktop(1200-1920): width*0.1-8 | large(≥1920): 192px
// We use a CSS variable --hp set via media queries in the <style> block below
const HP = `var(--hp)`;

// Flutter app base URL — يُقرأ من query param `origin` الذي يمرره Flutter عند الـ redirect
function getFlutterUrl(): string {
  if (typeof window === 'undefined') return 'http://localhost:5000';
  const origin = new URLSearchParams(window.location.search).get('origin');
  if (origin) return decodeURIComponent(origin);
  // fallback: نفس الـ origin مع استبدال port 3001 بـ 5000
  return window.location.origin.replace(':3001', ':5000');
}

const NAV_ROUTES = ['/', '/about-us', '/strategy-operations', '/investors-governance', '/news-careers'];

type Lang = 'en' | 'ar';

// ── Translations ─────────────────────────────────────────────────────────────
const T = {
  en: {
    navHome: 'Home', navAbout: 'About Us', navStrategy: 'Strategy & Operations',
    navInvestors: 'Investors & Governance', navNews: 'Newsroom & Careers',
    heroTitle: 'Investors & Governance',
    heroSub: 'Transparent reporting. Effective oversight.\nLong-term value creation for all shareholders.',
    intro1: 'Al Saif Gallery is committed to the highest standards of disclosure and communication for the investors who have placed their trust in our company. This section provides full access to our financial results, governance structure, regulatory filings, shareholder services, and corporate policies.',
    intro2: 'We understand that trust between a listed company and its shareholders is earned through consistency, clarity, and accountability, not promises.',
    investTitle: 'The Al Saif Gallery Investment Case', investSub: 'Investment Highlights',
    inv: [
      { n:'1', t:'A Niche Where We Lead', d:'We hold an advanced market position in kitchen tools, serveware, and specialized small household appliances in Saudi Arabia, supported by national distribution reach and control over product specification. This is not a broadly contested mass-retail category. It is a focused niche where our three decades of category expertise, owned-brand infrastructure, and service depth create barriers that are difficult to replicate.' },
      { n:'2', t:'Earnings Quality Rooted in Operations', d:'In 2025, Al Saif Gallery delivered SAR 58 million in net profit, a 54.6% increase year-on-year, driven entirely by operational improvements. Revenue of SAR 758.8 million, a gross margin of 23.5%, and operating cash flow of SAR 78.7 million reflect the underlying earning power of the platform. The Company ended 2025 with net cash of SAR 25.9 million.' },
      { n:'3', t:'Proprietary Brand Margin Advantage', d:'Approximately 88% of revenue flows through brands we own or exclusively hold. Direct sourcing from manufacturing partners enables gross margins on proprietary products that are structurally superior to the standard wholesale-retail model. The ongoing extension of the Edison brand into large appliances expands both revenue opportunity and margin mix.' },
      { n:'4', t:'Vision 2030 as Structural Tailwind', d:"Saudi Arabia's housing boom, with homeownership rising from 47% in 2016 to 65.4% in 2024, with 660,000+ new units in the pipeline and Sakani supporting 122,000+ families in 2024, creates a durable demand tailwind for household essentials. Every new Saudi home requires a full kitchen outfitting." },
      { n:'5', t:'Digital Acceleration with Operating Leverage', d:'E-commerce grew 37% in 2025, contributing SAR 94 million (12.4% of revenue) through an app with 500,000+ downloads. The digital channel operates with shared logistics and after-sales infrastructure, creating operating leverage as digital revenue grows within the existing physical footprint.' },
      { n:'6', t:'Professional Leadership at a Pivotal Moment', d:"The appointment of CEO Ahmed bin Saleh Al Sultan in December 2024, the first professional, non-family CEO in the Company's history, marks a deliberate governance maturation step. His three-pillar strategic framework (customer experience, earnings quality, measured expansion) is already reflected in the 2025 results." },
    ],
    sections: [
      { id:'company-snapshot',      title:'Company Snapshot',       minH: 320, tabs: null },
      { id:'corporate-news',        title:'Announcements',          minH: 400, tabs: null },
      { id:'fact-sheet',            title:'Fact Sheet',             minH: 500, tabs: [{ label:'Table', id:'fact-sheet-table' }, { label:'Chart', id:'fact-sheet-charts' }] },
      { id:'stock-activity',        title:'Stock Activity',         minH: 500, tabs: [{ label:'Simple', id:'stock-activity-simple' }, { label:'Advanced', id:'stock-activity-advanced' }] },
      { id:'corporate-actions',     title:'Corporate Actions',      minH: 400, tabs: null },
      { id:'company-financials',    title:'Company Financials',     minH: 500, tabs: null },
      { id:'investment-calculator', title:'Investment Calculator',  minH: 400, tabs: null },
      { id:'share-price',           title:'Share Price',            minH: 400, tabs: null },
      { id:'peer-group-analysis',   title:'Peer Group Analysis',    minH: 400, tabs: null },
      { id:'performance',           title:'Performance',            minH: 400, tabs: null },
      { id:'share-series',          title:'Share Series',           minH: 300, tabs: null },
      { id:'email-subscription',    title:'Email Subscription',     minH: 300, tabs: null },
    ],
    footerCta: "Looking to shop our full range of 15,000+ products?",
    footerCtaSub: 'Visit the Al Saif Gallery online store for fast delivery across the Kingdom and the GCC.',
    footerCtaBtn: 'Visit the Online Store',
    established: 'Established in 1993',
    company: 'Company', aboutUs: 'About Us', strategy: 'Strategy', careers: 'Careers',
    investors: 'Investors', annualReports: 'Annual Reports', governance: 'Governance', reports: 'Reports & Filings',
    contact: 'Contact', ir: 'Investor Relations',
    copyright: '© 2025 Al Saif Gallery. All rights reserved.',
    privacy: 'Privacy Policy', terms: 'Terms of Service', corpGov: 'Corporate Governance',
    lang: 'العربية', search: 'Search', docs: 'Documents Library', contactTop: 'Contact',
  },
  ar: {
    navHome: 'الرئيسية', navAbout: 'من نحن', navStrategy: 'الاستراتيجية والعمليات',
    navInvestors: 'المستثمرون والحوكمة', navNews: 'الأخبار والوظائف',
    heroTitle: 'المستثمرون والحوكمة',
    heroSub: 'إفصاح شفاف. رقابة فعّالة. وقيمة مستدامة لجميع المساهمين.',
    intro1: 'تلتزم السيف غاليري بأعلى معايير الإفصاح والتواصل مع المستثمرين الذين وضعوا ثقتهم في الشركة. يتيح هذا القسم وصولاً كاملاً إلى نتائجنا المالية وهيكل الحوكمة والإفصاحات التنظيمية وخدمات المساهمين والسياسات المؤسسية.',
    intro2: 'ندرك أن الثقة بين الشركة المدرجة ومساهميها تُبنى بالاتساق والوضوح والمساءلة، لا بالوعود.',
    investTitle: 'مقومات الاستثمار في السيف غاليري', investSub: 'أبرز مقومات الاستثمار',
    inv: [
      { n:'1', t:'قطاع متخصص نقوده', d:'نحتل مكانة متقدمة في أدوات المطبخ وأدوات التقديم والأجهزة المنزلية الصغيرة المتخصصة في المملكة العربية السعودية، مدعومين بشبكة توزيع وطنية وقدرة كاملة على التحكم في مواصفات المنتجات. هذا ليس قطاع تجزئة واسع المنافسة؛ بل قطاع متخصص محدد المعالم تُشكّل فيه خبرتنا على مدى ثلاثة عقود وبنيتنا في العلامات الخاصة وعمق خدمتنا حواجز دخول يصعب تجاوزها.' },
      { n:'2', t:'جودة الأرباح مصدرها العمليات', d:'حقّقت السيف غاليري صافي ربح قدره 58 مليون ريال في عام 2025 بنمو 54.6% على أساس سنوي، مدفوعاً كلياً بتحسينات تشغيلية. وتعكس إيرادات بلغت 758.8 مليون ريال وهامش مجمل ربح بنسبة 23.5% وتدفق نقدي تشغيلي بقيمة 78.7 مليون ريال القوة الربحية الكامنة للنموذج التشغيلي.' },
      { n:'3', t:'ميزة هوامش العلامات التجارية الخاصة', d:'تأتي نحو 88% من الإيرادات من علامات تجارية نملكها أو نمتلك توزيعها الحصري. ويُتيح التوريد المباشر من شركاء التصنيع هوامش ربح على المنتجات الخاصة تتفوق هيكلياً على نموذج البيع بالجملة والتجزئة التقليدي.' },
      { n:'4', t:'رؤية 2030 رافعة نمو هيكلية', d:'تُولّد طفرة الإسكان في المملكة العربية السعودية، ارتفاع نسبة تملّك المسكن من 47% عام 2016 إلى 65.4% عام 2024 مع أكثر من 660,000 وحدة سكنية قيد التطوير، طلباً متيناً ومستداماً على مستلزمات المنزل. كل منزل سعودي جديد يحتاج إلى تجهيز مطبخ متكامل.' },
      { n:'5', t:'تسارع التجارة الإلكترونية مع الرافعة التشغيلية', d:'نمت التجارة الإلكترونية 37% في 2025 مُسهِمةً بـ 94 مليون ريال، أي 12.4% من الإيرادات، عبر تطبيق يتجاوز عدد تنزيلاته 500,000. وتعمل القناة الرقمية بالاعتماد على البنية اللوجستية المشتركة مما يُنشئ رافعة تشغيلية حقيقية.' },
      { n:'6', t:'قيادة محترفة في لحظة محورية', d:'تم تعيين أحمد بن صالح آل سلطان رئيساً تنفيذياً في ديسمبر 2024، وهو أول رئيس تنفيذي محترف من خارج الأسرة المؤسِّسة في تاريخ الشركة. إطاره الاستراتيجي ثلاثي المحاور يتجلى بالفعل في نتائج 2025.' },
    ],
    sections: [
      { id:'company-snapshot',      title:'نظرة عامة عن الشركة',        minH: 320, tabs: null },
      { id:'corporate-news',        title:'الإعلانات',                   minH: 400, tabs: null },
      { id:'fact-sheet',            title:'نشرة المعلومات',              minH: 500, tabs: [{ label:'جدول', id:'fact-sheet-table' }, { label:'رسم بياني', id:'fact-sheet-charts' }] },
      { id:'stock-activity',        title:'نشاط السهم',                  minH: 500, tabs: [{ label:'بسيط', id:'stock-activity-simple' }, { label:'متقدم', id:'stock-activity-advanced' }] },
      { id:'corporate-actions',     title:'الإجراءات النظامية',          minH: 400, tabs: null },
      { id:'company-financials',    title:'البيانات المالية',            minH: 500, tabs: null },
      { id:'investment-calculator', title:'حاسبة الاستثمار',             minH: 400, tabs: null },
      { id:'share-price',           title:'سعر السهم',                   minH: 400, tabs: null },
      { id:'peer-group-analysis',   title:'تحليل المجموعة المماثلة',     minH: 400, tabs: null },
      { id:'performance',           title:'الأداء',                      minH: 400, tabs: null },
      { id:'share-series',          title:'سلسلة الأسهم',                minH: 300, tabs: null },
      { id:'email-subscription',    title:'الاشتراك بالبريد الإلكتروني', minH: 300, tabs: null },
    ],
    footerCta: 'تبحث عن تسوّق من أكثر من 15,000 منتج؟',
    footerCtaSub: 'زُر متجر السيف غاليري الإلكتروني للتوصيل السريع في المملكة ودول الخليج.',
    footerCtaBtn: 'تسوق الآن',
    established: 'تأسست عام 1993',
    company: 'الشركة', aboutUs: 'من نحن', strategy: 'الاستراتيجية', careers: 'الوظائف',
    investors: 'المستثمرون', annualReports: 'التقارير السنوية', governance: 'الحوكمة', reports: 'التقارير',
    contact: 'تواصل معنا', ir: 'علاقات المستثمرين',
    copyright: '© 2025 معرض السيف للأجهزة المنزلية. جميع الحقوق محفوظة.',
    privacy: 'سياسة الخصوصية', terms: 'الشروط والأحكام', corpGov: 'حوكمة الشركات',
    lang: 'English', search: 'بحث', docs: 'مكتبة الوثائق', contactTop: 'تواصل معنا',
  },
};

// ── Single Widget ─────────────────────────────────────────────────────────────
function IRWidget({ widgetId, lang, minHeight = 300 }: { widgetId: string; lang: Lang; minHeight?: number }) {
  const wrapRef = useRef<HTMLDivElement>(null);
  const innerRef = useRef<HTMLDivElement>(null);
  const [showSkeleton, setShowSkeleton] = useState(true);
  const loaded = useRef(false);

  useEffect(() => {
    const el = innerRef.current;
    if (!el || loaded.current) return;
    const w = window as any;
    if (typeof w.loadWidget !== 'function') {
      // Wait for script to load
      const interval = setInterval(() => {
        if (typeof (window as any).loadWidget === 'function') {
          clearInterval(interval);
          if (!loaded.current) {
            loaded.current = true;
            (window as any).loadWidget(widgetId, CLIENT_ID, lang, THEME_ID, VERSION);
            setTimeout(() => setShowSkeleton(false), 1500);
          }
        }
      }, 200);
      return () => clearInterval(interval);
    }
    loaded.current = true;
    w.loadWidget(widgetId, CLIENT_ID, lang, THEME_ID, VERSION);
    setTimeout(() => setShowSkeleton(false), 1500);
  }, [widgetId, lang]);

  return (
    <div ref={wrapRef} style={{ position: 'relative', minHeight }}>
      {showSkeleton && (
        <div style={{
          position: 'absolute', top: 0, left: 0, right: 0, height: minHeight,
          background: 'linear-gradient(90deg, #f0f0f0 25%, #e8e8e8 50%, #f0f0f0 75%)',
          backgroundSize: '200% 100%',
          animation: 'shimmer 1.4s infinite',
          borderRadius: 6,
          zIndex: 1,
          pointerEvents: 'none',
        }} />
      )}
      <div
        ref={innerRef}
        id={`${widgetId}-widget`}
      />
    </div>
  );
}

// ── Tabbed Widget (e.g. Fact Sheet Table/Chart, Stock Activity Simple/Advanced) ──
type TabDef = { label: string; id: string };

function TabbedWidget({ tabs, lang, minHeight = 400 }: { tabs: TabDef[]; lang: Lang; minHeight?: number }) {
  const [active, setActive] = useState(0);
  return (
    <div>
      {/* Tab buttons */}
      <div style={{ display: 'flex', gap: 8, marginBottom: 16 }}>
        {tabs.map((tab, i) => (
          <button
            key={tab.id}
            onClick={() => setActive(i)}
            style={{
              padding: '8px 24px',
              borderRadius: 6,
              border: `2px solid ${i === active ? COLORS.primary : COLORS.border}`,
              background: i === active ? '#fff' : '#F3F4F6',
              color: i === active ? COLORS.textPrimary : '#9CA3AF',
              fontWeight: i === active ? 600 : 400,
              fontSize: 14,
              cursor: 'pointer',
              transition: 'all 0.15s',
            }}
          >
            {tab.label}
          </button>
        ))}
      </div>
      {/* Only render active widget, keep others mounted but hidden to avoid reload */}
      {tabs.map((tab, i) => (
        <div key={tab.id} style={{ display: i === active ? 'block' : 'none' }}>
          <IRWidget widgetId={tab.id} lang={lang} minHeight={minHeight} />
        </div>
      ))}
    </div>
  );
}

// ── Main Page ─────────────────────────────────────────────────────────────────
export default function IRPage() {
  const [lang, setLang] = useState<Lang>('en');
  const [scriptReady, setScriptReady] = useState(false);
  const [menuOpen, setMenuOpen] = useState(false);
  const [flutterUrl, setFlutterUrl] = useState('http://localhost:5000');
  const isAr = lang === 'ar';
  const t = T[lang];

  // Read lang + origin from URL query on first load
  useEffect(() => {
    const params = new URLSearchParams(window.location.search);
    const urlLang = params.get('lang');
    if (urlLang === 'ar' || urlLang === 'en') setLang(urlLang);
    setFlutterUrl(getFlutterUrl());
  }, []);

  // Listen for lang from Flutter parent (iframe mode fallback)
  useEffect(() => {
    const handler = (e: MessageEvent) => {
      if (e.data?.type === 'set-lang' && (e.data.lang === 'ar' || e.data.lang === 'en')) {
        setLang(e.data.lang);
      }
    };
    window.addEventListener('message', handler);
    return () => window.removeEventListener('message', handler);
  }, []);

  // Report height to Flutter
  useEffect(() => {
    const report = () => {
      window.parent?.postMessage({ type: 'ir-page-height', height: document.body.scrollHeight }, '*');
    };
    const ro = new ResizeObserver(report);
    ro.observe(document.body);
    return () => ro.disconnect();
  }, []);

  const toggleLang = () => setLang(l => l === 'en' ? 'ar' : 'en');

  return (
    <>
      <Head>
        <meta charSet="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>{`${t.navInvestors} — Al Saif Gallery`}</title>
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossOrigin="" />
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
      </Head>

      <Script src="https://irp.atnmo.com/v2/widget/widget-loader.js" strategy="afterInteractive" onReady={() => setScriptReady(true)} />

      <div dir={isAr ? 'rtl' : 'ltr'} style={{ fontFamily: 'Inter, sans-serif', background: '#ffffff', minHeight: '100vh' }}>
        <div style={{ maxWidth: 1880, margin: '0 auto', background: '#F8FAFB', minHeight: '100vh' }}>

        {/* ── Top Bar ── */}
        <div style={{ background: COLORS.bg, borderBottom: `1px solid ${COLORS.border}`, height: 26 }}>
          <div style={{ maxWidth: 1880, margin: '0 auto', padding: `0 ${HP}`, height: '100%', display: 'flex', alignItems: 'center', justifyContent: 'flex-end', gap: 24 }}>
            {['docs','contactTop','search'].map(k => (
              <span key={k} style={{ fontSize: 12, color: COLORS.textSec, cursor: 'pointer', display: 'flex', alignItems: 'center', gap: 4 }}>
                {t[k as keyof typeof t] as string}
              </span>
            ))}
            <span onClick={toggleLang} style={{ fontSize: 12, color: COLORS.textSec, cursor: 'pointer' }}>{t.lang}</span>
          </div>
        </div>

        {/* ── Nav Bar ── */}
        <nav style={{ background: '#fff', borderBottom: `1px solid ${COLORS.border}`, boxShadow: '0 1px 3px rgba(0,0,0,0.08)', height: 70, position: 'sticky', top: 0, zIndex: 100 }}>
          <div style={{ maxWidth: 1880, margin: '0 auto', padding: `0 ${HP}`, height: '100%', display: 'flex', alignItems: 'center', justifyContent: 'space-between', direction: 'ltr' }}>
            {/* LTR: Logo left, nav right | RTL: Logo right, nav left — match Flutter */}
            {!isAr && <img src="/Al_Saif_Logo.svg" alt="Al Saif Gallery" style={{ width: 144, height: 59, objectFit: 'contain' }} />}
            {/* Desktop nav */}
            <div className="desktop-nav" style={{ display: 'flex', gap: 32, alignItems: 'center' }}>
              {(isAr
                ? [t.navNews, t.navInvestors, t.navStrategy, t.navAbout, t.navHome]
                : [t.navHome, t.navAbout, t.navStrategy, t.navInvestors, t.navNews]
              ).map((item, i) => {
                const routeIndex = isAr ? [4,3,2,1,0][i] : i;
                const isActive = routeIndex === 3;
                return (
                  <div key={i} onClick={() => {
                    if (!isActive) {
                      window.location.href = `${flutterUrl}${NAV_ROUTES[routeIndex]}`;
                    }
                  }}
                    style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', cursor: isActive ? 'default' : 'pointer' }}>
                    <span style={{ fontSize: 13, color: isActive ? COLORS.textPrimary : COLORS.textSec, fontWeight: isActive ? 500 : 400 }}>{item}</span>
                    <div style={{ height: 2, width: 40, background: isActive ? COLORS.primary : 'transparent', marginTop: 4 }} />
                  </div>
                );
              })}
            </div>
            {isAr && <img src="/Al_Saif_Logo.svg" alt="Al Saif Gallery" style={{ width: 144, height: 59, objectFit: 'contain' }} />}
            {/* Mobile hamburger */}
            <button className="mobile-menu-btn" onClick={() => setMenuOpen(!menuOpen)}
              style={{ display: 'none', background: 'none', border: 'none', cursor: 'pointer', padding: 8 }}>
              <div style={{ width: 22, height: 2, background: COLORS.textPrimary, marginBottom: 5 }} />
              <div style={{ width: 22, height: 2, background: COLORS.textPrimary, marginBottom: 5 }} />
              <div style={{ width: 22, height: 2, background: COLORS.textPrimary }} />
            </button>
          </div>
          {/* Mobile menu */}
          {menuOpen && (
            <div style={{ background: '#fff', borderTop: `1px solid ${COLORS.border}`, padding: '8px 0' }}>
              {[t.navHome, t.navAbout, t.navStrategy, t.navInvestors, t.navNews].map((item, i) => (
                <div key={i} onClick={() => {
                  setMenuOpen(false);
                  if (i !== 3) window.location.href = `${flutterUrl}${NAV_ROUTES[i]}`;
                }}
                  style={{ padding: '14px 24px', fontSize: 15, color: i === 3 ? COLORS.primary : COLORS.textPrimary,
                    fontWeight: i === 3 ? 600 : 400, borderBottom: `1px solid ${COLORS.bg}`, cursor: 'pointer',
                    textAlign: isAr ? 'right' : 'left' }}>
                  {item}
                </div>
              ))}
            </div>
          )}
        </nav>

        {/* ── Hero ── */}
        <div style={{
          position: 'relative',
          width: '100%',
          aspectRatio: '1600 / 475',
          overflow: 'hidden',
          minHeight: 180,
        }}>
          <img
            src="/ig_hero.jpeg"
            alt=""
            style={{ position: 'absolute', inset: 0, width: '100%', height: '100%', objectFit: 'cover', objectPosition: 'center' }}
          />
          {/* no overlay */}
          <div style={{
            position: 'relative', zIndex: 1,
            height: '100%', display: 'flex', alignItems: 'center',
            padding: `0 ${HP}`,
            justifyContent: isAr ? 'flex-end' : 'flex-start',
          }}>
            <div style={{ maxWidth: 600, textAlign: isAr ? 'right' : 'left' }}>
              <h1 style={{ color: '#fff', fontSize: 'clamp(16px, 2vw, 24px)', fontWeight: 700, margin: 0 }}>{t.heroTitle}</h1>
              <p style={{ color: 'rgba(255,255,255,0.9)', fontSize: 'clamp(11px, 1.2vw, 13px)', marginTop: 10, lineHeight: 1.6, whiteSpace: 'pre-line', textAlign: isAr ? 'right' : 'left' }}>{t.heroSub}</p>
            </div>
          </div>
        </div>

        {/* ── Intro ── */}
        <div style={{ background: '#fff', padding: `60px ${HP}` }}>
          <div style={{ maxWidth: 800, margin: '0 auto', textAlign: isAr ? 'right' : 'justify' }}>
            <p style={{ color: COLORS.textSec, fontSize: 15, lineHeight: 1.8, marginBottom: 16 }}>{t.intro1}</p>
            <p style={{ color: COLORS.textSec, fontSize: 15, lineHeight: 1.8 }}>{t.intro2}</p>
          </div>
        </div>

        {/* ── Investment Case ── */}
        <div style={{ background: COLORS.bg, padding: `40px ${HP}` }}>
          <div style={{ maxWidth: 1880, margin: '0 auto' }}>
            <h2 style={{ textAlign: 'center', fontSize: 28, fontWeight: 700, color: COLORS.textPrimary, margin: 0 }}>{t.investTitle}</h2>
            <p style={{ textAlign: 'center', color: COLORS.textSec, fontSize: 14, marginTop: 6, marginBottom: 30 }}>{t.investSub}</p>
            {/* Row 1 */}
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(280px, 1fr))', gap: 16, marginBottom: 16 }}>
              {t.inv.slice(0,3).map(card => (
                <div key={card.n} style={{ background: '#fff', borderRadius: 8, border: `1px solid ${COLORS.border}`, padding: 16, display: 'flex', flexDirection: 'column' }}>
                  <span style={{ color: COLORS.primary, fontSize: 26, fontWeight: 700, lineHeight: 1, marginBottom: 8, textAlign: isAr ? 'right' : 'left' }}>{card.n}</span>
                  <p style={{ color: COLORS.textPrimary, fontSize: 13, fontWeight: 600, margin: '0 0 6px', textAlign: isAr ? 'right' : 'left' }}>{card.t}</p>
                  <p style={{ color: COLORS.textSec, fontSize: 11, lineHeight: 1.6, margin: 0, textAlign: isAr ? 'right' : 'left' }}>{card.d}</p>
                </div>
              ))}
            </div>
            {/* Row 2 */}
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(280px, 1fr))', gap: 16 }}>
              {t.inv.slice(3,6).map(card => (
                <div key={card.n} style={{ background: '#fff', borderRadius: 8, border: `1px solid ${COLORS.border}`, padding: 16, display: 'flex', flexDirection: 'column' }}>
                  <span style={{ color: COLORS.primary, fontSize: 26, fontWeight: 700, lineHeight: 1, marginBottom: 8, textAlign: isAr ? 'right' : 'left' }}>{card.n}</span>
                  <p style={{ color: COLORS.textPrimary, fontSize: 13, fontWeight: 600, margin: '0 0 6px', textAlign: isAr ? 'right' : 'left' }}>{card.t}</p>
                  <p style={{ color: COLORS.textSec, fontSize: 11, lineHeight: 1.6, margin: 0, textAlign: isAr ? 'right' : 'left' }}>{card.d}</p>
                </div>
              ))}
            </div>
          </div>
        </div>

        {/* ── Stock Ticker ── */}
        {scriptReady && (
          <div style={{ background: '#fff', padding: `0 ${HP}` }}>
            <div style={{ maxWidth: 1880, margin: '0 auto' }}>
              <div style={{
                borderTop: `2px solid ${COLORS.primary}`,
                borderBottom: `2px solid ${COLORS.primary}`,
                overflow: 'hidden',
                display: 'flex',
                alignItems: 'center',
                minHeight: 52,
              }}>
                <IRWidget key={`stock-ticker-${lang}`} widgetId="stock-ticker" lang={lang} />
              </div>
            </div>
          </div>
        )}

        {/* ── Widgets ── */}
        <div style={{ background: '#fff', padding: `0 ${HP} 60px` }}>
          <div style={{ maxWidth: 1880, margin: '0 auto' }}>
            {scriptReady && t.sections.map(s => (
              <div key={`${s.id}-${lang}`} style={{ paddingTop: 48, borderTop: `1px solid ${COLORS.border}`, marginTop: 48 }}
                className="widget-section">
                <h2 style={{ fontSize: 20, fontWeight: 600, color: COLORS.textPrimary, marginBottom: 16,
                  textAlign: isAr ? 'right' : 'left' }}>{s.title}</h2>
                <div style={{ overflowX: 'auto', WebkitOverflowScrolling: 'touch' as any }}>
                  <div style={{ minWidth: 600 }}>
                  {s.tabs
                    ? <TabbedWidget key={`${s.id}-${lang}`} tabs={s.tabs} lang={lang} minHeight={s.minH} />
                    : <IRWidget widgetId={s.id} lang={lang} minHeight={s.minH} />
                  }
                  </div>
                </div>
              </div>
            ))}
          </div>
        </div>

        </div>

        {/* ── Footer CTA ── */}
        <div style={{ background: COLORS.primary, padding: `28px ${HP}`, textAlign: 'center' }}>
          <p style={{ color: '#fff', fontSize: 14, margin: 0 }}>{t.footerCta}</p>
          <p style={{ color: 'rgba(255,255,255,0.8)', fontSize: 11, margin: '4px 0 14px' }}>{t.footerCtaSub}</p>
          <a href="https://alsaifgallery.com/" target="_blank" rel="noreferrer"
            style={{ background: '#fff', color: COLORS.primary, padding: '9px 24px', borderRadius: 3,
              fontSize: 12, fontWeight: 500, textDecoration: 'none', display: 'inline-block' }}>
            {t.footerCtaBtn}
          </a>
        </div>

        {/* ── Footer ── */}
        <div style={{ background: COLORS.dark, padding: `28px ${HP}` }}>
          <div style={{ maxWidth: 1880, margin: '0 auto' }}>
            <div className="footer-grid" style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(160px, 1fr))', gap: 24, marginBottom: 28 }}>
              <div>
                <p style={{ color: '#fff', fontSize: 14, fontWeight: 600, margin: '0 0 8px' }}>Al Saif Gallery</p>
                <p style={{ color: '#9CA3AF', fontSize: 11, margin: '0 0 2px' }}>{t.established}</p>
                <p style={{ color: '#9CA3AF', fontSize: 11, margin: 0 }}>Tadawul: 4192</p>
              </div>
              <div>
                <p style={{ color: '#fff', fontSize: 12, fontWeight: 500, margin: '0 0 10px' }}>{t.company}</p>
                {[t.aboutUs, t.strategy, t.careers].map(i => <p key={i} style={{ color: '#9CA3AF', fontSize: 11, margin: '0 0 8px' }}>{i}</p>)}
              </div>
              <div>
                <p style={{ color: '#fff', fontSize: 12, fontWeight: 500, margin: '0 0 10px' }}>{t.investors}</p>
                {[t.annualReports, t.governance, t.reports].map(i => <p key={i} style={{ color: '#9CA3AF', fontSize: 11, margin: '0 0 8px' }}>{i}</p>)}
              </div>
              <div>
                <p style={{ color: '#fff', fontSize: 12, fontWeight: 500, margin: '0 0 10px' }}>{t.contact}</p>
                {[t.ir, 'ir@alsaifgallery.com', '+966 11 406 4444'].map(i => <p key={i} style={{ color: '#9CA3AF', fontSize: 11, margin: '0 0 8px' }}>{i}</p>)}
              </div>
            </div>
            <div style={{ borderTop: '1px solid #374151', paddingTop: 20, display: 'flex', flexWrap: 'wrap', justifyContent: 'space-between', gap: 12 }}>
              <p style={{ color: '#6B7280', fontSize: 12, margin: 0 }}>{t.copyright}</p>
              <div style={{ display: 'flex', gap: 24 }}>
                {[t.privacy, t.terms, t.corpGov].map(i => <p key={i} style={{ color: '#6B7280', fontSize: 12, margin: 0, cursor: 'pointer' }}>{i}</p>)}
              </div>
            </div>
          </div>
        </div>{/* end footer dark */}
      </div>{/* end wrapper maxWidth */}

      {/* ── Responsive CSS ── */}
      <style suppressHydrationWarning>{`
        * { box-sizing: border-box; margin: 0; padding: 0; }
        html, body { background: #ffffff; min-height: 100%; }
        body { overflow-x: hidden; }

        /* Allow text selection everywhere */
        *, *::before, *::after { user-select: text; -webkit-user-select: text; }
        /* Except buttons and interactive controls */
        button, [role="button"] { user-select: none; -webkit-user-select: none; }

        /* Flutter getHorizontalPadding exact match */
        :root { --hp: 12px; }
        @media (min-width: 600px)  { :root { --hp: 52px; } }
        @media (min-width: 1200px) { :root { --hp: calc(100vw * 0.1 - 8px); } }
        @media (min-width: 1920px) { :root { --hp: 192px; } }

        @keyframes shimmer {
          0%   { background-position: 200% 0; }
          100% { background-position: -200% 0; }
        }

        @media (max-width: 768px) {
          .desktop-nav { display: none !important; }
          .mobile-menu-btn { display: block !important; }
        }
        .widget-section:first-of-type {
          border-top: none !important;
          margin-top: 0 !important;
        }

        /* Allow horizontal scroll on widgets that overflow on mobile */
        [id$="-widget"] {
          overflow-x: auto !important;
          -webkit-overflow-scrolling: touch;
        }
        [id$="-widget"] > * {
          min-width: 0;
        }
        /* Match Flutter iframe CSS for widget containers */
        [id$="-widget"] * {
          touch-action: pan-x pan-y;
          -webkit-overflow-scrolling: touch;
        }
        [id$="-widget"] table,
        [id$="-widget"] .chart-container,
        [id$="-widget"] canvas {
          overflow-x: auto !important;
          max-width: 100%;
        }
      `}</style>
    </>
  );
}
