import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

String formatStringDate(String dateString, String outputFormat) {
  initializeDateFormatting();
  try {
    DateTime dateTime = DateTime.parse(dateString);

    return DateFormat(outputFormat, '${Get.locale}').format(dateTime);
  } catch (e) {
    return dateString;
  }
}
