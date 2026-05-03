import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/constants/colors.dart';

class DiscountsSection extends StatelessWidget {
  const DiscountsSection({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 80 : 140,
        horizontal: isMobile ? 24 : 150,
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(isMobile ? 30 : 60),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 40,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              'Early Bird Discounts',
              textAlign: TextAlign.center,
              style: GoogleFonts.merriweather(
                color: kDarkGreen,
                fontSize: isMobile ? 32 : 44,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Limited seats available — total seats are only 20. Discounts are applied from highest to\nlowest on a first-come, first-served basis.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                fontSize: isMobile ? 16 : 20,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 60),
            Wrap(
              spacing: 30,
              runSpacing: 30,
              alignment: WrapAlignment.center,
              children: [
                _buildDiscountCard(
                  'FIRST 5 STUDENTS',
                  '15% OFF',
                  const Color(0xFFD1FADF), // Light Green
                  const Color(0xFF027A48), // Dark Green text
                  context,
                ),
                _buildDiscountCard(
                  'NEXT 5 STUDENTS',
                  '10% OFF',
                  const Color(0xFFCCFBFF), // Light Cyan
                  const Color(0xFF006D77), // Dark Cyan text
                  context,
                ),
                _buildDiscountCard(
                  'NEXT 5 STUDENTS',
                  '5% OFF',
                  const Color(0xFFD1E9FF), // Light Blue
                  const Color(0xFF175CD3), // Dark Blue text
                  context,
                ),
                _buildDiscountCard(
                  'REMAINING SEATS',
                  'Full Fee',
                  const Color(0xFFF2F4F7), // Light Grey
                  const Color(0xFF344054), // Dark Grey text
                  context,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDiscountCard(
    String group,
    String discount,
    Color bgColor,
    Color textColor,
    BuildContext context,
  ) {
    bool isMobile = Responsive.isMobile(context);
    return Container(
      width: isMobile ? double.infinity : 280,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            group,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor.withValues(alpha: 0.6),
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            discount,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor.withValues(alpha: 0.8),
              fontSize: 44,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
