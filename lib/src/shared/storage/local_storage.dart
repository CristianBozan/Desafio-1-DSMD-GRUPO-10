import 'package:hive_flutter/hive_flutter.dart';

/// Abstração sobre o Hive para persistência local.
/// Centraliza abertura de boxes e operações de leitura/escrita.
class LocalStorage {
  static const String _historyBoxName = 'history_box';

  // Inicializa o Hive — deve ser chamado em main() antes de runApp
  static Future<void> init() async {
    await Hive.initFlutter();
    await openBoxes();
  }

  // Abre todos os boxes necessários
  static Future<void> openBoxes() async {
    if (!Hive.isBoxOpen(_historyBoxName)) {
      await Hive.openBox<String>(_historyBoxName);
    }
  }

  // Retorna o box de histórico
  static Box<String> get historyBox => Hive.box<String>(_historyBoxName);

  // Salva um item no histórico (evita duplicatas consecutivas)
  static Future<void> saveToHistory(String cep) async {
    final box = historyBox;
    if (box.isNotEmpty && box.getAt(box.length - 1) == cep) return;
    await box.add(cep);
  }

  // Retorna todos os itens do histórico em ordem reversa (mais recente primeiro)
  static List<String> getHistory() {
    return historyBox.values.toList().reversed.toList();
  }

  // Remove um item pelo índice
  static Future<void> removeFromHistory(int index) async {
    // O índice recebido é da lista invertida, então precisamos calcular o real
    final realIndex = historyBox.length - 1 - index;
    await historyBox.deleteAt(realIndex);
  }

  // Limpa todo o histórico
  static Future<void> clearHistory() async {
    await historyBox.clear();
  }
}
