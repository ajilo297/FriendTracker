import 'package:firebase_database/firebase_database.dart';

class Item {
  String key;
  String emailId;
  String latitude;
  String longitude;
  DateTime timestamp;

  Item(this.key, this.emailId, this.latitude, this.longitude, this.timestamp);

  Item.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        emailId = snapshot.value['emailId'],
        latitude = snapshot.value['latitude'],
        longitude = snapshot.value['longitude'],
        timestamp = snapshot.value['timestamp'];

  toJson() {
    return {
      'key': key,
      'emailId': emailId,
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': timestamp
    };
  }
}
