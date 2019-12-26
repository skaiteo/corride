import 'dart:convert';

import 'package:http/http.dart' as http;

class Traveller {
  final String id;
  final String email;
  final String name;
  final String phoneNo;

  Traveller({this.id, this.email, this.name, this.phoneNo});

  factory Traveller.fromJson(Map<String, dynamic> jsonMap) {
    return Traveller(
      id: jsonMap['id'],
      email: jsonMap['email'],
      name: jsonMap['name'],
      phoneNo: jsonMap['mob_num'],
    );
  }

  static Future<bool> createTraveller(
    String name,
    String email,
    String phoneNo,
    String password,
  ) async {
    final response = await http.post(
      'https://corride.000webhostapp.com/corride/traveller/createTraveller.php',
      body: jsonEncode({
        'name': name,
        'mob_num': phoneNo,
        'email': email,
        'password': password,
      }),
    );

    print(response.body);
    return jsonDecode(response.body)['response'] == '201';
  }

  static Future<Traveller> loginTraveller(String email, String password) async {
    final response = await http.post(
      'https://corride.000webhostapp.com/corride/traveller/loginTraveller.php',
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    var responseBody = jsonDecode(response.body);
    if (responseBody['response'] != null) {
      String id = responseBody['user_id'];
      return await (Traveller.fetchTraveller(id));
    } else {
      print('Failed to login traveller');
      // throw Exception('Failed to login traveller');
      return null;
    }
  }

  static Future<Traveller> fetchTraveller(String id) async {
    final response = await http.post(
      'https://corride.000webhostapp.com/corride/traveller/readTraveller.php',
      body: jsonEncode({
        'user_id': id,
      }),
    );

    if (response.statusCode == 200) {
      Map travellerMap = jsonDecode(response.body)['traveller'];
      return Traveller.fromJson(travellerMap);
    } else {
      print('Failed to fetch traveller');
      // throw Exception('Failed to fetch traveller');
      return null;
    }
  }
}

class Driver {
  final String id;
  final String email;
  final String name;
  final String phoneNo;
  final String carPlate;

  Driver({this.id, this.email, this.name, this.phoneNo, this.carPlate});

  factory Driver.fromJson(Map<String, dynamic> jsonMap) {
    return Driver(
      id: jsonMap['id'],
      email: jsonMap['email'],
      name: jsonMap['name'],
      phoneNo: jsonMap['mob_num'],
      carPlate: jsonMap['carplate'],
    );
  }

  static Future<bool> createDriver(
    String name,
    String email,
    String phoneNo,
    String password,
    String carPlate,
  ) async {
    final response = await http.post(
      'https://corride.000webhostapp.com/corride/driver/create.php',
      body: jsonEncode({
        'name': name,
        'mob_num': phoneNo,
        'email': email,
        'password': password,
        'carplate': carPlate,
      }),
    );

    print(response.body);
    return jsonDecode(response.body)['response'] == '201';
  }

  static Future<Driver> loginDriver(String email, String password) async {
    final response = await http.post(
      'https://corride.000webhostapp.com/corride/driver/login.php',
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    var responseBody = jsonDecode(response.body);
    if (responseBody['response'] != null) {
      String id = responseBody['user_id'];
      return await (Driver.fetchDriver(id));
    } else {
      print('Failed to login driver');
      // throw Exception('Failed to login driver');
      return null;
    }
  }

  static Future<Driver> fetchDriver(String id) async {
    final response = await http
        .get('https://corride.000webhostapp.com/corride/driver/read.php');

    if (response.statusCode == 200) {
      List driverMaps = List<Map>.from(jsonDecode(response.body));
      Map driverMap = driverMaps.firstWhere((driverMap) {
        return driverMap['id'] == id;
      });

      return Driver.fromJson(driverMap);
    } else {
      print('Failed to fetch driver');
      // throw Exception('Failed to fetch driver');
      return null;
    }
  }
}

// final String testName = 'charliemhz';
// final String testNum = '1234567';
// final String testEmail = 'charlie@email.com';
// final String testPw = 'secret';
