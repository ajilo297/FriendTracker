import 'package:firebase_database/firebase_database.dart';

abstract class IHomePresenter {
  void onLogout();
  void onLocationChange(
      DataSnapshot currentUser, String longitude, String latitude);
}

abstract class IHomePage {}
