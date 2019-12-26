import 'dart:convert';

import 'package:http/http.dart' as http;

class Trip {
  final String id;
  final String travellerId;
  final String destination;
  final DateTime startDate;
  final DateTime endDate;
  final String driverId;

  Trip(
      {this.id,
      this.travellerId,
      this.destination,
      this.startDate,
      this.endDate,
      this.driverId});

  factory Trip.fromJson(Map<String, dynamic> jsonMap) {
    return Trip(
      id: jsonMap['id'],
      travellerId: jsonMap['traveller_id'],
      destination: jsonMap['destination'],
      startDate: jsonMap['start_date'],
      endDate: jsonMap['end_date'],
      driverId: jsonMap['driver_id'],
    );
  }

  static Future<List<Trip>> fetchTrips({int userId}) async {
    final response = await http.get(
      'https://corride.000webhostapp.com/corride/trip/getTrip.php${(userId == null) ? '' : '?id=$userId'}',
    );

    if (response.statusCode == 200) {
      List tripsMap = jsonDecode(response.body)['trips'];

      List<Trip> trips = [];
      tripsMap.forEach((tripMap) {
        tripMap['start_date'] = DateTime.parse(tripMap['start_date']);
        tripMap['end_date'] = DateTime.parse(tripMap['end_date']);
        trips.add(Trip.fromJson(tripMap));
      });

      return trips.reversed.toList();
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load trips');
    }
  }

  static Future<bool> createTrip({
    String userId,
    String dest,
    DateTime startDate,
    DateTime endDate,
  }) async {
    String startDateString = startDate.toString().substring(0, 10);
    String endDateString = endDate.toString().substring(0, 10);
    print({
      'id': userId,
      'destination': dest,
      'start_date': startDateString,
      'end_date': endDateString,
    });
    // print(endDateString);

    final response = await http.post(
      'https://corride.000webhostapp.com/corride/trip/createTrip.php',
      body: jsonEncode({
        'id': userId,
        'destination': dest,
        'start_date': startDateString,
        'end_date': endDateString,
      }),
    );

    return response.statusCode == 200;
  }
}
