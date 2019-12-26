import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:red_tailed_hawk/models/trip_model.dart';
import 'package:red_tailed_hawk/models/user_model.dart';
import 'package:red_tailed_hawk/view_trip_details.dart';

class SearchResultsPage extends StatefulWidget {
  @override
  _SearchResultsPageState createState() => _SearchResultsPageState();

  SearchResultsPage(this._searchTerm, this._searchDates);

  final String _searchTerm;
  final List<DateTime> _searchDates;
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  Future<List> _calculation;
  List<Trip> _trips = [];

  @override
  void initState() {
    super.initState();
    _calculation = filterTrips();
  }

  Future<List> filterTrips() async {
    List fetchedTrips = await Trip.fetchTrips();
    setState(() {
      _trips = fetchedTrips;
    });
    // print('print all _trips');
    // print(_trips);
    List<Trip> searchedTrips = _trips.where(
      (Trip trip) {
        if (trip.destination
            .toLowerCase()
            .contains(widget._searchTerm.toLowerCase())) {
          if (widget._searchDates.isNotEmpty) {
            return widget._searchDates[0].isBefore(trip.startDate) &&
                widget._searchDates[1].isAfter(trip.endDate);
          } else {
            return true;
          }
        } else {
          return false;
        }
      },
    ).toList();
    // print('Print searchedTrips: \n$searchedTrips');

    List withTraveller = [];
    for (var trip in searchedTrips) {
      Traveller traveller = await Traveller.fetchTraveller(trip.travellerId);
      // print('fetched traveller: ${traveller.email} + ${traveller.name}');
      withTraveller.add({
        'trip': trip,
        'traveller': traveller,
      });
    }

    // print('withTraveller: $withTraveller');
    return withTraveller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: IconButton(
                  // padding: EdgeInsets.all(30.0),
                  icon: Icon(Icons.chevron_left),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Trips Available',
                        style: Theme.of(context).textTheme.display1.copyWith(
                              color: Colors.black,
                            ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Search results for "${widget._searchTerm}"',
                        style: Theme.of(context).textTheme.subhead.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                    ],
                  )),
              Expanded(
                child: FutureBuilder(
                  future: _calculation,
                  builder:
                      (BuildContext context, AsyncSnapshot<List> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasData) {
                      return ListView(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        children: snapshot.data.map((tripResult) {
                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 15.0),
                            elevation: 4.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(15.0),
                              onTap: () {
                                List<Trip> recentTrips =
                                    _trips.where((Trip trip) {
                                  return trip.travellerId ==
                                          tripResult['trip'].travellerId &&
                                      trip.id != tripResult['trip'].id;
                                }).toList();

                                Navigator.of(context).push(
                                  CupertinoPageRoute(
                                    builder: (context) => ViewTripDetails(
                                      recentTrips,
                                      tripResult['trip'],
                                      tripResult['traveller'],
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 20.0),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 20.0,
                                      ),
                                      child: CircleAvatar(
                                        maxRadius: 30.0,
                                        backgroundImage: NetworkImage(
                                          'https://api.adorable.io/avatars/256/${tripResult['traveller'].name}.png',
                                          // 'https://source.unsplash.com/random/256x256',
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            '${tripResult['traveller'].name}',
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 5.0,
                                            ),
                                            child: Text(
                                                '${tripResult['trip'].destination}'),
                                          ),
                                          Text(
                                            '${tripResult['trip'].startDate.year}/${tripResult['trip'].startDate.month}/${tripResult['trip'].startDate.day}\n${tripResult['trip'].endDate.year}/${tripResult['trip'].endDate.month}/${tripResult['trip'].endDate.day}',
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                          // Star rating design
                                          // Row(
                                          //   children: <Widget>[
                                          //     for (var i = 0; i < 4; i++)
                                          //       Icon(
                                          //         Icons.star,
                                          //         size: 14.0,
                                          //         color: Colors.yellow[700],
                                          //       ),
                                          //     Icon(
                                          //       Icons.star_half,
                                          //       size: 14.0,
                                          //       color: Colors.yellow[700],
                                          //     ),
                                          //     Spacer(),
                                          //     Text('4.5'),
                                          //   ],
                                          // ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 20.0,
                                      ),
                                      child: Icon(Icons.chevron_right),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    } else {
                      return Center(
                        child: Text('Error occured'),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
