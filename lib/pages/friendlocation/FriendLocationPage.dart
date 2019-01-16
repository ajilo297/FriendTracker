import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import './IFriendLocation.dart';
import './FriendLocationPresenter.dart';

class FriendLocationPage extends StatefulWidget {
  FriendLocationPage({this.id, Key key, this.title}) : super(key: key);

  final String title;
  final String id;

  @override
  _FriendLocationPageState createState() => _FriendLocationPageState(id);
}

class _FriendLocationPageState extends State<FriendLocationPage>
    implements IFriendLocationPage {
  FriendLocationPresenter presenter;
  GlobalKey<ScaffoldState> scaffoldKey;
  GoogleMapController mapController;
  DataSnapshot currentUser;
  static FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference itemRef = database.reference().child('friendsList');

  _FriendLocationPageState(String key) {
    itemRef.child(key).once().then((onValue) {
      setState(() {
        currentUser = onValue;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    presenter = FriendLocationPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: currentUser != null
              ? Text(currentUser.value['name'] + ' Location')
              : Text('Location'),
        ),
        body: currentUser != null
            ? new Container(
                padding: EdgeInsets.all(16.0),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  options: GoogleMapOptions(
                    cameraPosition: CameraPosition(
                      bearing: 270.0,
                      tilt: 30.0,
                      target: LatLng(
                          double.parse(currentUser.value['latitude']),
                          double.parse(currentUser.value['longitude'])),
                      zoom: 11.0,
                    ),
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.addMarker(
      MarkerOptions(
        position: LatLng(double.parse(currentUser.value['latitude']),
            double.parse(currentUser.value['longitude'])),
        infoWindowText: InfoWindowText('location', currentUser.value['name']),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
  }
}
