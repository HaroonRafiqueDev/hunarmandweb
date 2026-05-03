import 'package:flutter/material.dart';
import '../../../core/models/course.dart';
import '../../../shared/widgets/footer_section.dart';
import '../widgets/hero_section.dart';
import '../widgets/why_section.dart';
import '../widgets/programs_section.dart';
import '../widgets/journey_section.dart';

class LandingPage extends StatelessWidget {
  final Function(int) onNavigate;
  final List<Course> courses;
  final ScrollController? scrollController;
  const LandingPage({
    super.key,
    required this.onNavigate,
    required this.courses,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: [
          HeroSection(onNavigate: onNavigate, activeIndex: 0),
          const WhySection(),
          ProgramsSection(courses: courses, onNavigate: onNavigate),
          JourneySection(onNavigate: onNavigate),
          FooterSection(onNavigate: onNavigate, activeIndex: 0),
        ],
      ),
    );
  }
}
