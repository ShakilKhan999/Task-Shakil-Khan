import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../utils/constants/api_constants.dart';

class NetworkResponse {
  final int statusCode;
  final dynamic body;
  final bool isSuccess;
  final String? errorMessage;

  NetworkResponse({
    required this.statusCode,
    this.body,
    this.isSuccess = false,
    this.errorMessage,
  });
}

class NetworkCaller {
  static Future<NetworkResponse> getRequest(String endpoint) async {
    final url = Uri.parse('${ApiConstants.baseUrl}$endpoint');

    log('GET → $url');

    try {
      final response = await http.get(url);

      log('GET ← ${response.statusCode} | $endpoint');

      if (response.statusCode == 200) {
        final decodedBody = json.decode(response.body);
        log('GET ✓ $endpoint | Data received');
        return NetworkResponse(
          statusCode: response.statusCode,
          body: decodedBody,
          isSuccess: true,
        );
      }

      log('GET ✗ $endpoint | Status: ${response.statusCode}');
      return NetworkResponse(
        statusCode: response.statusCode,
        isSuccess: false,
        errorMessage: 'Request failed with status: ${response.statusCode}',
      );
    } catch (e) {
      log('GET ✗ $endpoint | Error: $e');
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  static Future<NetworkResponse> postRequest(
    String endpoint, {
    Map<String, dynamic>? body,
  }) async {
    final url = Uri.parse('${ApiConstants.baseUrl}$endpoint');

    log('POST → $url');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body != null ? json.encode(body) : null,
      );

      log('POST ← ${response.statusCode} | $endpoint');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodedBody = json.decode(response.body);
        log('POST ✓ $endpoint | Data received');
        return NetworkResponse(
          statusCode: response.statusCode,
          body: decodedBody,
          isSuccess: true,
        );
      }

      log('POST ✗ $endpoint | Status: ${response.statusCode}');
      return NetworkResponse(
        statusCode: response.statusCode,
        isSuccess: false,
        errorMessage: 'Request failed with status: ${response.statusCode}',
      );
    } catch (e) {
      log('POST ✗ $endpoint | Error: $e');
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }
}
