# FastLocation

### CONTEXTO ACADÊMICO

Curso: Superior de Tecnologia em Análise e Desenvolvimento de Sistemas  
Unidade Curricular: Desenvolvimento de Sistemas Móveis e Distribuídos  
Docente: Rafael de Faria Scheidt  

Equipe (Grupo 10):
- Michel Angelo da Silva Tuma
- Cristian Diego Bozan

---

Aplicativo mobile para consulta de CEP e endereços, desenvolvido com Flutter para o desafio da disciplina **Desenvolvimento de Sistemas Móveis e Distribuídos (SENAI)**.

---

## Funcionalidades

- Tela de splash com animação de entrada e redirecionamento automático
- Consulta de endereço por CEP via API pública [ViaCEP](https://viacep.com.br)
- Exibição detalhada do endereço consultado (logradouro, bairro, cidade, estado, DDD)
- Indicador de carregamento durante a consulta externa
- Mensagem de estado vazio quando nenhuma consulta foi realizada
- Armazenamento local do histórico de consultas (Hive)
- Tela de histórico com carregamento automático, remoção por item e limpeza total
- Ação para traçar rota do dispositivo até o endereço consultado (Google Maps / Waze)
- Gerenciamento de estado reativo com MobX

---

## Tecnologias e Dependências

| Pacote | Versão | Uso |
|---|---|---|
| `dio` | ^4.0.6 | Cliente HTTP para chamadas à API ViaCEP |
| `mobx` | ^2.0.6+1 | Gerenciamento de estado reativo |
| `flutter_mobx` | ^2.0.4 | Integração do MobX com widgets Flutter |
| `hive` | ^2.1.0 | Banco de dados local NoSQL |
| `hive_flutter` | ^1.1.0 | Inicialização do Hive no Flutter |
| `path_provider` | ^2.0.2 | Localização de diretórios do sistema |
| `path_provider_android` | ^2.0.14 | Suporte Android ao path_provider |
| `path_provider_ios` | ^2.0.9 | Suporte iOS ao path_provider |
| `map_launcher` | ^2.2.1+1 | Abertura de apps de mapa instalados |
| `geocoding` | ^2.1.1 | Conversão de endereço em coordenadas geográficas |

**Dev dependencies:** `mobx_codegen`, `build_runner`, `hive_generator`

---

## Pré-requisitos

- [Flutter SDK](https://docs.flutter.dev/get-started/install) **3.0 ou superior**
- Android Studio ou VS Code com extensão Flutter instalada
- Dispositivo Android físico **ou** emulador Android configurado
- Conexão com a internet (para consulta à API ViaCEP)

---

## Como executar

### 1. Clone o repositório

```bash
git clone https://github.com/CristianBozan/Desafio-1-DSMD-GRUPO-10
cd fast_location
```

### 2. Verifique o ambiente Flutter

```bash
flutter doctor
```

> Certifique-se de que não há erros críticos antes de prosseguir.

### 3. Instale as dependências

```bash
flutter pub get
```

### 4. Conecte um dispositivo ou inicie um emulador

Liste os dispositivos disponíveis:

```bash
flutter devices
```

### 5. Execute o aplicativo

```bash
flutter run
```

Para um dispositivo específico:

```bash
flutter run -d <device_id>
```

---

## Como usar o aplicativo

1. **Splash Screen** — ao abrir o app, uma tela animada é exibida e redireciona automaticamente para a Home
2. **Home** — digite um CEP no campo de busca (formato `00000-000`) e toque em **Buscar**
3. **Resultado** — o endereço completo é exibido em um card com logradouro, bairro, cidade, estado e DDD
4. **Traçar Rota** — toque no botão **Traçar Rota** para abrir o app de mapa e traçar o caminho até o endereço
5. **Histórico** — toque no ícone de histórico no canto superior direito para ver as consultas anteriores
6. **Re-consulta** — no histórico, toque em qualquer CEP para realizar uma nova consulta automaticamente

---

## Estrutura do projeto

```
lib/
├── main.dart                          # Inicialização do app e Hive
└── src/
    ├── http/                          # Configuração do cliente Dio
    ├── routes/                        # Rotas nomeadas da aplicação
    ├── shared/
    │   ├── colors/                    # Paleta de cores centralizada
    │   ├── components/                # Widgets compartilhados entre módulos
    │   ├── metrics/                   # Constantes de espaçamento e tamanho
    │   └── storage/                   # Abstração do armazenamento Hive
    └── modules/
        ├── initial/
        │   └── page/                  # Splash screen com animação
        ├── home/
        │   ├── model/                 # CepModel — estrutura de dados da API ViaCEP
        │   ├── repositories/          # Repositório da API e do armazenamento local
        │   ├── service/               # Regras de negócio da consulta de CEP
        │   ├── controller/            # MobX store da tela Home
        │   ├── components/            # Widgets: resultado, lista e estado vazio
        │   └── page/                  # HomePage com Observer e reactions MobX
        └── history/
            ├── controller/            # MobX store do histórico
            └── page/                  # HistoryPage com carregamento automático
```

---

## API utilizada

**[ViaCEP](https://viacep.com.br)** — API pública e gratuita para consulta de CEPs brasileiros.

Exemplo de requisição:
```
GET https://viacep.com.br/ws/01001000/json/
```

Exemplo de resposta:
```json
{
  "cep": "01001-000",
  "logradouro": "Praça da Sé",
  "complemento": "lado ímpar",
  "bairro": "Sé",
  "localidade": "São Paulo",
  "uf": "SP",
  "ddd": "11"
}
```
