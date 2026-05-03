import 'package:flutter/material.dart';

import '../../../shared/widgets/footer_section.dart';
import '../widgets/contact_hero_section.dart';
import '../widgets/contact_content_section.dart';

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
