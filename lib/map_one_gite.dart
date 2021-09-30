import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pnc/calcul.dart';
import 'package:pnc/gite_class.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pnc/meteo_class.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class MapOneGiteWidget extends StatefulWidget {
  final Gite gite;

  MapOneGiteWidget(this.gite);
  @override
  mapWidget createState() => mapWidget(this.gite);
}

class mapWidget extends State<MapOneGiteWidget> {
  // this will hold the generated polylines
  Set<Polyline> _polylines = {};
  // this will hold each polyline coordinate as Lat and Lng pairs
  List<LatLng> polylineCoordinates = [];
// this is the key object - the PolylinePoints
// which generates every polyline between start and finish
  PolylinePoints polylinePoints = PolylinePoints();
  Future<LatLng> me;
  BitmapDescriptor mapMarker;
  LatLng myposition;

  @override
  void initState() {
    super.initState();
    setCostumMarker();
    me = _determinePosition();
    //me.then((value) => myposition = LatLng(value.latitude, value.longitude));
    _onPressedButton();
  }

  Future<LatLng> _determinePosition() async {
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
    //Position p = await Geolocator.getCurrentPosition();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    if (position == null) position = await Geolocator.getLastKnownPosition();
    myposition = LatLng(position.latitude, position.longitude);
    return myposition;
  }

