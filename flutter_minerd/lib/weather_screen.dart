import 'package:flutter/material.dart';
import '../weather-api/weather_service.dart';
import '../weather-api/weather_ui.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final _formKey = GlobalKey<FormState>();
  final _latitudController = TextEditingController(text: "18.7357");
  final _longitudController = TextEditingController(text: "-70.1627");
  Map<String, dynamic> weatherData = {};

  final WeatherService _weatherService = WeatherService();

  void _getWeather() async {
    if (_formKey.currentState!.validate()) {
      try {
        double lat = double.parse(_latitudController.text);
        double lon = double.parse(_longitudController.text);

        var data = await _weatherService.fetchWeather(lat, lon, DateTime.now());

        setState(() {
          weatherData = data;
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
        title: Text('Clima', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _latitudController,
                decoration: InputDecoration(labelText: 'Latitud'),
                validator: (value) {
                  if (value!.isEmpty || double.tryParse(value) == null) {
                    return 'Por favor ingresa la latitud de un lugar';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _longitudController,
                decoration: InputDecoration(labelText: 'Longitud'),
                validator: (value) {
                  if (value!.isEmpty || double.tryParse(value) == null) {
                    return 'Por favor ingresa la longitud de un lugar';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _getWeather,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                ),
                child: Text('Obtener Clima', style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 16.0),
              WeatherUi(data: weatherData),
            ],
          ),
        ),
      ),
    );
  }
}
