import 'package:flutter/material.dart';

class RandonneeWidget extends StatefulWidget {
  @override
  _RandonneeMapWidget createState() => _RandonneeMapWidget();
}

class _RandonneeMapWidget extends State<RandonneeWidget> {
  _RandonneeMapWidget();
  TabController tabC;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //tabC = TabController(length: 4, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.map),
                  text: "Carte Google",
                ),
                Tab(icon: Icon(Icons.list), text: "Voir la liste"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
