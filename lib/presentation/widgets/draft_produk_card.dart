import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_beresin/common/date_format.dart';
import 'package:mobile_beresin/common/helper.dart';
import 'package:mobile_beresin/common/theme.dart';
import 'package:mobile_beresin/constants/api_constants.dart';
import 'package:mobile_beresin/models/service_model.dart';
import 'package:mobile_beresin/providers/service_provider.dart';
import 'package:provider/provider.dart';

class DraftProdukCard extends StatelessWidget {
  final ServiceModel item;
  const DraftProdukCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    ServiceProvider serviceProvider =
        Provider.of<ServiceProvider>(context, listen: false);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: secondaryTextColor,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                FormatDate.formatDateTime(item.createdAt),
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  color: alternativeBlackColor,
                  fontSize: 10,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                Helper.capitalize(item.status),
                style: GoogleFonts.poppins(
                  color: Helper.getColorStatus(item.status),
                  fontSize: 12,
                  fontWeight: semibold,
                ),
              ),
            ],
          ),
          Divider(
            color: secondaryTextColor,
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      serviceProvider.getCategoryName(item.categoryId),
                      style: GoogleFonts.poppins(
                        color: alternativeBlackColor,
                        fontSize: 10,
                        fontWeight: semibold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      item.nameOfService,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        color: alternativeBlackColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: secondaryTextColor,
                  image: DecorationImage(
                    image: NetworkImage(
                      '${ApiConstants.baseUrlImage}${item.images.first}',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
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
    );
  }
}
