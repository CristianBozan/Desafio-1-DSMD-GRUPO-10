import 'package:flutter/material.dart';

import '../colors/app_colors.dart';
import '../metrics/app_metrics.dart';

/// Indicador de carregamento centralizado, compartilhado entre módulos.
class AppLoadingWidget extends StatelessWidget {
  final String message;

  const AppLoadingWidget({
    super.key,
    this.message = 'Consultando...',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(color: AppColors.primary),
          const SizedBox(height: AppMetrics.spacingM),
          Text(
            message,
            style: const TextStyle(
              fontSize: AppMetrics.fontM,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
