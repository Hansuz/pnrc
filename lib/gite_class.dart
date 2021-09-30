import 'package:google_maps_flutter/google_maps_flutter.dart';

class Gite  {
  int id;
  String nom;
  int note;
  String commune;
  LatLng lat;

  Gite(
    this.id ,
    this.nom ,
    this.note ,
    this.commune ,
    this.lat
  );

}
