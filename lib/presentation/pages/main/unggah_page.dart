import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_beresin/common/animate_route.dart';
import 'package:mobile_beresin/common/theme.dart';
import 'package:mobile_beresin/presentation/pages/unggah/unggah_produk_page.dart';
import 'package:mobile_beresin/presentation/pages/unggah/draft_produk_page.dart';
import 'package:mobile_beresin/presentation/widgets/primary_button.dart';
import 'package:mobile_beresin/providers/service_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class UnggahPage extends StatefulWidget {
  const UnggahPage({super.key});

  @override
  State<UnggahPage> createState() => _UnggahPageState();
}

class _UnggahPageState extends State<UnggahPage> {
  Future<void> openWhatsappChat() async {
    final Uri whatsappUrl = Uri.parse('https://wa.me/6287709999050');

    if (await canLaunchUrl(whatsappUrl)) {
      // Buka aplikasi WhatsApp jika terinstal
      await launchUrl(
        whatsappUrl,
        mode: LaunchMode.externalApplication,
      );
    } else {
      Fluttertoast.showToast(msg: 'Terjadi kesalahan, coba lagi beberapa saat');
    }
  }

  Route halamanDetailUnggahProduk() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const UnggahProdukPage(),
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
            backgroundColor: backgroundColor,
            automaticallyImplyLeading: false,
            elevation: 0,
            scrolledUnderElevation: 0,
            title: Text(
              'Unggah',
              style: GoogleFonts.poppins(
                color: alternativeBlackTextColor,
                fontWeight: bold,
                fontSize: 24,
              ),
            ),
          ),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, halamanDetailUnggahProduk());
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Jual produk kamu disini!',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: alternativeWhiteTextColor,
                                fontWeight: semibold,
                              ),
                            ),
                            Text(
                              'Proses mudah dan nyaman',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: alternativeWhiteTextColor,
                                fontWeight: regular,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: categoryColor1,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(25),
                            ),
                          ),
                          child: SvgPicture.asset(
                            'assets/svg/upload.svg',
                            height: 30,
                            width: 30,
                            fit: BoxFit.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                PrimaryButton(
                  color: alternativeBackgroundColor,
                  borderColor: alternativeBlackColor,
                  height: 60,
                  onPressed: openWhatsappChat,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Admin BeresIn',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: primaryColor,
                          fontWeight: semibold,
                        ),
                      ),
                      Image.asset(
                        'assets/images/whatsapp.png',
                        height: 28,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                PrimaryButton(
                  color: alternativeBackgroundColor,
                  borderColor: alternativeBlackColor,
                  height: 80,
                  onPressed: () {
                    Navigator.push(
                        context, AnimateRoute.toPage(const DraftProdukPage()));
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.developer_board,
                        size: 30,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Draft Produk',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: primaryColor,
                              fontWeight: semibold,
                            ),
                          ),
                          Text(
                            '${context.watch<ServiceProvider>().getOnReviewProduct()} Produk dalam review',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: unselectedIconColor,
                              fontWeight: semibold,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.navigate_next_rounded,
                        size: 24.0,
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
