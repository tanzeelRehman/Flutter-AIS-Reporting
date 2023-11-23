import 'package:intl/intl.dart';

String getFormatedTime(String time) {
  DateTime lastSeen = DateTime.parse(time);
  return DateFormat("hh:mm, dd yyyy").format(lastSeen);
}

String lastSeen(String time) {
  DateTime data = DateTime.parse(time);
  print(time);
  DateTime currentDate = DateTime.now();
  if (currentDate.year != data.year) {
    return DateFormat("dd/mm/yyyy").format(data);
  } else if (currentDate.day - 1 == data.day) {
    return "yesterday";
  } else if (currentDate.day != data.day) {
    return DateFormat("dd MMM").format(data);
  } else {
    return DateFormat("hh:mm a").format(data);
  }
}
