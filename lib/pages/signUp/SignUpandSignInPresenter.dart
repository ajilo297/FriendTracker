import 'package:firebase_auth/firebase_auth.dart';
import './ISignupandSignInpage.dart';
import './../../utils/MD5HashCodeConvert.dart';
import './../../utils/persistentStore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:location/location.dart';
import './../../utils/Item.dart';

class SignUpandSignInPagePresenter implements ISignUpandSigninPagePresenter {
  ISignUpandSigninPage view;
  PersistantStore _persistantStore;
  Map<String, double> currentLocation = new Map();
  List<Item> items = new List();

  SignUpandSignInPagePresenter(ISignUpandSigninPage view) {
    this.view = view;
    _persistantStore = new PersistantStore();
  }
  @override
  void onLogin(String email, String password) async {
    try {
      FirebaseUser user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email, password: md5HashConvert(password));

      _persistantStore.setEmail(user.email);
      _persistantStore.setId(user.uid);
      view.onLoginSuccess();
    } catch (e) {
      print(e);
    }
  }

  @override
  void onSignUp(String email, String password,String name) async {
    FirebaseUser user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: email, password: md5HashConvert(password));
    currentLocation = await Location().getLocation();
    Item item = Item(
        user.uid,
        user.email,
        currentLocation['latitude'].toString(),
        currentLocation['longitude'].toString(),
        name,
        DateTime.now().toString());
    final FirebaseDatabase database = FirebaseDatabase.instance;
    DatabaseReference itemRef = database.reference().child('friendsList');
    itemRef.push().set(item.toJson());
    
    view.onSignUpSuccess();
  }

 
}
