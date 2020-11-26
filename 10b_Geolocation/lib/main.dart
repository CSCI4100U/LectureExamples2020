import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Geolocation and Geocoding',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(title: 'Geolocation and Geocoding'),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var _geolocator = Geolocator();
  var _positionMessage = '';

  @override
  Widget build(BuildContext context) {
    _geolocator
        .checkGeolocationPermissionStatus()
        .then((GeolocationStatus status) {
      print('Geolocation status: $status');
    });

    _geolocator
        .getPositionStream(
          LocationOptions(
            accuracy: LocationAccuracy.best,
            timeInterval: 5000,
          ),
        )
        .listen(_updateLocationStream);

    String address = '301 Front St W, Toronto, ON';
    _geolocator.placemarkFromAddress(address).then((List<Placemark> places) {
      print('Forward geocoding results:');
      for (Placemark place in places) {
        print(
            '${place.name}, ${place.position.latitude}, ${place.position.longitude}');
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Your location:',
              textScaleFactor: 2.0,
            ),
            Text(
              _positionMessage,
              textScaleFactor: 1.5,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _updateLocationOneTime,
        tooltip: 'Update',
        child: Icon(Icons.update),
      ),
    );
  }

  void _updateLocationOneTime() {
    _geolocator
        .getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    )
        .then((Position userLocation) {
      setState(() {
        _positionMessage = userLocation.latitude.toString() +
            ', ' +
            userLocation.longitude.toString();
      });
    });
  }

  void _updateLocationStream(Position userLocation) {
    setState(() {
      _positionMessage = userLocation.latitude.toString() +
          ', ' +
          userLocation.longitude.toString();

      _geolocator
          .placemarkFromCoordinates(
              userLocation.latitude, userLocation.longitude)
          .then((List<Placemark> places) {
        print('Reverse geocoding results:');
        for (Placemark place in places) {
          print(
              '${place.name}, ${place.subThoroughfare}, ${place.thoroughfare}, ${place.locality}');
        }
      });
    });
  }
}
