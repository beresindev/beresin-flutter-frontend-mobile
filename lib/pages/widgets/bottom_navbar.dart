import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_beresin/common/theme.dart';
import 'package:mobile_beresin/pages/beranda.dart';
import 'package:mobile_beresin/pages/produk_page.dart';

class BottomNavBar extends StatefulWidget {
  final int initialIndex;

  const BottomNavBar({super.key, this.initialIndex = 0});

  @override
  // ignore: library_private_types_in_public_api
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  Widget body() {
    switch (currentIndex) {
      case 0:
        return const BerandaPage();
      case 1:
        return const ProdukPage();
      case 2:
        return const BerandaPage();
      case 3:
        return const BerandaPage();
      default:
        return const BerandaPage();
    }
  }

  Widget customBottomNav() {
    return Container(
      height: 65,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 0.3,
            color: alternativeBlackColor,
          ),
        ),
      ),
      child: ClipRRect(
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 0,
          currentIndex: currentIndex,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: selectedIconColor,
          unselectedItemColor: unselectedIconColor,
          selectedLabelStyle: TextStyle(
            fontSize: 11,
            color: selectedIconColor,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 11,
            color: unselectedIconColor,
          ),
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                currentIndex == 0
                    ? 'assets/svg/home_tebal.svg'
                    : 'assets/svg/home.svg',
                width: 24,
                height: 24,
                fit: BoxFit.none,
              ),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                currentIndex == 1
                    ? 'assets/svg/product_tebal.svg'
                    : 'assets/svg/product.svg',
                width: 24,
                height: 24,
                fit: BoxFit.none,
              ),
              label: 'Produk',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                currentIndex == 2
                    ? 'assets/svg/plus_square_tebal.svg'
                    : 'assets/svg/plus_square.svg',
                width: 24,
                height: 24,
                fit: BoxFit.none,
              ),
              label: 'Unggah',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                currentIndex == 3
                    ? 'assets/svg/kelola_tebal.svg'
                    : 'assets/svg/kelola.svg',
                width: 24,
                height: 24,
                fit: BoxFit.none,
              ),
              label: 'Kelola',
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(), // Menampilkan konten berdasarkan currentIndex
      bottomNavigationBar: customBottomNav(), // Custom bottom navigation bar
    );
  }
}
