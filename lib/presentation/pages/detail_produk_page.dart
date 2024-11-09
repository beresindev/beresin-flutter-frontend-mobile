import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_beresin/common/theme.dart';

class DetailProdukPage extends StatefulWidget {
  const DetailProdukPage({super.key});

  @override
  State<DetailProdukPage> createState() => _DetailProdukPageState();
}

class _DetailProdukPageState extends State<DetailProdukPage> {
  final List<String> imagePaths = [
    'assets/images/jasa_pengurusan_K3.jpg',
    'assets/images/big_sale_benner.jpg',
    'assets/images/jasa_pengurusan_K3.jpg',
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          CustomScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              SliverAppBar(
                expandedHeight: 300,
                pinned: true,
                backgroundColor: primaryColor,
                automaticallyImplyLeading: false,
                elevation: 0,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.keyboard_backspace,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const Icon(
                      Icons.bookmark_border_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ],
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      PageView.builder(
                        itemCount: imagePaths.length,
                        onPageChanged: (index) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.asset(
                                imagePaths[index],
                                fit: BoxFit.cover,
                              ),
                              Container(
                                color: Colors.black.withOpacity(0.3),
                              ),
                            ],
                          );
                        },
                      ),
                      Positioned(
                        bottom: 10,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(imagePaths.length, (index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: currentIndex == index ? 10 : 6,
                              height: currentIndex == index ? 10 : 6,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: currentIndex == index
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.5),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 25),
                      decoration: BoxDecoration(
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Jasa Desain Web dan Aplikasi",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: alternativeBlackTextColor,
                              fontWeight: semibold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Rp.2.000.000 - Rp.4.000.000",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: alternativeBlackTextColor,
                              fontWeight: regular,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Deskripsi",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: alternativeBlackTextColor,
                              fontWeight: semibold,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            "Kami menawarkan layanan desain web dan aplikasi yang modern, responsif, dan berfokus pada pengalaman pengguna (UX) serta antarmuka (UI) yang menarik.\n\n"
                            "Layanan Utama:\n\n"
                            "1. Desain Website: Website responsif yang optimal di berbagai perangkat, didukung navigasi yang intuitif dan visual menarik sesuai identitas merek Anda.\n"
                            "2. Desain Aplikasi Mobile: Desain aplikasi untuk Android dan iOS yang user-friendly dan fungsional, lengkap dengan prototipe interaktif untuk pengalaman nyata sebelum peluncuran.\n"
                            "3. Desain Custom & Branding: Desain sesuai branding bisnis Anda dengan estetika modern dan SEO-friendly untuk membantu peningkatan visibilitas online.\n\n"
                            "Dengan fokus pada kualitas, kami siap membantu menciptakan solusi digital yang profesional dan efektif untuk mendukung bisnis Anda di era digital.",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: alternativeBlackTextColor,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 105,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.only(
                  top: 15, bottom: 25, right: 20, left: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Chat Lewat WA?',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: primaryTextColor,
                        fontWeight: semibold,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Icon(
                      Icons.whatshot,
                      color: primaryTextColor,
                      size: 24.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
