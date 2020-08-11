import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeapp/model/time.dart';

class TimeView extends StatefulWidget {
  const TimeView({
    Key key,
    @required this.value,
  }) : super(key: key);

  final Time value;

  @override
  _TimeViewState createState() => _TimeViewState();
}

class _TimeViewState extends State<TimeView> {
  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.value.time != null) {
      widget.value.dateTime = widget.value.dateTime.add(Duration(seconds: 1));
    }
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if (widget.value.isLoading)
            SpinKitFadingCube(
              color: Colors.white,
              size: 20.0,
            ),
          SizedBox(
            width: 20,
          ),
          Text(
            widget.value.time == null
                ? "Loading"
                : DateFormat.jm().format(widget.value.dateTime),
            style: widget.value.time == null
                ? GoogleFonts.roboto(
                    letterSpacing: 2,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: widget.value.isDay ? Colors.black : Colors.white)
                : TextStyle(
                    fontFamily: 'itc',
                    letterSpacing: 2,
                    fontSize: 50,
                    color: widget.value.isDay ? Colors.black : Colors.white),
          ),
        ],
      ),
    );
  }
}
