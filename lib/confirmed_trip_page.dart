import 'package:flutter/material.dart';
import 'package:red_tailed_hawk/models/trip_model.dart';

class ConfirmedTripPage extends StatelessWidget {
  final bool isDriver;
  final Trip trip;
  final opponent;

  ConfirmedTripPage({
    @required this.isDriver,
    @required this.trip,
    @required this.opponent,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Your ${isDriver ? 'Ride' : 'Trip'} on',
                      style: Theme.of(context).textTheme.display1.copyWith(
                            color: Colors.black,
                          ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      '${trip.startDate.year}/${trip.startDate.month}/${trip.startDate.day} - ${trip.endDate.year}/${trip.endDate.month}/${trip.endDate.day}',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Expanded(
                          child: SizedBox.expand(
                            // width: double.infinity,
                            // color: Colors.red,
                            child: Image.network(
                              'https://images.unsplash.com/photo-1480714378408-67cf0d13bc1b?ixlib=rb-1.2.1&w=1000&q=80',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 60.0,
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 8.0,
                                            ),
                                            child: Text(
                                              'Rating',
                                              style: TextStyle(fontSize: 18.0),
                                            ),
                                          ),
                                          // SizedBox(
                                          //   height: 10.0,
                                          // ),
                                          Text(
                                            'No rating',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 100.0,
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 8.0,
                                            ),
                                            child: Text(
                                              'Trip Fare',
                                              style: TextStyle(fontSize: 18.0),
                                            ),
                                          ),
                                          Text(
                                            'RM150',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '${opponent.name}',
                                style: TextStyle(fontSize: 20.0),
                              ),
                              Expanded(
                                child: Center(
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    child: Text('Pay'),
                                    color: Colors.orange,
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              title:
                                                  Text('Payment Information'),
                                              content: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    _buildTextField(
                                                        'First Name'),
                                                    _buildTextField(
                                                        'Last Name'),
                                                    _buildTextField(
                                                        'Card Number'),
                                                    Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          flex: 3,
                                                          child:
                                                              _buildTextField(
                                                            'Expiry date',
                                                          ),
                                                        ),
                                                        // SizedBox(
                                                        //   width: 10.0,
                                                        // ),
                                                        Expanded(
                                                          flex: 2,
                                                          child:
                                                              _buildTextField(
                                                            'CVV',
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    _buildTextField('Address'),
                                                  ],
                                                ),
                                              ),
                                              actions: <Widget>[
                                                FlatButton(
                                                  child: Text('Cancel'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                FlatButton(
                                                  child: Text('Pay'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://api.adorable.io/avatars/256/${opponent.name}.png',
                        ),
                        radius: 45.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String fieldLabel) {
    return Padding(
      padding: EdgeInsets.all(3.0),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: fieldLabel,
        ),
      ),
    );
  }
}
