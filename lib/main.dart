import 'package:flutter/material.dart';
import './pages/splash/SplashScreenPage.dart';
import './pages/signUp/SignUpandSignInPage.dart';
import './pages/home/HomePage.dart';


void main() => runApp(MyApp());

final Map<String, WidgetBuilder> routes = {
  '/login'  : (BuildContext context) => SignUpSignInPage(),
  '/home': (BuildContext context) =>  HomePage(),
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      routes: routes,
    );
  }
}

