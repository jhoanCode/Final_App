import 'package:flutter/material.dart';
import 'RegisterVisitPage.dart';
import 'AboutPage.dart';
import 'ListaVisitasPage.dart';
import 'RegisterLocationPage.dart';
import 'MenuPage.dart'; 

class TechHomepage extends StatefulWidget {
  @override
  _TechHomepageState createState() => _TechHomepageState();
}

class _TechHomepageState extends State<TechHomepage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    VisitsListPage(),
    MenuPage(),  
    RegisterLocationPage(), 
    AboutPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Visitas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Menú',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Mapa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Video',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: const Color.fromARGB(255, 0, 0, 0),
        backgroundColor: Colors.blue[900],
        onTap: _onItemTapped,
      ),
    );
  }
}
