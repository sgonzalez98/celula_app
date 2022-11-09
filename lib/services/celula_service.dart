import 'dart:convert';

import 'package:celula_app/models/celula.dart';
import 'package:celula_app/utilities/api_service.dart';

class CelulaService {
  final apiService = ApiService();

  Future<List<Celula>> load() async {
    final List<Celula> celulas = [];
    final List<dynamic> celulasMap = await apiService.get('celula?usuarioId=632e7710f490f996ad6af4c9');

    for (var value in celulasMap) {
      final tempCelula = Celula.fromJson(value);
      celulas.add(tempCelula);
    }

    return celulas;
  }

  Future saveOrCreate(Celula celula) async {
    if (celula.id == null) {
      await create(celula);
    } else {
      await update(celula);
    }
  }

  Future update(Celula celula) async {
    final String url = 'celula/${celula.id}';
    celula.estado = 'Activo';

    await apiService.put(url, jsonEncode(celula.toJson()));
  }

  Future create(Celula celula) async {
    final String body = jsonEncode(celula.toJson());

    await apiService.post('celula', body);
  }

  Future delete(String id) async {
    final String url = 'celula/$id';

    await apiService.delete(url);
  }
}
