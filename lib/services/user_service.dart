import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  static const String _baseUrl = 'http://10.0.2.2:3000/api';

  /// 🔹 **Cria um novo usuário**
  static Future<bool> createUser(String name, String email, String password) async {
    try {
      await _postRequest(
        '$_baseUrl/users',
        body: {'name': name, 'email': email, 'password': password},
        successStatusCode: 201,
        errorMessages: {409: 'E-mail já cadastrado'},
      );
      return true; // ✅ Retorna `true` se a criação for bem-sucedida
    } catch (e) {
      return false; // ✅ Retorna `false` se houver erro
    }
  }

  /// 🔹 **Autentica um usuário (Login)**
  static Future<Map<String, dynamic>> loginUser(String email, String password) async {
    final response = await _postRequest(
      '$_baseUrl/login',
      body: {'email': email, 'password': password},
      successStatusCode: 200,
      errorMessages: {401: 'E-mail ou senha incorretos'},
    );

    if (response is Map<String, dynamic>) {
      return response;
    } else {
      throw Exception("Resposta inesperada do servidor");
    }
  }

  /// 🔹 **Exclui um usuário pelo ID**
  static Future<bool> deleteUser(int userId) async {
    try {
      await _deleteRequest(
        '$_baseUrl/users/$userId',
        successStatusCode: 200,
        errorMessages: {404: 'Usuário não encontrado'},
      );
      return true; // ✅ Retorna `true` se a exclusão for bem-sucedida
    } catch (e) {
      return false; // ✅ Retorna `false` em caso de erro
    }
  }

  /// 🔹 **Método genérico para requisições `POST`**
  static Future<dynamic> _postRequest(
    String url, {
    required Map<String, dynamic> body,
    required int successStatusCode,
    Map<int, String>? errorMessages,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      return _handleResponse(response, successStatusCode, errorMessages);
    } catch (e) {
      throw Exception('Erro na requisição POST: $e');
    }
  }

  /// 🔹 **Método genérico para requisições `DELETE`**
  static Future<bool> _deleteRequest(
    String url, {
    required int successStatusCode,
    Map<int, String>? errorMessages,
  }) async {
    try {
      final response = await http.delete(Uri.parse(url));
      return _handleResponse(response, successStatusCode, errorMessages) == true;
    } catch (e) {
      throw Exception('Erro na requisição DELETE: $e');
    }
  }

  /// 🔹 **Tratamento genérico de respostas**
  static dynamic _handleResponse(
    http.Response response,
    int successStatusCode,
    Map<int, String>? errorMessages,
  ) {
    if (response.statusCode == successStatusCode) {
      return response.body.isNotEmpty ? jsonDecode(response.body) : true;
    } else if (errorMessages != null && errorMessages.containsKey(response.statusCode)) {
      throw Exception(errorMessages[response.statusCode]);
    } else {
      throw Exception('Erro desconhecido (${response.statusCode})');
    }
  }
}
