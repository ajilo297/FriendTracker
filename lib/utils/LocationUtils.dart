import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'dart:async';
class LocationUtils {
  Map<String,double> currentLocation=new Map();
  StreamSubscription<Map<String,double>> locationSubscription;
  Location location=Location();
  LocationUtils(){
    currentLocation['latitude']=0.0;
    currentLocation['longitude']=0.0;
  }
}