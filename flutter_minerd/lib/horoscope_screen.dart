import 'package:flutter/material.dart';
import '../horoscope-api/horoscope_service.dart';
import '../horoscope-api/horoscope_ui.dart';

class HoroscopeScreen extends StatefulWidget {
  const HoroscopeScreen({Key? key}) : super(key: key);

  @override
  _HoroscopeScreenState createState() => _HoroscopeScreenState();
}

class _HoroscopeScreenState extends State<HoroscopeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _signoController = TextEditingController(text: "virgo");
  Map<String, dynamic> horoscopeData = {};

  final HoroscopeService _horoscopeService = HoroscopeService();

  void _getHoroscope() async {
    if (_formKey.currentState!.validate()) {
      try {
        var data = await _horoscopeService.fetchHoroscope(_signoController.text);

        setState(() {
          horoscopeData = data;
        });
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Horóscopo', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _signoController,
                decoration: InputDecoration(labelText: 'Signo'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingresa el signo';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _getHoroscope,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                ),
                child: Text('Obtener Horóscopo', style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 16.0),
              HoroscopeUi(data: horoscopeData),
            ],
          ),
        ),
      ),
    );
  }
}
