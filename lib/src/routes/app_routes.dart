import 'package:flutter/material.dart';
import '../modules/history/page/history_page.dart';
import '../modules/home/page/home_page.dart';
import '../modules/initial/page/initial_page.dart';

/// Define todas as rotas nomeadas da aplicação.
/// Centraliza a navegação — nenhuma página conhece outra diretamente.
abstract class AppRoutes {
  static const String initial = '/';
  static const String home = '/home';
  static const String history = '/history';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.initial:
        return _buildRoute(const InitialPage(), settings);

      case AppRoutes.home:
        return _buildRoute(const HomePage(), settings);

      case AppRoutes.history:
        return _buildRoute(const HistoryPage(), settings);

      default:
        return _buildRoute(const InitialPage(), settings);
    }
  }

  /// Cria um [MaterialPageRoute] com a transição padrão.
  static MaterialPageRoute<dynamic> _buildRoute(
    Widget page,
    RouteSettings settings,
  ) {
    return MaterialPageRoute(builder: (_) => page, settings: settings);
  }
}
