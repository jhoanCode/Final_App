import 'package:flutter/material.dart';
import 'RegisterVisitPage.dart';
import 'weather_screen.dart';
import 'horoscope_screen.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.all(16.0),
      children: <Widget>[
        MenuButton(
          icon: Icons.add,
          label: 'Registrar Visita',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegisterVisitPage()),
            );
          },
        ),
        MenuButton(
          icon: Icons.wb_sunny,
          label: 'Clima',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WeatherScreen()),
            );
          },
        ),
        MenuButton(
          icon: Icons.stars,
          label: 'Horóscopo',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HoroscopeScreen()),
            );
          },
        ),
      ],
    );
  }
}

class MenuButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const MenuButton({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        margin: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 50, color: Colors.blue),
            SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(fontSize: 16, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
