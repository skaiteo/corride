import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:red_tailed_hawk/view_driver_details.dart';

class NotificationPage extends StatelessWidget {
  final bool isDriver;
  final List<Map> _pendingReqs;

  NotificationPage(this._pendingReqs, {@required this.isDriver});

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
                      'Notifications',
                      style: Theme.of(context).textTheme.display1.copyWith(
                            color: Colors.black,
                          ),
                    ),
                    // SizedBox(
                    //   height: 10.0,
                    // ),
                    // Text(
                    //   'Search results for "${widget._searchTerm}"',
                    //   style: Theme.of(context).textTheme.subhead.copyWith(
                    //         color: Colors.grey[600],
                    //       ),
                    // ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: _pendingReqs.map((Map pendingReq) {
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 15.0),
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(15.0),
                        onTap: isDriver
                            ? () {}
                            : () async {
                                bool hasResponded =
                                    await Navigator.of(context).push(
                                  CupertinoPageRoute(
                                    builder: (context) => ViewDriverDetails(
                                      reqId: pendingReq['request'].id,
                                      driver: pendingReq['driver'],
                                      trip: pendingReq['trip'],
                                    ),
                                  ),
                                );
                                print('hasResponded');
                                print(hasResponded);
                                if (hasResponded == true)
                                  Navigator.of(context).pop();
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
                                    'https://api.adorable.io/avatars/256/${(isDriver ? pendingReq['traveller'].name : pendingReq['driver'].name)}.png',
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(right: 20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        isDriver
                                            ? '${pendingReq['traveller'].name} accepted your ride offer!'
                                            : pendingReq['driver'].name,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        isDriver
                                            ? 'Connect with him/her now!'
                                            : 'Offering a ride around ${pendingReq['trip'].destination} from ${pendingReq['trip'].startDate.year}/${pendingReq['trip'].startDate.month}/${pendingReq['trip'].startDate.day} - ${pendingReq['trip'].endDate.year}/${pendingReq['trip'].endDate.month}/${pendingReq['trip'].endDate.day}',
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
                              ),
                              // Padding(
                              //   padding: EdgeInsets.symmetric(
                              //     horizontal: 20.0,
                              //   ),
                              //   child: Icon(Icons.chevron_right),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
