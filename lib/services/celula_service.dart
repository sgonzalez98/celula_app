import 'dart:convert';

import 'package:celula_app/models/celula.dart';
import 'package:celula_app/utilities/api_service.dart';

class CelulaService {
  final apiService = ApiService();

  Future<List<Celula>> loadCelulas() async {
    final List<Celula> celulas = [];
    final List<dynamic> celulasMap = await apiService.get('celula?usuarioId=632e7710f490f996ad6af4c9');

    for (var value in celulasMap) {
      final tempCelula = Celula.fromJson(value);
      celulas.add(tempCelula);
    }

    return celulas;
  }

  Future saveOrCreateProduct(Celula celula) async {
    if (celula.id == null) {
      await createProduct(celula);
    } else {
      await updateProduct(celula);
    }
  }

  Future<String> updateProduct(Celula celula) async {
    final String url = 'celula/${celula.id}';
    celula.usuarioId = '632e7710f490f996ad6af4c9';
    celula.estado = 'Activo';

    await apiService.put(url, jsonEncode(celula.toJson()));

    return celula.id!;
  }

  Future<String> createProduct(Celula celula) async {
    celula.usuarioId = '632e7710f490f996ad6af4c9';
    final String body = jsonEncode(celula.toJson());

    await apiService.post('celula', body);

    return celula.id!;
  }
}
