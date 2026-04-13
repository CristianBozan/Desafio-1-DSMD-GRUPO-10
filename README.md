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

## Funcionalidades

- Consulta de endereço por CEP via API pública [ViaCEP](https://viacep.com.br)
- Histórico de consultas armazenado localmente (Hive)
- Gerenciamento de estado reativo com MobX
- Tela de splash com animação de entrada
- Traçar rota até o endereço consultado (Google Maps / Waze)
- Remoção individual ou total do histórico

## Tecnologias

| Pacote | Uso |
|---|---|
| `dio` | Cliente HTTP para chamadas à API |
| `mobx` + `flutter_mobx` | Gerenciamento de estado reativo |
| `hive` + `hive_flutter` | Armazenamento local |
| `geocoding` | Conversão de endereço em coordenadas |
| `map_launcher` | Abertura de apps de mapa para traçar rota |

## Pré-requisitos

- [Flutter SDK](https://docs.flutter.dev/get-started/install) **3.x ou superior**
- Android Studio ou VS Code com extensão Flutter
- Dispositivo Android/iOS ou emulador configurado

## Como executar

### 1. Clone o repositório

```bash
git clone https://github.com/CristianBozan/Desafio-1-DSMD-GRUPO-10
cd fast_location
```

### 2. Instale as dependências

```bash
flutter pub get
```

### 3. Execute o aplicativo

```bash
flutter run
```

> Para um dispositivo específico:
> ```bash
> flutter run -d <device_id>
> ```
> Liste os dispositivos disponíveis com `flutter devices`.

### 4. (Opcional) Regerar o código MobX

Caso altere algum `@observable` ou `@action`:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## Estrutura do projeto

```
lib/
├── main.dart
└── src/
    ├── http/                        # Configuração do cliente Dio
    ├── routes/                      # Rotas nomeadas
    ├── shared/
    │   ├── colors/                  # Paleta de cores
    │   ├── components/              # Widgets compartilhados
    │   ├── metrics/                 # Espaçamentos e tamanhos
    │   └── storage/                 # Abstração do Hive
    └── modules/
        ├── initial/page/            # Splash screen
        ├── home/
        │   ├── model/               # CepModel (ViaCEP)
        │   ├── repositories/          # API + armazenamento local
        │   ├── service/             # Regras de negócio
        │   ├── controller/          # MobX store
        │   ├── components/          # Widgets da tela home
        │   └── page/                # HomePage
        └── history/
            ├── controller/          # MobX store
            └── page/                # HistoryPage
```

## API utilizada

[ViaCEP](https://viacep.com.br) — API pública e gratuita para consulta de CEPs brasileiros.

Exemplo de requisição:
```
GET https://viacep.com.br/ws/01001000/json/
```
