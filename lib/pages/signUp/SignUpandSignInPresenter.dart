import 'package:firebase_auth/firebase_auth.dart';
import './ISignupandSignInpage.dart';
import './../../utils/MD5HashCodeConvert.dart';
import './../../utils/persistentStore.dart';

class SignUpandSignInPagePresenter implements ISignUpandSigninPagePresenter {
  ISignUpandSigninPage view;
  PersistantStore _persistantStore;

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
      print(user.email);
      _persistantStore.setEmail(email);
      view.onLoginSuccess();
    } catch (e) {
      print(e);
    }
  }

  @override
  void onSignUp(String email, String password) async {
    FirebaseUser user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: email, password: md5HashConvert(password));
    view.onSignUpSuccess();
  }
}
