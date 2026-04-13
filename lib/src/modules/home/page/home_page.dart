import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:geocoding/geocoding.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:mobx/mobx.dart';

import '../../../routes/app_routes.dart';
import '../../../shared/colors/app_colors.dart';
import '../../../shared/components/app_loading_widget.dart';
import '../../../shared/metrics/app_metrics.dart';
import '../components/empty_search_component.dart';
import '../components/last_address_component.dart';
import '../controller/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController _controller = HomeController();
  final TextEditingController _cepController = TextEditingController();
  late ReactionDisposer _errorDisposer;

  @override
  void initState() {
    super.initState();
    // Reação MobX: exibe snackbar ao detectar erro
    _errorDisposer = reaction(
      (_) => _controller.errorMessage,
      (String? error) {
        if (error != null && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error),
              backgroundColor: AppColors.error,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
    );

    // Se vier do histórico com um CEP como argumento, dispara a busca automaticamente
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cep = ModalRoute.of(context)?.settings.arguments as String?;
      if (cep != null && cep.isNotEmpty) {
        _cepController.text = cep;
        _controller.searchCep(cep);
      }
    });
  }

  @override
  void dispose() {
    _errorDisposer();
    _cepController.dispose();
    super.dispose();
  }

  void _search() {
    FocusScope.of(context).unfocus();
    _controller.searchCep(_cepController.text.trim());
  }

  Future<void> _openMapRoute() async {
    final cepData = _controller.cepData;
    if (cepData == null) return;

    try {
      final locations = await locationFromAddress(cepData.geocodeAddress);
      if (locations.isEmpty) throw Exception('Endereço não encontrado no mapa.');

      final lat = locations.first.latitude;
      final lng = locations.first.longitude;

      final availableMaps = await MapLauncher.installedMaps;
      if (availableMaps.isEmpty) throw Exception('Nenhum aplicativo de mapa instalado.');

      await availableMaps.first.showDirections(
        destination: Coords(lat, lng),
        destinationTitle: cepData.fullAddress,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll('Exception: ', '')),
            backgroundColor: AppColors.warning,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FastLocation'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'Histórico de consultas',
            onPressed: () => Navigator.pushNamed(context, AppRoutes.history),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppMetrics.screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSearchForm(),
            const SizedBox(height: AppMetrics.spacingXL),
            Expanded(child: _buildContent()),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchForm() {
    return Card(
      elevation: AppMetrics.elevationLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppMetrics.radiusL),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppMetrics.spacingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _cepController,
              keyboardType: TextInputType.number,
              maxLength: 9,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                _CepInputFormatter(),
              ],
              decoration: const InputDecoration(
                labelText: 'CEP',
                hintText: '00000-000',
                prefixIcon: Icon(Icons.search),
                counterText: '',
              ),
              onSubmitted: (_) => _search(),
            ),
            const SizedBox(height: AppMetrics.spacingM),
            Observer(
              builder: (_) => ElevatedButton.icon(
                onPressed: _controller.isLoading ? null : _search,
                icon: _controller.isLoading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.textOnPrimary,
                        ),
                      )
                    : const Icon(Icons.search),
                label: Text(_controller.isLoading ? 'Consultando...' : 'Buscar'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Observer(
      builder: (_) {
        if (_controller.isLoading) {
          return const AppLoadingWidget();
        }
        if (_controller.cepData != null) {
          return LastAddressComponent(
            cepData: _controller.cepData!,
            onNavigate: _openMapRoute,
            onClear: _controller.clearSearch,
          );
        }
        return const EmptySearchComponent();
      },
    );
  }
}

/// Formata automaticamente o CEP enquanto o usuário digita (00000-000).
class _CepInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final buffer = StringBuffer();

    for (int i = 0; i < digits.length && i < 8; i++) {
      if (i == 5) buffer.write('-');
      buffer.write(digits[i]);
    }

    final formatted = buffer.toString();
    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
