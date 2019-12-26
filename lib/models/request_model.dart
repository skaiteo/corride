import 'dart:convert';

import 'package:http/http.dart' as http;

class Request {
  final String id;
  final String travellerId;
  final String tripId;
  final String driverId;
  final String status;

  Request({this.id, this.travellerId, this.tripId, this.driverId, this.status});

  factory Request.fromJson(Map<String, dynamic> jsonMap) {
    return Request(
      id: jsonMap['id'],
      travellerId: jsonMap['traveller_id'],
      tripId: jsonMap['trip_id'],
      driverId: jsonMap['driver_id'],
      status: jsonMap['status'],
    );
  }

  static Future<List<Request>> fetchRequests(
      {String travellerId, String driverId}) async {
    //TODO: check this
    final response = await http.post(
      'https://corride.000webhostapp.com/corride/request/getRequest.php',
      body: jsonEncode({
        'driver_id': driverId,
        'traveller_id': travellerId,
      }),
    );

    if (response.statusCode == 200) {
      List requestMaps = jsonDecode(response.body)['requests'] ?? [];

      List<Request> requests = requestMaps.where((requestMap) {
        // Filter pending and accepted for respective situtations
        return (driverId != null)
            // Drivers want accepted ones
            ? requestMap['status'] == 'accepted'
            // Travellers want pending ones
            : requestMap['status'] == 'pending';
      }).map((requestMap) {
        return Request.fromJson(requestMap);
      }).toList();

      // if (driverId != null) {
      //   requests = requests.where((Request request) {
      //     return request.status == 'accepted';
      //   }).toList();
      // } else {
      //   requests = requests.where((Request request) {
      //     return request.status == 'pending';
      //   }).toList();
      // }

      return requests.reversed.toList();
    } else {
      // If that call was not successful, throw an error.
      print('Failed to load requests');
      throw Exception('Failed to load requests');
    }
  }

  static Future<bool> createRequest({
    String travellerId,
    String tripId,
    String driverId,
  }) async {
    // String startDateString = startDate.toString().substring(0, 10);
    // String endDateString = endDate.toString().substring(0, 10);
    // print({
    //   'id': userId,
    //   'destination': dest,
    //   'start_date': startDateString,
    //   'end_date': endDateString,
    // });
    // print(endDateString);

    final response = await http.post(
      'https://corride.000webhostapp.com/corride/request/createRequest.php',
      body: jsonEncode({
        'traveller_id': travellerId,
        'trip_id': tripId,
        'driver_id': driverId,
        'details': '',
      }),
    );

    return response.statusCode == 200;
  }

  static Future<bool> acceptRequest({String tripId, String driverId}) async {
    final response = await http.post(
      'https://corride.000webhostapp.com/corride/request/acceptRequest.php',
      body: jsonEncode({
        'trip_id': tripId,
        'driver_id': driverId,
      }),
    );

    return response.statusCode == 200;
  }
}
