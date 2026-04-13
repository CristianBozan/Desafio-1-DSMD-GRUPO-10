import '../../../http/http_client.dart';
import '../model/cep_model.dart';

/// Repositório responsável pela comunicação com a API ViaCEP.
class CepRepository {
  final HttpClient _client;

  CepRepository({HttpClient? client}) : _client = client ?? HttpClient();

  /// Consulta endereço pelo CEP.
  /// Lança [Exception] se o CEP não for encontrado ou a requisição falhar.
  Future<CepModel> searchByCep(String cep) async {
    final cleanCep = cep.replaceAll(RegExp(r'\D'), '');
    final response = await _client.get('/$cleanCep/json/');

    final data = response.data as Map<String, dynamic>;
    if (data['erro'] == true || data['erro'] == 'true') {
      throw Exception('CEP não encontrado. Verifique e tente novamente.');
    }

    return CepModel.fromJson(data);
  }
}
