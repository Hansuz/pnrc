import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pnc/calcul.dart';
import 'package:pnc/gite_class.dart';
import 'package:pnc/map_one_gite.dart';
import 'package:geolocator/geolocator.dart';

// This widget is the home page of your application. It is stateful, meaning
// that it has a State object (defined below) that contains fields that affect
// how it looks.

// This class is the configuration for the state. It holds the values (in this
// case the title) provided by the parent (in this case the App widget) and
// used by the build method of the State. Fields in a Widget subclass are
// always marked "final".

class ProfilWidget extends StatefulWidget {
  ProfilWidget({Key key}) : super(key: key);
  //final Color color;
  @override
  _ProfilWidget createState() => _ProfilWidget();
}

class _ProfilWidget extends State<ProfilWidget> {

  @override
  void initState() {
    super.initState();

  }






  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.green,
          padding: EdgeInsets.only(top: 20),
          child: new Image.asset('assets/images/Image_accueil.png'),
        ),
        Column(
          children: [
            Expanded(child:
            Icon(Icons.face))
          ],
        )
      ],
    );
  }
}

/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}
