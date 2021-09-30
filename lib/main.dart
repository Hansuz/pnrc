import 'package:flutter/material.dart';
import 'package:pnc/accueil.dart';
import 'package:pnc/gites.dart';
import 'package:pnc/favoris.dart';
import 'package:pnc/map_all_activity.dart';
import 'package:pnc/profil.dart';
import 'package:pnc/randonnees.dart';
import 'package:pnc/activites.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PNR',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(title: 'Parc Naturel Régional Corse'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 2;
  final List<Widget> _children = [
    MapAllActivityWidget(),
    FavorisWidget(),
    AccueilWidget(),
    GitesWidget(),
    ProfilWidget()
  ];
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
    });
  }

  @override
  Widget build(BuildContext context) {
    void onTabTapped(int index) {
      setState(() {
        _currentIndex = index;
      });
    }

    return Scaffold(
      /*appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),*/
      body: _children[_currentIndex], // new
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, //_currentIndex, // new
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(
              Icons.map_outlined,
              color: Colors.black,
            ),
            activeIcon: new Icon(
              Icons.map_outlined,
              color: Color(0xffe84249),
            ),
            title: new Text(
              'Randonnées',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            backgroundColor: Color(0xffEFEFEF),
          ),
          BottomNavigationBarItem(
            icon: new Icon(
              Icons.star_border,
              color: Colors.black,
            ),
            activeIcon: new Icon(
              Icons.star_border,
              color: Color(0xffe84249),
            ),
            title: new Text(
              'Favoris',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            backgroundColor: Color(0xffEFEFEF),
          ),
          BottomNavigationBarItem(
            icon: new Icon(
              Icons.home_outlined,
              color: Colors.black,
            ),
            activeIcon: new Icon(
              Icons.home_outlined,
              color: Color(0xffe84249),
            ),
            title: new Text(
              'Accueil',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            backgroundColor: Color(0xffEFEFEF),
          ),
          BottomNavigationBarItem(
            icon: new Icon(
              Icons.settings_outlined,
              color: Colors.black,
            ),
            activeIcon: new Icon(
              Icons.settings_outlined,
              color: Color(0xffe84249),
            ),
            title: new Text(
              'Paramètres',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            backgroundColor: Color(0xffEFEFEF),
          ),
          BottomNavigationBarItem(
            icon: new Icon(
              Icons.perm_identity,
              color: Colors.black,
            ),
            activeIcon: new Icon(
              Icons.perm_identity,
              color: Color(0xffe84249),
            ),
            title: new Text(
              'Profil',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            backgroundColor: Color(0xffEFEFEF),
          ),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
