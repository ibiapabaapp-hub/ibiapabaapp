# IbiapabaApp

<div>
  <img src='https://img.shields.io/badge/flutter-%2302569B.svg?style=for-the-badge&logo=flutter&logoColor=white' alt='Flutter'>
  <img src='https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white' alt='Dart'>
  <img src='https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black' alt='Firebase'>
  <img src='https://img.shields.io/badge/riverpod-27B1FF?style=for-the-badge&logo=dart&logoColor=white' alt='Riverpod'>
  <img src='https://img.shields.io/badge/PostgreSQL-336791?style=for-the-badge&logo=postgresql&logoColor=white' alt='PostgreSQL'>
</div>

[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=ibiapabaapp-hub_ibiapabaapp&metric=alert_status&token=f74b646b9b72ed266c152ab5aa8913c400e2957c)](https://sonarcloud.io/summary/new_code?id=ibiapabaapp-hub_ibiapabaapp)

Aplicação mobile e web multiplataforma desenvolvida com Flutter para a plataforma IbiapabaApp, conectando usuários às informações sobre cidades, negócios, eventos e conteúdo multimídia da região do Ibiapaba.

## 📱 Sobre o Projeto

IbiapabaApp é uma solução que oferece uma experiência integrada para exploradores urbanos, turistas, residentes e empresários da região do Ibiapaba. O aplicativo facilita a descoberta de estabelecimentos, acompanhamento de eventos, interação com a comunidade e acesso a conteúdo multimídia da região.

### Plataformas Suportadas
- ✅ Android
- ✅ iOS
- ✅ Linux

## ✨ Funcionalidades Principais

- **Autenticação Segura**: Registro, login/logout com JWT, refresh tokens e armazenamento seguro via Flutter Secure Storage
- **Exploração de Cidades**: Visualização de cidades com localização, mídias e categorias
- **Descoberta de Negócios**: Busca e visualização de estabelecimentos por categorias, localização e avaliações
- **Gerenciamento de Eventos**: Acompanhamento de eventos com datas, horários e localização
- **Perfis Personalizados**: Perfis pessoais e empresariais com controle de permissões
- **Sistema de Busca**: Busca unificada por cidades, negócios e eventos
- **Mídia em Tempo Real**: Upload e visualização de imagens e vídeos via Cloudflare R2 CDN
- **Leads e Contatos**: Captura de leads (residentes, turistas, empresários) para follow-up
- **Interface Responsiva**: Design adaptativo para todos os tamanhos de tela com Forui
- **Offline Support**: Sincronização local de dados com Sembast
- **Localização**: Integração com mapas e geolocalização

## 🛠️ Stack Tecnológico

### Framework & Linguagem
- **Flutter**: Framework multiplataforma para UI/UX consistente
- **Dart**: Linguagem de programação moderna e eficiente

### State Management & Arquitetura
- **Riverpod**: Gerenciamento de estado reativo e injeção de dependência
- **GoRouter**: Roteamento tipo-seguro com suporte a deep linking

### Integração & API
- **Dio**: Cliente HTTP robusto com interceptadores
- **NestJS API**: Backend escalável em TypeScript

### Armazenamento & Persistência
- **Sembast**: Base de dados local (offline-first)
- **Flutter Secure Storage**: Armazenamento seguro de credenciais
- **Shared Preferences**: Preferências do usuário

### Design & UI
- **Forui**: Sistema de design com componentes customizáveis
- **Google Fonts**: Tipografia consistente
- **Flutter Animations**: Transições suaves entre telas

### Utilitários
- **Brasil Fields**: Validação de campos brasileiros (CPF, CNPJ, etc)
- **Carousel Slider**: Carrosséis responsivos
- **Logger**: Logging estruturado para debug
- **Intl**: Internacionalização e localização

## 🚀 Começando Rápido

### Pré-requisitos
- Flutter SDK: `^3.10.7`
- Dart: Incluído com Flutter
- Git
- Um editor de código (VS Code, Android Studio ou IntelliJ)

### Instalação

#### 1. Clonar o repositório

```bash
git clone https://github.com/1manuelc/ibiapabaapp.git
cd ibiapabaapp
```

#### 2. Instalar dependências

```bash
flutter pub get
```

#### 3. Gerar código com build_runner

```bash
flutter pub run build_runner build
```

#### 4. Configurar variáveis de ambiente

Crie um arquivo `.env` na raiz do projeto:

```env
API_BASE_URL=https://api.ibiapabaapp.com.br
LOGGER_LEVEL="all"
```

Copie também o arquivo de exemplo:

```bash
cp .env.example .env
```

#### 5. Rodar em modo desenvolvimento

**Mobile (Android)**
```bash
flutter run -d android
```

**Mobile (iOS)**
```bash
flutter run -d ios
```

**Desktop (Linux)**
```bash
flutter run -d linux
```

## 📂 Estrutura do Projeto

```
lib/
├── app/           # Inicialização e configuração principal do app
├── core/          # Serviços, temas, utilitários, configurações globais
├── features/      # Funcionalidades agrupadas por domínio (ex: auth, city, business, event, etc)
├── shared/        # Widgets, helpers e recursos reutilizáveis
└── main.dart      # Ponto de entrada da aplicação
```

## 🏗️ Arquitetura

O projeto segue a **Clean Architecture** com separação clara de responsabilidades:

- **Domain Layer**: Lógica de negócio independente de framework
- **Data Layer**: Implementação de repositórios e fontes de dados
- **Presentation Layer**: UI, state management e interações

Combinada com **Riverpod** para gerenciamento reativo e eficiente do estado.

## 📝 Scripts Disponíveis

```bash
# Desenvolvimento
flutter run                        # Rodar em dispositivo padrão
flutter run -d <device_id>         # Rodar em dispositivo específico

# Build & Geração de Código
flutter pub get                     # Instalar dependências
flutter pub run build_runner build  # Gerar código (Riverpod, etc)
flutter pub run build_runner clean  # Limpar arquivos gerados

# Análise & Testes
flutter analyze                     # Análise estática
flutter test                        # Rodar testes unitários
flutter test --coverage             # Testes com cobertura

# Build para Produção
flutter build apk                   # Build Android APK
flutter build ios                   # Build iOS (requer macOS)
```

## 🔐 Autenticação

A aplicação utiliza JWT (JSON Web Tokens) com fluxo seguro:

1. **Registro**: Usuário cria conta com email/telefone e senha
2. **Login**: Credenciais são enviadas, JWT é retornado
3. **Armazenamento Seguro**: Token armazenado em Flutter Secure Storage
4. **Requisições Autenticadas**: Token é incluído no header `Authorization: Bearer <token>`
5. **Refresh Automático**: Tokens expirados são renovados automaticamente via refresh token

## 🔄 Fluxo de Dados

```
UI (Widgets)
    ↓
Riverpod Providers (State Management)
    ↓
UseCases (Lógica de Negócio)
    ↓
Repositories (Abstração de Dados)
    ↓
DataSources (API HTTP, Banco Local)
```

## ✅ Validação de Dados

- Validação robusta com `form_builder_validators`
- Suporte a campos brasileiros (CPF, CNPJ, telefone) via `brasil_fields`
- Mensagens de erro claras e localizadas
- Validação em tempo real nos formulários

## 🗺️ Geolocalização

- Integração com `latlong2` para coordenadas geográficas
- Suporte a mapas (interativos no futuro)
- Busca por proximidade
- Visualização de localização de negócios e eventos (futuro)

## 📡 Sincronização Offline

- Cache local com **Sembast**
- Sincronização automática quando conectado
- Fila de operações para modo offline
- Indicadores de status online/offline

## 🎨 Design System

O projeto utiliza **Forui** (design system) com:
- Componentes customizáveis
- Tema consistente
- Tipografia com Google Fonts
- Paleta de cores moderna
- Suporte a dark mode

## 🧪 Testes

```bash
# Testes unitários
flutter test

# Testes com coverage
flutter test --coverage

# Testes específicos
flutter test test/features/auth_test.dart
```

## 🐛 Debug & Logs

Logs estruturados com `logger`:

```dart
logger.d('Debug message');
logger.i('Info message');
logger.w('Warning message');
logger.e('Error message');
```

## 📱 Responsividade

A aplicação é totalmente responsiva, com breakpoints para:
- Mobile (< 600px)
- Tablet (600px - 900px)
- Desktop (> 900px)

## 🌍 Internacionalização

Suporte a múltiplos idiomas com `intl` package. Strings localizadas em `assets/i18n/` (futuro).

## 📞 Suporte & Contato

- **Issues**: Use GitHub Issues para reportar bugs
- **Autor**: [@1manuelc](https://github.com/1manuelc)
- **Organização**: [@ibiapabaapp-hub](https://github.com/ibiapabaapp-hub)

## 📄 Licença

Este projeto está licenciado sob a MIT License - veja o arquivo [LICENSE](LICENSE) para detalhes.

## 🙏 Contribuindo

Contribuições são bem-vindas! Por favor:

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

---

**Desenvolvido com ❤️ para a comunidade da Ibiapaba**
