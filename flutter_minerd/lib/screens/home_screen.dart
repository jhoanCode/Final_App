import 'package:flutter/material.dart';
import 'registro_incidencia_screen.dart';
import 'lista_incidencias_screen.dart';
import 'more.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    ListaIncidenciasScreen(),
    RegistroIncidenciaScreen(),
    MorePage(),
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
            label: 'Incidencias',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Registrar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About us',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}