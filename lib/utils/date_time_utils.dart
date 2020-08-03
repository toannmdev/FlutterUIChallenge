import 'package:intl/intl.dart';

const String PATTERN_1 = "dd/MM/yyyy";
const String PATTERN_2 = "dd/MM";
const String PATTERN_3 = "yyyy-MM-dd'T'HH:mm:ss";
const String PATTERN_4 = "h:mm a dd/MM";
const String PATTERN_5 = "yyyy-MM-dd HH:mm:ss";
const String PATTERN_6 = "dd/MM/yyyy HH:mm";
const String PATTERN_7 = "HH:mm dd/MM/yyyy";
const String PATTERN_DEFAULT = "yyyy-MM-dd";

String convertDateToString(DateTime dateTime, String pattern) {
  return DateFormat(pattern).format(dateTime);
}

DateTime convertStringToDate(String dateTime) {
  return DateTime.parse(dateTime);
}

String convertDateToStringDefault(DateTime dateTime) {
  return DateFormat(PATTERN_DEFAULT).format(dateTime);
}

String changeDateString(String date, {String pattern = PATTERN_1}) {
  date = date.replaceAll('/', '');
  date = DateFormat(pattern).format(DateTime.parse(date));
  return date;
}
