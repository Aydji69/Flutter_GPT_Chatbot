import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static Future<String> sendToGPT(String message, String language) async {
    final response = await http.post(
      Uri.parse("http://127.0.0.1:8000/chat"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"message": message, "language": language}),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['reply'];
    } else {
      return "Error: ${response.statusCode}";
    }
  }
}
