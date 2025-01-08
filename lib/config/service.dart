
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:learn/config/localDB.dart';

class ServiceRepo {
  final String baseUrl =
      "https://x-shop-backend.onrender.com"; // Replace with your API URL
  LocalDatabaseService db = LocalDatabaseService();

  Future<Map<String, dynamic>?> requist(String endpoint,
      {required String method, Map<String, dynamic>? body, String? token}) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    try {
      // // get token from hive
      // final boxOpen = await db.openBox("token");
      // final token = db.fromDb(boxOpen, 'key');
      final headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'auth': token.toString(), // Ensure the token is a String
      };

      http.Response response;

      switch (method.toUpperCase()) {
        case 'POST':
          response = await http.post(
            url,
            headers: headers,
            body: body != null ? jsonEncode(body) : null,
          );
          break;
        case 'GET':
          response = await http.get(
            url,
            headers: headers,
          );
          break;
        case 'PUT':
          response = await http.put(
            url,
            headers: headers,
            body: body != null ? jsonEncode(body) : null,
          );
          break;
        case 'DELETE':
          response = await http.delete(
            url,
            headers: headers,
          );
          break;
        default:
          throw Exception("Unsupported HTTP method: $method");
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return response.body.isNotEmpty ? jsonDecode(response.body) : null;
      } else {
        throw Exception(
            'Failed to $method data: ${response.body} (status: ${response.statusCode})');
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

}
