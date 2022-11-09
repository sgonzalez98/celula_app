import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final storage = const FlutterSecureStorage();
  final String _baseUrl = dotenv.get('BASE_URL');

  Future<Map<String, String>> getHeaders() async {
    return <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${await storage.read(key: 'token') ?? ''}'
    };
  }

  Future<dynamic> get(String url) async {
    final completeUrl = Uri.parse('$_baseUrl$url');

    final resp = await http.get(
      completeUrl,
      headers: await getHeaders(),
    );

    return json.decode(resp.body);
  }

  Future<dynamic> post(String url, String body) async {
    final completeUrl = Uri.parse('$_baseUrl$url');

    final resp = await http.post(
      completeUrl,
      headers: await getHeaders(),
      body: body,
    );

    return json.decode(resp.body);
  }

  Future<dynamic> put(String url, String body) async {
    final completeUrl = Uri.parse('$_baseUrl$url');

    final resp = await http.put(
      completeUrl,
      headers: await getHeaders(),
      body: body,
    );

    return json.decode(resp.body);
  }

  Future<dynamic> delete(String url) async {
    final completeUrl = Uri.parse('$_baseUrl$url');

    final resp = await http.delete(
      completeUrl,
      headers: await getHeaders(),
    );

    return json.decode(resp.body);
  }
}
