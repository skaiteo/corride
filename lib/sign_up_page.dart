import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:red_tailed_hawk/models/user_model.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();

  final bool isDriver;

  SignUpPage({@required this.isDriver});
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _emailCtrl = TextEditingController(
    text: 'chaelee7@email.com',
  );
  TextEditingController _nameCtrl = TextEditingController(
    text: 'chaelee7',
  );
  TextEditingController _phoneCtrl = TextEditingController(
    text: '1239876',
  );
  TextEditingController _pwCtrl = TextEditingController(
    text: 'secret',
  );
  TextEditingController _pwConfCtrl = TextEditingController(
    text: 'secret',
  );
  TextEditingController _carPlateCtrl = TextEditingController(
    text: 'QAD2993',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) {
          _submitForm() async {
            // TODO: set button loading
            bool success = false;
            if (_nameCtrl.text != '' &&
                _emailCtrl.text != '' &&
                _phoneCtrl.text != '' &&
                _pwCtrl.text != '' &&
                _pwConfCtrl.text != '') {
              if (widget.isDriver) {
                success = await Driver.createDriver(
                  _nameCtrl.text,
                  _emailCtrl.text,
                  '60' + _phoneCtrl.text,
                  _pwCtrl.text,
                  _carPlateCtrl.text,
                );
              } else {
                success = await Traveller.createTraveller(
                  _nameCtrl.text,
                  _emailCtrl.text,
                  '60' + _phoneCtrl.text,
                  _pwCtrl.text,
                );
              }
            } else {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('Please fill in all fields'),
                ),
              );
            }
            if (success) {
              print('Created');
              final newUser = widget.isDriver
                  ? await Driver.loginDriver(
                      _emailCtrl.text,
                      _pwCtrl.text,
                    )
                  : await Traveller.loginTraveller(
                      _emailCtrl.text,
                      _pwCtrl.text,
                    );
              // TODO: If possible, pushAndRemoveUntil
              Navigator.of(context).pop(newUser);
              // TODO: unset button loading
            } else {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('Something went wrong'),
                ),
              );
            }
          }

          return SafeArea(
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
                            margin: EdgeInsets.symmetric(
                              vertical: 15.0,
                              horizontal: 5.0,
                            ),
                            elevation: 3.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Padding(
                              padding:
                                  EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 30.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  TextField(
                                    controller: _nameCtrl,
                                    decoration: InputDecoration(
                                      labelText: 'NAME',
                                    ),
                                  ),
                                  TextField(
                                    controller: _emailCtrl,
                                    decoration: InputDecoration(
                                      labelText: 'EMAIL',
                                    ),
                                  ),
                                  TextField(
                                    controller: _phoneCtrl,
                                    decoration: InputDecoration(
                                      labelText: 'PHONE NUMBER',
                                      prefixText: '+60',
                                      prefixStyle:
                                          Theme.of(context).textTheme.subhead,
                                    ),
                                  ),
                                  Visibility(
                                    visible: widget.isDriver,
                                    child: TextField(
                                      controller: _carPlateCtrl,
                                      // TODO: look up formatters for text input
                                      decoration: InputDecoration(
                                        labelText: 'CAR PLATE NUMBER',
                                      ),
                                    ),
                                  ),
                                  TextField(
                                    controller: _pwCtrl,
                                    decoration: InputDecoration(
                                      labelText: 'PASSWORD',
                                    ),
                                    obscureText: true,
                                  ),
                                  TextField(
                                    controller: _pwConfCtrl,
                                    decoration: InputDecoration(
                                      labelText: 'CONFIRM PASSWORD',
                                    ),
                                    obscureText: true,
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
                            child: SizedBox(
                              height: 50.0,
                              width: double.infinity,
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                color: Theme.of(context).primaryColorDark,
                                child: Text(
                                  'Create Account',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17.0,
                                  ),
                                ),
                                onPressed: _submitForm,
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
          );
        },
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
