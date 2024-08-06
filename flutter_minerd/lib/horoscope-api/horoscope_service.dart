import 'dart:convert';
import 'package:http/http.dart' as http;

class HoroscopeService {
  final String apiUrl = 'https://newastro.vercel.app';

  Future<Map<String, dynamic>> fetchHoroscope(String sign) async {
    final response = await http.get(
      Uri.parse('$apiUrl/$sign/?lang=es'),
      headers: {
        'Access-Control-Allow-Origin': '*', // Esto permite cualquier origen (¡no lo uses en producción!)
        'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
        'Access-Control-Allow-Headers': 'Origin, Content-Type, X-Auth-Token'
      }
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al obtener el horóscopo');
    }
  }
}