  void setCostumMarker() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/destination_map_marker.png');
  }

  GoogleMapController mapController;
  Gite _gite;
  final Set<Marker> _markers = {};
  mapWidget(this._gite);
  //_markers.add(Marker())
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.setMapStyle(Util.mapStyle);
    //setMapPins();

    /*setState((){

    });*/
  }

  setPolylines() async {
    print("here1");
    //List<PointLatLng>
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyCJWR2W4kSzZ7rnDTRAq4ziOoQbcghb_iY",
      PointLatLng(myposition.latitude, myposition.longitude),
      PointLatLng(_gite.lat.latitude, _gite.lat.longitude),
      travelMode: TravelMode.driving,
    );
    //List<PointLatLng> result1 = polylinePoints.decodePolyline("_p~iF~ps|U_ulLnnqC_mqNvxq`@");
    print("ima here $result");
    if (result.points.isNotEmpty) {
      print("isNotEmpty");
      // loop through all PointLatLng points and convert them
      // to a list of LatLng, required by the Polyline
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    setState(() {
      // create a Polyline instance
      // with an id, an RGB color and the list of LatLng pairs
      print("here");
      Polyline polyline = Polyline(
        polylineId: PolylineId("poly"),
        color: Colors.blue,
        points: polylineCoordinates,
      );

      // add the constructed polyline as a set of points
      // to the polyline set, which will eventually
      // end up showing up on the map
      _polylines.add(polyline);

      _markers.add(
        Marker(
          markerId: MarkerId("ma localisation"),
          position: myposition,
          infoWindow:
              InfoWindow(title: "ma localisation", snippet: "point de départ"),
        ),
        //icon: mapMarker
      );
    });
  }

  void _onPressedButton() {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(widget.gite.lat.toString()),
          position: widget.gite.lat,
          infoWindow:
              InfoWindow(title: widget.gite.nom, snippet: widget.gite.commune),
        ),
        //icon: mapMarker
      );
    });
    getMeteo();
  }

  var latitude;
  var longitude;

  Future<bool> checkEnabled() async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    return isLocationServiceEnabled;
  }

  Future<List<Meteo>> getMeteo() async {
    //
    List<Meteo> listMeteo = new List();
    if (listMeteo.length == 0) {
      var url =
          'https://api.darksky.net/forecast/dc2b44bba13e594252e8c191a3e80548/37.8267,-122.4233';
      var url1 = Uri.https(
          'https://api.darksky.net/forecast/dc2b44bba13e594252e8c191a3e80548/37.8267,-122.4233',
          '/currently/time',
          {'q': '{http}'});
      http.Response response = await http.get(url1);
      List StationArray = jsonDecode(response.body);
      for (var i = 0; i < StationArray.length; i++) {
        print(StationArray[i].latitude);
      }
    }
    return listMeteo;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Stack(
          children: [
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: widget.gite.lat,
                zoom: 14.0,
              ),
              markers: _markers,
              polylines: _polylines,
            ),
            FutureBuilder(
                future: me,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return (!snapshot.hasData)
                      ? Container(
                          child: Center(
                          child: CircularProgressIndicator(
                              backgroundColor: Colors.red),
                        ))
                      : Container(
                          alignment: Alignment.bottomCenter,
                          margin: EdgeInsets.fromLTRB(0, 600, 0, 0),
                          color: Color(0xFF66BB6A),
                          padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                          child: Column(
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("${_gite.nom}",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 15))),
                              Expanded(
                                  child: Row(
                                children: [
                                  Expanded(
                                    child: Card(
                                      elevation: 5,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.alt_route_sharp),
                                          Text(
                                              '${Calcul.DureeEnMinutes(Calcul.calculDistance(_gite, snapshot.data.latitude, snapshot.data.longitude))}'),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Card(
                                      elevation: 5,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.lock_clock),
                                          Text(
                                              '${Calcul.distanceEnMeter(_gite, snapshot.data.latitude, snapshot.data.longitude)}'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                              Expanded(
                                  child: Row(
                                children: [
                                  Expanded(
                                    child: Card(
                                      elevation: 5,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.add_road,
                                            size: 13,
                                          ),
                                          Text("12°"),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Card(
                                      elevation: 5,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                (_gite.note) >= 1
                                                    ? Icons.star
                                                    : Icons.star_border,
                                                color: (_gite.note) >= 1
                                                    ? Colors.amber
                                                    : Colors.grey,
                                              ),
                                              Icon(
                                                (_gite.note) >= 2
                                                    ? Icons.star
                                                    : Icons.star_border,
                                                color: (_gite.note) >= 2
                                                    ? Colors.amber
                                                    : Colors.grey,
                                              ),
                                              Icon(
                                                (_gite.note) >= 3
                                                    ? Icons.star
                                                    : Icons.star_border,
                                                color: (_gite.note) >= 3
                                                    ? Colors.amber
                                                    : Colors.grey,
                                              ),
                                              Icon(
                                                (_gite.note) >= 4
                                                    ? Icons.star
                                                    : Icons.star_border,
                                                color: (_gite.note) >= 4
                                                    ? Colors.amber
                                                    : Colors.grey,
                                              ),
                                              Icon(
                                                (_gite.note) >= 5
                                                    ? Icons.star
                                                    : Icons.star_border,
                                                color: (_gite.note) >= 5
                                                    ? Colors.amber
                                                    : Colors.grey,
                                              ),
                                            ],
                                          ),
                                          Text((_gite.note > 3)
                                              ? "Difficile"
                                              : "Facile"),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )),
                              Row(
                                children: [
                                  Container(
                                      child: Expanded(
                                          child: GestureDetector(
                                    child: Card(
                                      elevation: 6,
                                      child: Text(
                                        "Tracer le chemin",
                                        style : TextStyle(fontWeight: FontWeight.bold,color: Colors.black, fontSize: 17),
                                        textAlign: TextAlign.center,
                                      ),
                                    margin: EdgeInsets.all(10.0),),
                                    onTap: setPolylines,
                                  ))),
                                ],
                              )
                            ],
                          ));
                })
          ],
        ));
  }
}

class Util {
  static String mapStyle = '''
  [
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#ebe3cd"
      }
    ]
  },
  {
    "elementType": "labels",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#523735"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#f5f1e6"
      }
    ]
  },
  {
    "featureType": "administrative",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#c9b2a6"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#dcd2be"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#ae9e90"
      }
    ]
  },
  {
    "featureType": "administrative.neighborhood",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "landscape.natural",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dfd2ae"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dfd2ae"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#93817c"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#a5b076"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#447530"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f5f1e6"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#fdfcf8"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f8c967"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#e9bc62"
      }
    ]
  },
  {
    "featureType": "road.highway.controlled_access",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e98d58"
      }
    ]
  },
  {
    "featureType": "road.highway.controlled_access",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#db8555"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#806b63"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dfd2ae"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#8f7d77"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#ebe3cd"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dfd2ae"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#b9d3c2"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#92998d"
      }
    ]
  }
]
  ''';
}
