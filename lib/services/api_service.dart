import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthRepository {
  final String _authority = '10.0.2.2:8000'; // Note: Use without http:// in Uri.http

  Future<String?> register({
    required String name,       // Add name here
    required String email,
    required String password,
  }) async {
    final url = Uri.http(_authority, '/api/register');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,          // send name to API
          'email': email,
          'password': password,
        }),
      );

      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      final data = jsonDecode(response.body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        return data['message'] ?? 'Registered successfully';
      } else {
        return data['message'] ?? 'Registration failed';
      }
    } catch (e, stacktrace) {
      print('Error: $e');
      print('Stacktrace: $stacktrace');
      return 'An error occurred: $e';
    }
  }
}
