import 'package:flutter/material.dart';
import 'package:red_tailed_hawk/login_page.dart';
import 'package:red_tailed_hawk/models/sp_helper.dart';

class ProfilePage extends StatelessWidget {
  final _user;

  ProfilePage(this._user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          _buildHeader(context, _user.name),
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 10.0),
                child: _buildButton(context, Icons.favorite, "Saved Trips",
                    Color(0xffffd149), "SavedTrips"),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 10.0),
                child: _buildButton(context, Icons.calendar_today,
                    "Ride History", Color(0xffffd149), "RideHistory"),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 10.0),
                child: _buildButton(context, Icons.settings, "Settings",
                    Color(0xffffd149), "Settings"),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 10.0),
                child: _buildButton(
                    context, Icons.info, "FAQ", Color(0xffffd149), "FAQ"),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 10.0),
                child: _buildButton(
                    context, Icons.exit_to_app, "Logout", Colors.red, "Logout"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _navigateToPage(BuildContext context, String navigate) {
    switch (navigate) {
      case "SavedTrips":
        {
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => SavedTripsPage()));
        }
        break;

      case "RideHistory":
        {
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => RideHistoryPage()));
        }
        break;

      case "Settings":
        {
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => SettingsPage()));
        }
        break;

      case "FAQ":
        {
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => FAQPage()));
        }
        break;

      case "Logout":
        {
          SpHelper.clearUser();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
            (route) => false,
          );
        }
        break;

      default:
        {
          print("Something is wrong");
        }
        break;
    }
  }

  Widget _buildHeader(BuildContext context, String username) {
    return Container(
      height: 250.00,
      width: 487.00,
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
                  backgroundImage: NetworkImage(
                    'https://api.adorable.io/avatars/256/${_user.name}.png',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  username,
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context, IconData icon, String text,
      Color color, String navigateTo) {
    return ButtonTheme(
      minWidth: 242.0,
      height: 50.0,
      child: RaisedButton(
        onPressed: () {
          _navigateToPage(context, navigateTo);
        },
        child: Row(
          children: <Widget>[
            Icon(icon),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(text),
            ),
          ],
        ),
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.00),
        ),
      ),
    );
  }
}
