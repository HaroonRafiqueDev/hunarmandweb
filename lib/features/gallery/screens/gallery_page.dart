import 'package:flutter/material.dart';

import '../../../core/models/gallery_item.dart';
import '../../../shared/widgets/footer_section.dart';
import '../widgets/gallery_hero_section.dart';
import '../widgets/gallery_grid_section.dart';

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
