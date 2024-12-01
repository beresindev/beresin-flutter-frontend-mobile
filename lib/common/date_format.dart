import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:timezone/standalone.dart' as tz;

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
    final DateFormat formatter = DateFormat('dd MMMM yyyy, HH:mm', 'id_ID');
    String formatted = formatter.format(dateTime);

    return formatted;
  }

  static String formatDateTimeJakarta(DateTime dateTime) {
    // Konversi waktu ke Asia/Jakarta
    final jakarta = tz.getLocation('Asia/Jakarta');
    final jakartaTime = tz.TZDateTime.from(dateTime, jakarta);

    // Format waktu
    final DateFormat formatter = DateFormat('dd MMMM yyyy, HH:mm', 'id_ID');
    String formatted = formatter.format(jakartaTime);

    return formatted;
  }
}
