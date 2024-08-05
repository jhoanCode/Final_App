import 'package:flutter/material.dart';
import 'weather_service.dart';
import '../horoscope-api/horoscope_service.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final _formKey = GlobalKey<FormState>();
  final _latitudController = TextEditingController(text: "18.7357");
  final _longitudController = TextEditingController(text: "-70.1627");
  final _signoController = TextEditingController(text: "virgo");
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  String _weatherInfo = '';
  dynamic weatherData;
  String _horoscopeInfo = '';
  dynamic horoscopeData;

  final WeatherService _weatherService = WeatherService();
  final HoroscopeService _hService = HoroscopeService();

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _getWeather() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Obtener latitud y longitud del lugar ingresado (puedes usar un servicio de geocodificación como Google Maps Geocoding API)
        double lat = double.parse(_latitudController.text);
        double lon = double.parse(_longitudController.text);

        weatherData = await _weatherService.fetchWeather(lat, lon, DateTime.now());

        setState(() {
          _weatherInfo = weatherData.toString();
        });
      } catch (e) {
        print(e);
        setState(() {
          _weatherInfo = e.toString();
        });
      }
    }
  }

  void _getHoroscope() async {
    if (_formKey.currentState!.validate()) {
      try {
        weatherData = await _hService.fetchHoroscope(_signoController.text);

        setState(() {
          _horoscopeInfo = weatherData.toString();
        });
      } catch (e) {
        print(e);
        setState(() {
          _horoscopeInfo = e.toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clima'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _latitudController,
                decoration: const InputDecoration(labelText: 'Latitud'),
                validator: (value) {
                  if (value!.isEmpty || double.tryParse(value) == null) {
                    return 'Por favor ingresa la latitud de un lugar';
                  }
                  return null;
                },
              ),TextFormField(
                controller: _longitudController,
                decoration: const InputDecoration(labelText: 'Longitud'),
                validator: (value) {
                  if (value!.isEmpty || double.tryParse(value) == null) {
                    return 'Por favor ingresa la longitud de un lugar';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _getWeather,
                child: const Text('Obtener Clima'),
              ),
              const SizedBox(height: 16.0),
              Text(_weatherInfo),
              TextFormField(
                controller: _signoController,
                decoration: const InputDecoration(labelText: 'Signo'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingresa el signo';
                  }
                  return null;
                },),
              const SizedBox(height: 16.0),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _getHoroscope,
                child: const Text('Obtener Horóscopo'),
              ),
              const SizedBox(height: 16.0),
              Text(_horoscopeInfo),
            ],
          ),
        ),
      ),
    );
  }
}
