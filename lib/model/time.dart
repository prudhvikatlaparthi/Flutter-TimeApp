import 'package:intl/intl.dart';

class Time {
  String location; // location name for UI
  String time; // the time in that location
  String flag; // url to an asset flag icon
  String url; // location url for api endpoint
  bool isDaytime;
  bool isError;

  Time(
      {this.location,
      this.time,
      this.flag,
      this.url,
      this.isDaytime,
      this.isError});

  factory Time.fromJson(Map<String, dynamic> json) {
    String datetime = json['datetime'];
    String offset_Hours = json['utc_offset'].substring(1, 3);
    String offset_Minutes = json['utc_offset'].substring(4, 6);
    // create DateTime object
    DateTime now = DateTime.parse(datetime);
    print('now $now');
    print('offset H $offset_Hours');
    print('offset M $offset_Minutes');
    now = now.add(Duration(hours: int.parse(offset_Hours), minutes: int.parse(offset_Minutes)));
    return Time(
        isError: false,
        time: DateFormat.jm().format(now),
        isDaytime: now.hour > 6 && now.hour < 18);
  }
}
