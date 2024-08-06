import 'package:flutter/material.dart';

class WeatherUi extends StatelessWidget {
  final Map<String, dynamic> data;

  WeatherUi({required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("temperatura: ${data.containsKey("temperature") ? data["temperature"] : "0"} °C    precipitaciones: ${data.containsKey("precipitation") ? data["precipitation"] : "0"} %"),
        Text("humedad: ${data.containsKey("humidity") ? data["humidity"] : "0"} %    Vel. viento: ${data.containsKey("wind") ? data["wind"] : "0"} km/h"),
      ],
    );
  }
}
