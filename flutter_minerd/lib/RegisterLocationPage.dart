import 'package:flutter/material.dart';
import 'map_screen.dart';

class RegisterLocationPage extends StatefulWidget {
  @override
  _RegisterLocationPageState createState() => _RegisterLocationPageState();
}

class _RegisterLocationPageState extends State<RegisterLocationPage> {
  final _formKey = GlobalKey<FormState>();
  final _latitudeController = TextEditingController(text: "18.46620");
  final _longitudeController = TextEditingController(text: "-69.93435");

  @override
  void dispose() {
    _latitudeController.dispose();
    _longitudeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
        title: Text(
          'Datos de ubicacion', 
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _latitudeController,
                decoration: InputDecoration(
                  labelText: 'Latitud',
                  labelStyle: TextStyle(color: Colors.blue[900]),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue[900]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue[700]!),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce la latitud';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _longitudeController,
                decoration: InputDecoration(
                  labelText: 'Longitud',
                  labelStyle: TextStyle(color: Colors.blue[900]),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue[900]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue[700]!),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce la longitud';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MapScreen(
                          latitude: double.parse(_latitudeController.text),
                          longitude: double.parse(_longitudeController.text),
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                ),
                child: Text('Siguiente', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
