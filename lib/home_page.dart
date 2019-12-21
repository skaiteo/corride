import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
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
                // boxShadow: [
                //   BoxShadow(
                //     spreadRadius: 10.0,
                //     offset: Offset(0.0, 100.0),
                //   )
                // ],
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
            // child: ListTile(
            //   leading: CircleAvatar(
            //     // maxRadius: 30.0,
            //     // radius: 20.0,
            //     backgroundImage: NetworkImage(
            //       'https://source.unsplash.com/random/256x256',
            //     ),
            //   ),
            //   title: Text('Hello, Jeon Dough'),
            // ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    // maxRadius: 30.0,
                    radius: 30.0,
                    backgroundImage: NetworkImage(
                      'https://source.unsplash.com/random/256x256',
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        'Hello, Jeon Dough',
                        style: Theme.of(context).textTheme.subhead,
                      ),
                    ),
                  ),
                  // TODO: Make proper notificatio bell icon
                  IconButton(
                    icon: Icon(Icons.notification_important),
                    onPressed: () {},
                    iconSize: 30.0,
                  ),
                ],
              ),
            ),
          ),
          Card(
            color: Colors.grey[300],
            margin: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 25.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 7.0),
                    child: Text(
                      'Search for a Ride',
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                  ...['Dest', 'Dates', 'Pax'].map((String fieldHint) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 7.0),
                      child: Container(
                        color: Colors.grey,
                        height: 50.0,
                      ),
                    );
                  }).toList(),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 7.0),
                    alignment: Alignment.center,
                    child: Container(
                      color: Colors.grey,
                      height: 20.0,
                      width: 100.0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 7.0),
                    child: Container(
                      color: Colors.orange[600],
                      height: 50.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Placeholder(
              fallbackHeight: 300.0,
            ),
          ),
        ],
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
    // TODO: implement shouldReclip
    return true;
  }
}
