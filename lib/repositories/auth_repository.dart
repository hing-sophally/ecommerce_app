import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String?> register({
  required String name, // Add this
  required String email,
  required String password,
}) async {
  final url = Uri.http('10.0.2.2:8000', '/api/register');

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name, // send name here
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
Future<Map<String, dynamic>> login(String email, String password) async {
  final url = Uri.parse('http://10.0.2.2:8000/api/login');

  final response = await http.post(
    url,
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'email': email,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return {
      'success': true,
      'token': data['token'],
      'user': data['user'],
    };
  } else if (response.headers['content-type']!.contains('application/json')) {
    final errorData = jsonDecode(response.body);
    return {
      'success': false,
      'message': errorData['message'],
    };
  } else {
    return {
      'success': false,
      'message': 'Unexpected response from server',
    };
  }
}

