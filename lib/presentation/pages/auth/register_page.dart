import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_beresin/common/theme.dart';
import 'package:mobile_beresin/presentation/pages/auth/login_page.dart';
import 'package:mobile_beresin/presentation/pages/main/beranda.dart';
import 'package:mobile_beresin/presentation/widgets/bottom_navbar.dart';
import 'package:mobile_beresin/providers/auth_provider.dart';
import 'package:mobile_beresin/providers/service_provider.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController =
      TextEditingController();
  TextEditingController usernameController = TextEditingController();

  Future<void> handleRegister() async {
    Navigator.of(context).pop(); // Tutup dialog
    late ServiceProvider serviceProvider =
        Provider.of<ServiceProvider>(context, listen: false);

    if (emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        usernameController.text.isNotEmpty) {
      AuthProvider authProvider =
          Provider.of<AuthProvider>(context, listen: false);
      try {
        await authProvider.register(
          name: nameController.text,
          phone: phoneController.text,
          username: usernameController.text,
          email: emailController.text,
          password: passwordController.text,
        );

        await serviceProvider.getCategories();
        await serviceProvider.getDraftServices();

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const BottomNavBar(),
          ),
          (route) => false,
        );
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
      }
    } else {
      Fluttertoast.showToast(msg: 'Data tidak boleh kosong!');
    }
  }

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
                  controller: nameController,
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
                  'Username',
                  style: TextStyle(
                    fontSize: 14,
                    color: alternativeBlackTextColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    hintText: 'adamganteng321',
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
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
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
                  'Phone Number',
                  style: TextStyle(
                    fontSize: 14,
                    color: alternativeBlackTextColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: '812345678901',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 14,
                      color: secondaryTextColor,
                      fontWeight: FontWeight.normal,
                    ),
                    prefixText: '+62 ',
                    prefixStyle: GoogleFonts.poppins(
                      fontSize: 14,
                      color: alternativeBlackTextColor,
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
                  'Password',
                  style: TextStyle(
                    fontSize: 14,
                    color: alternativeBlackTextColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextField(
                  controller: passwordController,
                  keyboardType: TextInputType.name,
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
                // Text(
                //   'Confirm Password',
                //   style: TextStyle(
                //     fontSize: 14,
                //     color: alternativeBlackTextColor,
                //     fontWeight: FontWeight.w500,
                //   ),
                // ),
                // TextField(
                //   controller: passwordConfirmationController,
                //   obscureText: true,
                //   decoration: InputDecoration(
                //     hintText: 'Confirm your password',
                //     hintStyle: GoogleFonts.poppins(
                //       fontSize: 14,
                //       color: secondaryTextColor,
                //       fontWeight: FontWeight.normal,
                //     ),
                //     enabledBorder: UnderlineInputBorder(
                //       borderSide: BorderSide(
                //         color: secondaryTextColor,
                //       ),
                //     ),
                //     focusedBorder: UnderlineInputBorder(
                //       borderSide: BorderSide(
                //         color: primaryColor,
                //         width: 2,
                //       ),
                //     ),
                //   ),
                //   style: GoogleFonts.poppins(
                //     fontSize: 14,
                //     color: alternativeBlackTextColor,
                //     fontWeight: FontWeight.normal,
                //   ),
                // ),
                // const SizedBox(height: 20),
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
                                onPressed: handleRegister,
                                // onPressed: () {
                                //   Navigator.of(context).pop(); // Tutup dialog
                                //   Navigator.pushReplacement(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             const LoginPage()),
                                //   );
                                // },
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
