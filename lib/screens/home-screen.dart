import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeapp/networking/http-networking.dart';

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
  String timeT;
  bool isLoading = true;
  bool isListLoading = false;
  List zonesList = [];
  bool isDay = true;
  String selectedLocation = 'Asia/Kolkata';
  int selectedLocationIndex = 197;
  void setupWorldTime() async {
    setState(() {
      timeT = null;
      isLoading = true;
    });
    HttpCalls instance = HttpCalls(location: '', url: selectedLocation);
    dynamic t = await instance.doCallTime();
    if (t != null && t.time != null) {
      setState(() {
        isLoading = false;
        timeT = t.time;
        isDay = t.isDaytime;
      });
    } else {
      showInSnackBar("Error try again later");
      setState(() {
        isLoading = false;
        timeT = '0.00';
        isDay = true;
      });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                centerTitle: true,
                title: Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text('Time App',
                      style: GoogleFonts.roboto(
                        color: isDay ? Color(0XFF142F38) : Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      )),
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () {
                      setupWorldTime();
                    },
                    iconSize: 30,
                  ),
                ],
              ),
              extendBodyBehindAppBar: true,
              body: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: isDay
                        ? AssetImage('images/day.jpg')
                        : AssetImage('images/night.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CupertinoButton(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                if (isListLoading)
                                  SpinKitFadingCube(
                                    color: Colors.white,
                                    size: 20.0,
                                  ),
                                SizedBox(
                                  width: 20,
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: 'Tap',
                                    style: GoogleFonts.roboto(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: ' to change Location',
                                          style: GoogleFonts.roboto(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                              color: isDay
                                                  ? Color(0XFF142F38)
                                                  : Colors.white)),
                                    ],
                                  ),
                                ),
                              ]),
                          onPressed: () {
                            _settingModalBottomSheet(context);
                          }),
                      if (selectedLocation != null)
                        Text(
                          selectedLocation,
                          style: GoogleFonts.ubuntu(
                              fontWeight: FontWeight.w800,
                              fontSize: 30,
                              color: Colors.white),
                        ),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            if (isLoading)
                              SpinKitFadingCube(
                                color: Colors.white,
                                size: 20.0,
                              ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              timeT == null ? "Loading" : timeT,
                              style: timeT == null
                                  ? GoogleFonts.roboto(
                                      letterSpacing: 2,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          isDay ? Colors.black : Colors.white)
                                  : TextStyle(
                                      fontFamily: 'itc',
                                      letterSpacing: 2,
                                      fontSize: 50,
                                      color:
                                          isDay ? Colors.black : Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }

  void _settingModalBottomSheet(context) async {
    if (zonesList == null || zonesList.length == 0) {
      setState(() {
        isListLoading = true;
      });
      zonesList = await getZones();
      setState(() {
        isListLoading = false;
      });
    }
    if (zonesList == null || zonesList.length == 0) {
      showInSnackBar("Error try again later.");
      return;
    }
    // selectedLocation = zonesList[index];
    zonesList.remove(selectedLocation);
    zonesList.insert(0, selectedLocation);
    selectedLocationIndex = 0;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext cc) => Container(
              color: Colors.blue[50],
              child: Scrollbar(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: zonesList.length,
                  itemBuilder: (context, index) => Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Card(
                          child: ListTile(
                            leading: IconButton(
                              icon: Icon(Icons.done),
                              onPressed: () {
                                itemClickListener(index);
                              },
                              color: selectedLocationIndex == index
                                  ? Colors.black
                                  : Colors.black38,
                            ),
                            title: Text(zonesList[index],
                                style: GoogleFonts.roboto(
                                  color: selectedLocationIndex == index
                                      ? Colors.black
                                      : Colors.black38,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                            onTap: () {
                              itemClickListener(index);
                            },
                          ),
                        ),
                      ),
                      // Divider(),
                    ],
                  ),
                ),
              ),
            ));
  }

  void itemClickListener(int index) {
    Navigator.pop(context);
    selectedLocationIndex = index;
    selectedLocation = zonesList[index];
    setupWorldTime();
  }
}
