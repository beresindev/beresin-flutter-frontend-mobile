import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_beresin/common/theme.dart';
import 'package:mobile_beresin/pages/login_page.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        toolbarHeight: 5,
        backgroundColor: backgroundColor,
        elevation: 0,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      'assets/svg/logo_jempol.svg',
                      width: 73,
                      height: 73,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Create an Account',
                      style: GoogleFonts.poppins(
                        color: alternativeBlackTextColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Welcome to BeresIn',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: alternativeGrayColor,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Full Name',
                  style: TextStyle(
                    fontSize: 14,
                    color: alternativeBlackTextColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'e.g Adam Ganteng',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 14,
                      color: secondaryTextColor,
                      fontWeight: FontWeight.normal,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: secondaryTextColor,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: primaryColor,
                        width: 2,
                      ),
                    ),
                  ),
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: alternativeBlackTextColor,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Email Address',
                  style: TextStyle(
                    fontSize: 14,
                    color: alternativeBlackTextColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'example@gmail.com',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 14,
                      color: secondaryTextColor,
                      fontWeight: FontWeight.normal,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: secondaryTextColor,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: primaryColor,
                        width: 2,
                      ),
                    ),
                  ),
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: alternativeBlackTextColor,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'No Handphone',
                  style: TextStyle(
                    fontSize: 14,
                    color: alternativeBlackTextColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: '+628xxxxxxxxxx',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 14,
                      color: secondaryTextColor,
                      fontWeight: FontWeight.normal,
                    ),
                    prefixText: '+62 ',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: secondaryTextColor,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: primaryColor,
                        width: 2,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: alternativeBlackTextColor,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 14,
                    color: alternativeBlackTextColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 14,
                      color: secondaryTextColor,
                      fontWeight: FontWeight.normal,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: secondaryTextColor,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: primaryColor,
                        width: 2,
                      ),
                    ),
                  ),
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: alternativeBlackTextColor,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Confirm Password',
                  style: TextStyle(
                    fontSize: 14,
                    color: alternativeBlackTextColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Confirm your password',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 14,
                      color: secondaryTextColor,
                      fontWeight: FontWeight.normal,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: secondaryTextColor,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: primaryColor,
                        width: 2,
                      ),
                    ),
                  ),
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: alternativeBlackTextColor,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Center(
                            child: Text(
                              'Perhatian',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          content: Text(
                            'No HP digunakan untuk pendaftaran sebagai seller',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: alternativeGrayColor,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          actions: [
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop(); // Tutup dialog
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginPage()),
                                  );
                                },
                                child: const Text(
                                  'Ok, Mantap',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                          actionsAlignment: MainAxisAlignment.center,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'SIGN UP',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: alternativeGrayColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                        child: Text(
                          " Sign In",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                            decorationColor: primaryColor,
                          ),
                        ),
                      ),
                    ],
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
