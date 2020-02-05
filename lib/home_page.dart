import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:red_tailed_hawk/components/post_trip_card.dart';
import 'package:red_tailed_hawk/components/trip_search_card.dart';
import 'package:red_tailed_hawk/confirmed_trip_page.dart';
import 'package:red_tailed_hawk/login_page.dart';
import 'package:red_tailed_hawk/models/request_model.dart';
import 'package:red_tailed_hawk/models/sp_helper.dart';
import 'package:red_tailed_hawk/models/trip_model.dart';
import 'package:red_tailed_hawk/models/user_model.dart';
import 'package:red_tailed_hawk/notification_page.dart';
import 'package:red_tailed_hawk/profile_page.dart';

class HomePage extends StatefulWidget {
  HomePage(this.isDriver);

  final bool isDriver;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map> _pendingRequests = [];
  List<Map> _confirmedTrips = [];
  Future _userFuture;

  Future<Null> _fetchReqAndTrip(String userId) async {
    print('running _fetchReqAndTrip');
    // START Setting _pendingRequests
    List<Map> reqCollection = [];
    List<Trip> trips = await Trip.fetchTrips();
    if (widget.isDriver) {
      List<Request> requests = await Request.fetchRequests(driverId: userId);
      for (var request in requests) {
        var traveller = await Traveller.fetchTraveller(request.travellerId);
        Trip trip = trips.firstWhere((Trip trip) {
          return trip.id == request.tripId;
        });
        reqCollection.add({
          'request': request,
          'trip': trip,
          'traveller': traveller,
        });
        print('reqcol');
        print(reqCollection);
      }
    } else {
      List<Request> requests = await Request.fetchRequests(travellerId: userId);
      for (var request in requests) {
        // fetch each user individually
        var driver = await Driver.fetchDriver(request.driverId);
        Trip trip = trips.firstWhere((Trip trip) {
          return trip.id == request.tripId;
        });
        reqCollection.add({
          'request': request,
          'trip': trip,
          'driver': driver,
        });
      }
    }

    // START Setting _confirmedTrips
    List<Map> tripCollection = [];
    if (widget.isDriver) {
      final user = await SpHelper.getUser();
      for (var trip in trips) {
        if (trip.driverId == user.id) {
          final traveller = await Traveller.fetchTraveller(trip.travellerId);
          tripCollection.add({
            'trip': trip,
            'traveller': traveller,
          });
        }
      }
    } else {
      final user = await SpHelper.getUser();
      for (var trip in trips) {
        if (trip.travellerId == user.id && trip.driverId != null) {
          final driver = await Driver.fetchDriver(trip.driverId);
          tripCollection.add({
            'trip': trip,
            'driver': driver,
          });
        }
      }
    }

    try {
      setState(() {
        _pendingRequests = reqCollection.reversed.toList();
        _confirmedTrips = tripCollection.reversed.toList();
      });
    } catch (e) {
      print('logged');
    }
  }

  @override
  void initState() {
    super.initState();
    _userFuture = fetchUserAndPending();
  }

