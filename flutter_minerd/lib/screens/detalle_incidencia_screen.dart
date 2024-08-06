import 'package:flutter/material.dart';
import 'dart:io';
import '../models/incidencia.dart';

class DetalleIncidenciaScreen extends StatelessWidget {
  final Incidencia incidencia;

  const DetalleIncidenciaScreen({Key? key, required this.incidencia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(incidencia.titulo),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Centro Educativo: ${incidencia.centroEducativo}'),
            Text('Regional: ${incidencia.regional}'),
            Text('Distrito: ${incidencia.distrito}'),
            Text('Fecha: ${incidencia.fecha.toLocal().toString().split(' ')[0]}'),
            const SizedBox(height: 16),
            Text('Descripción:', style: Theme.of(context).textTheme.titleMedium),
            Text(incidencia.descripcion),
            const SizedBox(height: 16),
            if (incidencia.fotoPath != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Foto:', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Image.file(File(incidencia.fotoPath!)),
                ],
              ),
          ],
        ),
      ),
    );
  }
}