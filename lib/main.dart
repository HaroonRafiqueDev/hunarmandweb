import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import 'core/models/course.dart';
import 'core/models/gallery_item.dart';
import 'core/models/donation_option.dart';
import 'core/models/bank_details.dart';
import 'core/utils/responsive.dart';
import 'core/utils/hero_clipper.dart';
import 'core/constants/colors.dart';
import 'shared/widgets/ticker_widget.dart';
import 'shared/widgets/blinking_badge.dart';
import 'shared/widgets/footer_section.dart';
import 'shared/widgets/top_nav_bar.dart';
import 'features/home/screens/landing_page.dart';
import 'features/about/screens/about_page.dart';
import 'features/courses/screens/courses_page.dart';



void main() {
  // Capture Flutter framework errors
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    debugPrint('Global Flutter Error: ${details.exception}');
    debugPrint('Stack trace: ${details.stack}');
  };

  runApp(const HunarmandKashmirApp());
}



class HunarmandKashmirApp extends StatefulWidget {
  const HunarmandKashmirApp({super.key});

  @override
  State<HunarmandKashmirApp> createState() => _HunarmandKashmirAppState();
}

class _HunarmandKashmirAppState extends State<HunarmandKashmirApp> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();
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
      remainingSeats: '5 Seats Left',
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
      remainingSeats: '',
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
      remainingSeats: '',
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
      remainingSeats: 'Only 2 Seats Left',
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

  List<String> _tickerMessages = [
    "Admissions Open for Batch 5! Secure your seat today.",
    "Special discounts for early birds available until June 1st.",
    "Join our WhatsApp community for daily updates.",
  ];
  int? _tickerTargetIndex = 2; // Default to Courses

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _navigateTo(int index) {
    // Always scroll to top first, then switch page
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(0);
    }
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
          body: Column(
            children: [
              if (_tickerMessages.isNotEmpty)
                TickerWidget(
                  messages: _tickerMessages,
                  onTap: _tickerTargetIndex != null
                      ? () => _navigateTo(_tickerTargetIndex!)
                      : null,
                ),
              Container(
                color: const Color(0xFF166600), // navbar background
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.isMobile(context) ? 20 : 80,
                  vertical: 20,
                ),
                child: TopNavBar(
                  onNavigate: _navigateTo,
                  activeIndex: _currentPageIndex,
                ),
              ),
              Expanded(child: _buildPage()),
            ],
          ),
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
            ? const Color.fromRGBO(242, 169, 0, 1)
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
        return AboutPage(
          key: ValueKey(_currentPageIndex),
          onNavigate: _navigateTo,
          scrollController: _scrollController,
        );
      case 2:
        return CoursesPage(
          key: ValueKey(_currentPageIndex),
          onNavigate: _navigateTo,
          courses: _courses,
          scrollController: _scrollController,
        );
      case 3:
        return GalleryPage(
          key: ValueKey(_currentPageIndex),
          onNavigate: _navigateTo,
          galleryItems: _galleryItems,
          scrollController: _scrollController,
        );
      case 4:
        return ContactPage(
          key: ValueKey(_currentPageIndex),
          onNavigate: _navigateTo,
          scrollController: _scrollController,
        );
      case 5:
        return DonatePage(
          key: ValueKey(_currentPageIndex),
          onNavigate: _navigateTo,
          donationOptions: _donationOptions,
          bankDetails: _bankDetails,
          scrollController: _scrollController,
        );
      case 6:
        return AdminPanel(
          key: ValueKey(_currentPageIndex),
          onNavigate: _navigateTo,
          courses: _courses,
          galleryItems: _galleryItems,
          donationOptions: _donationOptions,
          bankDetails: _bankDetails,
          isLoggedIn: _isAdminLoggedIn,
          tickerMessages: _tickerMessages,
          tickerTargetIndex: _tickerTargetIndex,
          onLogin: (status) => setState(() => _isAdminLoggedIn = status),
          onUpdateTicker: (messages, target) => setState(() {
            _tickerMessages = messages;
            _tickerTargetIndex = target;
          }),
          onUpdate: () => setState(() {}),
        );
      default:
        return LandingPage(
          key: ValueKey(_currentPageIndex),
          onNavigate: _navigateTo,
          courses: _courses,
          scrollController: _scrollController,
        );
    }
  }
}

