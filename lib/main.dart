import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeapp/model/time.dart';
import 'package:timeapp/screens/home-screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Time>.value(
          value: Time(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes: {
          "/": (context) => HomeScreen(),
        },
      ),
    );
  }
}
