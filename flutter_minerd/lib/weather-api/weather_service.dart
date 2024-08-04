import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiUrl = 'https://api.open-meteo.com/v1/forecast';
  final String apiExtra = 'hourly=temperature_2m,relative_humidity_2m,precipitation_probability,precipitation&timezone=America%2FSanto_Domingo';

  Future<Map<String, dynamic>> fetchWeather(double lat, double lon, DateTime date) async {
    var fecha = date.toIso8601String().substring(0, 10);
    final response = await http.get(
      Uri.parse('$apiUrl?latitude=$lat&longitude=$lon&start_date=$fecha&end_date=$fecha&$apiExtra')
    );

    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      List wHora = res["hourly"]["time"];
      dynamic h = date.toIso8601String().substring(0, 14) + "00";
      h = wHora.indexOf(h);
      if (h < 0){
        throw Exception('No se encontró la hora especificada');
      }
      Map<String, dynamic> wData = {
        "temperature": res["hourly"]["temperature_2m"][h],
        "humidity": res["hourly"]["relative_humidity_2m"][h],
        "precipitation": res["hourly"]["precipitation_probability"][h]
        };
      return wData;
    } else {
      throw Exception('Error al obtener el clima');
    }
  }
}
