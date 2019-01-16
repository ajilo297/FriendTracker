import './../../utils/persistentStore.dart';
import './IHomePage.dart';
import 'package:firebase_database/firebase_database.dart';
import './../../utils/Item.dart';

class HomePresenter implements IHomePresenter {
  IHomePage view;
  PersistantStore _persistantStore;

  HomePresenter(IHomePage view) {
    this.view = view;
    _persistantStore = new PersistantStore();
  }

  @override
  void onLogout() {
    _persistantStore.resetStore();
  }

  @override
  void onLocationChange(
      DataSnapshot currentUser, String longitude, String latitude) async {
    Item item = Item(
        currentUser.value['key'],
        currentUser.value['emailId'],
        latitude,
        longitude,
        currentUser.value['name'],
        DateTime.now().toString());
    final FirebaseDatabase database = FirebaseDatabase.instance;
    DatabaseReference itemRef = database.reference().child('friendsList');
    itemRef.child(currentUser.key).update(item.toJson()).then((onValue){
    });
  }
}
