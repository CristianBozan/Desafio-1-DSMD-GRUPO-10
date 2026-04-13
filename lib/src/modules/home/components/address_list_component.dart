import 'package:flutter/material.dart';

import '../../../shared/colors/app_colors.dart';
import '../../../shared/metrics/app_metrics.dart';

/// Lista de endereços (CEPs) consultados anteriormente.
/// Usada tanto na Home quanto na tela de histórico.
class AddressListComponent extends StatelessWidget {
  final List<String> cepList;
  final void Function(String cep)? onTap;
  final void Function(int index)? onDelete;

  const AddressListComponent({
    super.key,
    required this.cepList,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (cepList.isEmpty) {
      return const Center(
        child: Text(
          'Nenhum endereço consultado ainda.',
          style: TextStyle(color: AppColors.textSecondary),
        ),
      );
    }

    return ListView.separated(
      itemCount: cepList.length,
      separatorBuilder: (_, _) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final cep = cepList[index];
        final formatted = _formatCep(cep);

        return ListTile(
          leading: const CircleAvatar(
            backgroundColor: AppColors.primaryLight,
            child: Icon(Icons.location_on, color: AppColors.textOnPrimary, size: AppMetrics.iconM),
          ),
          title: Text(
            formatted,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          subtitle: const Text(
            'Toque para consultar novamente',
            style: TextStyle(fontSize: AppMetrics.fontS, color: AppColors.textSecondary),
          ),
          trailing: onDelete != null
              ? IconButton(
                  icon: const Icon(Icons.delete_outline, color: AppColors.error),
                  tooltip: 'Remover do histórico',
                  onPressed: () => onDelete!(index),
                )
              : const Icon(Icons.chevron_right, color: AppColors.textSecondary),
          onTap: onTap != null ? () => onTap!(cep) : null,
        );
      },
    );
  }

  /// Formata o CEP no padrão 00000-000.
  String _formatCep(String cep) {
    final digits = cep.replaceAll(RegExp(r'\D'), '');
    if (digits.length == 8) {
      return '${digits.substring(0, 5)}-${digits.substring(5)}';
    }
    return cep;
  }
}
