// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_beresin/common/theme.dart';

class SearchFilterWidget extends StatelessWidget {
  final String placeHolder;
  final void Function(String) onChanged;
  const SearchFilterWidget({
    super.key,
    required this.placeHolder,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            // selectionHeightStyle: BoxHeightStyle.tight,
            style: GoogleFonts.poppins(),
            cursorColor: primaryColor,
            onChanged: onChanged,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(),
              hintText: placeHolder,
              hintStyle: GoogleFonts.poppins(
                color: secondaryTextColor,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(8.0),
                ),
                borderSide: BorderSide(
                  color: secondaryTextColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(8.0),
                ),
                borderSide: BorderSide(
                  color: alternativeBlackColor,
                ),
              ),
              prefixIconConstraints: const BoxConstraints(
                maxHeight: 22,
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 8),
                child: Icon(
                  Icons.search,
                  size: 24,
                  color: alternativeBlackColor,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
