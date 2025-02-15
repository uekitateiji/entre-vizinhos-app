import 'dart:convert';
import 'package:http/http.dart' as http;

class BannerService {
static const String baseUrl = 'http://10.0.2.2:3000/api/banners';

  static Future<List<dynamic>> fetchBanners() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        return jsonDecode(response.body); // Retorna os banners como lista
      } else {
        throw Exception('Erro ao carregar banners: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro na requisição: $e');
    }
  }
}
