import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_beresin/common/currency_format.dart';
import 'package:mobile_beresin/common/theme.dart';
import 'package:mobile_beresin/models/category_model.dart';
import 'package:mobile_beresin/models/service_model.dart';
import 'package:mobile_beresin/presentation/widgets/primary_button.dart';
import 'package:mobile_beresin/providers/service_provider.dart';
import 'package:provider/provider.dart';

class DetailUnggahProdukPage extends StatefulWidget {
  final ServiceModel item;
  const DetailUnggahProdukPage({super.key, required this.item});

  @override
  State<DetailUnggahProdukPage> createState() => _DetailUnggahProdukPageState();
}

class _DetailUnggahProdukPageState extends State<DetailUnggahProdukPage> {
  List<String> imagePaths = [];
  late CategoryModel category;

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
                margin: const EdgeInsets.only(bottom: 10),
                height: 250, // Atur tinggi carousel
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
                                  child: Icon(Icons.broken_image, size: 50));
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
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: currentIndex == index ? 10 : 6,
                            height: currentIndex == index ? 10 : 6,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentIndex == index
                                  ? Colors.white
                                  : Colors.grey.withOpacity(0.5),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
              // Center(
              //   child: PrimaryButton(
              //     onPressed: () {},
              //     width: 70,
              //     height: 70,
              //     borderRadius: 35,
              //     child: const Icon(
              //       Icons.developer_board,
              //       size: 24,
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.item.nameOfService,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: alternativeBlackTextColor,
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
                          color: alternativeBlackTextColor,
                          fontWeight: regular,
                        ),
                      ),
                      Text(
                        ' - ',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: alternativeBlackTextColor,
                          fontWeight: regular,
                        ),
                      ),
                      Text(
                        FormatCurrency.intToStringCurrency(
                            widget.item.maxPrice),
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: alternativeBlackTextColor,
                          fontWeight: regular,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(25),
                            ),
                          ),
                          child: const Icon(
                            Icons.edit,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Edit',
                          style: primaryTextStyle.copyWith(
                            fontSize: 12,
                            color: alternativeBlackTextColor,
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
                            color: primaryColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(25),
                            ),
                          ),
                          child: const Icon(
                            Icons.delete_outline_outlined,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Hapus',
                          style: primaryTextStyle.copyWith(
                            fontSize: 12,
                            color: alternativeBlackTextColor,
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
                            color: primaryColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(25),
                            ),
                          ),
                          child: const Icon(
                            Icons.rocket_launch_outlined,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Boost',
                          style: primaryTextStyle.copyWith(
                            fontSize: 12,
                            color: alternativeBlackTextColor,
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
                        color: alternativeBlackTextColor,
                        fontWeight: semibold,
                      ),
                    ),
                    const SizedBox(height: 15),
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
        // ],
      ),
    );
  }
}
