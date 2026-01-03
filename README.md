# Marshaller

![License](https://img.shields.io/badge/License-BSD--3--Clause-blue.svg)
![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter) ![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart)

Projeto pessoal criado para implementar uma interface clean e elegante para um boilerplate interno, seguindo as [recomendações oficiais do Flutter](https://docs.flutter.dev/app-architecture/recommendations) para arquitetura de aplicativos.

## ✨ Características

- 🏗️ **Clean Architecture** - Separação clara entre UI, Data e Domain
- 📱 **MVVM** - ViewModels com ValueNotifier e Command Pattern
- 🎨 **Design System** - ThemeExtension para cores, espaçamentos e tipografia
- 🌍 **Internacionalização** - Suporte a múltiplos idiomas com ARB
- 🔐 **Segurança** - Armazenamento seguro com criptografia
- 🧪 **Testável** - Estrutura preparada para testes unitários, widget e integração

## 🚀 Quick Start

```bash
# Clone o repositório
git clone https://github.com/wevertonj/marshaller.git
cd marshaller

# Instale as dependências
flutter pub get

# Gere o código necessário
dart run build_runner build --delete-conflicting-outputs

# Execute o app
flutter run
```

## 📂 Estrutura

```bash
lib/
├── config/         # Configurações, DI, Rotas, Flavors
├── data/           # DTOs, Repositories, Services, Exceptions
├── domain/         # Entities, Validators, Enums
├── ui/             # Features (Pages, ViewModels, Widgets)
│   └── core/       # Theme, Widgets globais
└── utils/          # Extensions, Formatters, L10n
```

## 🏗️ Arquitetura

O projeto segue uma arquitetura **MVVM (Model-View-ViewModel)** combinada com o **Repository Pattern**, respeitando os princípios de separação de responsabilidades:

### Camadas

| Camada | Responsabilidade |
|--------|------------------|
| **UI** | Pages, Widgets e ViewModels que gerenciam a lógica de apresentação |
| **Domain** | Entidades de negócio, enums e validadores que representam as regras do domínio |
| **Data** | Repositories, DTOs, Services e tratamento de exceções para acesso a dados |

### Fluxo de Dados

```
UI (Page) → ViewModel → Repository → Service → API/Storage
                ↓
           Entities (Domain)
```

1. A **Page** interage com o usuário e observa o **ViewModel**
2. O **ViewModel** processa comandos e estados usando `ValueNotifier` e o **Command Pattern**
3. O **Repository** abstrai a fonte de dados, implementando a interface do Domain
4. O **Service** realiza as operações de I/O (HTTP, Storage, etc.)

### Command Pattern

Os ViewModels utilizam o padrão Command para encapsular ações assíncronas, fornecendo estados de loading, erro e sucesso de forma reativa:

```dart
class MyViewModel extends ChangeNotifier {
  final GetDataCommand getDataCommand;
  
  MyViewModel(this.getDataCommand);
  
  void loadData() => getDataCommand.execute();
}
```

### Injeção de Dependências

O projeto utiliza **GetIt** para inversão de controle, configurado em `lib/config/di/`. Cada módulo registra suas dependências de forma organizada.

## 🛠️ Stack Tecnológica

| Categoria | Tecnologia |
|-----------|------------|
| Framework | Flutter SDK + Dart 3 |
| Estado | ValueNotifier + Command Pattern |
| Navegação | GoRouter |
| HTTP | Dio |
| Serialização | JsonSerializable + Equatable |
| Validação | lucid_validation |
| DI | GetIt |
| Storage | flutter_secure_storage |

## 🔧 Comandos Úteis

```bash
# Análise de código
flutter analyze

# Testes
flutter test

# Testes com cobertura
flutter test --coverage

# Gerar código (DTOs)
dart run build_runner build --delete-conflicting-outputs

# Gerar arquivos de internacionalização (l10n)
flutter gen-l10n

# Build Android
flutter build apk --release

# Build iOS
flutter build ipa --release
```

### VSCode Launch Configurations

Configurações de lançamento disponíveis em `.vscode/launch.json`:

| Configuração | Descrição |
|--------------|-----------|
| `Launch Dev` | Executa o app com flavor de desenvolvimento |

### VSCode Tasks

Tasks disponíveis em `.vscode/tasks.json`:

| Task | Descrição |
|------|-----------| 
| `Build Android APK` | Gera APK release |
| `Build iOS for TestFlight` | Limpa, restaura deps e gera IPA para TestFlight |

## 📄 Licença

Este projeto está licenciado sob a licença **BSD-3-Clause** - veja o arquivo [LICENSE](LICENSE) para detalhes.

