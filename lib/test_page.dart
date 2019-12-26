import 'package:flutter/material.dart';
import 'package:red_tailed_hawk/models/request_model.dart';

class TestButtonsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Site'),
      ),
      body: Column(
        children: <Widget>[
          Wrap(
            children: <Widget>[
              RaisedButton(
                child: Text('Test print'),
                onPressed: () {
                  print('sample');
                },
              ),
              RaisedButton(
                child: Text('Fetch requests'),
                onPressed: () async {
                  List requests = await Request.fetchRequests(travellerId: "2");
                  print('length: ${requests.length}');
                  for (var i = 0; i < requests.length; i++) {
                    print('$i: ${requests[i].status}');
                  }
                },
              ),
              RaisedButton(
                child: Text('Create request'),
                onPressed: () async {
                  bool result = await Request.createRequest(
                    travellerId: "2",
                    driverId: "5",
                    tripId: "2",
                  );
                  print(result);
                },
              ),
              RaisedButton(
                child: Text('Accept request'),
                onPressed: () async {
                  bool result = await Request.acceptRequest(
                    driverId: "5",
                    tripId: "2",
                  );
                  print(result);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
