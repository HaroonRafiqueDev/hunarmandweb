import 'package:flutter/material.dart';
import '../../../shared/widgets/footer_section.dart';
import '../widgets/about_hero_section.dart';
import '../widgets/story_section.dart';
import '../widgets/values_section.dart';
import '../widgets/about_cta_section.dart';

class AboutPage extends StatelessWidget {
  final Function(int) onNavigate;
  final ScrollController? scrollController;
  const AboutPage({super.key, required this.onNavigate, this.scrollController});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: [
          AboutHeroSection(onNavigate: onNavigate),
          const StorySection(),
          const ValuesSection(),
          AboutCTASection(onNavigate: onNavigate),
          FooterSection(onNavigate: onNavigate, activeIndex: 1),
        ],
      ),
    );
  }
}
