import '../../../shared/storage/local_storage.dart';

/// Repositório responsável pela comunicação com o armazenamento local (Hive).
class CepLocalRepository {
  /// Salva um CEP no histórico de consultas.
  Future<void> saveAddress(String cep) async {
    await LocalStorage.saveToHistory(cep);
  }

  /// Retorna o histórico de CEPs consultados (mais recente primeiro).
  List<String> getHistory() {
    return LocalStorage.getHistory();
  }

  /// Remove um item do histórico pelo índice da lista invertida.
  Future<void> removeFromHistory(int index) async {
    await LocalStorage.removeFromHistory(index);
  }

  /// Limpa todo o histórico.
  Future<void> clearHistory() async {
    await LocalStorage.clearHistory();
  }
}
