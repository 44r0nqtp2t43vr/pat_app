import 'package:intl/intl.dart';

String twoDigits(int n) => n.toString().padLeft(2, '0');

String dateTimeToString(DateTime dateTime) {
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  return dateFormat.format(dateTime);
}

String dateTimeToFolderName(DateTime dateTime) {
  return '${dateTime.year}${twoDigits(dateTime.month)}${twoDigits(dateTime.day)}_${twoDigits(dateTime.hour)}${twoDigits(dateTime.minute)}${twoDigits(dateTime.second)}';
}

String dateTimeToFilename(DateTime dateTime) {
  DateFormat dateFormat = DateFormat("yyyyMM");
  return dateFormat.format(dateTime);
}

String stringToFilename(String dateString) {
  final list = dateString.split('-');
  return '${list[0]}${list[1]}';
}

DateTime stringToDateTime(String dateString) {
  return DateTime.parse(dateString);
}
