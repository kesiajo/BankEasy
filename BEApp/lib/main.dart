import 'package:bank_easy/SplashScreen.dart';
import 'package:flutter/material.dart';
// import 'package:bankeasy/helper/Style.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bank Easy',
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(primarySwatch: Colors.black),
      home: SplashScreen(),
    );
  }
}
