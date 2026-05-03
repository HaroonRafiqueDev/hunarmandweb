import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';

class ManageTickerTab extends StatefulWidget {
  final List<String> tickerMessages;
  final int? tickerTargetIndex;
  final Function(List<String>, int?) onUpdateTicker;

  const ManageTickerTab({
    super.key,
    required this.tickerMessages,
    required this.tickerTargetIndex,
    required this.onUpdateTicker,
  });

  @override
  State<ManageTickerTab> createState() => _ManageTickerTabState();
}

class _ManageTickerTabState extends State<ManageTickerTab> {
  late List<TextEditingController> controllers;
  int? currentTarget;

  @override
  void initState() {
    super.initState();
    controllers = widget.tickerMessages
        .map((m) => TextEditingController(text: m))
        .toList();
    currentTarget = widget.tickerTargetIndex;
  }

  @override
  void dispose() {
    for (var c in controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () {
                        setState(() {
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
                setState(() {
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
                border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
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
                onChanged: (val) => setState(() => currentTarget = val),
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
  }
}
