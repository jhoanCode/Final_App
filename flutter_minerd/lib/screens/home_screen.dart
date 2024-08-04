import 'package:flutter/material.dart';
import 'registro_incidencia_screen.dart';
import 'lista_incidencias_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MINERD Técnicos'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Bienvenido a la aplicación de MINERD Técnicos'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegistroIncidenciaScreen()),
                );
              },
              child: const Text('Registrar Incidencia'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ListaIncidenciasScreen()),
                );
              },
              child: const Text('Ver Incidencias'),
            ),
          ],
        ),
      ),
    );
  }
}