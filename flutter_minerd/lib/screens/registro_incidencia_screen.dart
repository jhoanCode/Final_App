import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../models/incidencia.dart';
import '../utils/database_helper.dart';

class RegistroIncidenciaScreen extends StatefulWidget {
  const RegistroIncidenciaScreen({Key? key}) : super(key: key);

  @override
  _RegistroIncidenciaScreenState createState() => _RegistroIncidenciaScreenState();
}

class _RegistroIncidenciaScreenState extends State<RegistroIncidenciaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _centroEducativoController = TextEditingController();
  final _regionalController = TextEditingController();
  final _distritoController = TextEditingController();
  final _descripcionController = TextEditingController();
  DateTime _fecha = DateTime.now();
  File? _image;
  final picker = ImagePicker();

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _fecha,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _fecha) {
      setState(() {
        _fecha = picked;
      });
    }
  }

  Future getImage() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    } catch (e) {
      print('Error al seleccionar la imagen: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al seleccionar la imagen')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Incidencia',style: TextStyle(color: Colors.white),
        ),
         backgroundColor: Colors.blue[900],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              controller: _tituloController,
              decoration: InputDecoration(
                  labelText: 'Título',
                  labelStyle: TextStyle(color: Colors.blue[900]),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue[900]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue[700]!),
                  ),
                ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese un título';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _centroEducativoController,
              decoration: InputDecoration(
                  labelText: 'Centro Educativo',
                  labelStyle: TextStyle(color: Colors.blue[900]),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue[900]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue[700]!),
                  ),
                ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el centro educativo';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _regionalController,
              decoration: InputDecoration(
                  labelText: 'Regional',
                  labelStyle: TextStyle(color: Colors.blue[900]),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue[900]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue[700]!),
                  ),
                ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese la regional';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _distritoController,
              decoration: InputDecoration(
                  labelText: 'Distrito',
                  labelStyle: TextStyle(color: Colors.blue[900]),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue[900]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue[700]!),
                  ),
                ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el distrito';
                }
                return null;
              },
            ),
            ListTile(
              title: const Text('Fecha'),
              subtitle: Text(_fecha.toLocal().toString().split(' ')[0]),
              trailing: const Icon(Icons.calendar_today),
              onTap: _selectDate,
            ),
            TextFormField(
              controller: _descripcionController,
              decoration: InputDecoration(
                  labelText: 'Descripción',
                  labelStyle: TextStyle(color: Colors.blue[900]),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue[900]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue[700]!),
                  ),
                ),
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese una descripción';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: getImage,
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                ),
              child: const Text('Seleccionar Foto',style: TextStyle(color: Colors.white)),
            ),
            if (_image != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Image.file(_image!),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                ),
              child: const Text('Guardar Incidencia',style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final incidencia = Incidencia(
        titulo: _tituloController.text,
        centroEducativo: _centroEducativoController.text,
        regional: _regionalController.text,
        distrito: _distritoController.text,
        fecha: _fecha,
        descripcion: _descripcionController.text,
        fotoPath: _image?.path,
      );
      
      try {
        await DatabaseHelper.instance.insertIncidencia(incidencia);
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Incidencia registrada con éxito')),
        );
        
        _formKey.currentState!.reset();
        setState(() {
          _fecha = DateTime.now();
          _image = null;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al guardar la incidencia: $e')),
        );
      }
    }
  }
}