import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_beresin/common/currency_format.dart';
import 'package:mobile_beresin/common/theme.dart';
import 'package:mobile_beresin/models/category_model.dart';
import 'package:mobile_beresin/models/service_model.dart';
import 'package:mobile_beresin/presentation/pages/unggah/edit_service_page.dart';
import 'package:mobile_beresin/presentation/widgets/primary_button.dart';
import 'package:mobile_beresin/providers/service_provider.dart';
import 'package:provider/provider.dart';

class DetailDraftServicePage extends StatefulWidget {
  final ServiceModel item;
  const DetailDraftServicePage({super.key, required this.item});

  @override
  State<DetailDraftServicePage> createState() => _DetailDraftServicePageState();
}

class _DetailDraftServicePageState extends State<DetailDraftServicePage> {
  List<String> imagePaths = [];
  late CategoryModel category;
  bool isServiceActive = false;
  int currentIndex = 0;

  Route halamanEditService() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => EditServicePage(
        item: widget.item,
      ),
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
                  'Lihat Daftar',
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                height: 200, // Atur tinggi carousel
                child: Stack(
                  children: [
                    PageView.builder(
                      itemCount: imagePaths.length,
                      onPageChanged: (index) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          child: Image.network(
                            imagePaths[index],
                            fit: BoxFit.cover,
                            width: double.infinity,
                            loadingBuilder: (context, child, progress) {
                              if (progress == null) return child;
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                child: Icon(
                                  Icons.broken_image,
                                  size: 50,
                                ),
                              );
                            },
                          ),
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
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: currentIndex == index
                                ? 20
                                : 6, // Panjang bullet aktif
                            height: 6, // Tinggi tetap
                            decoration: BoxDecoration(
                              color: currentIndex == index
                                  ? alternativeWhiteColor
                                  : lightGrayColor,
                              borderRadius: BorderRadius.circular(
                                  12), // Membuat bentuk oval
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.item.nameOfService,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: blackTextColor,
                      fontWeight: semibold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        FormatCurrency.intToStringCurrency(
                            widget.item.minPrice),
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: blackTextColor,
                          fontWeight: regular,
                        ),
                      ),
                      Text(
                        ' - ',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: blackTextColor,
                          fontWeight: regular,
                        ),
                      ),
                      Text(
                        FormatCurrency.intToStringCurrency(
                            widget.item.maxPrice),
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: blackTextColor,
                          fontWeight: regular,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // Button Aktifkan dan Nonaktifkan Jasa
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: isServiceActive
                      ? PrimaryButton(
                          onPressed: () {
                            setState(() {
                              isServiceActive = false;
                            });
                          },
                          width: 355,
                          child: Text(
                            'Aktifkan Jasa',
                            style: primaryTextStyle.copyWith(
                              fontSize: 14,
                              color: whiteTextColor,
                              fontWeight: semibold,
                            ),
                          ),
                        )
                      : PrimaryButton(
                          onPressed: () {
                            setState(() {
                              isServiceActive = true;
                            });
                          },
                          color: alternativeBackgroundColor,
                          borderColor: primaryColor,
                          width: 355,
                          child: Text(
                            'Nonaktifkan Jasa',
                            style: primaryTextStyle.copyWith(
                              fontSize: 14,
                              color: primaryColor,
                              fontWeight: semibold,
                            ),
                          ),
                        ),
                ),
              ),

              // Icon Button Edit, Hapus, Boost
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, halamanEditService());
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: lightGrayColor,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(25),
                              ),
                            ),
                            child: Icon(
                              Icons.edit,
                              size: 30,
                              color: alternativeBlackColor,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Edit',
                            style: primaryTextStyle.copyWith(
                              fontSize: 12,
                              color: blackTextColor,
                              fontWeight: medium,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 40),
                    Column(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: lightGrayColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(25),
                            ),
                          ),
                          child: Icon(
                            Icons.delete_outline_outlined,
                            size: 30,
                            color: alternativeBlackColor,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Hapus',
                          style: primaryTextStyle.copyWith(
                            fontSize: 12,
                            color: blackTextColor,
                            fontWeight: medium,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 40),
                    Column(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: lightGrayColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(25),
                            ),
                          ),
                          child: Icon(
                            Icons.rocket_launch_outlined,
                            size: 30,
                            color: alternativeBlackColor,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Boost',
                          style: primaryTextStyle.copyWith(
                            fontSize: 12,
                            color: blackTextColor,
                            fontWeight: medium,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Deskripsi",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: blackTextColor,
                        fontWeight: semibold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      widget.item.description,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: blackTextColor,
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
        // ],
      ),
    );
  }
}
