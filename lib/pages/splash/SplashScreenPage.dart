import 'dart:async';

import 'package:flutter/material.dart';
import './../../utils/CheckConectivity.dart';
import './../../pages/signUp/SignUpandSignInPage.dart';
import './../../pages/home/HomePage.dart';
import './../../utils/persistentStore.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  GlobalKey<ScaffoldState> scaffoldKey;
  PersistantStore _persistantStore;
  @override
  void initState() {
    super.initState();
    _persistantStore = PersistantStore();
    scaffoldKey = GlobalKey<ScaffoldState>();

    Timer(Duration(seconds: 2), () => checkConection());
  }

  void checkConection() async {
    bool isConnected = await checkNetworkConnection();
    if (isConnected) {
      Navigator.pop(context);
      if (await _persistantStore.getEmail() != null) {
        Navigator.pushNamed(context, '/home');
      } else {
        Navigator.pushNamed(context, '/login');
      }
    } else {
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('check internet connectivity'),
        duration: Duration(seconds: 5),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.redAccent),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 50.0,
                        child: Icon(
                          Icons.child_friendly,
                          color: Colors.greenAccent,
                          size: 50.0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      Text(
                        'Friend Tracker',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
