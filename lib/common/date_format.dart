import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class FormatDate {
  static Future<void> initialize() async {
    // Inisialisasi locale 'id_ID' untuk formatting
    await initializeDateFormatting('id_ID', null);
  }

  static String dateTimeToStringDate(DateTime date) {
    final format = DateFormat('EEEE, dd MMMM yyyy', 'id_ID');
    return format.format(date);
  }

  static String formatDateTime(DateTime dateTime) {
    final DateFormat formatter =
        DateFormat('EEEE, dd MMMM yyyy HH:mm', 'id_ID');
    String formatted = formatter.format(dateTime);

    return formatted;
  }
}
