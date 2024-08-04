import 'package:flutter/material.dart';
import '../utils/database_helper.dart';
import 'DetalleVisitaPage.dart';

class VisitsListPage extends StatelessWidget {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visitas Registradas'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: dbHelper.getVisitas(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay visitas registradas'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var visita = snapshot.data![index];
                return ListTile(
                  title: Text('Centro: ${visita['codigoCentro']}'),
                  subtitle: Text('Fecha: ${visita['fecha']}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VisitDetailPage(visita: visita),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
