import 'dart:convert';

import 'package:celula_app/services/notifications_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String _baseUrl = dotenv.get('BASE_URL');
  final storage = const FlutterSecureStorage();

  Future<String?> createUser(String nombre, String usuario, String clave) async {
    final Map<String, dynamic> authData = {'nombre': nombre, 'usuario': usuario, 'clave': clave, 'isAdmin': false};

    final url = Uri.parse('${_baseUrl}usuario/register');

    final resp = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('token')) {
      await storage.write(key: 'token', value: decodedResp['token']);
      return null;
    }
    return decodedResp['message'];
  }

  Future<bool> login(String usuario, String clave) async {
    try {
      final Map<String, dynamic> authData = {'usuario': usuario, 'clave': clave};

      final resp = await http.post(
        Uri.parse('${_baseUrl}usuario/login'),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
        body: json.encode(authData),
      );

      final Map<String, dynamic> decodedResp = json.decode(resp.body);

      if (resp.statusCode != 200) {
        NotificationsService.showSnackBar(decodedResp['message']);
        return false;
      }

      if (decodedResp.containsKey('token')) {
        await storage.write(key: 'token', value: decodedResp['token']);
        await storage.write(key: 'nombre', value: decodedResp['nombre']);
        return true;
      }
    } catch (error) {
      NotificationsService.showSnackBar(error.toString());
    }
    return false;
  }

  Future<bool> validateToken() async {
    try {
      final token = await readToken();
      if (token.isEmpty) {
        return false;
      }

      final resp = await http.post(
        Uri.parse('${_baseUrl}usuario/verify'),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $token'},
      );

      final Map<String, dynamic> decodedResp = json.decode(resp.body);

      if (resp.statusCode != 200) {
        return false;
      }

      if (decodedResp.containsKey('token')) {
        await storage.write(key: 'token', value: decodedResp['token']);
        await storage.write(key: 'nombre', value: decodedResp['nombre']);
        return true;
      }
    } catch (error) {
      NotificationsService.showSnackBar(error.toString());
    }
    return false;
  }

  Future logout() async {
    await storage.delete(key: 'token');
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }
}
