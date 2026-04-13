// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HistoryController on _HistoryControllerBase, Store {
  late final _$historyAtom =
      Atom(name: '_HistoryControllerBase.history', context: context);

  @override
  ObservableList<String> get history {
    _$historyAtom.reportRead();
    return super.history;
  }

  @override
  set history(ObservableList<String> value) {
    _$historyAtom.reportWrite(value, super.history, () {
      super.history = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_HistoryControllerBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$removeItemAsyncAction =
      AsyncAction('_HistoryControllerBase.removeItem', context: context);

  @override
  Future<void> removeItem(int index) {
    return _$removeItemAsyncAction.run(() => super.removeItem(index));
  }

  late final _$clearHistoryAsyncAction =
      AsyncAction('_HistoryControllerBase.clearHistory', context: context);

  @override
  Future<void> clearHistory() {
    return _$clearHistoryAsyncAction.run(() => super.clearHistory());
  }

  late final _$_HistoryControllerBaseActionController =
      ActionController(name: '_HistoryControllerBase', context: context);

  @override
  void loadHistory() {
    final _$actionInfo = _$_HistoryControllerBaseActionController.startAction(
        name: '_HistoryControllerBase.loadHistory');
    try {
      return super.loadHistory();
    } finally {
      _$_HistoryControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
history: ${history},
isLoading: ${isLoading}
    ''';
  }
}
