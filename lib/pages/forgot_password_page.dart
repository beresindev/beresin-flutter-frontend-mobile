import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_beresin/common/theme.dart';
import 'package:mobile_beresin/pages/login_page.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          },
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Forgot Password',
                  style: GoogleFonts.poppins(
                    color: alternativeBlackTextColor,
                    fontSize: 32,
                    fontWeight: bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Please enter your email address to receive a reset link.',
                  style: GoogleFonts.poppins(
                    color: alternativeGrayColor,
                    fontSize: 14,
                    fontWeight: regular,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Email Address',
                  style: TextStyle(
                    fontSize: 14,
                    color: alternativeBlackTextColor,
                    fontWeight: medium,
                  ),
                ),
                const SizedBox(height: 5),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'example@gmail.com',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 14,
                      color: secondaryTextColor,
                      fontWeight: regular,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: secondaryTextColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: primaryColor, width: 2),
                    ),
                  ),
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: alternativeBlackTextColor,
                    fontWeight: regular,
                  ),
                ),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    // Aksi ketika tombol "SEND" ditekan
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 5.0,
                          spreadRadius: 2.0,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'SEND',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: primaryTextColor,
                          fontWeight: semibold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
