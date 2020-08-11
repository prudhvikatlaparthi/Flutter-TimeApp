import 'package:flutter/material.dart';
import 'package:timeapp/screens/home-screen.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => HomeScreen(),
      },
    ));
