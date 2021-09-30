import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pnc/calcul.dart';
import 'package:pnc/gite_class.dart';
import 'package:pnc/map_one_gite.dart';
import 'package:geolocator/geolocator.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

// This widget is the home page of your application. It is stateful, meaning
// that it has a State object (defined below) that contains fields that affect
// how it looks.

// This class is the configuration for the state. It holds the values (in this
// case the title) provided by the parent (in this case the App widget) and
// used by the build method of the State. Fields in a Widget subclass are
// always marked "final".

class GitesWidget extends StatefulWidget {
  GitesWidget({Key key}) : super(key: key);

  @override
  _MyGitesWidget createState() => _MyGitesWidget();
}

class _MyGitesWidget extends State<GitesWidget> {
  Future<List<Gite>> me;
  AutoCompleteTextField searchTextField;
  GlobalKey<AutoCompleteTextFieldState<Gite>> key = new GlobalKey();
  List<Gite> listNochange=[];

  final snackBar = SnackBar(content: Text('Le gîte est bien ajouté'));

  @override
  void initState() {
    super.initState();
    me = getPosition();
    listNochange = Calcul.favorisList;
  }
//final items = List<String>.generate(10000, (i) => "Gîte $i");

  Set<Gite> _listeGite = new Set<Gite>();

  /*
    Calenzana	Gîte communal	42.51140285511578, 8.85132301534121
    Bonifatu	Auberge de la Forêt	42.44215133782906, 8.854724540190047
    Galeria 	L’étape Marine	42.41121524151053, 8.64461698218744
    Galeria 	Auberge gîte/Hôtel « Le Filasorma »	42.41296390196426, 8.648488155199326
    Girolata	Girolata - Le cormoran voyageur	42.348903580628374, 8.61276192820879
    Girolata	La cabane du berger	42.349793719682665, 8.61311075519698
    Curzu	Gîte d'étape de Curzu	42.34887987527873, 8.612687086194077
    Serriera	L’Alivi	42.29999938271239, 8.707511253348033
    Ota	Chez Félix	42.2582717750638, 8.742718961581351
    Ota	Chez Marie	42.257511116318334, 8.742015497522956
    Evisa	Gîte U Poghju	42.25232615869495, 8.804539397522806
    Marignana	Gîte M. Ceccaldi,	42.236521533699346, 8.806045053345695
    E Case (Revinda)	Gîte d’étape E Case	42.188539446226784, 8.666452315905467
    Cargèse	Hôtel Punta e Mare	42.13701519717175, 8.598016353342025
    Cargèse	Hôtel Saint-Jean	42.1367211419656, 8.596449455189113

   */
  var latitude;
  var longitude;
  //GitesWidget(this.color);
  Future<List<Gite>> getPosition() async {
    //List items = <Gite>[];

    List<Gite> items = [];

    /*Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    if (position == null) position = await Geolocator.getLastKnownPosition();
    print(
        "here ${position.longitude.toString()}  ${position.latitude.toString()}");
    longitude = position.longitude;
    latitude = position.latitude;
    */
    var position =  await _determinePosition();


    longitude = position.longitude;
    latitude = position.latitude;
    items.add(new Gite(1, "Calenzana", 2, "Gîte communal",
        LatLng(42.51140285511578, 8.85132301534121)));
    items.add(new Gite(2, "Bonifatu", 4, "Auberge de la Forêt",
        LatLng(42.44215133782906, 8.854724540190047)));
    items.add(new Gite(3, "Galeria", 2, "L’étape Marine",
        LatLng(42.41121524151053, 8.64461698218744)));
    items.add(new Gite(4, "Galeria", 4, "Auberge gîte/Hôtel",
        LatLng(42.41296390196426, 8.648488155199326)));
    items.add(new Gite(5, "Girolata", 0, "Girolata - Le cormoran voyageur",
        LatLng(42.348903580628374, 8.61276192820879)));
    return items;
  }
  /*
  *
  * */

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

