import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_beresin/common/theme.dart';
import 'package:mobile_beresin/presentation/pages/auth/register_page.dart';
import 'package:mobile_beresin/presentation/widgets/bottom_navbar.dart';
import 'package:mobile_beresin/providers/auth_provider.dart';
import 'package:mobile_beresin/providers/service_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  var showPassword = true;
  bool isLoading = false;

  Route halamanBeranda() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const BottomNavBar(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset(0.0, 0.0);
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    ServiceProvider serviceProvider = Provider.of<ServiceProvider>(context);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        toolbarHeight: 5,
        backgroundColor: backgroundColor,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.lock,
                  size: 64,
                  color: primaryColor,
                ),
                const SizedBox(height: 10),
                Text(
                  'Welcome Back',
                  style: GoogleFonts.poppins(
                    color: blackTextColor,
                    fontSize: 32,
                    fontWeight: bold,
                  ),
                ),
                Text(
                  'Sign in to your account',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: darkGrayColor,
                    fontWeight: regular,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Email Address',
                  style: TextStyle(
                    fontSize: 14,
                    color: blackTextColor,
                    fontWeight: medium,
                  ),
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Masukan nama jasa anda',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 14,
                      color: greyTextColor,
                      fontWeight: regular,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: greyTextColor,
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
                    color: blackTextColor,
                    fontWeight: regular,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 14,
                    color: blackTextColor,
                    fontWeight: medium,
                  ),
                ),
                TextField(
                  obscureText: showPassword,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: 'Masukan nama jasa anda',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 14,
                      color: greyTextColor,
                      fontWeight: regular,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        showPassword
                            ? Icons.remove_red_eye
                            : Icons.remove_red_eye_outlined,
                      ),
                      onPressed: () => setState(() {
                        showPassword = !showPassword;
                      }),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: greyTextColor,
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
                    color: blackTextColor,
                    fontWeight: regular,
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forgot Password?',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: darkGrayColor,
                      fontWeight: medium,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () async {
                    // String? token = await FirebaseMessaging.instance.getToken();
                    // print("ini token $token");
                    if (_emailController.text.isEmpty ||
                        _passwordController.text.isEmpty) {
                      setState(() {
                        isLoading = true;
                      });
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Harap isi data terlebih dahulu"),
                        ),
                      );
                      setState(() {
                        isLoading = false;
                      });
                    } else {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        await authProvider.login(
                          _emailController.text,
                          _passwordController.text,
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
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Login gagal: ${e.toString()}'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 13),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
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
                        'Masuk',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: whiteTextColor,
                          fontWeight: semibold,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Row(
                    children: [
                      Text(
                        "Don't have an account?",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: darkGrayColor,
                          fontWeight: medium,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterPage(),
                              ));
                        },
                        child: Text(
                          " Sign Up",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: medium,
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
