import 'package:google_maps_flutter/google_maps_flutter.dart';

class Meteo implements Iterable<Meteo> {
  int id;
  String nom;
  DateTime date;
  LatLng lat;

  Meteo(
    this.id ,
    this.nom ,
    this.date ,
    this.lat
  );

  @override
  bool any(bool Function(Meteo element) test) {
    // TODO: implement any
    throw UnimplementedError();
  }

  @override
  Iterable<R> cast<R>() {
    // TODO: implement cast
    throw UnimplementedError();
  }

  @override
  bool contains(Object element) {
    // TODO: implement contains
    throw UnimplementedError();
  }

  @override
  Meteo elementAt(int index) {
    // TODO: implement elementAt
    throw UnimplementedError();
  }

  @override
  bool every(bool Function(Meteo element) test) {
    // TODO: implement every
    throw UnimplementedError();
  }

  @override
  Iterable<T> expand<T>(Iterable<T> Function(Meteo element) f) {
    // TODO: implement expand
    throw UnimplementedError();
  }

  @override
  // TODO: implement first
  Meteo get first => throw UnimplementedError();

  @override
  Meteo firstWhere(bool Function(Meteo element) test, {Meteo Function() orElse}) {
    // TODO: implement firstWhere
    throw UnimplementedError();
  }

  @override
  T fold<T>(T initialValue, T Function(T previousValue, Meteo element) combine) {
    // TODO: implement fold
    throw UnimplementedError();
  }

  @override
  Iterable<Meteo> followedBy(Iterable<Meteo> other) {
    // TODO: implement followedBy
    throw UnimplementedError();
  }

  @override
  void forEach(void Function(Meteo element) f) {
    // TODO: implement forEach
  }

  @override
  // TODO: implement isEmpty
  bool get isEmpty => throw UnimplementedError();

  @override
  // TODO: implement isNotEmpty
  bool get isNotEmpty => throw UnimplementedError();

  @override
  // TODO: implement iterator
  Iterator<Meteo> get iterator => throw UnimplementedError();

  @override
  String join([String separator = ""]) {
    // TODO: implement join
    throw UnimplementedError();
  }

  @override
  // TODO: implement last
  Meteo get last => throw UnimplementedError();

  @override
  Meteo lastWhere(bool Function(Meteo element) test, {Meteo Function() orElse}) {
    // TODO: implement lastWhere
    throw UnimplementedError();
  }

  @override
  // TODO: implement length
  int get length => throw UnimplementedError();

  @override
  Iterable<T> map<T>(T Function(Meteo e) f) {
    // TODO: implement map
    throw UnimplementedError();
  }

  @override
  Meteo reduce(Meteo Function(Meteo value, Meteo element) combine) {
    // TODO: implement reduce
    throw UnimplementedError();
  }

  @override
  // TODO: implement single
  Meteo get single => throw UnimplementedError();

  @override
  Meteo singleWhere(bool Function(Meteo element) test, {Meteo Function() orElse}) {
    // TODO: implement singleWhere
    throw UnimplementedError();
  }

  @override
  Iterable<Meteo> skip(int count) {
    // TODO: implement skip
    throw UnimplementedError();
  }

  @override
  Iterable<Meteo> skipWhile(bool Function(Meteo value) test) {
    // TODO: implement skipWhile
    throw UnimplementedError();
  }

  @override
  Iterable<Meteo> take(int count) {
    // TODO: implement take
    throw UnimplementedError();
  }

  @override
  Iterable<Meteo> takeWhile(bool Function(Meteo value) test) {
    // TODO: implement takeWhile
    throw UnimplementedError();
  }

  @override
  List<Meteo> toList({bool growable = true}) {
    // TODO: implement toList
    throw UnimplementedError();
  }

  @override
  Set<Meteo> toSet() {
    // TODO: implement toSet
    throw UnimplementedError();
  }

  @override
  Iterable<Meteo> where(bool Function(Meteo element) test) {
    // TODO: implement where
    throw UnimplementedError();
  }

  @override
  Iterable<T> whereType<T>() {
    // TODO: implement whereType
    throw UnimplementedError();
  }

}
