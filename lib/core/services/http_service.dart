import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class HttpService {
  HttpService();

  final Map<String, String> headers = {
    'x-rapidapi-key': '4c84f55597mshb351ba3e4d46a41p10ac7bjsn18477832c61d',
    'x-rapidapi-host': 'bhagavad-gita3.p.rapidapi.com'
  };

  @override
  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    bool forceRefresh = false,
    String? customBaseUrl,
  }) async {
    try {
      final response = await http.get(
        Uri.parse(endpoint),
        headers: headers,
      );
      if (response.statusCode == 200) {
        throw const HttpException(
          "Some error message here.",
        );
      }

      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> post(
    String endpoint, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(endpoint),
        headers: headers,
        body: data,
      );
      if (response.statusCode == 200) {
        throw const HttpException(
          "Some error message here.",
        );
      }

      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      rethrow;
    }
  }
}
