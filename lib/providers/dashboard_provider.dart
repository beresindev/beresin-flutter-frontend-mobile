import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_beresin/presentation/pages/main/beranda.dart';
import 'package:mobile_beresin/presentation/pages/main/produk_page.dart';
import 'package:mobile_beresin/presentation/pages/main/unggah_page.dart';

class DashboardProvider with ChangeNotifier {
  int _currentIndex = 0;

  List dashboardMenu = [
    [
      'Beranda',
      'assets/svg/home.svg',
      'assets/svg/home_tebal.svg',
      const BerandaPage(),
    ],
    [
      'Produk',
      'assets/svg/product.svg',
      'assets/svg/product_tebal.svg',
      const ProdukPage(),
    ],
    [
      'Unggah',
      'assets/svg/plus_square.svg',
      'assets/svg/plus_square_blue.svg',
      const UnggahPage(),
    ],
  ];

  int get currentIndex => _currentIndex;

  List<Widget> get pages =>
      dashboardMenu.map((item) => item[3] as Widget).toList();

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
