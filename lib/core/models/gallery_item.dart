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
