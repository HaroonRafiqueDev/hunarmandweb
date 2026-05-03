import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/constants/colors.dart';
import 'core/models/bank_details.dart';
import 'core/models/course.dart';
import 'core/models/donation_option.dart';
import 'core/models/gallery_item.dart';
import 'core/utils/responsive.dart';
import 'features/about/screens/about_page.dart';
import 'features/admin/screens/admin_panel.dart';
import 'features/contact/screens/contact_page.dart';
import 'features/courses/screens/courses_page.dart';
import 'features/donate/screens/donate_page.dart';
import 'features/gallery/screens/gallery_page.dart';
import 'features/home/screens/landing_page.dart';
import 'shared/widgets/ticker_widget.dart';
import 'shared/widgets/top_nav_bar.dart';

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
