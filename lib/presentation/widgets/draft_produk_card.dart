import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_beresin/common/date_format.dart';
import 'package:mobile_beresin/common/helper.dart';
import 'package:mobile_beresin/common/theme.dart';
import 'package:mobile_beresin/constants/api_constants.dart';
import 'package:mobile_beresin/models/service_model.dart';
import 'package:mobile_beresin/presentation/pages/unggah/boost_service_page.dart';
import 'package:mobile_beresin/presentation/pages/unggah/detail_draft_service_page.dart';

class DraftProdukCard extends StatelessWidget {
  final ServiceModel item;
  const DraftProdukCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    Route halamanDetailProduk() {
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            DetailDraftServicePage(
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

    Route halamanBoostService() {
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            BoostServicePage(
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

    // ServiceProvider serviceProvider =
    //     Provider.of<ServiceProvider>(context, listen: false);

    return GestureDetector(
      onTap: () {
        Navigator.push(context, halamanDetailProduk());
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: alternativeBackgroundColor,
          // border: Border.all(
          //   width: 1.0,
          //   color: greyTextColor,
          // ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    color: greyTextColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                    // image: DecorationImage(
                    //   image: NetworkImage(
                    //     '${ApiConstants.baseUrlImage}${item.images.first}',
                    //   ),
                    //   fit: BoxFit.cover,
                    // ),
                    image: DecorationImage(
                      image: item.images.isNotEmpty
                          ? NetworkImage(
                              '${ApiConstants.baseUrlImage}${item.images.first}')
                          : const AssetImage('assets/images/no_image.webp')
                              as ImageProvider, // Gunakan as ImageProvider
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.40,
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: backgroundColor,
                  )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.nameOfService,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          color: alternativeBlackColor,
                          fontSize: 14,
                          fontWeight: semibold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        Helper.capitalize(item.status),
                        style: GoogleFonts.poppins(
                          color: Helper.getColorStatus(item.status),
                          fontSize: 12,
                          fontWeight: medium,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        FormatDate.formatDateTime(item.createdAt),
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          color: darkGrayColor,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                if (item.status == 'accept')
                  IconButton(
                    onPressed: () {
                      Navigator.push(context, halamanBoostService());
                    },
                    icon: Icon(
                      Icons.rocket_launch_outlined,
                      color: primaryColor,
                      size: 24.0,
                    ),
                  ),
                const SizedBox(
                  width: 5,
                ),
                const Icon(
                  Icons.more_vert_outlined,
                  size: 24.0,
                ),
              ],
            ),
            // const SizedBox(
            //   height: 5,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       'Pending',
            //       style: GoogleFonts.poppins(
            //         color: pendingColor,
            //         fontSize: 12,
            //         fontWeight: semibold,
            //       ),
            //     ),
            //     PrimaryButton(
            //       height: 25,
            //       width: 80,
            //       child: Text(
            //         'Edit',
            //         style: GoogleFonts.poppins(
            //           color: Colors.white,
            //           fontSize: 12,
            //           fontWeight: semibold,
            //         ),
            //       ),
            //       onPressed: () {},
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
