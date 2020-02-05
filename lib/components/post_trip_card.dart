import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:numberpicker/numberpicker.dart';
import 'package:red_tailed_hawk/models/sp_helper.dart';
import 'package:red_tailed_hawk/models/trip_model.dart';

enum SearchType { destination, date, pax }

class PostTripCard extends StatefulWidget {
  @override
  _PostTripCardState createState() => _PostTripCardState();
}

class _PostTripCardState extends State<PostTripCard> {
  // TextEditingController _destCtrlr = TextEditingController();
  // TextEditingController _dateCtrlr = TextEditingController();
  // TextEditingController _paxCtrlr = TextEditingController();

  // void dispose() {
  //   _destCtrlr.dispose();
  //   _dateCtrlr.dispose();
  //   _paxCtrlr.dispose();
  //   super.dispose();
  // }
  List<DateTime> _pickedDates = [];
  int _pickedPax;
  String _pickedDest = '';

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 4.0,
      // color: Colors.grey[200],
      margin: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 25.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 7.0),
              child: Text(
                'Post a Trip',
                style: Theme.of(context).textTheme.title,
              ),
            ),
            // _buildSearchFields(context, SearchType.destination),
            SearchField(
              // iconData: Icons.search,
              // searchHintText: 'Enter your destination',
              // controller: _destCtrlr,
              // onTapCallback: () {},
              searchType: SearchType.destination,
              onComplete: (String dest) {
                setState(() {
                  _pickedDest = dest;
                });
              },
              // readOnly: false,
            ),
            SearchField(
              // iconData: Icons.date_range,
              // searchHintText: 'Select your dates',
              // controller: _dateCtrlr,
              searchType: SearchType.date,
              onComplete: (List<DateTime> dates) {
                setState(() {
                  _pickedDates = dates;
                });
              },
            ),
            SearchField(
              // iconData: Icons.people,
              // searchHintText: 'Select number of pax',
              // controller: _paxCtrlr,
              searchType: SearchType.pax,
              onComplete: (int paxNumber) {
                setState(() {
                  _pickedPax = paxNumber;
                });
              },
            ),
            // Container(
            //   padding: EdgeInsets.symmetric(vertical: 7.0),
            //   alignment: Alignment.center,
            //   child: Container(
            //     color: Colors.grey,
            //     height: 20.0,
            //     width: 100.0,
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 7.0),
              child: SizedBox(
                height: 50.0,
                width: double.infinity,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.orange,
                  disabledColor: Colors.grey,
                  child: Text(
                    'Post Trip',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.0,
                    ),
                  ),
                  onPressed: (_pickedDest == '' ||
                          _pickedDates.isEmpty ||
                          _pickedPax == null)
                      ? null
                      : () async {
                          print('Button press by traveller to post a new trip');
                          print(_pickedDest);
                          print(_pickedDates);
                          print(_pickedPax);
                          bool confirm = await showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                title: Text('Confirm New Trip'),
                                content: Row(
                                  children: <Widget>[
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Destination:   '),
                                        Text('Start date: '),
                                        Text('End date: '),
                                        Text('Pax:'),
                                      ],
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text('$_pickedDest'),
                                          Text(
                                            '${_pickedDates[0].year}/${_pickedDates[0].month}/${_pickedDates[0].day}',
                                          ),
                                          Text(
                                            // (_pickedDates.length == 1)
                                            //     ? '${_pickedDates[0].year}/${_pickedDates[0].month}/${_pickedDates[0].day}'
                                            '${_pickedDates[1].year}/${_pickedDates[1].month}/${_pickedDates[1].day}',
                                          ),
                                          Text('$_pickedPax'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                  ),
                                  FlatButton(
                                    child: Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                          if (confirm == true) {
                            print('creating trip');
                            final user = await SpHelper.getUser();
                            bool created = await Trip.createTrip(
                              userId: user.id,
                              dest: _pickedDest,
                              startDate: _pickedDates[0],
                              endDate:
                                  /* (_pickedDates.length == 1)
                                  ? _pickedDates[0]
                                  :  */
                                  _pickedDates[1],
                            );
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(
                                (created)
                                    ? 'Post created!'
                                    : 'Something went wrong',
                              ),
                            ));
                            if (created == true) {
                              // TODO: clear fields
                            }
                          }
                        },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchField extends StatefulWidget {
  SearchField({
    @required this.searchType,
    // @required this.iconData,
    // @required this.searchHintText,
    // @required this.controller,
    this.onComplete,
  });

  final SearchType searchType;
  // final IconData iconData;
  // final String searchHintText;
  final onComplete;
  // final TextEditingController controller;
  // final bool readOnly;

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _handleDestTap() {}

    _handlePaxTap() async {
      int paxNumber = await showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return NumberPickerDialog.integer(
            title: Text('Number of Pax'),
            minValue: 1,
            maxValue: 10,
            initialIntegerValue: 1,
          );
        },
      );

      print(paxNumber);
      _controller.text = (paxNumber == null) ? '' : '$paxNumber';
      widget.onComplete(paxNumber);
    }

    _handleDateTap() async {
      final List<DateTime> picked = await DateRagePicker.showDatePicker(
        context: context,
        firstDate: DateTime.now().subtract(Duration(days: 1)),
        initialFirstDate: DateTime.now(),
        initialLastDate: DateTime.now().add(Duration(days: 1)),
        lastDate: DateTime.now().add(Duration(days: 30)),
      );

      if (picked != null) {
        print(picked);
        String dateStr = '';
        if (picked.length == 2 && picked[0].compareTo(picked[1]) != 0)
          // Compare first and last, if there is a diff, only then set dateStr to below
          dateStr =
              '${picked[0].year}/${picked[0].month}/${picked[0].day} - ${picked[1].year}/${picked[1].month}/${picked[1].day}';
        else
          dateStr = '${picked[0].year}/${picked[0].month}/${picked[0].day}';
        _controller.text = dateStr;

        widget.onComplete(picked);
      }
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7.0),
      child: Container(
        // width: double.infinity,
        height: 50.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.grey[200],
        ),
        child: Row(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.0 / 1.0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.grey[350],
                ),
                child: Icon(
                  (widget.searchType == SearchType.destination)
                      ? Icons.search
                      : (widget.searchType == SearchType.date)
                          ? Icons.date_range
                          : Icons.people,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: TextField(
                  readOnly: (widget.searchType == SearchType.destination)
                      ? false
                      : true,
                  onChanged: (widget.searchType == SearchType.destination)
                      ? widget.onComplete
                      : (_) {},
                  // enabled: false,
                  onTap: (widget.searchType == SearchType.destination)
                      ? _handleDestTap
                      : (widget.searchType == SearchType.date)
                          ? _handleDateTap
                          : _handlePaxTap,
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: (widget.searchType == SearchType.destination)
                        ? 'Enter your destination'
                        : (widget.searchType == SearchType.date)
                            ? 'Select your dates'
                            : 'Select number of pax',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
