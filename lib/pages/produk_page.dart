import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_beresin/common/theme.dart';

class ProdukPage extends StatefulWidget {
  const ProdukPage({super.key});

  @override
  State<ProdukPage> createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  final List<Map<String, String>> products = [
    {
      "title": "Graphic Designer",
      "price": "Rp. 300.000",
      "image": 'assets/images/big_sale_benner.jpg'
    },
    {
      "title": "Web Developer",
      "price": "Rp. 450.000",
      "image": 'assets/images/big_sale_benner.jpg'
    },
    {
      "title": "Graphic Designer",
      "price": "Rp. 300.000",
      "image": 'assets/images/big_sale_benner.jpg'
    },
    {
      "title": "Web Developer",
      "price": "Rp. 450.000",
      "image": 'assets/images/big_sale_benner.jpg'
    },
    {
      "title": "Graphic Designer",
      "price": "Rp. 300.000",
      "image": 'assets/images/big_sale_benner.jpg'
    },
    {
      "title": "Web Developer",
      "price": "Rp. 450.000",
      "image": 'assets/images/big_sale_benner.jpg'
    },
    {
      "title": "Graphic Designer",
      "price": "Rp. 300.000",
      "image": 'assets/images/big_sale_benner.jpg'
    },
    {
      "title": "Web Developer",
      "price": "Rp. 450.000",
      "image": 'assets/images/big_sale_benner.jpg'
    },
    // Tambahkan produk lain di sini
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: alternativeBackgroundColor,
        automaticallyImplyLeading: false,
        title: Text(
          'Produk',
          style: GoogleFonts.poppins(
            color: alternativeTextColor,
            fontWeight: semibold,
            fontSize: 24,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          top: 15,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                      border: Border.all(color: alternativeBlackColor),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search,
                            size: 24, color: alternativeBlackColor),
                        const SizedBox(width: 10),
                        Text(
                          'Search collections or users',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: secondaryTextColor,
                            fontWeight: regular,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Icon(Icons.bookmark_border_outlined,
                    size: 24.0, color: alternativeBlackColor),
                const SizedBox(width: 10),
                Icon(Icons.person_2_outlined,
                    size: 24.0, color: alternativeBlackColor),
              ],
            ),
            const SizedBox(height: 15),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Jumlah kolom
                  mainAxisSpacing: 10, // Spasi antar baris
                  crossAxisSpacing: 10, // Spasi antar kolom
                  childAspectRatio:
                      16 / 21, // Rasio aspek agar sesuai dengan desain Anda
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return GestureDetector(
                    onTap: () {
                      // Navigator.push(context, halamanDetailProduk());
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      width: 160,
                      height: 210,
                      decoration: BoxDecoration(
                        color: alternativeBackgroundColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 150,
                            height: 115,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              child: Image.asset(
                                // 'assets/images/big_sale_benner.jpg',
                                product['image']!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                left: 5, right: 5, top: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product['title']!,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: alternativeTextColor,
                                    fontWeight: medium,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  product['price']!,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: primaryColor,
                                    fontWeight: semibold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
