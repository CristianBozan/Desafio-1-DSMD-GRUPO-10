import 'package:mobx/mobx.dart';

import '../../home/repositories/cep_local_repository.dart';

part 'history_controller.g.dart';

// ignore: library_private_types_in_public_api
class HistoryController = _HistoryControllerBase with _$HistoryController;

abstract class _HistoryControllerBase with Store {
  final CepLocalRepository _localRepository;

  _HistoryControllerBase() : _localRepository = CepLocalRepository();

  @observable
  ObservableList<String> history = ObservableList<String>();

  @observable
  bool isLoading = false;

  /// Carrega o histórico do armazenamento local.
  @action
  void loadHistory() {
    isLoading = true;
    history = ObservableList.of(_localRepository.getHistory());
    isLoading = false;
  }

  /// Remove um item pelo índice da lista exibida.
  @action
  Future<void> removeItem(int index) async {
    await _localRepository.removeFromHistory(index);
    loadHistory();
  }

  /// Limpa todo o histórico.
  @action
  Future<void> clearHistory() async {
    await _localRepository.clearHistory();
    history.clear();
  }
}
