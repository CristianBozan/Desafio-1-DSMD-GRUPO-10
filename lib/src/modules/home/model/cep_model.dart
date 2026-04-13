/// Modelo de dados para o retorno da API ViaCEP.
/// Referência: https://viacep.com.br/ws/{cep}/json/
class CepModel {
  final String cep;
  final String logradouro;
  final String complemento;
  final String bairro;
  final String localidade;
  final String uf;
  final String ibge;
  final String ddd;

  const CepModel({
    required this.cep,
    required this.logradouro,
    required this.complemento,
    required this.bairro,
    required this.localidade,
    required this.uf,
    required this.ibge,
    required this.ddd,
  });

  factory CepModel.fromJson(Map<String, dynamic> json) {
    return CepModel(
      cep: json['cep'] as String? ?? '',
      logradouro: json['logradouro'] as String? ?? '',
      complemento: json['complemento'] as String? ?? '',
      bairro: json['bairro'] as String? ?? '',
      localidade: json['localidade'] as String? ?? '',
      uf: json['uf'] as String? ?? '',
      ibge: json['ibge'] as String? ?? '',
      ddd: json['ddd'] as String? ?? '',
    );
  }

  /// Endereço completo formatado para exibição.
  String get fullAddress {
    final parts = <String>[];
    if (logradouro.isNotEmpty) parts.add(logradouro);
    if (complemento.isNotEmpty) parts.add(complemento);
    if (bairro.isNotEmpty) parts.add(bairro);
    parts.add('$localidade/$uf');
    return parts.join(', ');
  }

  /// String de endereço usada para geocodificação.
  String get geocodeAddress => '$logradouro, $bairro, $localidade, $uf, Brasil';

  @override
  String toString() => 'CepModel(cep: $cep, localidade: $localidade/$uf)';
}
