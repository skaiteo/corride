import 'dart:convert';

import 'package:red_tailed_hawk/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpHelper {
  static Future saveUser(var user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', user.id);
    await prefs.setString('userName', user.name);
    await prefs.setString('userEmail', user.email);
    await prefs.setString('userPhone', user.phoneNo);
    if (user.runtimeType == Driver) {
      await prefs.setString('userCarPlate', user.carPlate);
      await prefs.setBool('userIsDriver', true);
      print('yeap, saved Driver carplate: ${prefs.getString('userCarplate')}');
    }
  }

  static Future getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('userId');
    String name = prefs.getString('userName');
    String email = prefs.getString('userEmail');
    String phoneNo = prefs.getString('userPhone');
    bool isDriver = prefs.getBool('userIsDriver');
    String carPlate = isDriver ? prefs.getString('userCarPlate') : null;
    if (isDriver) {
      return Driver(
        id: id,
        name: name,
        email: email,
        phoneNo: phoneNo,
        carPlate: carPlate,
      );
    } else {
      return Traveller(
        id: id,
        name: name,
        email: email,
        phoneNo: phoneNo,
      );
    }
  }
}
