import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Course {
  final String id;
  String title;
  List<String> subtitles;
  String registrationLink;
  String queryLink; // Link for the Query button (e.g. WhatsApp)
  String courseType; // Physical, Online
  String locationDetail; // Platform for Online, Address for Physical
  String description;
  String duration;
  String schedule;
  String price;
  String orderNumber;
  IconData icon;
  bool isVisible;

  Course({
    required this.id,
    required this.title,
    required this.subtitles,
    this.registrationLink = '',
    this.queryLink = 'https://wa.me/923451234567', // Default WhatsApp
    this.courseType = 'Physical',
    this.locationDetail = '',
    this.description = '',
    this.duration = '',
    this.schedule = '',
    this.price = '',
    this.orderNumber = '01',
    required this.icon,
    this.isVisible = true,
  });
}

class GalleryItem {
  final String id;
  String imageUrl;
  bool isVisible;

  GalleryItem({
    required this.id,
    required this.imageUrl,
    this.isVisible = true,
  });
}

class DonationOption {
  final String id;
  String title;
  String price;
  String description;
  IconData icon;
  bool isPopular;

  DonationOption({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.icon,
    this.isPopular = false,
  });
}

class BankDetails {
  String accountName;
  String accountNo;
  String bankName;
  String branchCode;

  BankDetails({
    required this.accountName,
    required this.accountNo,
    required this.bankName,
    required this.branchCode,
  });
}

void main() {
  runApp(const HunarmandKashmirApp());
}

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const Responsive({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 1000;
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1200 &&
      MediaQuery.of(context).size.width >= 1000;
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1200;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    if (width >= 1200) {
      return desktop;
    } else if (width >= 1000 && tablet != null) {
      return tablet!;
    } else {
      return mobile;
    }
  }
}

class HunarmandKashmirApp extends StatefulWidget {
  const HunarmandKashmirApp({super.key});

  @override
  State<HunarmandKashmirApp> createState() => _HunarmandKashmirAppState();
}

class _HunarmandKashmirAppState extends State<HunarmandKashmirApp> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentPageIndex =
      0; // 0: Home, 1: About, 2: Courses, 3: Gallery, 4: Contact, 5: Donate, 6: Admin
  bool _isAdminLoggedIn = false;

  final List<Course> _courses = [
    Course(
      id: '1',
      title: 'AI Master',
      subtitles: ['Practical AI skills for real income.'],
      icon: Icons.smart_toy,
      courseType: 'Online',
      locationDetail: 'Zoom / Google Meet',
      registrationLink: 'https://forms.gle/example1',
      queryLink: 'https://wa.me/923451234567',
      description:
          'I know you feel basic regarding your productivity, starts with learning online.',
      duration: '3 Months | 12 Weeks',
      schedule: '4 Days a Week (Mon-Thu)',
      price: 'Rs. 12,000',
      orderNumber: '01',
    ),
    Course(
      id: '2',
      title: 'Graphic Design',
      subtitles: ['Professional design skills.'],
      icon: Icons.brush,
      courseType: 'Physical',
      locationDetail: 'SCO Software Tech Park, Mirpur',
      registrationLink: 'https://forms.gle/example2',
      queryLink: 'https://wa.me/923451234567',
      description:
          'Learn complete graphic design have best for the family and globally.',
      duration: '3 Months | 12 Weeks',
      schedule: '4 Days a Week (Mon-Thu)',
      price: 'Rs. 12,000',
      orderNumber: '02',
    ),
    Course(
      id: '3',
      title: 'E-commerce',
      subtitles: ['Build and scale online stores.'],
      icon: Icons.shopping_bag,
      courseType: 'Physical',
      locationDetail: 'SCO Software Tech Park, Mirpur',
      registrationLink: 'https://forms.gle/example3',
      queryLink: 'https://wa.me/923451234567',
      description:
          'Learn tools techniques for stores using Shopify and dropshipping models.',
      duration: '2 Months | 8 Weeks',
      schedule: '4 Days a Week (Mon-Thu)',
      price: 'Rs. 10,000',
      orderNumber: '03',
    ),
    Course(
      id: '4',
      title: 'Freelancing',
      subtitles: ['Work with global clients.'],
      icon: Icons.language,
      courseType: 'Online',
      locationDetail: 'Discord / Live Sessions',
      description:
          'Master the art of freelancing and work with international clients.',
      duration: '2 Months | 8 Weeks',
      schedule: 'Weekends (Sat-Sun)',
      price: 'Rs. 8,000',
      orderNumber: '04',
    ),
  ];

  final List<GalleryItem> _galleryItems = [
    GalleryItem(
      id: '1',
      imageUrl:
          'https://images.unsplash.com/photo-1522202176988-66273c2fd55f?w=800&q=80',
    ),
    GalleryItem(
      id: '2',
      imageUrl:
          'https://images.unsplash.com/photo-1517245386807-bb43f82c33c4?w=800&q=80',
    ),
    GalleryItem(
      id: '3',
      imageUrl:
          'https://images.unsplash.com/photo-1523240795612-9a054b0db644?w=800&q=80',
    ),
  ];

  final List<DonationOption> _donationOptions = [
    DonationOption(
      id: '1',
      title: 'Learning Kit',
      price: 'Rs. 2,000',
      description:
          'Provide a student with essential learning materials, internet access for a month, and software subscriptions.',
      icon: Icons.card_giftcard,
    ),
    DonationOption(
      id: '2',
      title: 'Sponsor a Skill',
      price: 'Rs. 5,000',
      description:
          'Cover the cost of a complete short-term module (e.g., Graphic Design Basics) for one deserving student.',
      icon: Icons.menu_book,
      isPopular: true,
    ),
    DonationOption(
      id: '3',
      title: 'Full Scholarship',
      price: 'Rs. 15,000',
      description:
          'Sponsor a student\'s entire journey from beginner to job-ready professional, including mentorship.',
      icon: Icons.group,
    ),
  ];

  final BankDetails _bankDetails = BankDetails(
    accountName: 'Hunarmand Kashmir Trust',
    accountNo: '1234 5678 9012',
    bankName: 'Bank of AJK, Mirpur',
    branchCode: '0123',
  );

  void _navigateTo(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hunarmand Kashmir',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF004D26),
          primary: const Color(0xFF004D26),
          secondary: const Color(0xFFF2A900),
        ),
        textTheme: GoogleFonts.interTextTheme(),
      ),
      home: Builder(
        builder: (context) => Scaffold(
          key: _scaffoldKey,
          drawer: _buildDrawer(context),
          body: _buildPage(),
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Container(
        color: kPrimaryGreen,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: kDarkGreen),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo_white.png',
                      height: 60,
                      errorBuilder: (c, e, s) => const Icon(
                        Icons.school,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'HUNARMAND KASHMIR',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _drawerItem(context, 0, 'Home', Icons.home),
            _drawerItem(context, 1, 'About Us', Icons.info),
            _drawerItem(context, 2, 'Courses', Icons.book),
            _drawerItem(context, 3, 'Gallery', Icons.photo_library),
            _drawerItem(context, 4, 'Contact', Icons.contact_mail),
            const Divider(color: Colors.white24),
            _drawerItem(context, 5, 'Donate', Icons.favorite, isSpecial: true),
            _drawerItem(context, 6, 'Admin', Icons.admin_panel_settings),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(
    BuildContext context,
    int index,
    String title,
    IconData icon, {
    bool isSpecial = false,
  }) {
    bool active = _currentPageIndex == index;
    return ListTile(
      leading: Icon(
        icon,
        color: isSpecial
            ? kAccentOrange
            : (active ? kAccentOrange : Colors.white),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSpecial
              ? kAccentOrange
              : (active ? kAccentOrange : Colors.white),
          fontWeight: active ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: () {
        _navigateTo(index);
        Navigator.pop(context);
      },
    );
  }

  Widget _buildPage() {
    switch (_currentPageIndex) {
      case 1:
        return AboutPage(onNavigate: _navigateTo);
      case 2:
        return CoursesPage(onNavigate: _navigateTo, courses: _courses);
      case 3:
        return GalleryPage(
          onNavigate: _navigateTo,
          galleryItems: _galleryItems,
        );
      case 4:
        return ContactPage(onNavigate: _navigateTo);
      case 5:
        return DonatePage(
          onNavigate: _navigateTo,
          donationOptions: _donationOptions,
          bankDetails: _bankDetails,
        );
      case 6:
        return AdminPanel(
          onNavigate: _navigateTo,
          courses: _courses,
          galleryItems: _galleryItems,
          donationOptions: _donationOptions,
          bankDetails: _bankDetails,
          isLoggedIn: _isAdminLoggedIn,
          onLogin: (success) => setState(() => _isAdminLoggedIn = success),
          onUpdate: () => setState(() {}),
        );
      default:
        return LandingPage(onNavigate: _navigateTo, courses: _courses);
    }
  }
}

// --- Colors ---
const Color kPrimaryGreen = Color(0xFF004D26);
const Color kDarkGreen = Color(0xFF00331A);
const Color kAccentOrange = Color(0xFFF2A900);
const Color kLightBg = Color(0xFFF9F9F9);

// --- Pages ---

class LandingPage extends StatelessWidget {
  final Function(int) onNavigate;
  final List<Course> courses;
  const LandingPage({
    super.key,
    required this.onNavigate,
    required this.courses,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          HeroSection(onNavigate: onNavigate, activeIndex: 0),
          const WhySection(),
          ProgramsSection(courses: courses, onNavigate: onNavigate),
          JourneySection(onNavigate: onNavigate),
          FooterSection(onNavigate: onNavigate),
        ],
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  final Function(int) onNavigate;
  const AboutPage({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AboutHeroSection(onNavigate: onNavigate),
          const StorySection(),
          const ValuesSection(),
          AboutCTASection(onNavigate: onNavigate),
          FooterSection(onNavigate: onNavigate),
        ],
      ),
    );
  }
}

class CoursesPage extends StatelessWidget {
  final Function(int) onNavigate;
  final List<Course> courses;
  const CoursesPage({
    super.key,
    required this.onNavigate,
    required this.courses,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CoursesHeroSection(onNavigate: onNavigate),
          CoursesFeesSection(courses: courses), // Dynamic grid moved into here
          const DiscountsSection(),
          const OrphanSupportBanner(),
          ReadyToStartSection(onNavigate: onNavigate),
          FooterSection(onNavigate: onNavigate),
        ],
      ),
    );
  }
}