  Future fetchUserAndPending() async {
    var user = await SpHelper.getUser();
    await _fetchReqAndTrip(user.id);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Quit the app?'),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text('Cancel'),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            });
      },
      child: Scaffold(
        body: FutureBuilder(
          future: _userFuture,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              var user = snapshot.data;
              return RefreshIndicator(
                onRefresh: () {
                  return _fetchReqAndTrip(user.id);
                },
                displacement: 90.0,
                child: ListView(
                  children: <Widget>[
                    ClipOval(
                      clipper: CustomOval(),
                      child: Container(
                        height: 90.0,
                        alignment: Alignment.lerp(
                          Alignment.topCenter,
                          Alignment.center,
                          0.7,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          // TODO: Try adding shadow
                        ),
                        child: Text(
                          'CORRIDE',
                          style: Theme.of(context)
                              .textTheme
                              .display1
                              .apply(color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => ProfilePage(user),
                                  ),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.orange,
                                ),
                                child: CircleAvatar(
                                  radius: 30.0,
                                  backgroundImage: NetworkImage(
                                    'https://api.adorable.io/avatars/256/${user.name}.png',
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.0),
                                child: Text(
                                  'Hello, ${user.name}',
                                  style: Theme.of(context).textTheme.subhead,
                                ),
                              ),
                            ),
                            Stack(
                              alignment: Alignment.topRight,
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.notifications),
                                  iconSize: 35.0,
                                  color: Colors.orange,
                                  onPressed: () async {
                                    print(_pendingRequests);
                                    await Navigator.of(context).push(
                                      CupertinoPageRoute(
                                        builder: (context) => NotificationPage(
                                          _pendingRequests,
                                          isDriver: widget.isDriver,
                                        ),
                                      ),
                                    );
                                    await _fetchReqAndTrip(user.id);
                                  },
                                ),
                                Visibility(
                                  visible: _pendingRequests.isNotEmpty,
                                  child: Container(
                                    padding: EdgeInsets.all(2.0),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.orange,
                                    ),
                                    child: CircleAvatar(
                                      minRadius: 10.0,
                                      backgroundColor: Colors.white,
                                      child: Text(
                                        '${_pendingRequests.length}',
                                        style: TextStyle(fontSize: 14.0),
                                      ),
                                    ),
                                  ),
                                ),
                                // InkWell(
                                //   onTap: () {
                                //     print('notify');
                                //   },
                                // ),
                              ],
                            ),
                            // IconButton(
                            //   icon: Icon(Icons.notification_important),
                            //   onPressed: () {
                            //     Navigator.of(context).push(
                            //       CupertinoPageRoute(
                            //         builder: (context) => TestButtonsPage(),
                            //       ),
                            //     );
                            //   },
                            //   iconSize: 30.0,
                            // ),
                          ],
                        ),
                      ),
                    ),
                    widget.isDriver ? TripSearchCard() : PostTripCard(),
                    Card(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      elevation: 4.0,
                      child: Padding(
                        padding: EdgeInsets.only(top: 15.0),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    widget.isDriver
                                        ? 'Planned Rides'
                                        : 'Planned Trips',
                                    style: Theme.of(context).textTheme.title,
                                  ),
                                  Text(
                                    widget.isDriver
                                        ? 'Rides that you have offered and accepted by the traveller'
                                        : 'Trips that have been offered to and accepted by you',
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 200.0,
                              child: ListView(
                                padding: EdgeInsets.symmetric(horizontal: 15.0),
                                scrollDirection: Axis.horizontal,
                                children:
                                    _confirmedTrips.map((Map tripDetails) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 5.0,
                                      vertical: 15.0,
                                    ),
                                    width: 150.0,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          CupertinoPageRoute(
                                            builder: (context) =>
                                                ConfirmedTripPage(
                                              isDriver: widget.isDriver,
                                              trip: tripDetails['trip'],
                                              opponent: widget.isDriver
                                                  ? tripDetails['traveller']
                                                  : tripDetails['driver'],
                                            ),
                                          ),
                                        );
                                      },
                                      child: Card(
                                        elevation: 4.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          child: Stack(
                                            fit: StackFit.expand,
                                            children: <Widget>[
                                              Image.network(
                                                'https://api.adorable.io/avatars/256/${widget.isDriver ? tripDetails['traveller'].name : tripDetails['driver'].name}.png',
                                                fit: BoxFit.cover,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  // color: Colors.red,
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Colors.black
                                                          .withOpacity(0.8),
                                                      Colors.transparent,
                                                      Colors.transparent,
                                                      Colors.black
                                                          .withOpacity(0.8),
                                                    ],
                                                    stops: [0.0, 0.4, 0.5, 1.0],
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: 12.0,
                                                left: 10.0,
                                                child: Text(
                                                  '${widget.isDriver ? tripDetails['traveller'].name : tripDetails['driver'].name}',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 12.0,
                                                left: 10.0,
                                                right: 10.0,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      '${tripDetails['trip'].destination}',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${tripDetails['trip'].startDate.year}/${tripDetails['trip'].startDate.month}/${tripDetails['trip'].startDate.day}\n${tripDetails['trip'].endDate.year}/${tripDetails['trip'].endDate.month}/${tripDetails['trip'].endDate.day}',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Something went wrong'),
                    RaisedButton(
                      child: Text('Try Again'),
                      onPressed: () {
                        setState(() {
                          _userFuture = fetchUserAndPending();
                        });
                      },
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

class CustomOval extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    Rect rect = Rect.fromLTRB(
        -size.width * 0.2, -size.height, size.width * 1.2, size.height);
    return rect;
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
