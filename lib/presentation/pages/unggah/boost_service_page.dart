import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_beresin/common/theme.dart';
import 'package:mobile_beresin/models/service_model.dart';

class BoostServicePage extends StatefulWidget {
  final ServiceModel item;
  const BoostServicePage({super.key, required this.item});

  @override
  State<BoostServicePage> createState() => _BoostServicePageState();
}

class _BoostServicePageState extends State<BoostServicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: Container(
          decoration: BoxDecoration(
            color: alternativeBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 7.0,
                spreadRadius: 1.0,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: primaryColor,
            automaticallyImplyLeading: false,
            elevation: 0,
            scrolledUnderElevation: 0,
            title: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_sharp,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 15),
                Text(
                  'Boost Listing',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w600, // semibold
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SizedBox(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [],
            ),
          ),
        ),
        // ],
      ),
    );
  }
}
