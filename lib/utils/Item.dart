import 'package:firebase_database/firebase_database.dart';

class Item {
  String key;
  String emailId;
  String latitude;
  String longitude;
  String name;
  String timestamp;

  Item(this.key, this.emailId, this.latitude, this.longitude,this.name, this.timestamp);

  Item.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        emailId = snapshot.value['emailId'],
        latitude = snapshot.value['latitude'],
        longitude = snapshot.value['longitude'],
        name = snapshot.value['name'],
        timestamp = snapshot.value['timestamp'];

  toJson() {
    return {
      'key': key,
      'emailId': emailId,
      'latitude': latitude,
      'longitude': longitude,
      'name': name,
      'timestamp': timestamp
    };
  }
}
