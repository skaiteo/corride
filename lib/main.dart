import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

  Widget loginCard() {
    return Align(
      child: Container(
        height: 400,
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
            _commonButton(true),
            Text("Or"),
            _textInput(Icons.mail, "Email address", true),
            TextField(),
            _commonButton(false)
          ],
        ),
      ),
    );
  }
}

Widget _commonButton(bool hasIcon) {
  if (hasIcon) {
    return InkWell(
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
                    Icons.person_outline,
                    color: Colors.white,
                  )),
            ),
            Positioned.fill(
              left: 40,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Sign Up for New User",
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
    );
  } else {
    return InkWell(
      onTap: () {
        print("Login pressed");
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
    );
  }
}

Widget _textInput(IconData icon, String placeholder, bool isPassword) {
  return Container(
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
        TextField(
          decoration: InputDecoration(
            labelText: placeholder,
            labelStyle: TextStyle(
                color: Color(0xff9E9E9E),
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );
}
