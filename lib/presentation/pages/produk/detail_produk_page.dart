import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_beresin/common/theme.dart';
import 'package:mobile_beresin/models/category_model.dart';
import 'package:mobile_beresin/models/service_model.dart';
import 'package:mobile_beresin/providers/service_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailProdukPage extends StatefulWidget {
  final ServiceModel item;
  const DetailProdukPage({super.key, required this.item});

  @override
  State<DetailProdukPage> createState() => _DetailProdukPageState();
}

class _DetailProdukPageState extends State<DetailProdukPage> {
  List<String> imagePaths = [];
  late CategoryModel category;

  Future<void> openWhatsappChat() async {
    final Uri whatsappUrl = Uri.parse('https://wa.me/${widget.item.phone}');

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

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    for (String image in widget.item.images) {
      imagePaths.add('http://178.128.21.130:3000/$image');
    }
    ServiceProvider serviceProvider =
        Provider.of<ServiceProvider>(context, listen: false);

    category = serviceProvider.categories.where(
      (e) {
        return e.id == widget.item.categoryId;
      },
    ).first;
  }

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
                        Icons.arrow_back_sharp,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    // const Icon(
                    //   Icons.bookmark_border_rounded,
                    //   color: Colors.white,
                    //   size: 24,
                    // ),
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
                              Image.network(
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
                            category.nameOfCategory,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: primaryColor,
                              fontWeight: semibold,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            widget.item.nameOfService,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: alternativeBlackTextColor,
                              fontWeight: semibold,
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
                          const SizedBox(height: 10),
                          Text(
                            widget.item.description,
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
              child: GestureDetector(
                onTap: () {},
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
          ),
        ],
      ),
    );
  }
}
