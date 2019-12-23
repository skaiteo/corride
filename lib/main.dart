import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:red_tailed_hawk/home_page.dart';
import 'package:red_tailed_hawk/sign_up_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(title: 'Corride Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isSwitched = true;
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
                      child: loginCard(),
                      flex: 6,
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }

  navigateToSignIn() {}

  Widget loginCard() {
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
                  _signUpButton(true, "Sign Up as a Traveller",
                      Icons.person_outline, context),
                  _signUpButton(false, "Sign Up as a Driver",
                      Icons.directions_car, context),
                ],
              ),
            ),
            _loginSignUpDivider(),
            Column(
              children: <Widget>[
                _textInput(Icons.mail, "Email address", false),
                _textInput(Icons.lock, "Password", true),
              ],
            ),
            MyAccountSwitchButton(),
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
}

Widget _loginButton(BuildContext context) {

  loginUser() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
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

Widget _signUpButton(bool forTraveller, String buttonText, IconData icon, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: InkWell(
        onTap: () {
          print("Sign In Pressed");
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

Widget _loginSignUpDivider() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: <Widget>[
      Container(
        height: 1.00,
        width: 107.00,
        color: Color(0xff707070),
      ),
      Text("OR", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      Container(
        height: 1.00,
        width: 107.00,
        color: Color(0xff707070),
      ),
    ],
  );
}

Widget _textInput(IconData icon, String placeholder, bool isPassword) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5.0),
    child: Container(
      height: 50.00,
      width: 268.00,
      decoration: BoxDecoration(
        color: Color(0xffeeeeee),
        borderRadius: BorderRadius.circular(15.00),
      ),
      child: Row(
        children: <Widget>[
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Color(0xffD4D4D4),
              borderRadius: BorderRadius.circular(15.00),
            ),
            child: Icon(
              icon,
              color: Color(0xff9E9E9E),
            ),
          ),
          Expanded(
            child: TextField(
              obscureText: isPassword,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 20.00),
                border: InputBorder.none,
                hintText: placeholder,
                hintStyle: TextStyle(
                    color: Color(0xff9E9E9E),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class MyAccountSwitchButton extends StatefulWidget {
  @override
  _MyAccountSwitchButtonState createState() => _MyAccountSwitchButtonState();
}

class _MyAccountSwitchButtonState extends State<MyAccountSwitchButton> {
  bool isSwitched = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text("Traveller"),
        Switch(
          onChanged: (value) {
            setState(() {
              isSwitched = value;
            });
          },
          value: isSwitched,
          activeTrackColor: Color(0xffFFD299),
          activeColor: Colors.orange,
        ),
        Text("Driver")
      ],
    );
  }
}
