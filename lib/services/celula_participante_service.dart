import 'dart:convert';

import 'package:celula_app/models/celula_participante.dart';
import 'package:celula_app/utilities/api_service.dart';

class CelulaParticipanteService {
  final apiService = ApiService();

  Future<List<CelulaParticipante>> loadParticipantes(String celulaId) async {
    final List<CelulaParticipante> participantes = [];
    final List<dynamic> participantesMap = await apiService.get('celulaparticipante?celulaId=$celulaId');

    for (var value in participantesMap) {
      final tempValue = CelulaParticipante.fromJson(value);
      participantes.add(tempValue);
    }

    return participantes;
  }

  Future saveOrCreateProduct(CelulaParticipante celulaParticipante) async {
    if (celulaParticipante.id == null) {
      await create(celulaParticipante);
    } else {
      await update(celulaParticipante);
    }
  }

  Future update(CelulaParticipante celulaParticipante) async {
    final String url = 'celulaparticipante/${celulaParticipante.id}';

    await apiService.put(url, jsonEncode(celulaParticipante.toJson()));
  }

  Future create(CelulaParticipante celulaParticipante) async {
    final String body = jsonEncode(celulaParticipante.toJson());

    await apiService.post('celulaparticipante', body);
  }

  Future delete(String id) async {
    final String url = 'celulaparticipante/$id';

    await apiService.delete(url);
  }
}
