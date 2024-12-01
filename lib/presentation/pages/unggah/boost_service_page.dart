import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_beresin/common/theme.dart';
import 'package:mobile_beresin/models/service_model.dart';
import 'package:mobile_beresin/presentation/widgets/price_card_boost_listing.dart';

class BoostServicePage extends StatefulWidget {
  final ServiceModel item;
  const BoostServicePage({super.key, required this.item});

  @override
  State<BoostServicePage> createState() => _BoostServicePageState();
}

class _BoostServicePageState extends State<BoostServicePage> {
  // bool isSelected = false; // Status pilihan
  int selectedIndex = -1;
  // final List<bool> isSelectedList = [false, false, false];

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
                  'Boost Listing',
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
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: [
                // Container pilihan harga listing
                PriceCardBoostListing(
                  price: 'Rp.3.000',
                  days: '3 Day',
                  description: 'Boost untuk 3 hari',
                  isSelected: selectedIndex == 0, // Aktif jika indeks 0
                  onTap: () {
                    setState(() {
                      selectedIndex = 0; // Pilih kartu pertama
                    });
                  },
                ),
                PriceCardBoostListing(
                  price: 'Rp.5.000',
                  days: 'Daily Budget',
                  description: 'Boost untuk 5 hari',
                  isSelected: selectedIndex == 1, // Aktif jika indeks 1
                  onTap: () {
                    setState(() {
                      selectedIndex = 1; // Pilih kartu kedua
                    });
                  },
                ),
                PriceCardBoostListing(
                  price: 'Rp.10.000',
                  days: 'Weekly Budget',
                  description: 'Boost untuk 10 hari',
                  isSelected: selectedIndex == 2, // Aktif jika indeks 2
                  onTap: () {
                    setState(() {
                      selectedIndex = 2; // Pilih kartu ketiga
                    });
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: whiteBackgroundColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 0,
                        blurRadius: 2,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ringkasan Pembayaran',
                        style: primaryTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: semibold,
                          color: blackTextColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Iklan anda akan aktif selama 1 hari hingga masa tayang iklan jasa anda berakhir.',
                        style: primaryTextStyle.copyWith(
                          fontSize: 12,
                          fontWeight: regular,
                          color: blackTextColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Jumlah Total',
                                style: primaryTextStyle.copyWith(
                                  fontSize: 14,
                                  fontWeight: semibold,
                                  color: blackTextColor,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                '1 hari',
                                style: primaryTextStyle.copyWith(
                                  fontSize: 12,
                                  fontWeight: regular,
                                  color: blackTextColor,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'Rp.2.500',
                            style: primaryTextStyle.copyWith(
                              fontSize: 20,
                              fontWeight: semibold,
                              color: blackTextColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          color: whiteBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              spreadRadius: 1,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        padding:
            const EdgeInsets.only(top: 10, bottom: 20, left: 20, right: 20),
        child: ElevatedButton(
          onPressed: selectedIndex == -1
              ? null // Tombol tidak aktif jika tidak ada pilihan
              : () {
                  // Logika untuk pembelian
                  print('Membeli Boost dengan pilihan ke-${selectedIndex + 1}');
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            minimumSize: const Size(double.infinity, 50),
          ),
          child: Text(
            'Beli',
            style: primaryTextStyle.copyWith(
              color: Colors.white,
              fontWeight: semibold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
