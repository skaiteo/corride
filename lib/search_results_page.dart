import 'package:flutter/material.dart';

class SearchResultsPage extends StatefulWidget {
  @override
  _SearchResultsPageState createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  Future<List> _calculation = Future<List>.delayed(
    Duration(seconds: 2),
    () => List.generate(7, (int index) {
      return {
        'name': 'Person $index',
        'rating': index % 5,
      };
    }),
  );

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
                        'Drivers Available',
                        style: Theme.of(context).textTheme.display1.copyWith(
                              color: Colors.black,
                            ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Listing all drivers at PlaceName',
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
                        children: <Widget>[
                          for (var i = 0; i < snapshot.data.length; i++)
                            Card(
                              margin: EdgeInsets.symmetric(vertical: 15.0),
                              elevation: 4.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(15.0),
                                onTap: () {},
                                // child: Container(
                                //   height: 120.0,
                                //   child: Center(
                                //     child: Text('${snapshot.data[i]['name']}'),
                                //   ),
                                // ),
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
                                            'https://source.unsplash.com/random/256x256/?person',
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text('${snapshot.data[i]['name']}'),
                                            Text(
                                                'Available from 1${i} - 1${i + 1}'),
                                            SizedBox(
                                              height: 15.0,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                for (var i = 0; i < 4; i++)
                                                  Icon(
                                                    Icons.star,
                                                    size: 14.0,
                                                    color: Colors.yellow[700],
                                                  ),
                                                Icon(
                                                  Icons.star_half,
                                                  size: 14.0,
                                                  color: Colors.yellow[700],
                                                ),
                                                Spacer(),
                                                Text('4.5'),
                                              ],
                                            ),
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
                            ),
                        ],
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
