import 'package:mobx/mobx.dart';

import '../model/cep_model.dart';
import '../service/cep_service.dart';

part 'home_controller.g.dart';

// ignore: library_private_types_in_public_api
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final CepService _service;

  _HomeControllerBase({CepService? service})
      : _service = service ?? CepService();

  @observable
  CepModel? cepData;

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  /// Realiza a consulta do CEP na API e persiste no histórico local.
  @action
  Future<void> searchCep(String cep) async {
    isLoading = true;
    errorMessage = null;
    cepData = null;

    try {
      cepData = await _service.searchCep(cep);
    } catch (e) {
      errorMessage = e.toString().replaceAll('Exception: ', '');
    } finally {
      isLoading = false;
    }
  }

  /// Limpa o resultado atual para uma nova consulta.
  @action
  void clearSearch() {
    cepData = null;
    errorMessage = null;
  }
}