  Future<bool> checkEnabled() async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    return isLocationServiceEnabled;
  }

  @override
  Widget build(BuildContext context) {
    /*if(checkEnabled() != null){
      getPosition();
    }*/
    /*void clickedItem() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MapOneGiteWidget(snapshot.data[0])),
      );
    }*/
    return Column(
      children: [
        Container(
          color: Colors.green,
          child: Image.asset('assets/images/Image_accueil.png'),
        ),
        Container(
          alignment: Alignment.topCenter,
          child: searchTextField = AutoCompleteTextField<Gite>(
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.0,
            ),
            decoration: InputDecoration(
                suffixIcon: Container(
                  child: Icon(Icons.search),
                  //width: 85.0,
                  //height: 60.0,
                ),
                filled: true,
                fillColor: Color(0xFFFFFFFF),
                hintText: 'Rechercher un gîte',
                hintStyle: TextStyle(color: Colors.black)),
            itemBuilder: (context, item) {
              return Container(
                color: Colors.green,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      item.nom,
                      style: TextStyle(
                          fontSize: 16.0, color: Colors.white),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15.0),
                    ),
                    Text(
                      item.nom,
                      style: TextStyle(
                          fontSize: 16.0, color: Colors.white),
                    )
                  ],
                ),
              );
            },
            itemFilter: (item, query) {
              return item.nom
                  .toLowerCase()
                  .startsWith(query.toLowerCase());
            },
            itemSorter: (a, b) {
              return a.nom.compareTo(b.nom);
            },
            itemSubmitted: (item) {
              /*setState(() {
                searchTextField.textField.controller.text = item.nom;
                listNochange = Calcul.favorisList
                    .where((x) => x.nom == item.nom)
                    .toList();
                print("test");
              });*/

            },
            key : key,
            suggestions: listNochange,
            clearOnSubmit: false,
            textChanged: (a) {
              setState(() {
                /*if (Calcul.favorisList.length != listNochange.length) {
                  Calcul.favorisList = listNochange;
                }*/
                setState(() {
                  searchTextField.textField.controller.text = a;
                  listNochange = Calcul.favorisList
                      .where((x) => x.nom == a)
                      .toList();
                  print("test");
                });
              });
            },
          ),
        ),
        Expanded(
          child: FutureBuilder(
              future: me,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return (!snapshot.hasData)
                    ? Container(
                        child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.green)),
                      ))
                    : ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          var alreadyFavorite = Calcul.favorisList.contains(snapshot.data[index]);
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MapOneGiteWidget(snapshot.data[index])),
                              );
                            },
                            child: Card(
                              child: SizedBox(
                                height: 180,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 170,
                                      margin: EdgeInsets.all(7.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/${snapshot.data[index].id}_.png"),
                                              fit: BoxFit.fill)),
                                    ),
                                    Expanded(
                                      child: Column(children: <Widget>[
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                '${snapshot.data[index].nom}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 19),
                                              ),
                                            ),
                                            GestureDetector(
                                                child: Icon(
                                                  alreadyFavorite ? Icons.star:Icons.star_border,
                                              color: alreadyFavorite ? Colors.deepOrangeAccent:Colors.grey,
                                            ),
                                            onDoubleTap: (){
                                              Calcul.favorisList.add(snapshot.data[index]);
                                              setState(() {
                                                alreadyFavorite = Calcul.favorisList.contains(snapshot.data[index]);
                                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                              });
                                            } ),
                                          ],
                                        ),
                                        Container(
                                          child: Text(
                                            '${snapshot.data[index].commune}',
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.wifi_lock,
                                              color: Colors.green,
                                            ),
                                            Text(
                                              '${Calcul.distanceEnMeter(snapshot.data[index], latitude, longitude)}',
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.lock_clock,
                                              color: Colors.green,
                                            ),
                                            Text(
                                              '${Calcul.DureeEnMinutes(Calcul.calculDistance(snapshot.data[index], latitude, longitude))}',
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              (snapshot.data[index].note) >= 1
                                                  ? Icons.star
                                                  : Icons.star_border,
                                              color:
                                                  (snapshot.data[index].note) >= 1
                                                      ? Colors.amber
                                                      : Colors.grey,
                                            ),
                                            Icon(
                                              (snapshot.data[index].note) >= 2
                                                  ? Icons.star
                                                  : Icons.star_border,
                                              color:
                                                  (snapshot.data[index].note) >= 2
                                                      ? Colors.amber
                                                      : Colors.grey,
                                            ),
                                            Icon(
                                              (snapshot.data[index].note) >= 3
                                                  ? Icons.star
                                                  : Icons.star_border,
                                              color:
                                                  (snapshot.data[index].note) >= 3
                                                      ? Colors.amber
                                                      : Colors.grey,
                                            ),
                                            Icon(
                                              (snapshot.data[index].note) >= 4
                                                  ? Icons.star
                                                  : Icons.star_border,
                                              color:
                                                  (snapshot.data[index].note) >= 4
                                                      ? Colors.amber
                                                      : Colors.grey,
                                            ),
                                            Icon(
                                              (snapshot.data[index].note) >= 5
                                                  ? Icons.star
                                                  : Icons.star_border,
                                              color:
                                                  (snapshot.data[index].note) >= 5
                                                      ? Colors.amber
                                                      : Colors.grey,
                                            ),
                                          ],
                                        )
                                      ]),
                                    ),
                                  ],
                                ),
                              ),
                              elevation: 4,
                            ),
                          );
                        },
                      );
              }),
        ),
      ],
    );
  }
}

/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
