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
    _refreshIncidencias();
  }

  void _refreshIncidencias() {
    setState(() {
      _incidenciasFuture = DatabaseHelper.instance.getIncidencias();
    });
  }

  Future<void> _deleteIncidencia(int id) async {
    await DatabaseHelper.instance.deleteIncidencia(id);
    _refreshIncidencias();
  }

  Future<void> _deleteAllIncidencias() async {
    await DatabaseHelper.instance.deleteAllIncidencias();
    _refreshIncidencias();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Incidencias'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Borrar todas las incidencias'),
                    content: Text('¿Estás seguro de que quieres borrar todas las incidencias?'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Cancelar'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('Borrar'),
                        onPressed: () {
                          _deleteAllIncidencias();
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
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
                return Dismissible(
                  key: Key(incidencia.id.toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  confirmDismiss: (direction) async {
                    return await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Borrar incidencia'),
                          content: Text('¿Estás seguro de que quieres borrar esta incidencia?'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Cancelar'),
                              onPressed: () => Navigator.of(context).pop(false),
                            ),
                            TextButton(
                              child: Text('Borrar'),
                              onPressed: () => Navigator.of(context).pop(true),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  onDismissed: (direction) {
                    _deleteIncidencia(incidencia.id!);
                  },
                  child: ListTile(
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
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}