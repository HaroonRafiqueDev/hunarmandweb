import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/models/donation_option.dart';

class ManageDonationsTab extends StatefulWidget {
  final List<DonationOption> donationOptions;
  final VoidCallback onUpdate;

  const ManageDonationsTab({
    super.key,
    required this.donationOptions,
    required this.onUpdate,
  });

  @override
  State<ManageDonationsTab> createState() => _ManageDonationsTabState();
}

class _ManageDonationsTabState extends State<ManageDonationsTab> {
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
}
