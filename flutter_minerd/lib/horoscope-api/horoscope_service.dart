import 'dart:convert';
import 'package:http/http.dart' as http;

class HoroscopeService {
  final String apiUrl = 'POST: https://aztro.sameerkumar.website';

  Future<Map<String, dynamic>> fetchHoroscope(String sign) async {
    final response = await http.get(
      Uri.parse('$apiUrl?sign=$sign&day=today')
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al obtener el horóscopo');
    }
  }
}
