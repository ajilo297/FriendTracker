import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import './ISignupandSignInpage.dart';
import './SignUpandSignInPresenter.dart';
import './../home/HomePage.dart';
import './../../utils/Item.dart';

class SignUpSignInPage extends StatefulWidget {
  SignUpSignInPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpSignInPageState createState() => _SignUpSignInPageState();
}

class _SignUpSignInPageState extends State<SignUpSignInPage>
    with SingleTickerProviderStateMixin
    implements ISignUpandSigninPage {

  GlobalKey<ScaffoldState> scaffoldKey;
  SignUpandSignInPagePresenter presenter;

  GlobalKey<FormState> loginFormKey;
  GlobalKey<FormState> registrationFormKey;
  TextEditingController passwordController = TextEditingController();
  TabController tabController;

  List<Item> items = List();
  Item item;
  DatabaseReference itemRef;

  String _email, _password;

  _SignUpSignInPageState() {
    scaffoldKey = GlobalKey<ScaffoldState>();
    loginFormKey = GlobalKey<FormState>();
    registrationFormKey = GlobalKey<FormState>();
    presenter = SignUpandSignInPagePresenter(this);
    tabController = TabController(vsync: this, length: 2);
  }

  @override
  void initState() {
    super.initState();
    // item = Item("", "");
    // final FirebaseDatabase database = FirebaseDatabase.instance; //Rather then just writing FirebaseDatabase(), get the instance.  
    // itemRef = database.reference().child('items');
    // itemRef.onChildAdded.listen(_onEntryAdded);
    // itemRef.onChildChanged.listen(_onEntryChanged);
  }

  bool loginValidateAndSave() {
    final form = loginFormKey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void loginValidateAndSubmit() {
    if (loginValidateAndSave()) {
      presenter.onLogin(_email, _password);
    }
  }

  bool signUpValidateAndSave() {
    final form = registrationFormKey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void signUpValidateAndSubmit() {
    if (signUpValidateAndSave()) {
      presenter.onSignUp(_email, _password);
    }
  }

  Widget loginScreen() => new Padding(
        padding: const EdgeInsets.all(20.0),
        child: new Form(
          key: loginFormKey,
          child: new ListView(
            children: <Widget>[
              new TextFormField(
                decoration: new InputDecoration(
                  hintText: 'xyz@gmail.com',
                  labelText: 'Email',
                  icon: const Icon(Icons.email),
                ),
                validator: (val) => !val.contains('@') ? 'Invalid Email' : null,
                onSaved: (val) => _email = val,
              ),
              new TextFormField(
                decoration: new InputDecoration(
                  labelText: 'Password',
                  icon: const Icon(Icons.lock_outline),
                ),
                validator: (val) =>
                    val.length < 6 ? 'Password too short' : null,
                onSaved: (val) => _password = val,
                obscureText: true,
              ),
              new Padding(
                padding: const EdgeInsets.only(top: 20.0),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
                width: double.infinity,
                height: 50,
                child: RaisedButton(
                  shape: StadiumBorder(),
                  color: Theme.of(context).primaryColorDark,
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: loginValidateAndSubmit,
                ),
              ),
            ],
          ),
        ),
      );

  Widget registrationScreen() => Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Form(
        key: registrationFormKey,
        child: ListView(
          children: <Widget>[
            Container(
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Username',
                  labelText: 'Username',
                  icon: const Icon(Icons.person),
                ),
                validator: (val) => val.isEmpty ? 'username is empty' : null,
                // onSaved: _signupState.setString_first_name,
              ),
              padding:
                  const EdgeInsets.only(bottom: 15.0, top: 0.0, right: 20.0),
            ),
            Container(
              child: Container(
                child: TextFormField(
                  decoration: InputDecoration(
                    icon: const Icon(Icons.mail),
                    hintText: 'xyz@gmail.com',
                    labelText: 'Email Id',
                  ),
                  validator: (val) =>
                      !val.contains('@') ? 'Invalid Email' : null,
                  onSaved: (val) => _email = val,
                  // onSaved: _signupState.setString_email,
                ),
                padding:
                    const EdgeInsets.only(bottom: 15.0, top: 0.0, right: 20.0),
              ),
              padding: const EdgeInsets.only(top: 10.0),
            ),
            Container(
              child: Container(
                child: TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: 'password',
                    labelText: 'password',
                    icon: const Icon(Icons.lock_outline),
                  ),
                  validator: (val) =>
                      val.length < 6 ? 'Password too short' : null,
                  onSaved: (val) => _password = val,
                  obscureText: true,
                ),
                padding:
                    const EdgeInsets.only(bottom: 15.0, top: 0.0, right: 20.0),
              ),
              padding: const EdgeInsets.only(top: 10.0),
            ),
            Container(
              child: Container(
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    labelText: 'Confirm Password',
                    icon: const Icon(Icons.lock),
                  ),
                  validator: (val) => val != passwordController.text
                      ? 'Password does not match'
                      : null,
                  obscureText: true,
                ),
                padding:
                    const EdgeInsets.only(bottom: 15.0, top: 0.0, right: 20.0),
              ),
              padding: const EdgeInsets.only(top: 10.0),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
              width: double.infinity,
              height: 50,
              child: RaisedButton(
                  shape: StadiumBorder(),
                  color: Theme.of(context).primaryColorDark,
                  child: Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: signUpValidateAndSubmit),
            ),
          ],
        ),
      ));
  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 2,
      child: new Scaffold(
        key: scaffoldKey,
        appBar: new PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: new Container(
            color: Theme.of(context).primaryColorDark,
            child: new SafeArea(
              child: Column(
                children: <Widget>[
                  new Expanded(child: new Container()),
                  new TabBar(
                    controller: tabController,
                    tabs: [
                      Tab(
                        child: new Text('Login',
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.center),
                      ),
                      Tab(
                        child: new Text(
                          'Registration',
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: new TabBarView(
          children: <Widget>[loginScreen(), registrationScreen()],
        ),
      ),
    );
  }

  @override
  void onLoginSuccess() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  @override
  void onSignUpSuccess() {
    scaffoldKey.currentState
        .showSnackBar(SnackBar(content: Text('account created Successfully')));
    tabController.animateTo(0);
  }
}
