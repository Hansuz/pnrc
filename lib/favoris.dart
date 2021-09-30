import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pnc/calcul.dart';
import 'package:pnc/gite_class.dart';
import 'package:pnc/map_one_gite.dart';

class FavorisWidget extends StatefulWidget {
  FavorisWidget();
  @override
  _FavorisWidget createState() => _FavorisWidget();
}

class _FavorisWidget extends State<FavorisWidget>{
  _FavorisWidget();
  var latitude = 11.0;
  var longitude = 44.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: Colors.green,
          child: new Image.asset('assets/images/Image_accueil.png'),
        ),
        Container(
          padding: EdgeInsets.only(top: 150,right: 20),
          alignment: Alignment.topCenter,
          child: Text("Favoris", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white, fontSize: 19),),
        ),
        ListView.builder(
          padding: EdgeInsets.only(top: 190),
          itemCount: Calcul.favorisList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MapOneGiteWidget(Calcul.favorisList[index])),
                );
              },
              child: Card(
                child: SizedBox(
                  height: 180,
                  child: Row(
                    children: [
                      Container(
                        width: 130,
                        height: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            image: DecorationImage(
                                image: AssetImage("assets/images/${Calcul.favorisList[index].id}.png"),
                                fit: BoxFit.fill)),
                      ),
                      Expanded(
                        child: Column(children: <Widget>[
                          Text(
                            '${Calcul.favorisList[index].nom}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 19),
                          ),
                          Container(
                            child: Text(
                              '${Calcul.favorisList[index].commune}',
                            ),
                          ),Row(
                            children: [
                              Icon(
                                Icons.wifi_lock,
                                color: Colors.green,
                              ),
                              Text(
                                '${Calcul.distanceEnMeter(Calcul.favorisList[index], latitude, longitude)}',
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
                                '${Calcul.DureeEnMinutes(Calcul.calculDistance(Calcul.favorisList[index], latitude, longitude))}',
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                (Calcul.favorisList[index].note) >= 1
                                    ? Icons.star
                                    : Icons.star_border,
                                color: (Calcul.favorisList[index].note) >= 1
                                    ? Colors.amber
                                    : Colors.grey,
                              ),
                              Icon(
                                (Calcul.favorisList[index].note) >= 2
                                    ? Icons.star
                                    : Icons.star_border,
                                color: (Calcul.favorisList[index].note) >= 2
                                    ? Colors.amber
                                    : Colors.grey,
                              ),
                              Icon(
                                (Calcul.favorisList[index].note) >= 3
                                    ? Icons.star
                                    : Icons.star_border,
                                color: (Calcul.favorisList[index].note) >= 3
                                    ? Colors.amber
                                    : Colors.grey,
                              ),
                              Icon(
                                (Calcul.favorisList[index].note) >= 4
                                    ? Icons.star
                                    : Icons.star_border,
                                color: (Calcul.favorisList[index].note) >= 4
                                    ? Colors.amber
                                    : Colors.grey,
                              ),
                              Icon(
                                (Calcul.favorisList[index].note) >= 5
                                    ? Icons.star
                                    : Icons.star_border,
                                color: (Calcul.favorisList[index].note) >= 5
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
        )
        
      ],
    );
  }
}