class GalleryPage extends StatelessWidget {
  final Function(int) onNavigate;
  final List<GalleryItem> galleryItems;
  const GalleryPage({
    super.key,
    required this.onNavigate,
    required this.galleryItems,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          GalleryHeroSection(onNavigate: onNavigate),
          GalleryGridSection(galleryItems: galleryItems),
          FooterSection(onNavigate: onNavigate),
        ],
      ),
    );
  }
}

class ContactPage extends StatelessWidget {
  final Function(int) onNavigate;
  const ContactPage({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ContactHeroSection(onNavigate: onNavigate),
          const ContactContentSection(),
          FooterSection(onNavigate: onNavigate),
        ],
      ),
    );
  }
}

class DonatePage extends StatelessWidget {
  final Function(int) onNavigate;
  final List<DonationOption> donationOptions;
  final BankDetails bankDetails;
  const DonatePage({
    super.key,
    required this.onNavigate,
    required this.donationOptions,
    required this.bankDetails,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          DonateHeroSection(onNavigate: onNavigate),
          const PillarsSection(),
          const TransparencySection(),
          WaysToContributeSection(donationOptions: donationOptions),
          BankTransferSection(bankDetails: bankDetails),
          FooterSection(onNavigate: onNavigate),
        ],
      ),
    );
  }
}

// --- Shared Components ---

