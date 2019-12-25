import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:red_tailed_hawk/login_page.dart';
import 'package:red_tailed_hawk/view_driver_details.dart';
import 'package:red_tailed_hawk/view_trip_details.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: LoginPage(),
    );
  }
}
