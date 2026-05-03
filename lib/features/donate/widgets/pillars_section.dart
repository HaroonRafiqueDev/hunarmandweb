import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/utils/responsive.dart';

class PillarsSection extends StatelessWidget {
  const PillarsSection({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 60 : 100,
        horizontal: isMobile ? 24 : 150,
      ),
      child: isMobile
          ? Column(
              children: [
                _pillarCard(
                  Icons.menu_book,
                  'Sponsor Education',
                  'Many talented students in remote villages drop out due to lack of funds. Your donation covers their tuition, software licenses, and learning materials.',
                  const Color(0xFFFFF4E5),
                  context,
                ),
                const SizedBox(height: 30),
                _pillarCard(
                  Icons.group_add,
                  'Empower Mentorship',
                  'We bring in industry experts to mentor our students. Your support helps us organize workshops, hackathons, and career counseling sessions.',
                  const Color(0xFFE8F5E9),
                  context,
                ),
                const SizedBox(height: 30),
                _pillarCard(
                  Icons.shield_outlined,
                  'Create Independence',
                  'We don\'t give handouts; we give hand-ups. Students you support go on to become freelancers and entrepreneurs who support their families.',
                  const Color(0xFFFFF3E0),
                  context,
                ),
              ],
            )
          : IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: _pillarCard(
                      Icons.menu_book,
                      'Sponsor Education',
                      'Many talented students in remote villages drop out due to lack of funds. Your donation covers their tuition, software licenses, and learning materials.',
                      const Color(0xFFFFF4E5),
                      context,
                    ),
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    child: _pillarCard(
                      Icons.group_add,
                      'Empower Mentorship',
                      'We bring in industry experts to mentor our students. Your support helps us organize workshops, hackathons, and career counseling sessions.',
                      const Color(0xFFE8F5E9),
                      context,
                    ),
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    child: _pillarCard(
                      Icons.shield_outlined,
                      'Create Independence',
                      'We don\'t give handouts; we give hand-ups. Students you support go on to become freelancers and entrepreneurs who support their families.',
                      const Color(0xFFFFF3E0),
                      context,
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _pillarCard(
    IconData icon,
    String title,
    String desc,
    Color iconBg,
    BuildContext context,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: iconBg == const Color(0xFFE8F5E9)
                  ? Colors.green
                  : Colors.orange,
              size: 24,
            ),
          ),
          const SizedBox(height: 25),
          Text(
            title,
            style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 15),
          Text(
            desc,
            style: GoogleFonts.inter(
              color: Colors.black54,
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
