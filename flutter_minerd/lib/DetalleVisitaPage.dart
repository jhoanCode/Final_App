import 'package:flutter/material.dart';
import 'dart:io';

class VisitDetailPage extends StatelessWidget {
  final Map<String, dynamic> visita;

  VisitDetailPage({required this.visita});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle de la Visita'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Cédula: ${visita['cedula']}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              
              Text('Código del Centro: ${visita['codigoCentro']}', style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
              
              Text('Motivo: ${visita['motivo']}', style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
              
              Text('Comentario: ${visita['comentario']}', style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
              
              Text('Fecha: ${visita['fecha']}', style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
              
              Text('Hora: ${visita['hora']}', style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
             
              if (visita['imagePath'] != null) 
                Column(
                  children: [
                    SizedBox(height: 16),
                    Image.file(File(visita['imagePath'])),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
