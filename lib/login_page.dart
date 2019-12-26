import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:red_tailed_hawk/home_page.dart';
import 'package:red_tailed_hawk/models/sp_helper.dart';
import 'package:red_tailed_hawk/models/user_model.dart';
import 'package:red_tailed_hawk/sign_up_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Image(
                image: AssetImage("assets/images/login-background-image.png"),
                fit: BoxFit.cover,
                height: 800,
              ),
            ),
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Color.fromRGBO(255, 160, 0, 0.7),
              ),
            ),
            Positioned.fill(
              top: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "CORRIDE",
                        style: TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                  blurRadius: 10.0,
                                  color: Color(0xFFC67100),
                                  offset: Offset(5.0, 5.0))
                            ]),
                      ),
                    ),
                  ),
                  Expanded(
                    child: LoginCard(),
                    flex: 6,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginCard extends StatefulWidget {
  @override
  _LoginCardState createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  bool _isSwitched = true;

  TextEditingController _emailController = TextEditingController(
    text: 'chaelee7@email.com',
  );
  TextEditingController _pwController = TextEditingController(
    text: 'secret',
  );

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Container(
        height: 500,
        width: 350,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.5),
              offset: Offset(0, 3),
              blurRadius: 6,
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20.0, 0, 5.0),
              child: Column(
                children: <Widget>[
                  _signUpButton(false, "Sign Up as a Traveller",
                      Icons.person_outline, context),
                  _signUpButton(true, "Sign Up as a Driver",
                      Icons.directions_car, context),
                ],
              ),
            ),
            _loginSignUpDivider(),
            Column(
              children: <Widget>[
                _textInput(
                  Icons.mail,
                  "Email address",
                  false,
                  _emailController,
                ),
                _textInput(
                  Icons.lock,
                  "Password",
                  true,
                  _pwController,
                ),
              ],
            ),
            MyAccountSwitchButton(
              isDriver: _isSwitched,
              onSwitch: (bool value) {
                setState(() {
                  _isSwitched = value;
                });
              },
            ),
            _loginButton(context),
            FlatButton(
              onPressed: () {},
              child: Text(
                "Forgot your password?",
                style: TextStyle(color: Color(0xff9E9E9E), fontSize: 12),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _signUpButton(
    bool forDriver,
    String buttonText,
    IconData icon,
    BuildContext context,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: InkWell(
        onTap: () async {
          final newUser = await Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (context) => SignUpPage(
                isDriver: forDriver,
              ),
            ),
          );

          if (newUser != null) {
            await SpHelper.saveUser(newUser);
            Navigator.of(context).pushReplacement(
              CupertinoPageRoute(
                builder: (context) => HomePage(forDriver),
              ),
            );
          }
        },
        child: Container(
          height: 50,
          width: 268,
          decoration: BoxDecoration(
            color: Color(0xFFFFA000),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xFFC67100),
                    ),
                    child: Icon(
                      icon,
                      color: Colors.white,
                    )),
              ),
              Positioned.fill(
                left: 40,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    buttonText,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _textInput(IconData icon, String placeholder, bool isPassword,
      TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        height: 50.0,
        width: 268.0,
        decoration: BoxDecoration(
          color: Color(0xffeeeeee),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          children: <Widget>[
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Color(0xffD4D4D4),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Icon(
                icon,
                color: Color(0xff9E9E9E),
              ),
            ),
            Expanded(
              child: TextField(
                controller: controller,
                obscureText: isPassword,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                  border: InputBorder.none,
                  hintText: placeholder,
                  hintStyle: TextStyle(
                    color: Color(0xff9E9E9E),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    loginUser() async {
      // TODO: disable and spin button
      String email = _emailController.text;
      String password = _pwController.text;
      var loggedInUser;
      if (_isSwitched) {
        // if pointed towards Driver
        loggedInUser = await Driver.loginDriver(email, password);
      } else {
        loggedInUser = await Traveller.loginTraveller(email, password);
      }
      if (loggedInUser != null) {
        // TODO: navigate and replace
        await SpHelper.saveUser(loggedInUser);
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => HomePage(_isSwitched),
          ),
        );
      } else {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('Login Failed'),
          ),
        );
      }
      // Navigator.pushReplacement(
      //   context,
      //   CupertinoPageRoute(
      //     builder: (context) => HomePage(forDriver),
      //   ),
      // );
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: InkWell(
        onTap: () {
          loginUser();
        },
        child: Container(
          height: 50,
          width: 268,
          decoration: BoxDecoration(
            color: Color(0xFFC67100),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              "Login",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _loginSignUpDivider() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: <Widget>[
      Container(
        height: 1.0,
        width: 107.0,
        color: Color(0xff707070),
      ),
      Text("OR", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      Container(
        height: 1.0,
        width: 107.0,
        color: Color(0xff707070),
      ),
    ],
  );
}

class MyAccountSwitchButton extends StatelessWidget {
//   @override
//   _MyAccountSwitchButtonState createState() => _MyAccountSwitchButtonState();
// }

// class _MyAccountSwitchButtonState extends State<MyAccountSwitchButton> {
  MyAccountSwitchButton({this.isDriver, this.onSwitch});

  final bool isDriver;
  final void Function(bool) onSwitch;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Traveller",
          style: TextStyle(
            color: isDriver ? Colors.grey : Colors.orange[700],
            fontWeight: isDriver ? null : FontWeight.w600,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Switch(
            onChanged: onSwitch,
            value: isDriver,
            activeTrackColor: Color(0xffFFD299),
            activeColor: Colors.orange,
            inactiveTrackColor: Color(0xffFFD299),
            inactiveThumbColor: Colors.orange,
          ),
        ),
        Text(
          "Driver",
          style: TextStyle(
            color: isDriver ? Colors.orange[700] : Colors.grey,
            fontWeight: isDriver ? FontWeight.w600 : null,
          ),
        )
      ],
    );
  }
}