// --- Colors ---


// --- Pages ---





class GalleryPage extends StatelessWidget {
  final Function(int) onNavigate;
  final List<GalleryItem> galleryItems;
  final ScrollController? scrollController;
  const GalleryPage({
    super.key,
    required this.onNavigate,
    required this.galleryItems,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: [
          GalleryHeroSection(onNavigate: onNavigate),
          GalleryGridSection(galleryItems: galleryItems),
          FooterSection(onNavigate: onNavigate, activeIndex: 3),
        ],
      ),
    );
  }
}

class ContactPage extends StatelessWidget {
  final Function(int) onNavigate;
  final ScrollController? scrollController;
  const ContactPage({
    super.key,
    required this.onNavigate,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: [
          ContactHeroSection(onNavigate: onNavigate),
          const ContactContentSection(),
          FooterSection(onNavigate: onNavigate, activeIndex: 4),
        ],
      ),
    );
  }
}

class DonatePage extends StatelessWidget {
  final Function(int) onNavigate;
  final List<DonationOption> donationOptions;
  final BankDetails bankDetails;
  final ScrollController? scrollController;
  const DonatePage({
    super.key,
    required this.onNavigate,
    required this.donationOptions,
    required this.bankDetails,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: [
          DonateHeroSection(onNavigate: onNavigate),
          const PillarsSection(),
          const TransparencySection(),
          WaysToContributeSection(donationOptions: donationOptions),
          BankTransferSection(bankDetails: bankDetails),
          FooterSection(onNavigate: onNavigate, activeIndex: 5),
        ],
      ),
    );
  }
}

// --- Shared Components ---



// --- Home Sections ---

// --- About Sections ---



// --- Courses Sections ---


// --- Gallery Sections ---

