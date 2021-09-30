
import 'package:pnc/gite_class.dart';
import 'dart:math';
import 'package:geolocator/geolocator.dart';

class Calcul{
  static List<Gite> favorisList=[];
  // calculate the distance (in meters) between two geocoordinates
  static double calculDistance(Gite g,double latitude,double longitude){
    // distance euclidienne
    //https://geodesie.ign.fr/contenu/fichiers/Distance_longitude_latitude.pdf
    //return sqrt((g.lat.latitude - latitude) * (g.lat.latitude - latitude) + (g.lat.longitude - longitude) * (g.lat.longitude - longitude));
    return Geolocator.distanceBetween(g.lat.longitude, g.lat.latitude, longitude, latitude);
  }

  static distanceEnMeter(Gite g,double latitude,double longitude){
    var distance = calculDistance(g,latitude,longitude);
    return (distance>1000 ) ? (distance~/1000).toString()+ " km "+ (distance%1000).toInt().toString() + " m" : distance.toInt().toString()+ " m";
  }

  static double calculDuree(double distance){
      return distance/3;
  }

  static String DureeEnMinutes(double distance){
    var secondes = calculDuree(distance).toInt();
    int minutes,heurs;
    minutes = secondes~/60;
    if(minutes<1){
      return secondes.toString() + "s";
    }else{
      heurs = minutes ~/ 60;
      if(heurs<1){
        return minutes.toString() +" min "+(secondes % 60).toString() + " s";
      }else{
        return heurs.toString() +" h "+(minutes % 60).toString() +" m "+(secondes % 60).toString() + " s";
      }
    }


  }

}