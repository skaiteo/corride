import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:red_tailed_hawk/components/post_trip_card.dart';
import 'package:red_tailed_hawk/components/trip_search_card.dart';
import 'package:red_tailed_hawk/models/request_model.dart';
import 'package:red_tailed_hawk/models/sp_helper.dart';
import 'package:red_tailed_hawk/models/trip_model.dart';
import 'package:red_tailed_hawk/models/user_model.dart';
import 'package:red_tailed_hawk/test_page.dart';

class HomePage extends StatefulWidget {
  HomePage(this.isDriver);

  final bool isDriver;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map> _pendingRequests = [];
  Future _userFuture;

  Future<Null> _fetchPending(String userId) async {
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

    // await Future.delayed(Duration(seconds: 3));
    setState(() {
      _pendingRequests = reqCollection.reversed.toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _userFuture = fetchUserAndPending();
  }

  Future fetchUserAndPending() async {
    var user = await SpHelper.getUser();
    await _fetchPending(user.id);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _userFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            var user = snapshot.data;
            return RefreshIndicator(
              onRefresh: () {
                return _fetchPending(snapshot.data.id);
              },
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
                          CircleAvatar(
                            radius: 30.0,
                            backgroundImage: NetworkImage(
                              'https://api.adorable.io/avatars/256/${user.name}.png',
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.0),
                              child: Text(
                                // TODO: Find out why there are double quotes around the name
                                'Hello, ${user.name}',
                                style: Theme.of(context).textTheme.subhead,
                              ),
                            ),
                          ),
                          // TODO: Make proper notification bell icon
                          Stack(
                            alignment: Alignment.topRight,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.notifications),
                                iconSize: 35.0,
                                color: Colors.orange,
                                onPressed: () {
                                  print(_pendingRequests);
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
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14.0),
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
                                  'Planned Trips',
                                  style: Theme.of(context).textTheme.title,
                                ),
                                Text(
                                  'Trips specially planned and selected for you by our drivers',
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
                                  ['One', 'Two', 'Three'].map((String word) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 5.0,
                                    vertical: 15.0,
                                  ),
                                  width: 150.0,
                                  child: Card(
                                    elevation: 4.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15.0),
                                      child: Stack(
                                        fit: StackFit.expand,
                                        children: <Widget>[
                                          Image.network(
                                            'https://source.unsplash.com/300x300',
                                            fit: BoxFit.cover,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              // color: Colors.red,
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Colors.black.withOpacity(0.8),
                                                  Colors.transparent,
                                                  Colors.transparent,
                                                  Colors.black.withOpacity(0.8),
                                                ],
                                                stops: [0.0, 0.4, 0.6, 1.0],
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 12.0,
                                            left: 10.0,
                                            child: Text(
                                              word,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 12.0,
                                            left: 10.0,
                                            right: 10.0,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                for (var i = 0; i < 4; i++)
                                                  Icon(
                                                    Icons.star,
                                                    size: 14.0,
                                                    color: Colors.white,
                                                  ),
                                                Icon(
                                                  Icons.star_half,
                                                  size: 14.0,
                                                  color: Colors.white,
                                                ),
                                                Spacer(),
                                                Text(
                                                  '4.5',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
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
              child: Text('Something went wrong'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
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
