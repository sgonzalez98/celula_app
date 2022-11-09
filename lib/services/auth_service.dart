import 'dart:convert';

import 'package:celula_app/services/notifications_service.dart';
import 'package:celula_app/services/storage_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String _baseUrl = dotenv.get('BASE_URL');
  final storageService = StorageService();

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
      await storageService.write('token', decodedResp['token']);
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
        await storageService.write('token', decodedResp['token']);
        final Map<String, dynamic> userMap = decodedResp['user'];
        await storageService.write('nombre', userMap['nombre']);
        await storageService.write('usuarioId', userMap['id']);
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
        await storageService.write('token', decodedResp['token']);
        final Map<String, dynamic> userMap = decodedResp['user'];
        await storageService.write('nombre', userMap['nombre']);
        await storageService.write('usuarioId', userMap['id']);

        return true;
      }
    } catch (error) {
      NotificationsService.showSnackBar(error.toString());
    }
    return false;
  }

  Future logout() async {
    await storageService.delete('token');
  }

  Future<String> readToken() async {
    return await storageService.read('token') ?? '';
  }
}
