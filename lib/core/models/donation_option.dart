import 'package:flutter/material.dart';

class DonationOption {
  final String id;
  String title;
  String price;
  String description;
  IconData icon;
  bool isPopular;

  DonationOption({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.icon,
    this.isPopular = false,
  });
}
