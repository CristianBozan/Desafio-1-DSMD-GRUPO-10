import 'package:flutter/material.dart';

import '../../../shared/colors/app_colors.dart';
import '../../../shared/metrics/app_metrics.dart';

/// Estado vazio exibido quando nenhuma consulta foi realizada ainda.
class EmptySearchComponent extends StatelessWidget {
  const EmptySearchComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 80,
            color: AppColors.textHint,
          ),
          const SizedBox(height: AppMetrics.spacingM),
          const Text(
            'Nenhum endereço consultado',
            style: TextStyle(
              fontSize: AppMetrics.fontXL,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppMetrics.spacingS),
          const Text(
            'Digite um CEP acima e toque em Buscar\npara ver as informações do endereço.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: AppMetrics.fontM,
              color: AppColors.textHint,
            ),
          ),
        ],
      ),
    );
  }
}
