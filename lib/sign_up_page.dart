import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
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
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 15.0,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.w900),
                        ),
                      ),
                      Card(
                        // color: Colors.yellow,
                        margin: EdgeInsets.symmetric(vertical: 15.0),
                        elevation: 3.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(30.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              TextField(
                                decoration: InputDecoration(labelText: 'EMAIL'),
                              ),
                              TextField(
                                decoration: InputDecoration(
                                  labelText: 'PHONE NUMBER',
                                  prefixText: '+60',
                                  prefixStyle:
                                      Theme.of(context).textTheme.subhead,
                                ),
                              ),
                              TextField(
                                decoration:
                                    InputDecoration(labelText: 'PASSWORD'),
                              ),
                              TextField(
                                decoration: InputDecoration(
                                    labelText: 'CONFIRM PASSWORD'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30.0,
                          vertical: 10.0,
                        ),
                        child: Card(
                          color: Theme.of(context).primaryColorDark,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              child: Text(
                                'Create Account',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// child: Container(
//   color: Colors.red,
//   child: Column(
//     children: <Widget>[
//       Container(
//         padding: EdgeInsets.symmetric(
//           vertical: 10.0,
//           horizontal: 15.0,
//         ),
//         alignment: Alignment.centerLeft,
//         child: Text(
//           'Sign Up',
//           style: TextStyle(fontSize: 30.0),
//         ),
//       ),
//       Text('asdasd'),
//     ],
//   ),
// ),

// Expanded(
//   child: SingleChildScrollView(
//     child: Column(
//       children: <Widget>[
//         Center(
//           child: Card(
//             color: Colors.yellow,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(15.0),
//             ),
//             margin: EdgeInsets.symmetric(vertical: 15.0),
//             child: Padding(
//               padding: EdgeInsets.all(30.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   TextField(
//                     decoration:
//                         InputDecoration(labelText: 'Name'),
//                   ),
//                   TextField(
//                     decoration:
//                         InputDecoration(labelText: 'Name'),
//                   ),
//                   TextField(
//                     decoration:
//                         InputDecoration(labelText: 'Name'),
//                   ),
//                   TextField(
//                     decoration:
//                         InputDecoration(labelText: 'Name'),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         Card(
//           color: Colors.orange,
//           child: Padding(
//             padding: EdgeInsets.all(15.0),
//             child: Text('Create Account'),
//           ),
//         ),
//       ],
//     ),
//   ),
// ),
// ),
