import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart'; 
import '../utils/database_helper.dart';

class RegisterVisitPage extends StatefulWidget {
  @override
  _RegisterVisitPageState createState() => _RegisterVisitPageState();
}

class _RegisterVisitPageState extends State<RegisterVisitPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController cedulaController = TextEditingController();
  final TextEditingController codigoCentroController = TextEditingController();
  final TextEditingController comentarioController = TextEditingController();
  File? _image;
  String? _selectedMotivo;
  Position? _position;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _position = position;
      });
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future<void> _saveVisit() async {
    if (_formKey.currentState!.validate()) {
      final now = DateTime.now();
      final formattedDate = DateFormat('yyyy-MM-dd').format(now);
      final formattedTime = DateFormat('HH:mm:ss').format(now);

      final visitData = {
        'cedula': cedulaController.text,
        'codigoCentro': codigoCentroController.text,
        'motivo': _selectedMotivo,
        'comentario': comentarioController.text,
        'imagePath': _image?.path,
        'fecha': formattedDate,
        'hora': formattedTime,
      };

      final dbHelper = DatabaseHelper.instance; 
      await dbHelper.insertVisita(visitData);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Visita registrada')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Visita'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: cedulaController,
                decoration: InputDecoration(labelText: 'Cédula del Director'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa la cédula del director';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: codigoCentroController,
                decoration: InputDecoration(labelText: 'Código del Centro'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el código del centro';
                  }
                  return null;
                },
              ),
              DropdownButton<String>(
                hint: Text('Selecciona el motivo de la visita'),
                value: _selectedMotivo,
                items: <String>['Inspección Técnica', 'Evaluación Docente', 'Asesoramiento Técnico'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedMotivo = newValue;
                  });
                },
              ),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Adjuntar Foto'),
              ),
              _image != null ? Image.file(_image!) : Container(),
              TextFormField(
                controller: comentarioController,
                decoration: InputDecoration(labelText: 'Comentario'),
              ),
              ElevatedButton(
                onPressed: _saveVisit,
                child: Text('Registrar Visita'),
              ),
             
            ],
          ),
        ),
      ),
    );
  }
}
