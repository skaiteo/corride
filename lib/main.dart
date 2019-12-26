import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:red_tailed_hawk/login_page.dart';
import 'package:red_tailed_hawk/profile_page.dart';

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
