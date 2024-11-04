import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_beresin/common/theme.dart';
import 'package:mobile_beresin/pages/widgets/carousel_widget.dart';
import 'package:mobile_beresin/pages/widgets/tombol_layanan.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({super.key});

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          SliverAppBar(
            expandedHeight: 140,
            pinned: true,
            backgroundColor: primaryColor,
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "Search all collection or users",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: secondaryTextColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Icon(
                  Icons.bookmark_border_rounded,
                  color: Colors.white,
                  size: 24,
                ),
                const SizedBox(width: 12),
                const Icon(
                  Icons.person_outline,
                  color: Colors.white,
                  size: 24,
                ),
              ],
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.fromLTRB(16, 60, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 60),
                    Text(
                      'Hai Muhammad Daniel Krisna Halim',
                      style: GoogleFonts.poppins(
                        color: primaryTextColor,
                        fontWeight: bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Selamat Datang di Baresin, Sewa Cepat Tanpa Ribet!',
                      style: GoogleFonts.poppins(
                        color: primaryTextColor,
                        fontWeight: regular,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: CarouselWidget(),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: Text(
                    "Kategori",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: primaryColor,
                      fontWeight: bold,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TombolLayanan(
                        svgIconPath: 'assets/svg/hard_disk.svg',
                        bgIconColor: categoryColor1,
                        text: 'Elektronik',
                        onTap: () {
                          // Navigator.push(context, halamanAmbilAntrian());
                        },
                      ),
                      const SizedBox(width: 30),
                      TombolLayanan(
                        svgIconPath: 'assets/svg/chair.svg',
                        bgIconColor: categoryColor2,
                        text: 'Rumah',
                        onTap: () {
                          // Navigator.push(context, halamanAmbilAntrian());
                        },
                      ),
                      const SizedBox(width: 30),
                      TombolLayanan(
                        svgIconPath: 'assets/svg/menu_grid_view.svg',
                        bgIconColor: categoryColor3,
                        text: 'Lainnya',
                        onTap: () {
                          // Navigator.push(context, halamanAmbilAntrian());
                        },
                      ),
                    ],
                  ),
                ),
                // Tambahkan konten di sini
              ],
            ),
          ),
        ],
      ),
    );
  }
}
