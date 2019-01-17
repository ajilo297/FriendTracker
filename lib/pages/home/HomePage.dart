import 'package:flutter/material.dart';

import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import './IHomePage.dart';
import './HomePresenter.dart';
import './../signUp/SignUpandSignInPage.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import './../../utils/persistentStore.dart';
import './../friendlocation/FriendLocationPage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> implements IHomePage {
  HomePresenter presenter;
  GlobalKey<ScaffoldState> scaffoldKey;
  Map<String, double> currentLocation = new Map();
  PersistantStore _persistantStore;

  StreamSubscription<Map<String, double>> locationSubscription;
  Location location = Location();
  DataSnapshot currentUser;
  String error;

  static FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference itemRef = database.reference().child('friendsList');

  _HomePageState() {
    scaffoldKey = GlobalKey<ScaffoldState>();
  }

  @override
  void initState() {
    _persistantStore = PersistantStore();
    presenter = HomePresenter(this);
    currentLocation['latitude'] = 0.0;
    currentLocation['longitude'] = 0.0;
    initplatFormState();
    locationSubscription =
        location.onLocationChanged().listen((Map<String, double> result) {
      if (currentUser != null) {
        setState(() {
          currentLocation = result;
          presenter.onLocationChange(
              currentUser,
              currentLocation['longitude'].toString(),
              currentLocation['latitude'].toString());
        });
      }
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

  void onLogOut() {
    Navigator.pushNamed(context, '/login');
    presenter.onLogout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Friends List'),
        actions: <Widget>[
          FlatButton(
            child: Text('Logout'),
            onPressed: onLogOut,
          )
        ],
      ),
      body: new Container(
        child: FirebaseAnimatedList(
          defaultChild: Center(child: CircularProgressIndicator()),
          query: itemRef,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            DateTime date = DateTime.parse(snapshot.value['timestamp']);
            String timeStamp = DateFormat('yyyy-MM-dd  kk:mm').format(date);
            getCurrentUser(snapshot);
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FriendLocationPage(
                            id: snapshot.key,
                          )),
                );
              },
              child: new Container(
                margin: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      snapshot.value['name'],
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('last Update :' + timeStamp,
                        style: TextStyle(fontSize: 14.0)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void getCurrentUser(DataSnapshot snapshot) async {
    if (await _persistantStore.getEmail() == snapshot.value['emailId']) {
      currentUser = snapshot;
    }
  }
}
