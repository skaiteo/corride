import 'package:flutter/material.dart';
import 'package:red_tailed_hawk/home_page.dart';

class ViewDriverDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          _buildHeader(context, "Sam Smith", "Petaling Jaya",
              "21 Dec 2019 - 30 Dec 2019"),
          _buildContactCard("+6023456781", "samsmith@mail.com"),
          _buildCarDetailsCard("Myvi", "4.0"),
          _buildRecentTrips(),
        ],
      ),
    );
  }
}

//area for functions
void _showAcceptAlertDialog(BuildContext context, bool isAccepted) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        if (isAccepted) {
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePage(false)));
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
        } else {
          return AlertDialog(
            title: Text(
              "Ride Rejected!",
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
                TextField(
                  maxLines: 5,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Please state your reason."),
                ),
                ButtonTheme(
                  minWidth: 117.0,
                  height: 35.0,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePage(false)));
                    },
                    child: Text("Submit"),
                    color: Color(0xffffd149),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.00),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      });
}
//end of area for functions

//area for widget building functions
Widget _buildHeader(BuildContext context, String username, String destination,
    String duration) {
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
                username,
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(2.0),
              child: Text(
                "Offered to drive you around " + destination,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(2.0),
              child: Text(
                "From " + duration,
                style: TextStyle(fontSize: 14.0),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ButtonTheme(
                minWidth: 117.0,
                height: 35.0,
                child: RaisedButton(
                  onPressed: () {
                    _showAcceptAlertDialog(context, true);
                  },
                  child: Text("Accept Ride"),
                  color: Color(0xff49FF56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.00),
                  ),
                ),
              ),
              ButtonTheme(
                minWidth: 117.0,
                height: 35.0,
                child: RaisedButton(
                  onPressed: () {
                    _showAcceptAlertDialog(context, false);
                  },
                  child: Text("Reject Ride"),
                  color: Color(0xffFF6C49),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.00),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildContactCard(String phoneNum, String email) {
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
                        phoneNum,
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
                          email,
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

Widget _buildCarDetailsCard(String car, String rating) {
  return Container(
    height: 194.00,
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
      padding: EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image(
            image: AssetImage("assets/images/sedan-car-front.png"),
            height: 77.0,
            width: 77.0,
          ),
          Text(
            "Drives a(n) " + car,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color(0xff000000),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              rating + " rating",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
                color: Color(0xff000000),
              ),
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
//end of area for widget building functions
