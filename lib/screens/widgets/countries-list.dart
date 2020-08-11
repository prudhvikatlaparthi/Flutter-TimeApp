import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeapp/model/time.dart';

class CountriesList extends StatelessWidget {
  Time value;
  Function showMyBottomSheet;
  CountriesList({Key key, this.value, this.showMyBottomSheet})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (value.isListLoading)
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
                            color: value.isDay
                                ? Color(0XFF142F38)
                                : Colors.white)),
                  ],
                ),
              ),
            ]),
        onPressed: showMyBottomSheet);
  }
}
