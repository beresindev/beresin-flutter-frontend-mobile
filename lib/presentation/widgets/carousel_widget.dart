import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselWidget extends StatefulWidget {
  @override
  _CarouselWidgetState createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  int _currentIndex = 0;

  // Daftar item gambar
  final List<String> imageList = [
    'assets/images/big_sale_benner.jpg',
    'assets/images/big_sale_benner.jpg',
    'assets/images/big_sale_benner.jpg',
    'assets/images/big_sale_benner.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 0,
      ),
      child: Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height * 0.18,
              enableInfiniteScroll: true,
              autoPlay: true,
              viewportFraction: 0.93, // Menambahkan jarak antar gambar
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            items: imageList.map((imagePath) {
              return buildImageContainer(imagePath);
            }).toList(),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(imageList.length, (index) {
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 3.0,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index
                        ? const Color.fromRGBO(255, 255, 255, 0.9)
                        : const Color.fromRGBO(255, 255, 255, 0.4),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildImageContainer(String imagePath) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 3,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      ),
    );
  }
}
