import 'package:flutter/material.dart';
import 'RegisterVisitPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TechHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio Técnico'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.remove('isLoggedIn');
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Bienvenido, Técnico!'),
            SizedBox(height: 20),
            ElevatedButton.icon(
              icon: Icon(Icons.add_location),
              label: Text('Registrar Visita'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterVisitPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
