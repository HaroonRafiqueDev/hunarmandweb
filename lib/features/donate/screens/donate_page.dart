import 'package:flutter/material.dart';

import '../../../core/models/bank_details.dart';
import '../../../core/models/donation_option.dart';
import '../../../shared/widgets/footer_section.dart';
import '../widgets/donate_hero_section.dart';
import '../widgets/pillars_section.dart';
import '../widgets/transparency_section.dart';
import '../widgets/ways_to_contribute_section.dart';
import '../widgets/bank_transfer_section.dart';

class DonatePage extends StatelessWidget {
  final Function(int) onNavigate;
  final List<DonationOption> donationOptions;
  final BankDetails bankDetails;
  final ScrollController? scrollController;

  const DonatePage({
    super.key,
    required this.onNavigate,
    required this.donationOptions,
    required this.bankDetails,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: [
          DonateHeroSection(onNavigate: onNavigate),
          const PillarsSection(),
          const TransparencySection(),
          WaysToContributeSection(donationOptions: donationOptions),
          BankTransferSection(bankDetails: bankDetails),
          FooterSection(onNavigate: onNavigate, activeIndex: 5),
        ],
      ),
    );
  }
}
