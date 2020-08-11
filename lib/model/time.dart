import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Time extends ChangeNotifier {
  String _timeT;
  bool _isLoading = true;
  bool _isListLoading = false;
  List _zonesList = [];
  bool _isDay = true;
  String _selectedLocation = 'Asia/Kolkata';
  int _selectedLocationIndex = 197;
  DateTime _dateTime;

  Time();

  DateTime get dateTime => _dateTime;

  set dateTime(DateTime _dateTime) {
    this._dateTime = _dateTime;
  }

  String get time => _timeT;

  set time(String timeT) {
    this._timeT = timeT;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  set isLoading(bool isLoading) {
    this._isLoading = isLoading;
    notifyListeners();
  }

  bool get isListLoading => _isListLoading;

  set isListLoading(bool isListLoading) {
    this._isListLoading = isListLoading;
    notifyListeners();
  }

  List get zonesList => _zonesList;

  set zonesList(List zonesList) {
    this._zonesList = zonesList;
  }

  bool get isDay => _isDay;

  set isDay(bool isDay) {
    this._isDay = isDay;
  }

  String get selectedLocation => _selectedLocation;

  set selectedLocation(String selectedLocation) {
    this._selectedLocation = selectedLocation;
  }

  int get selectedLocationIndex => _selectedLocationIndex;

  set selectedLocationIndex(int selectedLocationIndex) {
    this._selectedLocationIndex = selectedLocationIndex;
  }

  void notify() {
    notifyListeners();
  }

  Time fromJson(Map<String, dynamic> json) {
    String datetime = json['datetime'];
    String offset_Hours = json['utc_offset'].substring(1, 3);
    String offset_Minutes = json['utc_offset'].substring(4, 6);
    // create DateTime object
    DateTime now = DateTime.parse(datetime);
    now = now.add(Duration(
        hours: int.parse(offset_Hours), minutes: int.parse(offset_Minutes)));
    Time ti = Time();
    ti.dateTime = now;
    ti.time = DateFormat.jm().format(now);
    ti.isDay = now.hour > 6 && now.hour < 18;
    return ti;
  }
}
