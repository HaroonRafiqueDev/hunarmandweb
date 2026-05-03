import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/models/gallery_item.dart';

class ManageGalleryTab extends StatefulWidget {
  final List<GalleryItem> galleryItems;
  final VoidCallback onUpdate;

  const ManageGalleryTab({
    super.key,
    required this.galleryItems,
    required this.onUpdate,
  });

  @override
  State<ManageGalleryTab> createState() => _ManageGalleryTabState();
}

class _ManageGalleryTabState extends State<ManageGalleryTab> {
  @override
  Widget build(BuildContext context) {
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
}
