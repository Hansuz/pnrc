import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AccueilWidget extends StatelessWidget {
  AccueilWidget();
  Color GreenPNRC = Color(0xff92b474);
  Color YellowPNRC = Color(0xfffed061);
  Color RedPNRC = Color(0xffe84249);

  final TextEditingController _controller = new TextEditingController();
  var activites = ['Randonnées', 'Gîtes'];
  var thematiques = ['Montagne', 'Fôret', 'Bord de mer', 'Historique'];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: new Column(
            children: <Widget>[
              Container(
                color: GreenPNRC,
                padding: EdgeInsets.only(top: 20),
                child: new Image.asset('assets/images/Image_accueil.png'),
              ),
              Container(
                transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 180.0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    viewportFraction: 0.8,
                  ),
                  items: [
                    Container(
                      margin: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: YellowPNRC,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'La pointe de la Revellata',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              'Lorem Ipsum is simply dummy text use for printing and type script',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: YellowPNRC,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Lac Mélo - Lac Capitello',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              'Lorem Ipsum is simply dummy text use for printing and type script',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: YellowPNRC,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Plage de l\'Acciolu',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              'Lorem Ipsum is simply dummy text use for printing and type script',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.only(left: 25),
                  child: Text(
                    'LOCALISATION',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 20),
                  child: new ListTile(
                    title: new TextField(
                      decoration: new InputDecoration(
                        hintText: "Choisir la localisation",
                      ),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.only(top: 25, left: 25),
                  child: Text(
                    'THÉMATIQUE',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 20),
                  child: new ListTile(
                    title: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: "Choisir la thématique",
                        suffixIcon: PopupMenuButton<String>(
                          icon: const Icon(Icons.arrow_drop_down),
                          onSelected: (String value) {
                            _controller.text = value;
                          },
                          itemBuilder: (BuildContext context) {
                            return thematiques
                                .map<PopupMenuItem<String>>((String value) {
                              return new PopupMenuItem(
                                  child: new Text(value), value: value);
                            }).toList();
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.only(top: 25, left: 25),
                  child: Text(
                    'ACTIVITÉ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 20),
                  child: new ListTile(
                    title: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: "Choisir l'activité",
                        suffixIcon: PopupMenuButton<String>(
                          icon: const Icon(Icons.arrow_drop_down),
                          onSelected: (String value) {
                            _controller.text = value;
                          },
                          itemBuilder: (BuildContext context) {
                            return activites
                                .map<PopupMenuItem<String>>((String value) {
                              return new PopupMenuItem(
                                  child: new Text(value), value: value);
                            }).toList();
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.only(top: 25, bottom: 25),
                  child: new TextButton(
                      child: Text('CHERCHER'),
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: RedPNRC,
                        padding: EdgeInsets.only(
                            top: 15, left: 50, right: 50, bottom: 15),
                      ),
                      onPressed: () {
                        print('CHERCHER PRESSED');
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