class TopNavBar extends StatelessWidget {
  final Function(int) onNavigate;
  final int activeIndex;
  const TopNavBar({super.key, required this.onNavigate, this.activeIndex = 0});

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return Row(
      children: [
        if (isMobile)
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        GestureDetector(
          onTap: () => onNavigate(0),
          child: Row(
            children: [
              Image.asset(
                'assets/images/logo_white.png',
                height: isMobile ? 30 : 40,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
        const Spacer(),
        if (!isMobile) ...[
          _navLink('Home', index: 0),
          _navLink('About Us', index: 1),
          _navLink('Courses', index: 2),
          _navLink('Gallery', index: 3),
          _navLink('Contact', index: 4),
          const SizedBox(width: 20),
          GestureDetector(
            onTap: () => onNavigate(5),
            child: _navButton(
              'Donate',
              Icons.favorite,
              activeIndex == 5 ? kAccentOrange : Colors.transparent,
              Colors.white,
              true,
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () => onNavigate(2),
            child: _navButton(
              'Apply Now',
              null,
              Colors.white,
              kPrimaryGreen,
              false,
            ),
          ),
        ] else ...[
          GestureDetector(
            onTap: () => onNavigate(5),
            child: _navButton(
              'Donate',
              Icons.favorite,
              kAccentOrange,
              Colors.white,
              false,
            ),
          ),
        ],
      ],
    );
  }

  Widget _navLink(String title, {int? index}) {
    bool active = index != null && activeIndex == index;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: InkWell(
        onTap: index != null ? () => onNavigate(index) : null,
        child: Text(
          title,
          style: TextStyle(
            color: active ? kAccentOrange : Colors.white,
            fontWeight: active ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _navButton(
    String title,
    IconData? icon,
    Color bgColor,
    Color textColor,
    bool outline,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        border: outline
            ? Border.all(color: Colors.white.withValues(alpha: 0.5))
            : null,
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              color: bgColor == kAccentOrange ? Colors.white : kAccentOrange,
              size: 16,
            ),
            const SizedBox(width: 8),
          ],
          Text(
            title,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

// --- Home Sections ---

class HeroSection extends StatelessWidget {
  final Function(int) onNavigate;
  final int activeIndex;
  const HeroSection({
    super.key,
    required this.onNavigate,
    required this.activeIndex,
  });

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return Stack(
      children: [
        ClipPath(
          clipper: HeroClipper(),
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF013A1C), Color(0xFF004D26)],
              ),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20 : 80,
              vertical: 40,
            ),
            child: Column(
              children: [
                TopNavBar(onNavigate: onNavigate, activeIndex: activeIndex),
                SizedBox(height: isMobile ? 30 : 60),
                Image.asset(
                  'assets/images/logo_white.png',
                  height: isMobile ? 80 : 120,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 20),
                Text(
                  'Rooted in Kashmir. Ready for the World.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.merriweather(
                    color: Colors.white,
                    fontSize: isMobile ? 28 : 48,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Empowering the youth of the Valley with cutting-edge digital skills.\nTurning talent into livelihood, and dreams into reality.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: isMobile ? 14 : 18,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 40),
                Flex(
                  direction: isMobile ? Axis.vertical : Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildButton(
                      'Explore Our Courses →',
                      kAccentOrange,
                      Colors.white,
                      () => onNavigate(2),
                    ),
                    SizedBox(
                      width: isMobile ? 0 : 20,
                      height: isMobile ? 15 : 0,
                    ),
                    _buildOutlineButton(
                      'Our Mission',
                      Colors.white,
                      () => onNavigate(1),
                    ),
                  ],
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButton(
    String text,
    Color bgColor,
    Color textColor,
    VoidCallback onTap,
  ) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: textColor,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 0,
      ),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  Widget _buildOutlineButton(String text, Color color, VoidCallback onTap) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        foregroundColor: color,
        side: BorderSide(color: color.withValues(alpha: 0.5)),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}

class WhySection extends StatelessWidget {
  const WhySection({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 40 : 80,
        horizontal: isMobile ? 20 : 40,
      ),
      child: Column(
        children: [
          Image.asset(
            'assets/images/logo_colored.png',
            height: isMobile ? 60 : 80,
            errorBuilder: (c, e, s) =>
                const Icon(Icons.school, size: 50, color: kPrimaryGreen),
          ),
          const SizedBox(height: 30),
          Text(
            'Why Hunarmand Kashmir?',
            textAlign: TextAlign.center,
            style: GoogleFonts.merriweather(
              color: kPrimaryGreen,
              fontSize: isMobile ? 28 : 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Container(width: 60, height: 3, color: kAccentOrange),
          const SizedBox(height: 30),
          Text(
            'We believe in "Skills over Degrees". In a rapidly changing world, we provide the\npractical, hands-on training that the industry demands, right here in Mirpur.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: Colors.black54,
              fontSize: isMobile ? 14 : 16,
              height: 1.5,
            ),
          ),
          SizedBox(height: isMobile ? 40 : 60),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [
              _buildFeatureCard(
                Icons.code,
                'Expert Mentorship',
                'Learn from industry professionals\nwho have worked globally.',
                context,
              ),
              _buildFeatureCard(
                Icons.memory,
                'Practical Learning',
                'No boring theory. Work on real\nprojects that build your portfolio.',
                context,
              ),
              _buildFeatureCard(
                Icons.trending_up,
                'Career Support',
                'From resume building to freelance\ngigs, we guide your career path.',
                context,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(
    IconData icon,
    String title,
    String desc,
    BuildContext context,
  ) {
    bool isMobile = Responsive.isMobile(context);
    return Container(
      width: isMobile ? double.infinity : 300,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: kPrimaryGreen.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, color: kPrimaryGreen, size: 30),
          ),
          const SizedBox(height: 25),
          Text(
            title,
            style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 15),
          Text(
            desc,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: Colors.black54,
              fontSize: 14,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class ProgramsSection extends StatelessWidget {
  final List<Course> courses;
  final Function(int) onNavigate;
  final bool showHeader;
  const ProgramsSection({
    super.key,
    required this.courses,
    required this.onNavigate,
    this.showHeader = true,
  });

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    final visibleCourses = courses.where((c) => c.isVisible).toList();
    visibleCourses.sort((a, b) => a.orderNumber.compareTo(b.orderNumber));
    return Container(
      width: double.infinity,
      color: kLightBg,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 40 : 80,
        horizontal: isMobile ? 20 : 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (showHeader) ...[
            Text(
              'OUR PROGRAMS',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: kAccentOrange,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 10),
            Flex(
              direction: isMobile ? Axis.vertical : Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: isMobile
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Skills for the Future',
                  textAlign: isMobile ? TextAlign.center : TextAlign.start,
                  style: GoogleFonts.merriweather(
                    color: kPrimaryGreen,
                    fontSize: isMobile ? 28 : 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (isMobile) const SizedBox(height: 10),
                TextButton(
                  onPressed: () => onNavigate(2),
                  child: const Text(
                    'View all courses →',
                    style: TextStyle(
                      color: kPrimaryGreen,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
          Center(
            child: Wrap(
              spacing: 30,
              runSpacing: 30,
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              children: visibleCourses
                  .map((course) => _buildCourseCard(course, context))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseCard(Course course, BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return Container(
      width: isMobile ? double.infinity : 350,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: kPrimaryGreen.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(course.icon, color: kPrimaryGreen, size: 24),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: course.courseType == 'Online'
                      ? Colors.blue.withValues(alpha: 0.1)
                      : Colors.orange.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  course.courseType,
                  style: TextStyle(
                    color: course.courseType == 'Online'
                        ? Colors.blue
                        : Colors.orange,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            course.title,
            style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                course.courseType == 'Online'
                    ? Icons.videocam_outlined
                    : Icons.location_on_outlined,
                size: 14,
                color: Colors.black38,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  course.locationDetail,
                  style: const TextStyle(color: Colors.black38, fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          ...course.subtitles.map(
            (sub) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle_outline,
                    color: Colors.green,
                    size: 14,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      sub,
                      style: GoogleFonts.inter(
                        color: Colors.black54,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          if (course.registrationLink.isNotEmpty)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final url = Uri.parse(course.registrationLink);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryGreen,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Register Now'),
              ),
            ),
        ],
      ),
    );
  }
}

class JourneySection extends StatelessWidget {
  final Function(int) onNavigate;
  const JourneySection({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 60 : 100,
        horizontal: isMobile ? 20 : 40,
      ),
      child: Column(
        children: [
          Text(
            'Your Journey Begins Here',
            textAlign: TextAlign.center,
            style: GoogleFonts.merriweather(
              color: kPrimaryGreen,
              fontSize: isMobile ? 32 : 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Don't let lack of opportunity hold you back. Join Hunarmand Kashmir today and unlock a\nfuture of dignity, independence, and success.",
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: Colors.black54,
              fontSize: isMobile ? 14 : 16,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () => onNavigate(2),
            style: ElevatedButton.styleFrom(
              backgroundColor: kDarkGreen,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 40 : 50,
                vertical: 25,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
            ),
            child: Text(
              'Apply Now',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: isMobile ? 16 : 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- About Sections ---

class AboutHeroSection extends StatelessWidget {
  final Function(int) onNavigate;
  const AboutHeroSection({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return Container(
      width: double.infinity,
      color: kPrimaryGreen,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: 40,
      ),
      child: Column(
        children: [
          TopNavBar(onNavigate: onNavigate, activeIndex: 1),
          SizedBox(height: isMobile ? 60 : 100),
          Text(
            'Our Story',
            textAlign: TextAlign.center,
            style: GoogleFonts.merriweather(
              color: Colors.white,
              fontSize: isMobile ? 40 : 56,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Building a legacy of skill, self-reliance, and pride in the heart of Kashmir.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: isMobile ? 14 : 18,
              height: 1.5,
            ),
          ),
          SizedBox(height: isMobile ? 60 : 100),
        ],
      ),
    );
  }
}

class StorySection extends StatelessWidget {
  const StorySection({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 60 : 100,
        horizontal: isMobile ? 20 : 80,
      ),
      child: Flex(
        direction: isMobile ? Axis.vertical : Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: isMobile ? 0 : 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'From Kashmir to Global Opportunities',
                  style: GoogleFonts.merriweather(
                    color: kPrimaryGreen,
                    fontSize: isMobile ? 32 : 40,
                    fontWeight: FontWeight.bold,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  'Hunarmand Kashmir was born from a simple yet powerful truth: talent is everywhere, but opportunity is not. For far too long, the brilliant minds of Kashmir have faced challenges—geographical isolation, limited infrastructure, and limited exposure to global industries.',
                  style: GoogleFonts.inter(
                    color: Colors.black87,
                    fontSize: isMobile ? 14 : 16,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'We chose to change that.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kPrimaryGreen,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  'We believe digital skills are the great equalizer. With the right training, mentorship, and access, a student from even the most remote areas of Kashmir can work with companies and clients across the world.',
                  style: GoogleFonts.inter(
                    color: Colors.black87,
                    fontSize: isMobile ? 14 : 16,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.all(30),
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(color: kAccentOrange, width: 4),
                    ),
                  ),
                  child: Text(
                    '"At Hunarmand Kashmir, we don’t just teach skills—we open doors, restore confidence, and help build futures rooted in dignity, independence, and global opportunity."',
                    style: GoogleFonts.inter(
                      fontStyle: FontStyle.italic,
                      color: Colors.black54,
                      fontSize: isMobile ? 14 : 16,
                      height: 1.6,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (!isMobile) const SizedBox(width: 80),
          if (isMobile) const SizedBox(height: 40),
          Expanded(
            flex: isMobile ? 0 : 4,
            child: Column(
              children: [
                // Container(
                //   width: double.infinity,
                //   height: 20,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(10),
                //     gradient: const LinearGradient(
                //       colors: [kAccentOrange, Color(0xFFFF7A00)],
                //     ),
                //   ),
                //   child: const Center(
                //     child: Text(
                //       'Our Story',
                //       style: TextStyle(
                //         color: Colors.white,
                //         fontSize: 10,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //   ),
                // ),
                const SizedBox(height: 40),
                Image.network(
                  'https://images.unsplash.com/photo-1522202176988-66273c2fd55f?w=800&q=80',
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ValuesSection extends StatelessWidget {
  const ValuesSection({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: isMobile ? 60 : 100,
      ),
      child: Wrap(
        spacing: 40,
        runSpacing: 40,
        alignment: WrapAlignment.center,
        children: [
          _buildValueCard(
            Icons.ads_click,
            'Our Mission',
            'To bridge the skills gap in Kashmir by delivering world-class digital training...',
            context,
          ),
          _buildValueCard(
            Icons.favorite_border,
            'Our Vision',
            'A self-reliant Kashmir where every young person has the skills to compete globally...',
            context,
          ),
          _buildValueCard(
            Icons.people_outline,
            'Community',
            'We are more than an Institute; we are a family. We support each other...',
            context,
          ),
        ],
      ),
    );
  }

  Widget _buildValueCard(
    IconData icon,
    String title,
    String desc,
    BuildContext context,
  ) {
    bool isMobile = Responsive.isMobile(context);
    return Container(
      width: isMobile ? double.infinity : 350,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: const Border(top: BorderSide(color: kPrimaryGreen, width: 4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: kAccentOrange, size: 36),
          const SizedBox(height: 25),
          Text(
            title,
            style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 20),
          Text(
            desc,
            style: GoogleFonts.inter(
              color: Colors.black54,
              fontSize: 14,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

class AboutCTASection extends StatelessWidget {
  final Function(int) onNavigate;
  const AboutCTASection({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: isMobile ? 60 : 100,
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: isMobile ? 40 : 80,
          horizontal: isMobile ? 20 : 40,
        ),
        decoration: BoxDecoration(
          color: kDarkGreen,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          children: [
            Text(
              'Be Part of the Change',
              textAlign: TextAlign.center,
              style: GoogleFonts.merriweather(
                color: Colors.white,
                fontSize: isMobile ? 28 : 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: isMobile ? double.infinity : null,
              child: ElevatedButton(
                onPressed: () => onNavigate(4),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: kDarkGreen,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Contact Us Today'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Courses Sections ---

class CoursesHeroSection extends StatelessWidget {
  final Function(int) onNavigate;
  const CoursesHeroSection({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return Container(
      width: double.infinity,
      color: kPrimaryGreen,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: 40,
      ),
      child: Column(
        children: [
          TopNavBar(onNavigate: onNavigate, activeIndex: 2),
          SizedBox(height: isMobile ? 60 : 100),
          Text(
            'Start Your Journey',
            textAlign: TextAlign.center,
            style: GoogleFonts.merriweather(
              color: Colors.white,
              fontSize: isMobile ? 40 : 56,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Hunarmand Kashmir provides digital courses designed to help you master modern skills and start earning immediately.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: isMobile ? 14 : 18,
              height: 1.5,
            ),
          ),
          SizedBox(height: isMobile ? 60 : 100),
        ],
      ),
    );
  }
}

class LearningChoiceSection extends StatelessWidget {
  const LearningChoiceSection({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 40 : 80,
        horizontal: isMobile ? 20 : 80,
      ),
      child: Column(
        children: [
          Text(
            'Your Learning, Your Choice',
            textAlign: TextAlign.center,
            style: GoogleFonts.merriweather(
              color: kPrimaryGreen,
              fontSize: isMobile ? 28 : 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Choose the location and schedule that fits your routine.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 50),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [
              _buildChoiceCard(
                'Freelancing Hub (B.I.S.E)',
                'Khaliq Abad Barrier Blvd, Gov Degree College, Mirpur',
                const Color(0xFFFFEBF0),
                const Color(0xFFE91E63),
                Icons.location_on,
                context,
              ),
              _buildChoiceCard(
                'Software Technology Park',
                'SCO Software Technology Park, Kotli Road, Mirpur',
                const Color(0xFFFFF4E5),
                const Color(0xFFFF9800),
                Icons.apartment,
                context,
              ),
              _buildChoiceCard(
                'Online Classes (Live Sessions)',
                'Mastering from the live Zoom / Google Meet',
                const Color(0xFFE3F2FD),
                const Color(0xFF2196F3),
                Icons.videocam,
                context,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChoiceCard(
    String title,
    String location,
    Color bgColor,
    Color accentColor,
    IconData icon,
    BuildContext context,
  ) {
    bool isMobile = Responsive.isMobile(context);
    return Container(
      width: isMobile ? double.infinity : 320,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: accentColor.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: accentColor, size: 24),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            location,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 12,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20),
          _bulletItem(
            Icons.calendar_today,
            '4 Days a Week (Mon-Thu)',
            bgColor,
            accentColor,
          ),
          _bulletItem(Icons.person, 'Our for everyone', bgColor, accentColor),
          _bulletItem(Icons.verified, 'Course Basics', bgColor, accentColor),
        ],
      ),
    );
  }

  Widget _bulletItem(
    IconData icon,
    String text,
    Color bgColor,
    Color accentColor,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: bgColor.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon, color: accentColor, size: 14),
            const SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                color: accentColor,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CoursesFeesSection extends StatelessWidget {
  final List<Course> courses;
  const CoursesFeesSection({super.key, required this.courses});

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    final visibleCourses = courses.where((c) => c.isVisible).toList();
    visibleCourses.sort((a, b) => a.orderNumber.compareTo(b.orderNumber));
    return Container(
      color: kLightBg,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 40 : 80,
        horizontal: isMobile ? 20 : 80,
      ),
      child: Column(
        children: [
          Text(
            'Courses & Fees',
            textAlign: TextAlign.center,
            style: GoogleFonts.merriweather(
              color: kPrimaryGreen,
              fontSize: isMobile ? 28 : 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 60),
          Wrap(
            spacing: 40,
            runSpacing: 40,
            children: visibleCourses
                .map((course) => _buildCourseDetailCard(course, context))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseDetailCard(Course course, BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return Container(
      width: isMobile ? double.infinity : 500,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            child: Text(
              course.orderNumber,
              style: TextStyle(
                color: Colors.black.withValues(alpha: 0.05),
                fontSize: 80,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: kPrimaryGreen.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(course.icon, color: kPrimaryGreen, size: 28),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      course.title,
                      style: GoogleFonts.merriweather(
                        color: kPrimaryGreen,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  _badge(course.courseType),
                  if (course.locationDetail.isNotEmpty) ...[
                    const SizedBox(width: 10),
                    _badge(course.locationDetail),
                  ],
                ],
              ),
              const SizedBox(height: 15),
              Text(
                course.description,
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              if (course.subtitles.isNotEmpty) ...[
                const SizedBox(height: 20),
                ...course.subtitles.map(
                  (sub) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: kPrimaryGreen,
                          size: 16,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            sub,
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 13,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 10),
              Text(
                'Duration: ${course.duration}',
                style: const TextStyle(
                  color: kAccentOrange,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              _priceRow(
                course.schedule,
                course.price,
                const Color(0xFFFFEBF0),
                const Color(0xFFE91E63),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () async {
                        final url = Uri.parse(course.queryLink);
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: kPrimaryGreen,
                        side: const BorderSide(color: kPrimaryGreen),
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.chat_bubble_outline, size: 18),
                          SizedBox(width: 8),
                          Text(
                            'Query',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (course.registrationLink.isNotEmpty) ...[
                    const SizedBox(width: 15),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          final url = Uri.parse(course.registrationLink);
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryGreen,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Register Now',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _badge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.green.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.green,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _priceRow(
    String batch,
    String price,
    Color bgColor,
    Color accentColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: bgColor.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accentColor.withValues(alpha: 0.1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Icon(Icons.calendar_today, color: accentColor, size: 16),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    batch,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: accentColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text(
            price,
            style: TextStyle(
              color: accentColor,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}

class DiscountsSection extends StatelessWidget {
  const DiscountsSection({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 60 : 100,
        horizontal: isMobile ? 20 : 80,
      ),
      child: Column(
        children: [
          Text(
            'Early Bird Discounts',
            textAlign: TextAlign.center,
            style: GoogleFonts.merriweather(
              color: kPrimaryGreen,
              fontSize: isMobile ? 28 : 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Limited seats available — First come, first served.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 50),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [
              _buildDiscountCard(
                'First 10 Students',
                '15% OFF',
                const Color(0xFFE0F7FA),
                const Color(0xFF00ACC1),
                context,
              ),
              _buildDiscountCard(
                'Next 10 Students',
                '10% OFF',
                const Color(0xFFE8F5E9),
                const Color(0xFF43A047),
                context,
              ),
              _buildDiscountCard(
                'Next 10 Students',
                '5% OFF',
                const Color(0xFFE1F5FE),
                const Color(0xFF039BE5),
                context,
              ),
              _buildDiscountCard(
                'Remaining Seats',
                'Full Fee',
                const Color(0xFFF5F5F5),
                Colors.grey,
                context,
              ),
            ],
          ),
          const SizedBox(height: 60),
          Wrap(
            spacing: 20,
            runSpacing: 15,
            alignment: WrapAlignment.center,
            children: [
              _noteBox(
                Icons.info_outline,
                'Only one discount can be applied per student.',
                context,
              ),
              _noteBox(
                Icons.payments_outlined,
                '50% Advance Fee required to confirm your seat booking.',
                context,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDiscountCard(
    String group,
    String discount,
    Color bgColor,
    Color accentColor,
    BuildContext context,
  ) {
    bool isMobile = Responsive.isMobile(context);
    return Container(
      width: isMobile ? double.infinity : 240,
      padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 40,
            spreadRadius: 1,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -45,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 60,
                height: 4,
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: bgColor.withValues(alpha: 0.3),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.local_offer_rounded,
                  color: accentColor,
                  size: 30,
                ),
              ),
              const SizedBox(height: 25),
              Text(
                group,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                discount,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: accentColor,
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _noteBox(IconData icon, String text, BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return Container(
      width: isMobile ? double.infinity : 420,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.orange.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.orange.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.orange, size: 20),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OrphanSupportBanner extends StatelessWidget {
  const OrphanSupportBanner({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 80),
      child: Container(
        padding: EdgeInsets.all(isMobile ? 30 : 60),
        decoration: BoxDecoration(
          color: kPrimaryGreen,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Flex(
          direction: isMobile ? Axis.vertical : Axis.horizontal,
          children: [
            Icon(
              Icons.favorite,
              color: Colors.orange,
              size: isMobile ? 40 : 60,
            ),
            SizedBox(width: isMobile ? 0 : 40, height: isMobile ? 20 : 0),
            Expanded(
              flex: isMobile ? 0 : 1,
              child: Column(
                crossAxisAlignment: isMobile
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    'Support for Orphans',
                    textAlign: isMobile ? TextAlign.center : TextAlign.start,
                    style: GoogleFonts.merriweather(
                      color: Colors.white,
                      fontSize: isMobile ? 24 : 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text.rich(
                    textAlign: isMobile ? TextAlign.center : TextAlign.start,
                    TextSpan(
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: isMobile ? 14 : 18,
                      ),
                      children: [
                        const TextSpan(text: 'We provide a '),
                        TextSpan(
                          text: '100% Fee Waiver',
                          style: TextStyle(
                            color: kAccentOrange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(text: ' for orphan students.'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (!isMobile)
              const Icon(
                Icons.favorite_border,
                color: Colors.white12,
                size: 120,
              ),
          ],
        ),
      ),
    );
  }
}

class ReadyToStartSection extends StatelessWidget {
  final Function(int) onNavigate;
  const ReadyToStartSection({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return Padding(
      padding: EdgeInsets.all(isMobile ? 20 : 80),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: isMobile ? 40 : 80,
          horizontal: isMobile ? 20 : 40,
        ),
        decoration: BoxDecoration(
          color: kDarkGreen,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          children: [
            Text(
              'Ready to Start?',
              textAlign: TextAlign.center,
              style: GoogleFonts.merriweather(
                color: Colors.white,
                fontSize: isMobile ? 32 : 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Secure your spot in the upcoming batch.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 40),
            Flex(
              direction: isMobile ? Axis.vertical : Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: isMobile ? double.infinity : null,
                  child: ElevatedButton(
                    onPressed: () => onNavigate(2),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: kDarkGreen,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text('Apply Online'),
                  ),
                ),
                SizedBox(width: isMobile ? 0 : 20, height: isMobile ? 15 : 0),
                SizedBox(
                  width: isMobile ? double.infinity : null,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text('Chat on WhatsApp'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// --- Gallery Sections ---

class GalleryHeroSection extends StatelessWidget {
  final Function(int) onNavigate;
  const GalleryHeroSection({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return Container(
      width: double.infinity,
      color: kPrimaryGreen,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: 40,
      ),
      child: Column(
        children: [
          TopNavBar(onNavigate: onNavigate, activeIndex: 3),
          SizedBox(height: isMobile ? 60 : 100),
          Text(
            'Moments of Hope',
            textAlign: TextAlign.center,
            style: GoogleFonts.merriweather(
              color: Colors.white,
              fontSize: isMobile ? 40 : 56,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Witness the journey of transformation. From Mirpur to Bhimber, empowering every corner of Kashmir.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: isMobile ? 14 : 18,
              height: 1.5,
            ),
          ),
          SizedBox(height: isMobile ? 60 : 100),
        ],
      ),
    );
  }
}

class GalleryGridSection extends StatelessWidget {
  final List<GalleryItem> galleryItems;
  const GalleryGridSection({super.key, required this.galleryItems});

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    final visibleItems = galleryItems.where((item) => item.isVisible).toList();
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 40 : 80,
        horizontal: isMobile ? 20 : 80,
      ),
      child: Wrap(
        spacing: 30,
        runSpacing: 30,
        alignment: WrapAlignment.center,
        children: visibleItems
            .map((item) => _buildImageCard(item.imageUrl, context))
            .toList(),
      ),
    );
  }

  Widget _buildImageCard(String url, BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return Container(
      width: isMobile ? double.infinity : 400,
      height: isMobile ? 240 : 280,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
    );
  }
}

// --- Contact Sections ---

class ContactHeroSection extends StatelessWidget {
  final Function(int) onNavigate;
  const ContactHeroSection({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return Container(
      width: double.infinity,
      color: kPrimaryGreen,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: 40,
      ),
      child: Column(
        children: [
          TopNavBar(onNavigate: onNavigate, activeIndex: 4),
          SizedBox(height: isMobile ? 60 : 100),
          Text(
            'Get in Touch',
            textAlign: TextAlign.center,
            style: GoogleFonts.merriweather(
              color: Colors.white,
              fontSize: isMobile ? 40 : 56,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Start your journey today. Visit us, call us, or fill out the form below. We are here to help you grow.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: isMobile ? 14 : 18,
              height: 1.5,
            ),
          ),
          SizedBox(height: isMobile ? 60 : 100),
        ],
      ),
    );
  }
}

class ContactContentSection extends StatelessWidget {
  const ContactContentSection({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 40 : 80,
        horizontal: isMobile ? 20 : 80,
      ),
      child: Flex(
        direction: isMobile ? Axis.vertical : Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: isMobile ? 0 : 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Visit Our Campus',
                  style: GoogleFonts.merriweather(
                    color: kPrimaryGreen,
                    fontSize: isMobile ? 28 : 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 25),
                Text(
                  'Our doors are always open for students and parents. Come see our state-of-the-art labs, meet our mentors, and feel the energy of innovation.',
                  style: GoogleFonts.inter(
                    color: Colors.black54,
                    fontSize: isMobile ? 14 : 16,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 40),
                _contactInfo(
                  Icons.location_on,
                  'Address',
                  'SCO Software Technology Park, Mirpur',
                  const Color(0xFFE8F5E9),
                  const Color(0xFF43A047),
                ),
                const SizedBox(height: 20),
                _contactInfo(
                  Icons.phone,
                  'Phone',
                  '0313 884 0571',
                  const Color(0xFFE0F2F1),
                  const Color(0xFF009688),
                ),
                const SizedBox(height: 20),
                _contactInfo(
                  Icons.chat_bubble_outline,
                  'WhatsApp',
                  '0313 884 0571',
                  const Color(0xFFE1F5FE),
                  const Color(0xFF03A9F4),
                ),
                const SizedBox(height: 40),
                Container(
                  height: isMobile ? 250 : 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                      image: NetworkImage(
                        'https://images.unsplash.com/photo-1526778548025-fa2f459cd5c1?w=800&q=80',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (!isMobile) const SizedBox(width: 80),
          if (isMobile) const SizedBox(height: 40),
          Expanded(
            flex: isMobile ? 0 : 1,
            child: Container(
              padding: EdgeInsets.all(isMobile ? 30 : 50),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 30,
                    offset: const Offset(0, 15),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.chat_bubble_outline,
                    size: isMobile ? 60 : 80,
                    color: kAccentOrange,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Quick Response on WhatsApp',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.merriweather(
                      color: kDarkGreen,
                      fontSize: isMobile ? 24 : 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'The fastest way to get in touch with us is via WhatsApp. Our team is online and ready to answer your questions about courses, admissions, and more.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: isMobile ? 14 : 16,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 50),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF25D366),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 0,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.chat, size: 24),
                          SizedBox(width: 15),
                          Text(
                            'Contact via WhatsApp',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Typical response time: < 30 mins',
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _contactInfo(
    IconData icon,
    String label,
    String text,
    Color bgColor,
    Color iconColor,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            Text(
              text,
              style: const TextStyle(color: Colors.black54, fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }
}

// --- Donate Sections ---

class DonateHeroSection extends StatelessWidget {
  final Function(int) onNavigate;
  const DonateHeroSection({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return Container(
      width: double.infinity,
      color: kPrimaryGreen,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: 40,
      ),
      child: Column(
        children: [
          TopNavBar(onNavigate: onNavigate, activeIndex: 5),
          const SizedBox(height: 60),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.favorite, color: kAccentOrange, size: 16),
                SizedBox(width: 8),
                Text(
                  'Support the Mission',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: GoogleFonts.merriweather(
                color: Colors.white,
                fontSize: isMobile ? 32 : 56,
                fontWeight: FontWeight.bold,
                height: 1.1,
              ),
              children: [
                const TextSpan(text: 'Invest in Dignity,\n'),
                TextSpan(
                  text: 'Not Dependency.',
                  style: TextStyle(color: kAccentOrange),
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
          Text(
            'Your contribution doesn\'t just pay a fee, it unlocks a future. Help us empower the youth of Kashmir with the skills they need to stand tall, earn a livelihood, and build a self-reliant community.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: isMobile ? 14 : 18,
              height: 1.5,
            ),
          ),
          SizedBox(height: isMobile ? 60 : 100),
        ],
      ),
    );
  }
}

class PillarsSection extends StatelessWidget {
  const PillarsSection({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 40 : 80,
        horizontal: isMobile ? 20 : 80,
      ),
      child: Wrap(
        spacing: 30,
        runSpacing: 30,
        alignment: WrapAlignment.center,
        children: [
          _pillarCard(
            Icons.menu_book,
            'Sponsor Education',
            'Many talented students in remote villages drop out due to lack of funds. Your donation covers their tuition, software licenses, and learning materials.',
            const Color(0xFFFFF4E5),
            context,
          ),
          _pillarCard(
            Icons.group_add,
            'Empower Mentorship',
            'We bring in industry experts to mentor our students. Your support helps us organize workshops, hackathons, and career counseling sessions.',
            const Color(0xFFE8F5E9),
            context,
          ),
          _pillarCard(
            Icons.shield_outlined,
            'Create Independence',
            'We don\'t give handouts; we give hand-ups. Students you support go on to become freelancers and entrepreneurs who support their families.',
            const Color(0xFFFFF3E0),
            context,
          ),
        ],
      ),
    );
  }

  Widget _pillarCard(
    IconData icon,
    String title,
    String desc,
    Color iconBg,
    BuildContext context,
  ) {
    bool isMobile = Responsive.isMobile(context);
    return Container(
      width: isMobile ? double.infinity : 350,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: iconBg == const Color(0xFFE8F5E9)
                  ? Colors.green
                  : Colors.orange,
              size: 24,
            ),
          ),
          const SizedBox(height: 25),
          Text(
            title,
            style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 15),
          Text(
            desc,
            style: GoogleFonts.inter(
              color: Colors.black54,
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class TransparencySection extends StatelessWidget {
  const TransparencySection({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 40 : 80,
        horizontal: isMobile ? 20 : 80,
      ),
      child: Flex(
        direction: isMobile ? Axis.vertical : Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: isMobile ? 0 : 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Our Promise of Transparency',
                  style: GoogleFonts.merriweather(
                    color: kPrimaryGreen,
                    fontSize: isMobile ? 28 : 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 25),
                Text(
                  'We understand that trust is the foundation of any contribution. At Hunarmand Kashmir, every rupee is accounted for. We operate with a strict policy of ethical allocation.',
                  style: GoogleFonts.inter(
                    color: Colors.black54,
                    fontSize: isMobile ? 14 : 16,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 40),
                _promiseItem(
                  '100% of student scholarship funds go directly to training costs.',
                ),
                _promiseItem('Regular impact reports sent to all donors.'),
                _promiseItem(
                  'Open-door policy: Visit our campus to see your impact in action.',
                ),
                _promiseItem(
                  'Focus on long-term sustainability, not temporary relief.',
                ),
              ],
            ),
          ),
          if (!isMobile) const SizedBox(width: 80),
          if (isMobile) const SizedBox(height: 40),
          Expanded(
            flex: isMobile ? 0 : 1,
            child: Container(
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 30,
                    offset: const Offset(0, 15),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      'How Funds Are Utilized',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  _utilBar(
                    'Student Scholarships & Training',
                    0.7,
                    Colors.green,
                  ),
                  const SizedBox(height: 25),
                  _utilBar('Infrastructure & Tools', 0.2, Colors.orange),
                  const SizedBox(height: 25),
                  _utilBar(
                    'Community Outreach & Operations',
                    0.1,
                    Colors.blueGrey,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _promiseItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle_outline,
            color: kAccentOrange,
            size: 20,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.black87, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _utilBar(String label, double value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            Text(
              '${(value * 100).toInt()}%',
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: LinearProgressIndicator(
            value: value,
            backgroundColor: Colors.black.withValues(alpha: 0.05),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 8,
          ),
        ),
      ],
    );
  }
}

class WaysToContributeSection extends StatelessWidget {
  final List<DonationOption> donationOptions;
  const WaysToContributeSection({super.key, required this.donationOptions});

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return Container(
      width: double.infinity,
      color: kLightBg,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 40 : 80,
        horizontal: isMobile ? 20 : 80,
      ),
      child: Column(
        children: [
          Text(
            'Ways to Contribute',
            textAlign: TextAlign.center,
            style: GoogleFonts.merriweather(
              color: kPrimaryGreen,
              fontSize: isMobile ? 28 : 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Choose how you want to make a difference. Every amount counts towards\nbuilding a skilled Kashmir.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 60),
          Wrap(
            spacing: 30,
            runSpacing: 30,
            alignment: WrapAlignment.center,
            children: donationOptions
                .map(
                  (opt) => _priceCard(
                    opt.title,
                    opt.price,
                    opt.description,
                    opt.icon,
                    opt.isPopular ? kAccentOrange : kPrimaryGreen,
                    context,
                    isPopular: opt.isPopular,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _priceCard(
    String title,
    String price,
    String desc,
    IconData icon,
    Color color,
    BuildContext context, {
    bool isPopular = false,
  }) {
    bool isMobile = Responsive.isMobile(context);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: isMobile ? double.infinity : 320,
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: isPopular
                ? Border.all(color: color, width: 2)
                : Border.all(color: Colors.black.withValues(alpha: 0.05)),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.05),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 36),
              const SizedBox(height: 25),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                price,
                style: TextStyle(
                  color: color,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                desc,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        if (isPopular)
          Positioned(
            top: -12,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'MOST POPULAR',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class BankTransferSection extends StatelessWidget {
  final BankDetails bankDetails;
  const BankTransferSection({super.key, required this.bankDetails});

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 40 : 80,
        horizontal: isMobile ? 20 : 80,
      ),
      child: Container(
        padding: EdgeInsets.all(isMobile ? 30 : 60),
        decoration: BoxDecoration(
          color: kDarkGreen,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Flex(
          direction: isMobile ? Axis.vertical : Axis.horizontal,
          children: [
            Expanded(
              flex: isMobile ? 0 : 3,
              child: Column(
                crossAxisAlignment: isMobile
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    'Direct Bank Transfer',
                    textAlign: isMobile ? TextAlign.center : TextAlign.start,
                    style: GoogleFonts.merriweather(
                      color: Colors.white,
                      fontSize: isMobile ? 24 : 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Prefer to transfer directly? You can send your contributions to our registered trust account. Please share the receipt via WhatsApp.',
                    textAlign: isMobile ? TextAlign.center : TextAlign.start,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: isMobile ? 12 : 14,
                    ),
                  ),
                  const SizedBox(height: 40),
                  _bankRow('Account Name:', bankDetails.accountName, context),
                  _bankRow('Account No:', bankDetails.accountNo, context),
                  _bankRow('Bank:', bankDetails.bankName, context),
                  _bankRow('Branch Code:', bankDetails.branchCode, context),
                ],
              ),
            ),
            if (isMobile) const SizedBox(height: 40),
            Expanded(
              flex: isMobile ? 0 : 2,
              child: Column(
                children: [
                  Icon(
                    Icons.favorite_border,
                    color: Colors.white12,
                    size: isMobile ? 60 : 100,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '"Charity does not decrease wealth."',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontStyle: FontStyle.italic,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: isMobile ? double.infinity : null,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: kDarkGreen,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.chat_bubble_outline, size: 18),
                          SizedBox(width: 10),
                          Text(
                            'Contact Finance Team',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
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

  Widget _bankRow(String label, String value, BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          SizedBox(
            width: isMobile ? 100 : 120,
            child: Text(
              label,
              style: const TextStyle(
                color: kAccentOrange,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: isMobile ? 13 : 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- Common Footer & Clipper ---

class FooterSection extends StatelessWidget {
  final Function(int) onNavigate;
  const FooterSection({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return Container(
      color: kDarkGreen,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 60 : 80,
        horizontal: isMobile ? 20 : 100,
      ),
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return Wrap(
                spacing: 60,
                runSpacing: 40,
                alignment: WrapAlignment.start,
                children: [
                  // Column 1: Brand & About
                  SizedBox(
                    width: isMobile
                        ? constraints.maxWidth
                        : constraints.maxWidth * 0.45,
                    child: Column(
                      crossAxisAlignment: isMobile
                          ? CrossAxisAlignment.center
                          : CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/logo_white.png',
                          height: 70,
                          fit: BoxFit.contain,
                          errorBuilder: (c, e, s) => const Icon(
                            Icons.school,
                            size: 60,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 25),
                        Text(
                          'Empowering the youth of Kashmir through digital skills, fostering self-reliance, and building a future where talent meets opportunity right here in the valley.',
                          textAlign: isMobile
                              ? TextAlign.center
                              : TextAlign.start,
                          style: GoogleFonts.inter(
                            color: Colors.white70,
                            fontSize: 15,
                            height: 1.8,
                          ),
                        ),
                        const SizedBox(height: 30),
                        if (!isMobile)
                          Row(
                            children: [
                              _socialIcon(Icons.camera_alt),
                              const SizedBox(width: 15),
                              _socialIcon(Icons.facebook),
                              const SizedBox(width: 15),
                              _socialIcon(Icons.alternate_email),
                            ],
                          ),
                      ],
                    ),
                  ),

                  // Column 2: Links and Contact
                  SizedBox(
                    width: isMobile
                        ? constraints.maxWidth
                        : constraints.maxWidth * 0.45,
                    child: Wrap(
                      spacing: 40,
                      runSpacing: 40,
                      alignment: isMobile
                          ? WrapAlignment.center
                          : WrapAlignment.start,
                      children: [
                        // Sub-column: Quick Links
                        SizedBox(
                          width: 160,
                          child: Column(
                            crossAxisAlignment: isMobile
                                ? CrossAxisAlignment.center
                                : CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'QUICK LINKS',
                                style: TextStyle(
                                  color: kAccentOrange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              const SizedBox(height: 25),
                              _footerLink(
                                'Our Story',
                                onTap: () => onNavigate(1),
                              ),
                              _footerLink(
                                'All Courses',
                                onTap: () => onNavigate(2),
                              ),
                              _footerLink(
                                'Gallery',
                                onTap: () => onNavigate(3),
                              ),
                              _footerLink(
                                'Contact Us',
                                onTap: () => onNavigate(4),
                              ),
                              _footerLink(
                                'Donate Now',
                                isSpecial: true,
                                onTap: () => onNavigate(5),
                              ),
                            ],
                          ),
                        ),

                        // Sub-column: Contact Info
                        SizedBox(
                          width: 220,
                          child: Column(
                            crossAxisAlignment: isMobile
                                ? CrossAxisAlignment.center
                                : CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'GET IN TOUCH',
                                style: TextStyle(
                                  color: kAccentOrange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              const SizedBox(height: 25),
                              _contactItem(
                                Icons.location_on_outlined,
                                'SCO Software Technology Park, Mirpur',
                              ),
                              _contactItem(
                                Icons.phone_outlined,
                                '0313 884 0571',
                              ),
                              _contactItem(
                                Icons.email_outlined,
                                'salam@hunarmandkashmir.com',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 60),
          const Divider(color: Colors.white12, thickness: 1),
          const SizedBox(height: 30),
          Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: isMobile
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: [
                  const Text(
                    '© 2026 Hunarmand Kashmir. All rights reserved.',
                    style: TextStyle(color: Colors.white38, fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () => onNavigate(6),
                    child: const Text(
                      'Admin Dashboard',
                      style: TextStyle(color: Colors.white10, fontSize: 11),
                    ),
                  ),
                ],
              ),
              if (isMobile) ...[
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _socialIcon(Icons.camera_alt),
                    const SizedBox(width: 20),
                    _socialIcon(Icons.facebook),
                    const SizedBox(width: 20),
                    _socialIcon(Icons.alternate_email),
                  ],
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _footerLink(
    String text, {
    bool isSpecial = false,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        child: Text(
          text,
          style: TextStyle(
            color: isSpecial ? kAccentOrange : Colors.white70,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _contactItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: kAccentOrange, size: 16),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white70, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _socialIcon(IconData icon) {
    return Icon(icon, color: Colors.white38, size: 20);
  }
}

class HeroClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 80);
    var cp = Offset(size.width / 2, size.height);
    var ep = Offset(size.width, size.height - 80);
    path.quadraticBezierTo(cp.dx, cp.dy, ep.dx, ep.dy);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// --- Admin Panel ---

class AdminPanel extends StatefulWidget {
  final Function(int) onNavigate;
  final List<Course> courses;
  final List<GalleryItem> galleryItems;
  final List<DonationOption> donationOptions;
  final BankDetails bankDetails;
  final bool isLoggedIn;
  final Function(bool) onLogin;
  final VoidCallback onUpdate;

  const AdminPanel({
    super.key,
    required this.onNavigate,
    required this.courses,
    required this.galleryItems,
    required this.donationOptions,
    required this.bankDetails,
    required this.isLoggedIn,
    required this.onLogin,
    required this.onUpdate,
  });

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  final TextEditingController _passController = TextEditingController();
  int _activeTab = 0; // 0: Courses, 1: Gallery, 2: Donations, 3: Bank Details

  void _login() {
    if (_passController.text == 'admin123') {
      widget.onLogin(true);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Invalid Password')));
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    if (!widget.isLoggedIn) {
      return Scaffold(
        backgroundColor: kLightBg,
        body: Center(
          child: Container(
            width: isMobile ? MediaQuery.of(context).size.width * 0.9 : 400,
            padding: EdgeInsets.all(isMobile ? 20 : 40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20)],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.lock_outline, size: 60, color: kPrimaryGreen),
                const SizedBox(height: 20),
                Text(
                  'Admin Login',
                  style: GoogleFonts.merriweather(
                    fontSize: isMobile ? 20 : 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: _passController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryGreen,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('Login'),
                ),
                TextButton(
                  onPressed: () => widget.onNavigate(0),
                  child: const Text(
                    'Back to Website',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Admin Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: kPrimaryGreen,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => widget.onLogin(false),
          ),
        ],
      ),
      drawer: isMobile
          ? Drawer(
              child: Container(color: kLightBg, child: _sidebarContent()),
            )
          : null,
      body: Row(
        children: [
          // Sidebar (only on desktop)
          if (!isMobile)
            Container(width: 250, color: kLightBg, child: _sidebarContent()),
          // Content
          Expanded(
            child: _activeTab == 0
                ? _manageCourses()
                : _activeTab == 1
                ? _manageGallery()
                : _activeTab == 2
                ? _manageDonations()
                : _manageBank(),
          ),
        ],
      ),
    );
  }

  Widget _sidebarContent() {
    return Column(
      children: [
        const SizedBox(height: 20),
        _sidebarItem(0, Icons.book, 'Manage Courses'),
        _sidebarItem(1, Icons.image, 'Manage Gallery'),
        _sidebarItem(2, Icons.favorite, 'Manage Donations'),
        _sidebarItem(3, Icons.account_balance, 'Bank Details'),
        const Spacer(),
        ListTile(
          leading: const Icon(Icons.arrow_back),
          title: const Text('Exit Admin'),
          onTap: () => widget.onNavigate(0),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _sidebarItem(int index, IconData icon, String title) {
    bool active = _activeTab == index;
    bool isMobile = Responsive.isMobile(context);
    return ListTile(
      leading: Icon(icon, color: active ? kPrimaryGreen : Colors.grey),
      title: Text(
        title,
        style: TextStyle(
          color: active ? kPrimaryGreen : Colors.black87,
          fontWeight: active ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: active,
      onTap: () {
        setState(() => _activeTab = index);
        if (isMobile) Navigator.pop(context);
      },
    );
  }

  Widget _manageCourses() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Courses List',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ElevatedButton.icon(
                onPressed: _addCourseDialog,
                icon: const Icon(Icons.add),
                label: const Text('Add Course'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kAccentOrange,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: widget.courses.length,
            itemBuilder: (context, index) {
              final course = widget.courses[index];
              return ListTile(
                leading: Icon(course.icon, color: kPrimaryGreen),
                title: Text(
                  course.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '${course.courseType} • ${course.subtitles.isNotEmpty ? course.subtitles.first : 'No subtitles'}',
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        course.isVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        setState(() => course.isVisible = !course.isVisible);
                        widget.onUpdate();
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.orange),
                      onPressed: () => _editCourseDialog(course),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() => widget.courses.removeAt(index));
                        widget.onUpdate();
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _manageGallery() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Gallery Images',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ElevatedButton.icon(
                onPressed: _addImageDialog,
                icon: const Icon(Icons.add_a_photo),
                label: const Text('Add Image'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kAccentOrange,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(20),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 1.5,
            ),
            itemCount: widget.galleryItems.length,
            itemBuilder: (context, index) {
              final item = widget.galleryItems[index];
              return Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      item.imageUrl,
                      fit: BoxFit.cover,
                      opacity: AlwaysStoppedAnimation(
                        item.isVisible ? 1.0 : 0.4,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                            icon: Icon(
                              item.isVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.blue,
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() => item.isVisible = !item.isVisible);
                              widget.onUpdate();
                            },
                          ),
                        ),
                        const SizedBox(width: 5),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 20,
                            ),
                            onPressed: () {
                              setState(
                                () => widget.galleryItems.removeAt(index),
                              );
                              widget.onUpdate();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  void _addCourseDialog() {
    final titleController = TextEditingController();
    final linkController = TextEditingController();
    final detailController = TextEditingController();
    final descController = TextEditingController();
    final durController = TextEditingController();
    final schController = TextEditingController();
    final priceController = TextEditingController();
    final orderController = TextEditingController();
    final queryLinkController = TextEditingController();
    List<String> tempSubtitles = [''];
    String tempType = 'Physical';
    IconData tempIcon = Icons.school;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Add New Course'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextField(
                        controller: orderController,
                        decoration: const InputDecoration(
                          labelText: 'Order # (e.g. 01)',
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 3,
                      child: TextField(
                        controller: titleController,
                        decoration: const InputDecoration(
                          labelText: 'Course Title',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  initialValue: tempType,
                  decoration: const InputDecoration(labelText: 'Course Type'),
                  items: ['Physical', 'Online']
                      .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                      .toList(),
                  onChanged: (v) => setDialogState(() => tempType = v!),
                ),
                TextField(
                  controller: detailController,
                  decoration: InputDecoration(
                    labelText: tempType == 'Online'
                        ? 'Platform (e.g. Zoom)'
                        : 'Address / Location',
                  ),
                ),
                TextField(
                  controller: descController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Main Description',
                  ),
                ),
                TextField(
                  controller: durController,
                  decoration: const InputDecoration(
                    labelText: 'Duration (e.g. 3 Months)',
                  ),
                ),
                TextField(
                  controller: schController,
                  decoration: const InputDecoration(
                    labelText: 'Schedule (e.g. Mon-Thu)',
                  ),
                ),
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(
                    labelText: 'Price (e.g. Rs. 12,000)',
                  ),
                ),
                TextField(
                  controller: linkController,
                  decoration: const InputDecoration(
                    labelText: 'Registration Link (URL)',
                  ),
                ),
                TextField(
                  controller: queryLinkController,
                  decoration: const InputDecoration(
                    labelText: 'Query Link (e.g. WhatsApp URL)',
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Select Icon',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  children:
                      [
                            Icons.school,
                            Icons.smart_toy,
                            Icons.brush,
                            Icons.shopping_bag,
                            Icons.language,
                            Icons.phone_android,
                            Icons.computer,
                            Icons.code,
                          ]
                          .map(
                            (icon) => GestureDetector(
                              onTap: () =>
                                  setDialogState(() => tempIcon = icon),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: tempIcon == icon
                                      ? kPrimaryGreen.withValues(alpha: 0.2)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: tempIcon == icon
                                        ? kPrimaryGreen
                                        : Colors.grey.withValues(alpha: 0.3),
                                  ),
                                ),
                                child: Icon(
                                  icon,
                                  color: tempIcon == icon
                                      ? kPrimaryGreen
                                      : Colors.grey,
                                  size: 24,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Subtitles / Features (Bullet Points)',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                ...tempSubtitles.asMap().entries.map((entry) {
                  int idx = entry.key;
                  return Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: (v) => tempSubtitles[idx] = v,
                          decoration: InputDecoration(
                            labelText: 'Subtitle ${idx + 1}',
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.remove_circle,
                          color: Colors.red,
                        ),
                        onPressed: () =>
                            setDialogState(() => tempSubtitles.removeAt(idx)),
                      ),
                    ],
                  );
                }),
                TextButton.icon(
                  onPressed: () => setDialogState(() => tempSubtitles.add('')),
                  icon: const Icon(Icons.add),
                  label: const Text('Add Subtitle'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.courses.add(
                    Course(
                      id: DateTime.now().toString(),
                      title: titleController.text,
                      subtitles: tempSubtitles
                          .where((s) => s.isNotEmpty)
                          .toList(),
                      registrationLink: linkController.text,
                      courseType: tempType,
                      locationDetail: detailController.text,
                      description: descController.text,
                      duration: durController.text,
                      schedule: schController.text,
                      price: priceController.text,
                      orderNumber: orderController.text.isEmpty
                          ? '01'
                          : orderController.text,
                      queryLink: queryLinkController.text.isEmpty
                          ? 'https://wa.me/923451234567'
                          : queryLinkController.text,
                      icon: tempIcon,
                    ),
                  );
                });
                widget.onUpdate();
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }

  void _editCourseDialog(Course course) {
    final titleController = TextEditingController(text: course.title);
    final linkController = TextEditingController(text: course.registrationLink);
    final detailController = TextEditingController(text: course.locationDetail);
    final descController = TextEditingController(text: course.description);
    final durController = TextEditingController(text: course.duration);
    final schController = TextEditingController(text: course.schedule);
    final priceController = TextEditingController(text: course.price);
    final orderController = TextEditingController(text: course.orderNumber);
    final queryLinkController = TextEditingController(text: course.queryLink);
    List<String> tempSubtitles = List.from(course.subtitles);
    if (tempSubtitles.isEmpty) tempSubtitles.add('');
    String tempType = course.courseType;
    IconData tempIcon = course.icon;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Edit Course'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextField(
                        controller: orderController,
                        decoration: const InputDecoration(labelText: 'Order #'),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 3,
                      child: TextField(
                        controller: titleController,
                        decoration: const InputDecoration(
                          labelText: 'Course Title',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  initialValue: tempType,
                  decoration: const InputDecoration(labelText: 'Course Type'),
                  items: ['Physical', 'Online']
                      .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                      .toList(),
                  onChanged: (v) => setDialogState(() => tempType = v!),
                ),
                TextField(
                  controller: detailController,
                  decoration: InputDecoration(
                    labelText: tempType == 'Online'
                        ? 'Platform (e.g. Zoom)'
                        : 'Address / Location',
                  ),
                ),
                TextField(
                  controller: descController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Main Description',
                  ),
                ),
                TextField(
                  controller: durController,
                  decoration: const InputDecoration(labelText: 'Duration'),
                ),
                TextField(
                  controller: schController,
                  decoration: const InputDecoration(labelText: 'Schedule'),
                ),
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(labelText: 'Price'),
                ),
                TextField(
                  controller: linkController,
                  decoration: const InputDecoration(
                    labelText: 'Registration Link (URL)',
                  ),
                ),
                TextField(
                  controller: queryLinkController,
                  decoration: const InputDecoration(
                    labelText: 'Query Link (e.g. WhatsApp)',
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Select Icon',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  children:
                      [
                            Icons.school,
                            Icons.smart_toy,
                            Icons.brush,
                            Icons.shopping_bag,
                            Icons.language,
                            Icons.phone_android,
                            Icons.computer,
                            Icons.code,
                          ]
                          .map(
                            (icon) => GestureDetector(
                              onTap: () =>
                                  setDialogState(() => tempIcon = icon),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: tempIcon == icon
                                      ? kPrimaryGreen.withValues(alpha: 0.2)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: tempIcon == icon
                                        ? kPrimaryGreen
                                        : Colors.grey.withValues(alpha: 0.3),
                                  ),
                                ),
                                child: Icon(
                                  icon,
                                  color: tempIcon == icon
                                      ? kPrimaryGreen
                                      : Colors.grey,
                                  size: 24,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Subtitles / Features',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                ...tempSubtitles.asMap().entries.map((entry) {
                  int idx = entry.key;
                  return Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: entry.value,
                          onChanged: (v) => tempSubtitles[idx] = v,
                          decoration: InputDecoration(
                            labelText: 'Subtitle ${idx + 1}',
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.remove_circle,
                          color: Colors.red,
                        ),
                        onPressed: () =>
                            setDialogState(() => tempSubtitles.removeAt(idx)),
                      ),
                    ],
                  );
                }),
                TextButton.icon(
                  onPressed: () => setDialogState(() => tempSubtitles.add('')),
                  icon: const Icon(Icons.add),
                  label: const Text('Add Subtitle'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  course.title = titleController.text;
                  course.subtitles = tempSubtitles
                      .where((s) => s.isNotEmpty)
                      .toList();
                  course.registrationLink = linkController.text;
                  course.courseType = tempType;
                  course.locationDetail = detailController.text;
                  course.description = descController.text;
                  course.duration = durController.text;
                  course.schedule = schController.text;
                  course.price = priceController.text;
                  course.orderNumber = orderController.text;
                  course.queryLink = queryLinkController.text;
                  course.icon = tempIcon;
                });
                widget.onUpdate();
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void _addImageDialog() {
    final urlController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Gallery Image'),
        content: TextField(
          controller: urlController,
          decoration: const InputDecoration(labelText: 'Image URL'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                widget.galleryItems.add(
                  GalleryItem(
                    id: DateTime.now().toString(),
                    imageUrl: urlController.text,
                  ),
                );
              });
              widget.onUpdate();
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  Widget _manageDonations() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Donation Options',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ElevatedButton.icon(
                onPressed: _addDonationDialog,
                icon: const Icon(Icons.add),
                label: const Text('Add Option'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kAccentOrange,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: widget.donationOptions.length,
            itemBuilder: (context, index) {
              final opt = widget.donationOptions[index];
              return Card(
                child: ListTile(
                  leading: Icon(opt.icon, color: kAccentOrange),
                  title: Text(
                    opt.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(opt.price),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (opt.isPopular)
                        const Chip(
                          label: Text(
                            'Popular',
                            style: TextStyle(fontSize: 10),
                          ),
                          backgroundColor: Colors.amberAccent,
                        ),
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.orange),
                        onPressed: () => _editDonationDialog(opt),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(
                            () => widget.donationOptions.removeAt(index),
                          );
                          widget.onUpdate();
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _manageBank() {
    final nameController = TextEditingController(
      text: widget.bankDetails.accountName,
    );
    final noController = TextEditingController(
      text: widget.bankDetails.accountNo,
    );
    final bankController = TextEditingController(
      text: widget.bankDetails.bankName,
    );
    final branchController = TextEditingController(
      text: widget.bankDetails.branchCode,
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Bank Transfer Details',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'This information is displayed in the "Direct Bank Transfer" section of the Donate page.',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 40),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Account Name',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person_outline),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: noController,
            decoration: const InputDecoration(
              labelText: 'Account Number',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.numbers),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: bankController,
            decoration: const InputDecoration(
              labelText: 'Bank Name',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.account_balance_outlined),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: branchController,
            decoration: const InputDecoration(
              labelText: 'Branch Code',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.code),
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              setState(() {
                widget.bankDetails.accountName = nameController.text;
                widget.bankDetails.accountNo = noController.text;
                widget.bankDetails.bankName = bankController.text;
                widget.bankDetails.branchCode = branchController.text;
              });
              widget.onUpdate();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Bank details updated successfully!'),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryGreen,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 60),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Update Bank Information',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  void _addDonationDialog() {
    final titleController = TextEditingController();
    final priceController = TextEditingController();
    final descController = TextEditingController();
    bool tempPopular = false;
    IconData tempIcon = Icons.card_giftcard;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Add Donation Option'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(
                    labelText: 'Price (e.g. Rs. 2,000)',
                  ),
                ),
                TextField(
                  controller: descController,
                  maxLines: 3,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                SwitchListTile(
                  title: const Text('Most Popular?'),
                  value: tempPopular,
                  onChanged: (v) => setDialogState(() => tempPopular = v),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.donationOptions.add(
                    DonationOption(
                      id: DateTime.now().toString(),
                      title: titleController.text,
                      price: priceController.text,
                      description: descController.text,
                      icon: tempIcon,
                      isPopular: tempPopular,
                    ),
                  );
                });
                widget.onUpdate();
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }

  void _editDonationDialog(DonationOption opt) {
    final titleController = TextEditingController(text: opt.title);
    final priceController = TextEditingController(text: opt.price);
    final descController = TextEditingController(text: opt.description);
    bool tempPopular = opt.isPopular;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Edit Donation Option'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(labelText: 'Price'),
                ),
                TextField(
                  controller: descController,
                  maxLines: 3,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                SwitchListTile(
                  title: const Text('Most Popular?'),
                  value: tempPopular,
                  onChanged: (v) => setDialogState(() => tempPopular = v),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  opt.title = titleController.text;
                  opt.price = priceController.text;
                  opt.description = descController.text;
                  opt.isPopular = tempPopular;
                });
                widget.onUpdate();
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
