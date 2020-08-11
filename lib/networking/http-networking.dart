import 'dart:convert';

import 'package:http/http.dart';
import 'package:timeapp/model/time.dart';

class HttpCalls {
  String url;
  Time time;
  final String mainUrl = 'http://worldtimeapi.org/api/timezone/';

  HttpCalls({this.url});

  Future doCallTime() async {
    try {
      Response response = await get(mainUrl + url);
      if (response.statusCode == 200) {
        time = Time();
        return time.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<List> getZones() async {
    try {
      Response response = await get(mainUrl);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
