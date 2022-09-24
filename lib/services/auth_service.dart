import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  // final String _baseUrl = 'http://127.0.0.1:3002/api/v1/';
  final String _baseUrl = 'http://10.0.2.2:3002/api/v1/';

  final storage = const FlutterSecureStorage();

  Future<String?> createUser(
      String nombre, String usuario, String clave) async {
    final Map<String, dynamic> authData = {
      'nombre': nombre,
      'usuario': usuario,
      'clave': clave,
      'isAdmin': false
    };

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

  Future<String?> login(String usuario, String clave) async {
    final Map<String, dynamic> authData = {
      'usuario': usuario,
      'clave': clave,
    };

    final url = Uri.parse('${_baseUrl}usuario/login');

    final resp = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('token')) {
      await storage.write(key: 'token', value: decodedResp['token']);
      await storage.write(key: 'nombre', value: decodedResp['nombre']);
      return null;
    }
    return decodedResp['message'];
  }

  Future logout() async {
    await storage.delete(key: 'token');
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }
}
