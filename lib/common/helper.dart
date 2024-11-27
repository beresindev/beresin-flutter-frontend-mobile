import 'dart:ui';

import 'package:mobile_beresin/common/theme.dart';

class Helper {
  static Color getColorStatus(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return pendingColor;
      case 'accept':
        return approveColor;
      case 'decline':
        return rejectedColor;
      default:
        return greyTextColor; // Default color jika status tidak dikenali
    }
  }

  static String capitalize(String? text) {
    if (text == null || text.isEmpty) {
      return '';
    }
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }
}
