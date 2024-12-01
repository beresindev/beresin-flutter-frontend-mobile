import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_beresin/common/currency_format.dart';
import 'package:mobile_beresin/common/theme.dart';
import 'package:mobile_beresin/models/service_model.dart';
import 'package:mobile_beresin/presentation/pages/produk/detail_produk_page.dart';

class ServiceCard extends StatelessWidget {
  final ServiceModel item;
  const ServiceCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    Route halamanDetailProduk() {
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            DetailProdukPage(
          item: item,
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

    return GestureDetector(
      onTap: () {
        Navigator.push(context, halamanDetailProduk());
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
              decoration: BoxDecoration(
                color: unselectedIconColor,
                image: DecorationImage(
                  image: NetworkImage(
                    'http://178.128.21.130:3000/${item.images[0]}',
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 5, right: 5, top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.nameOfService,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: blackTextColor,
                      fontWeight: medium,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 5),
                  // Text(
                  //   item.description,
                  //   maxLines: 2,
                  //   overflow: TextOverflow.ellipsis,
                  //   style: GoogleFonts.poppins(
                  //     fontSize: 10,
                  //     color: primaryColor,
                  //     fontWeight: regular,
                  //   ),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        FormatCurrency.intToStringCurrency(item.minPrice),
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: medium,
                        ),
                      ),
                      Text(
                        ' - ',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: medium,
                        ),
                      ),
                      Text(
                        FormatCurrency.intToStringCurrency(item.maxPrice),
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: medium,
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
    );
  }
}