class GalleryHeroSection extends StatelessWidget {
  final Function(int) onNavigate;
  const GalleryHeroSection({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return Container(
      width: double.infinity,
      color: const Color(0xFF002B11),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: 40,
      ),
      child: Column(
        children: [
          SizedBox(height: isMobile ? 20 : 40),
          Text(
            'Moments of Hope',
            textAlign: TextAlign.center,
            style: GoogleFonts.merriweather(
              color: Colors.white,
              fontSize: isMobile ? 48 : 72,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Witness the journey of transformation. From Mirpur to Bhimber, empowering every corner of Kashmir.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: isMobile ? 18 : 22,
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
        vertical: isMobile ? 60 : 120,
        horizontal: isMobile ? 24 : 150,
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
      color: const Color(0xFF002B11),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: 40,
      ),
      child: Column(
        children: [
          SizedBox(height: isMobile ? 20 : 40),
          Text(
            'Get in Touch',
            textAlign: TextAlign.center,
            style: GoogleFonts.merriweather(
              color: Colors.white,
              fontSize: isMobile ? 48 : 72,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Start your journey today. Visit us, call us, or fill out the form below. We are here to help you grow.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: isMobile ? 18 : 22,
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

    Widget leftCard = Container(
      width: double.infinity,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Visit Our Campus',
            style: GoogleFonts.merriweather(
              color: kPrimaryGreen,
              fontSize: isMobile ? 32 : 48,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 25),
          Text(
            'Our doors are always open for students and parents. Come see our state-of-the-art labs, meet our mentors, and feel the energy of innovation.',
            style: GoogleFonts.inter(
              color: Colors.black54,
              fontSize: isMobile ? 16 : 20,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 40),
          _contactInfo(
            Icons.location_on,
            'Address',
            'A.M. Design, Nangi (Behind Bank of Punjab), Allama Iqbal Road, Mirpur, AJK, Pakistan',
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
          // ConstrainedBox(
          //   constraints: const BoxConstraints(minHeight: 250),
          //   child: Container(
          //     width: double.infinity,
          //     height: isMobile ? 250 : null,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(20),
          //       image: const DecorationImage(
          //         image: NetworkImage(
          //           'https://images.unsplash.com/photo-1526778548025-fa2f459cd5c1?w=800&q=80',
          //         ),
          //         fit: BoxFit.cover,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );

    Widget rightCard = Container(
      width: double.infinity,
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
              fontSize: isMobile ? 28 : 44,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'The fastest way to get in touch with us is via WhatsApp. Our team is online and ready to answer your questions about courses, admissions, and more.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black54,
              fontSize: isMobile ? 16 : 20,
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
    );

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 40 : 80,
        horizontal: isMobile ? 24 : 150,
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [leftCard, const SizedBox(height: 40), rightCard],
            )
          : IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: leftCard),
                  const SizedBox(width: 80),
                  Expanded(child: rightCard),
                ],
              ),
            ),
    );
  }

  Widget _contactInfo(
    IconData icon,
    String label,
    String text,
    Color bgColor,
    Color iconColor, {
    int? maxLines,
  }) {
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
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                text,
                maxLines: maxLines,
                style: const TextStyle(color: Colors.black54, fontSize: 14),
              ),
            ],
          ),
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
      color: const Color(0xFF002B11),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: 40,
      ),
      child: Column(
        children: [
          SizedBox(height: isMobile ? 20 : 40),
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
                fontSize: isMobile ? 36 : 64,
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
              fontSize: isMobile ? 18 : 22,
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
        vertical: isMobile ? 60 : 100,
        horizontal: isMobile ? 24 : 150,
      ),
      child: isMobile
          ? Column(
              children: [
                _pillarCard(
                  Icons.menu_book,
                  'Sponsor Education',
                  'Many talented students in remote villages drop out due to lack of funds. Your donation covers their tuition, software licenses, and learning materials.',
                  const Color(0xFFFFF4E5),
                  context,
                ),
                const SizedBox(height: 30),
                _pillarCard(
                  Icons.group_add,
                  'Empower Mentorship',
                  'We bring in industry experts to mentor our students. Your support helps us organize workshops, hackathons, and career counseling sessions.',
                  const Color(0xFFE8F5E9),
                  context,
                ),
                const SizedBox(height: 30),
                _pillarCard(
                  Icons.shield_outlined,
                  'Create Independence',
                  'We don\'t give handouts; we give hand-ups. Students you support go on to become freelancers and entrepreneurs who support their families.',
                  const Color(0xFFFFF3E0),
                  context,
                ),
              ],
            )
          : IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: _pillarCard(
                      Icons.menu_book,
                      'Sponsor Education',
                      'Many talented students in remote villages drop out due to lack of funds. Your donation covers their tuition, software licenses, and learning materials.',
                      const Color(0xFFFFF4E5),
                      context,
                    ),
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    child: _pillarCard(
                      Icons.group_add,
                      'Empower Mentorship',
                      'We bring in industry experts to mentor our students. Your support helps us organize workshops, hackathons, and career counseling sessions.',
                      const Color(0xFFE8F5E9),
                      context,
                    ),
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    child: _pillarCard(
                      Icons.shield_outlined,
                      'Create Independence',
                      'We don\'t give handouts; we give hand-ups. Students you support go on to become freelancers and entrepreneurs who support their families.',
                      const Color(0xFFFFF3E0),
                      context,
                    ),
                  ),
                ],
              ),
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
    return Container(
      width: double.infinity,
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
        horizontal: isMobile ? 24 : 150,
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTransparencyContent(isMobile),
                const SizedBox(height: 40),
                _buildTransparencyUtil(isMobile),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildTransparencyContent(isMobile)),
                const SizedBox(width: 80),
                Expanded(child: _buildTransparencyUtil(isMobile)),
              ],
            ),
    );
  }

  Widget _buildTransparencyContent(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Our Promise of Transparency',
          style: GoogleFonts.merriweather(
            color: kPrimaryGreen,
            fontSize: isMobile ? 32 : 44,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 25),
        Text(
          'We understand that trust is the foundation of any contribution. At Hunarmand Kashmir, every rupee is accounted for. We operate with a strict policy of ethical allocation.',
          style: GoogleFonts.inter(
            color: Colors.black54,
            fontSize: isMobile ? 16 : 20,
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
    );
  }

  Widget _buildTransparencyUtil(bool isMobile) {
    return Container(
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
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          const SizedBox(height: 40),
          _utilBar('Student Scholarships & Training', 0.7, Colors.green),
          const SizedBox(height: 25),
          _utilBar('Infrastructure & Tools', 0.2, Colors.orange),
          const SizedBox(height: 25),
          _utilBar('Community Outreach & Operations', 0.1, Colors.blueGrey),
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
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 10),
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
        horizontal: isMobile ? 24 : 150,
      ),
      child: Column(
        children: [
          Text(
            'Ways to Contribute',
            textAlign: TextAlign.center,
            style: GoogleFonts.merriweather(
              color: kPrimaryGreen,
              fontSize: isMobile ? 32 : 48,
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
          isMobile
              ? Column(
                  children: donationOptions
                      .map(
                        (opt) => Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: _priceCard(
                            opt.title,
                            opt.price,
                            opt.description,
                            opt.icon,
                            opt.isPopular ? kAccentOrange : kPrimaryGreen,
                            context,
                            isPopular: opt.isPopular,
                          ),
                        ),
                      )
                      .toList(),
                )
              : IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: donationOptions
                        .expand(
                          (opt) => [
                            Expanded(
                              child: _priceCard(
                                opt.title,
                                opt.price,
                                opt.description,
                                opt.icon,
                                opt.isPopular ? kAccentOrange : kPrimaryGreen,
                                context,
                                isPopular: opt.isPopular,
                              ),
                            ),
                            if (opt != donationOptions.last)
                              const SizedBox(width: 30),
                          ],
                        )
                        .toList(),
                  ),
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
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
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
        horizontal: isMobile ? 24 : 150,
      ),
      child: Container(
        padding: EdgeInsets.all(isMobile ? 30 : 60),
        decoration: BoxDecoration(
          color: kDarkGreen,
          borderRadius: BorderRadius.circular(30),
        ),
        child: isMobile
            ? Column(
                children: [
                  _buildBankInfo(isMobile, context),
                  const SizedBox(height: 40),
                  _buildBankCta(isMobile),
                ],
              )
            : Row(
                children: [
                  Expanded(flex: 3, child: _buildBankInfo(isMobile, context)),
                  const SizedBox(width: 40),
                  Expanded(flex: 2, child: _buildBankCta(isMobile)),
                ],
              ),
      ),
    );
  }

  Widget _buildBankInfo(bool isMobile, BuildContext context) {
    return Column(
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
          style: TextStyle(color: Colors.white70, fontSize: isMobile ? 16 : 20),
        ),
        const SizedBox(height: 40),
        _bankRow('Account Name:', bankDetails.accountName, context),
        _bankRow('Account No:', bankDetails.accountNo, context),
        _bankRow('Bank:', bankDetails.bankName, context),
        _bankRow('Branch Code:', bankDetails.branchCode, context),
      ],
    );
  }

  Widget _buildBankCta(bool isMobile) {
    return Column(
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
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
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





// --- Admin Panel ---

class AdminPanel extends StatefulWidget {
  final Function(int) onNavigate;
  final List<Course> courses;
  final List<GalleryItem> galleryItems;
  final List<DonationOption> donationOptions;
  final BankDetails bankDetails;
  final bool isLoggedIn;
  final List<String> tickerMessages;
  final int? tickerTargetIndex;
  final Function(bool) onLogin;
  final Function(List<String>, int?) onUpdateTicker;
  final VoidCallback onUpdate;

  const AdminPanel({
    super.key,
    required this.onNavigate,
    required this.courses,
    required this.galleryItems,
    required this.donationOptions,
    required this.bankDetails,
    required this.isLoggedIn,
    required this.tickerMessages,
    required this.tickerTargetIndex,
    required this.onLogin,
    required this.onUpdateTicker,
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
                : _activeTab == 3
                ? _manageBank()
                : _manageTicker(),
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
        _sidebarItem(4, Icons.campaign, 'Announcement Ticker'),
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
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey[200],
                        child: const Center(
                          child: Icon(Icons.broken_image, color: Colors.red),
                        ),
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
    final remainingSeatsController = TextEditingController();
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
                  controller: remainingSeatsController,
                  decoration: const InputDecoration(
                    labelText: 'Remaining Seats (e.g. 5 Seats Left)',
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
                try {
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
                        remainingSeats: remainingSeatsController.text,
                        queryLink: queryLinkController.text.isEmpty
                            ? 'https://wa.me/923451234567'
                            : queryLinkController.text,
                        icon: tempIcon,
                      ),
                    );
                  });
                  widget.onUpdate();
                  Navigator.pop(context);
                } catch (e) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Error: $e')));
                }
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
    final remainingSeatsController = TextEditingController(
      text: course.remainingSeats,
    );
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
                  controller: remainingSeatsController,
                  decoration: const InputDecoration(
                    labelText: 'Remaining Seats',
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

  String _processImageUrl(String url) {
    if (url.contains('drive.google.com')) {
      final RegExp regExp = RegExp(r'(?:/d/|id=)([a-zA-Z0-9_-]+)');
      final Match? match = regExp.firstMatch(url);
      if (match != null && match.groupCount >= 1) {
        final String? fileId = match.group(1);
        final directUrl = 'https://drive.google.com/uc?export=view&id=$fileId';

        // Use a Google-provided proxy to bypass CORS issues on Flutter Web
        final proxiedUrl =
            'https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?container=focus&refresh=2592000&url=${Uri.encodeComponent(directUrl)}';

        debugPrint('AdminPanel: Processed GDrive URL (Proxied): $proxiedUrl');
        return proxiedUrl;
      }
    }
    return url;
  }

  void _addImageDialog() {
    final urlController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Add Gallery Image'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: urlController,
                decoration: const InputDecoration(
                  labelText: 'Image URL',
                  hintText: 'Direct link or Google Drive share link',
                  helperText:
                      'For Google Drive, ensure file is set to "Anyone with the link"',
                  helperStyle: TextStyle(fontSize: 10, color: Colors.blueGrey),
                ),
                onChanged: (value) => setDialogState(() {}),
              ),
              const SizedBox(height: 20),
              if (urlController.text.isNotEmpty)
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      _processImageUrl(urlController.text),
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.broken_image, color: Colors.red),
                          const SizedBox(height: 8),
                          const Text(
                            'Invalid Image URL',
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                          TextButton(
                            onPressed: () async {
                              final pUrl = _processImageUrl(urlController.text);
                              if (await canLaunchUrl(Uri.parse(pUrl))) {
                                await launchUrl(Uri.parse(pUrl));
                              }
                            },
                            child: const Text(
                              'Verify Link Manually',
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                try {
                  if (urlController.text.isEmpty) {
                    throw 'Image URL cannot be empty';
                  }

                  setState(() {
                    widget.galleryItems.add(
                      GalleryItem(
                        id: DateTime.now().toString(),
                        imageUrl: _processImageUrl(urlController.text),
                      ),
                    );
                  });
                  widget.onUpdate();
                  debugPrint(
                    'AdminPanel: Successfully added gallery image: ${urlController.text}',
                  );
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Image added successfully')),
                  );
                } catch (e, stack) {
                  debugPrint('AdminPanel Error (Add Image): $e');
                  debugPrint(stack.toString());
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error adding image: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text('Add'),
            ),
          ],
        ),
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
                          backgroundColor: Color.fromRGBO(255, 215, 64, 1),
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
              try {
                setState(() {
                  widget.bankDetails.accountName = nameController.text;
                  widget.bankDetails.accountNo = noController.text;
                  widget.bankDetails.bankName = bankController.text;
                  widget.bankDetails.branchCode = branchController.text;
                });
                widget.onUpdate();
                debugPrint('AdminPanel: Successfully updated bank details');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Bank details updated successfully!'),
                  ),
                );
              } catch (e, stack) {
                debugPrint('AdminPanel Error (Update Bank): $e');
                debugPrint(stack.toString());
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error updating bank details: $e'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
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
                try {
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
                  debugPrint(
                    'AdminPanel: Successfully added donation option: ${titleController.text}',
                  );
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Donation option added successfully'),
                    ),
                  );
                } catch (e, stack) {
                  debugPrint('AdminPanel Error (Add Donation): $e');
                  debugPrint(stack.toString());
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error adding donation: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
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

  Widget _manageTicker() {
    // Initial controllers for existing messages
    List<TextEditingController> controllers = widget.tickerMessages
        .map((m) => TextEditingController(text: m))
        .toList();
    int? currentTarget = widget.tickerTargetIndex;

    return StatefulBuilder(
      builder: (context, setTickerState) {
        return Padding(
          padding: const EdgeInsets.all(40),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Announcement Ticker',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Add multiple scrolling announcements. They will be displayed at the top of the page separated by bullets.',
                  style: TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 30),
                // List of Messages
                ...List.generate(controllers.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controllers[index],
                            decoration: InputDecoration(
                              labelText: 'Message ${index + 1}',
                              border: const OutlineInputBorder(),
                              prefixIcon: const Icon(Icons.campaign_outlined),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        IconButton(
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            setTickerState(() {
                              controllers[index].dispose();
                              controllers.removeAt(index);
                            });
                          },
                        ),
                      ],
                    ),
                  );
                }),
                // Add Button
                OutlinedButton.icon(
                  onPressed: () {
                    setTickerState(() {
                      controllers.add(TextEditingController());
                    });
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Another Message'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  'Target Page (When Ticker is Tapped):',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.withValues(alpha: 0.3),
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButton<int?>(
                    value: currentTarget,
                    isExpanded: true,
                    underline: const SizedBox(),
                    items: const [
                      DropdownMenuItem(
                        value: null,
                        child: Text('No Link (Not Clickable)'),
                      ),
                      DropdownMenuItem(value: 0, child: Text('Home')),
                      DropdownMenuItem(value: 1, child: Text('About Us')),
                      DropdownMenuItem(value: 2, child: Text('Courses')),
                      DropdownMenuItem(value: 3, child: Text('Gallery')),
                      DropdownMenuItem(value: 4, child: Text('Contact')),
                      DropdownMenuItem(value: 5, child: Text('Donate')),
                    ],
                    onChanged: (val) =>
                        setTickerState(() => currentTarget = val),
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton.icon(
                  onPressed: () {
                    // Collect all non-empty messages
                    List<String> finalMessages = controllers
                        .map((c) => c.text.trim())
                        .where((t) => t.isNotEmpty)
                        .toList();

                    widget.onUpdateTicker(finalMessages, currentTarget);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Ticker messages updated successfully'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  icon: const Icon(Icons.save),
                  label: const Text('Save All Changes'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryGreen,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 100), // Extra space for scrolling
              ],
            ),
          ),
        );
      },
    );
  }
}


