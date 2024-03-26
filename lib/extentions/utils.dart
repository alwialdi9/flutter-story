import 'package:intl/intl.dart';

String formatStringDate(String dateString, String outputFormat) {
  try {
    DateTime dateTime = DateTime.parse(dateString);

    return DateFormat(outputFormat).format(dateTime);
  } catch (e) {
    return dateString;
  }
}
