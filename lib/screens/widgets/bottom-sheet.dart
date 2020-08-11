import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeapp/model/time.dart';

class MyBottomSheetView extends StatelessWidget {
  Time value;
  Function fetchData;
  MyBottomSheetView({this.value,this.fetchData});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[50],
      child: Scrollbar(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: value.zonesList.length,
          itemBuilder: (context, index) => Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Card(
                  child: ListTile(
                    leading: IconButton(
                      icon: Icon(Icons.done),
                      onPressed: () {
                        itemClickListener(value, index, context);
                      },
                      color: value.selectedLocationIndex == index
                          ? Colors.black
                          : Colors.black38,
                    ),
                    title: Text(value.zonesList[index],
                        style: GoogleFonts.roboto(
                          color: value.selectedLocationIndex == index
                              ? Colors.black
                              : Colors.black38,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                    onTap: () {
                      itemClickListener(value, index, context);
                    },
                  ),
                ),
              ),
              // Divider(),
            ],
          ),
        ),
      ),
    );
  }

  void itemClickListener(value, index, context) {
    Navigator.pop(context);
    value.selectedLocationIndex = index;
    value.selectedLocation = value.zonesList[index];
    fetchData();
  }
}
