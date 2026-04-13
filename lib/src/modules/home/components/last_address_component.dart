import 'package:flutter/material.dart';

import '../../../shared/colors/app_colors.dart';
import '../../../shared/metrics/app_metrics.dart';
import '../model/cep_model.dart';

/// Exibe o último endereço consultado com opções de nova consulta e rota.
class LastAddressComponent extends StatelessWidget {
  final CepModel cepData;
  final VoidCallback onNavigate;
  final VoidCallback onClear;

  const LastAddressComponent({
    super.key,
    required this.cepData,
    required this.onNavigate,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: AppMetrics.elevationMedium,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppMetrics.radiusL),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppMetrics.spacingL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const Divider(height: AppMetrics.spacingXL),
              _buildInfoRow(Icons.pin_drop, 'CEP', cepData.cep),
              if (cepData.logradouro.isNotEmpty)
                _buildInfoRow(Icons.streetview, 'Logradouro', cepData.logradouro),
              if (cepData.complemento.isNotEmpty)
                _buildInfoRow(Icons.info_outline, 'Complemento', cepData.complemento),
              if (cepData.bairro.isNotEmpty)
                _buildInfoRow(Icons.location_city, 'Bairro', cepData.bairro),
              _buildInfoRow(Icons.place, 'Cidade', cepData.localidade),
              _buildInfoRow(Icons.map, 'Estado', cepData.uf),
              if (cepData.ddd.isNotEmpty)
                _buildInfoRow(Icons.phone, 'DDD', cepData.ddd),
              const SizedBox(height: AppMetrics.spacingL),
              _buildActions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        const Icon(Icons.location_on, color: AppColors.primary, size: AppMetrics.iconL),
        const SizedBox(width: AppMetrics.spacingS),
        Expanded(
          child: Text(
            '${cepData.localidade} / ${cepData.uf}',
            style: const TextStyle(
              fontSize: AppMetrics.fontXL,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.close, color: AppColors.textSecondary),
          tooltip: 'Nova consulta',
          onPressed: onClear,
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppMetrics.spacingXS),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: AppMetrics.iconM, color: AppColors.secondary),
          const SizedBox(width: AppMetrics.spacingS),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: AppMetrics.fontS,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: AppMetrics.fontL,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onNavigate,
        icon: const Icon(Icons.directions),
        label: const Text('Traçar Rota'),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondary,
          foregroundColor: AppColors.textOnPrimary,
          minimumSize: const Size(double.infinity, AppMetrics.buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppMetrics.radiusM),
          ),
        ),
      ),
    );
  }
}
