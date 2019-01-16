import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class PersistantStore {
  static PersistantStore singleton;

  final String PREF_EMAIL = 'PREF_EMAIL';
  final String PREF_ID = 'PREF_ID';

  SharedPreferences _prefs;

  factory PersistantStore() {
    singleton ??= singleton = PersistantStore._internal();
    return singleton;
  }

  PersistantStore._internal() {
    SharedPreferences.getInstance().then<void>((SharedPreferences onValue) {
      _prefs = onValue;
    });
  }

  void resetStore() {
    setEmail(null);
  }

  Future<String> getEmail() async {
    return _prefs.getString(PREF_EMAIL);
  }

  Future<void> setEmail(String email) async {
    return _prefs.setString(PREF_EMAIL, email);
  }

  Future<String> getId() async {
    return _prefs.getString(PREF_ID);
  }

  Future<void> setId(String id) async {
    return _prefs.setString(PREF_ID, id);
  }
}
