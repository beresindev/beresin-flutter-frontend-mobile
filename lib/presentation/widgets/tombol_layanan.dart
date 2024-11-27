import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_beresin/common/theme.dart';

class TombolLayanan extends StatelessWidget {
  final String svgIconPath;
  final String text;
  final Color? bgIconColor;
  final VoidCallback onTap;

  const TombolLayanan({
    Key? key,
    required this.svgIconPath,
    required this.text,
    this.bgIconColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // width: 80,
        height: 90,
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: alternativeBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(25),
                ),
                color: bgIconColor,
              ),
              child: SvgPicture.asset(
                svgIconPath, // Use the SVG path here
                height: 24,
                width: 24,
                fit: BoxFit.none,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              text,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 10,
                color: blackTextColor,
                fontWeight: semibold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
