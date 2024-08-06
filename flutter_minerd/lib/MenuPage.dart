import 'package:flutter/material.dart';
import 'noticias/news_screen.dart';
import 'RegisterVisitPage.dart';
import 'weather_screen.dart';
import 'horoscope_screen.dart';
import 'main.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.all(16.0),
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
              MaterialPageRoute(builder: (context) => const WeatherScreen()),
            );
          },
        ),
        MenuButton(
          icon: Icons.stars,
          label: 'Horóscopo',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HoroscopeScreen()),
            );
          },
        ),
        MenuButton(
          icon: Icons.stars,
          label: 'Noticias',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NewsScreen()),
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

  // ignore: use_key_in_widget_constructors
  const MenuButton({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 50, color: Colors.blue),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(fontSize: 16, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
