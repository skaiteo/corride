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
              height: 100.0,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Placeholder(
            fallbackHeight: 300.0,
          ),
          Placeholder(
            fallbackHeight: 300.0,
          ),
          Placeholder(
            fallbackHeight: 300.0,
          ),
        ],
      ),
    );
  }
}

class CustomOval extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    Rect rect = Rect.fromLTRB(0.0, -size.height, size.width, size.height);
    return rect;
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    // TODO: implement shouldReclip
    return null;
  }
}
