import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../routes/app_routes.dart';
import '../../../shared/colors/app_colors.dart';
import '../../../shared/components/app_loading_widget.dart';
import '../../../shared/metrics/app_metrics.dart';
import '../../home/components/address_list_component.dart';
import '../controller/history_controller.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final HistoryController _controller = HistoryController();

  @override
  void initState() {
    super.initState();
    // Carrega o histórico automaticamente ao abrir a tela
    _controller.loadHistory();
  }

  Future<void> _confirmClearAll() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Limpar histórico'),
        content: const Text('Deseja remover todos os endereços consultados?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Limpar'),
          ),
        ],
      ),
    );
    if (confirmed == true) await _controller.clearHistory();
  }

  void _reSearch(String cep) {
    Navigator.pushReplacementNamed(
      context,
      AppRoutes.home,
      arguments: cep,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico'),
        actions: [
          Observer(
            builder: (_) => _controller.history.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.delete_sweep_outlined),
                    tooltip: 'Limpar histórico',
                    onPressed: _confirmClearAll,
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
      body: Observer(
        builder: (_) {
          if (_controller.isLoading) {
            return const AppLoadingWidget(message: 'Carregando histórico...');
          }

          if (_controller.history.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.history_toggle_off_rounded,
                    size: 80,
                    color: AppColors.textHint,
                  ),
                  const SizedBox(height: AppMetrics.spacingM),
                  const Text(
                    'Histórico vazio',
                    style: TextStyle(
                      fontSize: AppMetrics.fontXL,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppMetrics.spacingS),
                  const Text(
                    'Os CEPs consultados aparecerão aqui.',
                    style: TextStyle(
                      fontSize: AppMetrics.fontM,
                      color: AppColors.textHint,
                    ),
                  ),
                  const SizedBox(height: AppMetrics.spacingXL),
                  ElevatedButton.icon(
                    onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.home),
                    icon: const Icon(Icons.search),
                    label: const Text('Fazer uma consulta'),
                  ),
                ],
              ),
            );
          }

          return AddressListComponent(
            cepList: _controller.history.toList(),
            onTap: _reSearch,
            onDelete: (index) => _controller.removeItem(index),
          );
        },
      ),
    );
  }
}
