import 'dart:convert';
import 'package:http/http.dart' as http;
import 'constants.dart';

class ApiClient {
  static Future<Map<String, dynamic>> get(
    String endpoint, [
    Map<String, String>? params,
  ]) async {
    final uri = Uri.parse('$baseUrl$endpoint').replace(
      queryParameters: {'api_key': apiKey, 'language': 'pt-BR', ...?params},
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Erro ao carregar dados: ${response.statusCode}');
    }
  }
}
