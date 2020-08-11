import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeapp/model/time.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  Time value;
  Function fetchData;
  MyAppBar({Key key, this.value, this.fetchData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: Padding(
        padding: EdgeInsets.only(top: 5),
        child: Text('Time App',
            style: GoogleFonts.roboto(
              color: value.isDay ? Color(0XFF142F38) : Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w600,
            )),
      ),
      actions: <Widget>[
        Visibility(
          visible: false,
          child: IconButton(
            icon: Icon(Icons.refresh),
            onPressed: fetchData,
            iconSize: 30,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}
