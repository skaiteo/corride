import 'package:flutter/material.dart';
import 'package:red_tailed_hawk/components/home_search_card.dart';

class HomePage extends StatelessWidget {
  HomePage(this.isDriver);

  final bool isDriver;

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
          SearchCard(),
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
                      children: ['One', 'Two', 'Three'].map((String word) {
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
                                      style: TextStyle(color: Colors.white),
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
                                          style: TextStyle(color: Colors.white),
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
