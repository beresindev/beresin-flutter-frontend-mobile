import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_beresin/common/theme.dart';
import 'package:mobile_beresin/common/token_manager.dart';
import 'package:mobile_beresin/presentation/pages/auth/login_page.dart';
import 'package:mobile_beresin/presentation/widgets/bottom_navbar.dart';
import 'package:mobile_beresin/providers/auth_provider.dart';
import 'package:mobile_beresin/providers/service_provider.dart';
import 'package:provider/provider.dart';
// import 'package:testgetdata/views/tenant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final tokenManager = TokenManager();
  late AuthProvider authProvider =
      Provider.of<AuthProvider>(context, listen: false);
  late ServiceProvider serviceProvider =
      Provider.of<ServiceProvider>(context, listen: false);

  Future authCheck() async {
    debugPrint("MASUK TOKEN AUTH");
    await Future.delayed(const Duration(seconds: 3));

    final token =
        await tokenManager.getToken(); // Ambil token dari Shared Preferences

    if (token != null) {
      debugPrint("TOKEN TERSEDIA");
      final success = await authProvider.getProfile(
          token: token,
          errorCallback: (error) {
            log("isoooo");
          });
      if (success) {
        await serviceProvider.getCategories();
        await serviceProvider.getDraftServices();
        debugPrint("SUKSES MASUK, TOKEN TERSEDIA");
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const BottomNavBar(),
            ));
      } else {
        debugPrint("GAISOK MASUK, TOKEN TIDAK TERSEDIA");
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ));
      }
    } else {
      debugPrint("NULL");
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    authCheck();
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/splashscreen.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: SvgPicture.asset(
              'assets/svg/logo_jempol.svg',
              fit: BoxFit.none,
            ),
          ),
          Positioned(
            // top: 200.0,
            left: 15.0,
            right: 15.0,
            bottom: 10,
            child: SvgPicture.asset(
              'assets/svg/text_logo_beresin.svg',
              height: 60,
              width: 60,
              fit: BoxFit.none,
            ),
          ),
        ],
      ),
    );
  }
}
