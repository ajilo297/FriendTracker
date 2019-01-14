import 'package:flutter/material.dart';

import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> scaffoldKey;
  Map<String, double> currentLocation = new Map();
  StreamSubscription<Map<String, double>> locationSubscription;
  Location location = Location();
  String error;

  _HomePageState() {
    scaffoldKey = GlobalKey<ScaffoldState>();
  }

  @override
  void initState() {
    currentLocation['latitude'] = 0.0;
    currentLocation['longitude'] = 0.0;
    initplatFormState();
    locationSubscription =
        location.onLocationChanged().listen((Map<String, double> result) {
      setState(() {
        currentLocation = result;
      });
    });
  }

  initplatFormState() async {
    Map<String, double> myLocation;
    try {
      myLocation = await location.getLocation();
      error = '';
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED')
        error = 'Permission denied';
      else if (e.code == 'PERMISSION_DENIED_NEVER_ASK')
        error = 'Permission denied enable the location in app';
      myLocation = null;
    }
    setState(() {
      currentLocation = myLocation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Friends List'),
        actions: <Widget>[
          FlatButton(
            child: Text('Logout'),
            onPressed: () {},
          )
        ],
      ),
      body: new Container(
        child: Center(
          child: Text('Longitude  -  ' +
              currentLocation['longitude'].toString() +
              '\n' +
              'Latitude  -  ' +
              currentLocation['latitude'].toString()),
        ),
      ),
    );
  }
}
