import 'package:flutter/material.dart';
import '../models/incidencia.dart';
import '../utils/database_helper.dart';
import 'detalle_incidencia_screen.dart';

class ListaIncidenciasScreen extends StatefulWidget {
  const ListaIncidenciasScreen({Key? key}) : super(key: key);

  @override
  _ListaIncidenciasScreenState createState() => _ListaIncidenciasScreenState();
}

class _ListaIncidenciasScreenState extends State<ListaIncidenciasScreen> {
  late Future<List<Incidencia>> _incidenciasFuture;

  @override
  void initState() {
    super.initState();
    _incidenciasFuture = DatabaseHelper.instance.getIncidencias();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Incidencias',style: TextStyle(color: Colors.white),
        ),
         backgroundColor: Colors.blue[900],
      ),
      body: FutureBuilder<List<Incidencia>>(
        future: _incidenciasFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay incidencias registradas.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final incidencia = snapshot.data![index];
                return ListTile(
                  title: Text(incidencia.titulo),
                  subtitle: Text('${incidencia.centroEducativo} - ${incidencia.fecha.toLocal().toString().split(' ')[0]}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetalleIncidenciaScreen(incidencia: incidencia),
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