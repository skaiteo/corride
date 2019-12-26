import 'package:flutter/material.dart';
import 'package:red_tailed_hawk/home_page.dart';

class ViewTripDetails extends StatefulWidget {
  @override
  _ViewTripDetailsState createState() => _ViewTripDetailsState();
}

class _ViewTripDetailsState extends State<ViewTripDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          _buildHeader(context),
          _buildContactCard(),
          _buildRecentTrips(),
        ],
      ),
    );
  }
}

//area for functions
void _showAlertDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Ride Confirmed!",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color(0xff000000),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Image(
                image: AssetImage("assets/images/checked.png"),
                height: 66.0,
                width: 66.0,
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "The driver will contact \nyou soon ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff9e9e9e),
                  ),
                ),
              ),
              ButtonTheme(
                minWidth: 117.0,
                height: 35.0,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage(true)));
                  },
                  child: Text("OK"),
                  color: Color(0xffffd149),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.00),
                  ),
                ),
              ),
            ],
          ),
        );
      });
}
//end area for functions

//area for widget building functions
Widget _buildHeader(BuildContext context) {
  return Container(
    height: 349.00,
    width: 487.00,
    color: Color(0xffff8f00),
    child: Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.fromLTRB(10.0, 40.0, 0.0, 0.0),
          child: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        Column(
          children: <Widget>[
            Container(
              width: 87.0,
              height: 87.0,
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Color(0xffFFD149),
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                radius: 43.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Text(
                "John Doe",
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(2.0),
              child: Text(
                "Wants to travel to Petaling Jaya",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(2.0),
              child: Text(
                "From 21 Dec 2019 - 30 Dec 2019",
                style: TextStyle(fontSize: 14.0),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: ButtonTheme(
            minWidth: 117.0,
            height: 35.0,
            child: RaisedButton(
              onPressed: () {
                _showAlertDialog(context);
              },
              child: Text("Offer Ride"),
              color: Color(0xffffd149),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.00),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildContactCard() {
  return Container(
    height: 139.00,
    width: 411.00,
    decoration: BoxDecoration(
      color: Color(0xffffffff),
      boxShadow: [
        BoxShadow(
          offset: Offset(0.00, 3.00),
          color: Color(0xff000000).withOpacity(0.16),
          blurRadius: 6,
        ),
      ],
    ),
    child: Padding(
      padding: EdgeInsets.fromLTRB(41.0, 27.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Contact Details",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 18.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.call, size: 16.0, color: Color(0xff9E9E9E)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        "+60123456789",
                        style:
                            TextStyle(fontSize: 14.0, color: Color(0xff9E9E9E)),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 9.0),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.mail, size: 16.0, color: Color(0xff9E9E9E)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          "johndoe@mail.com",
                          style: TextStyle(
                              fontSize: 14.0, color: Color(0xff9E9E9E)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildRecentTrips() {
  return Container(
    width: 411.0,
    padding: EdgeInsets.fromLTRB(41.0, 27.0, 0.0, 0.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Recent Trips",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        Container(
          height: 200,
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              _buildTripCard("Mutiara Damansara", "Petaling Jaya"),
              _buildTripCard("KLCC", "Kuala Lumpur"),
              _buildTripCard("Mont Kiara", "Segambut"),
              _buildTripCard("Sunway Pyramid", "Subang Jaya"),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildTripCard(String travelArea, String location) {
  return Padding(
    padding: EdgeInsets.fromLTRB(0.0, 10.0, 18.0, 10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          height: 90.0,
          width: 130.0,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://dbv47yu57n5vf.cloudfront.net/s3fs-public/editorial/my/2016/September/09/20160907_PLA_MutiaraDamansara_8509_IZW.jpg"),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0.00, 3.00),
                  color: Color(0xff000000).withOpacity(0.16),
                  blurRadius: 6,
                ),
              ]),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(travelArea,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
            Text(location, style: TextStyle(fontSize: 12)),
          ],
        )
      ],
    ),
  );
}
