import '../model/cep_model.dart';
import '../repositories/cep_local_repository.dart';
import '../repositories/cep_repository.dart';

/// Camada de serviço — implementa as regras de negócio da consulta de CEP.
class CepService {
  final CepRepository _repository;
  final CepLocalRepository _localRepository;

  CepService({
    CepRepository? repository,
    CepLocalRepository? localRepository,
  })  : _repository = repository ?? CepRepository(),
        _localRepository = localRepository ?? CepLocalRepository();

  /// Busca o endereço pelo CEP, valida a entrada e persiste no histórico.
  Future<CepModel> searchCep(String cep) async {
    final cleanCep = cep.replaceAll(RegExp(r'\D'), '');
    if (cleanCep.length != 8) {
      throw Exception('CEP inválido. Informe 8 dígitos.');
    }

    final result = await _repository.searchByCep(cleanCep);
    await _localRepository.saveAddress(cleanCep);
    return result;
  }

  /// Retorna o histórico de CEPs consultados.
  List<String> getHistory() => _localRepository.getHistory();
}
