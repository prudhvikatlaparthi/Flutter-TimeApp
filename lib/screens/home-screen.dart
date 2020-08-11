import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timeapp/model/time.dart';
import 'package:timeapp/networking/http-networking.dart';
import 'package:timeapp/screens/widgets/bottom-sheet.dart';
import 'package:timeapp/screens/widgets/clock.dart';
import 'package:timeapp/screens/widgets/countries-list.dart';
import 'package:timeapp/screens/widgets/my-appbar.dart';
import 'package:timeapp/screens/widgets/time-view.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

void showInSnackBar(String value) {
  _scaffoldKey.currentState
      .showSnackBar(new SnackBar(content: new Text(value)));
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Time value;
  Future<Function> setupWorldTime() async {
    if (value != null) {
      value.time = null;
      value.isLoading = true;
    }
    HttpCalls instance =
        HttpCalls(url: value == null ? 'Asia/Kolkata' : value.selectedLocation);
    Time t = await instance.doCallTime();
    if (t != null && t.time != null) {
      value.time = t.time;
      value.isLoading = false;
      value.isDay = t.isDay;
      value.dateTime = t.dateTime;
    } else {
      showInSnackBar("Error try again later");
      value.time = '0.00';
      value.dateTime = DateTime.now();
      value.isDay = true;
      value.isLoading = false;
    }
  }

  Future<List> getZones() async {
    HttpCalls instance = HttpCalls();
    List data = await instance.getZones();
    if (data != null && data.length > 0) {
      return data;
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  // Function fetchData() {
  //   setupWorldTime();
  // }

  Function showMyBottomSheet() {
    _settingModalBottomSheet(value, context);
  }

  @override
  Widget build(BuildContext context) {
    value = Provider.of<Time>(context);
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: MyAppBar(
              value: value,
              fetchData: setupWorldTime,
            ),
            extendBodyBehindAppBar: true,
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: value.isDay
                      ? AssetImage('images/day.jpg')
                      : AssetImage('images/night.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CountriesList(
                        value: value, showMyBottomSheet: showMyBottomSheet),
                    if (value.selectedLocation != null)
                      Text(
                        value.selectedLocation,
                        style: GoogleFonts.ubuntu(
                            fontWeight: FontWeight.w800,
                            fontSize: 30,
                            color: Colors.white),
                      ),
                    ClockView(
                      dateTime: value.dateTime != null
                          ? value.dateTime
                          : DateTime.now(),
                    ),
                    TimeView(value: value),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _settingModalBottomSheet(value, context) async {
    if (value.zonesList == null || value.zonesList.length == 0) {
      value.isListLoading = true;
      value.zonesList = await getZones();
      value.isListLoading = false;
    }
    if (value.zonesList == null || value.zonesList.length == 0) {
      showInSnackBar("Error try again later.");
      return;
    }
    value.zonesList.remove(value.selectedLocation);
    value.zonesList.insert(0, value.selectedLocation);
    value.selectedLocationIndex = 0;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext cc) => MyBottomSheetView(
              value: value,
              fetchData: setupWorldTime,
            ));
  }
}
