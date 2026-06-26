# Flutter Account Migration Plan - Atualizado com Descobertas da Implementação

> **Projeto**: ibiapabaapp - Multi-Account Support
> **Status**: Implementação do Data Layer concluída com correções arquiteturais

---

## 📋 Visão Geral

Implementar suporte a múltiplas contas com arquitetura limpa, separando claramente responsabilidades entre **Autenticação** (Auth) e **Gerenciamento de Contas** (Accounts).

---

## 🎯 Modelo de Conta Unificada

### Conceitos Fundamentais

- **Unified Account Model**: Uma única classe `Account` para contas pessoais e empresariais
- **Account Types**: Tipo imutável (pessoal ou business) definido no registro
- **Contas Independentes**: Cada conta é completamente separada
- **Account Switching**: Estilo Instagram - troca rápida entre contas logadas no dispositivo

### Contas Cacheáveis (⚠️ **Correção Importante**)

**Entendimento Correto**: Contas cacheáveis são **apenas as contas que o usuário logou neste dispositivo**, não todas as contas do sistema.

- **Quando é cacheada**: Após registro ou login bem-sucedido
- **Quando é removida do cache**: Após logout
- **getCachedAccounts()**: Retorna apenas do cache local, **sem endpoint remoto**

---

## 🏗️ Arquitetura Clean - Separação de Responsabilidades

### **1. Auth Module** (Autenticação)
Responsabilidade: Login, registro, tokens, dados da sessão atual

```
lib/features/auth/
├── data/datasources/
│   ├── auth_remote_datasource.dart      # Login, register, refresh, getMe
│   └── auth_local_storage.dart          # Cache da conta atual (única)
├── domain/repositories/
│   └── auth_repository.dart             # Contratos de autenticação
```

**Métodos Auth**:
- `login(email, password)` → retorna AuthResult
- `register(formData)` → retorna AuthResult
- `getMe()` → retorna Account atual
- `refreshTokens()` → renova tokens
- `checkAvailability()` → valida email/slug

### **2. Accounts Module** (Gerenciamento de Contas Cacheadas)
Responsabilidade: Cache local de múltiplas contas, troca de conta ativa

```
lib/features/auth/
├── data/datasources/
│   ├── accounts_local_storage.dart      # Cache de múltiplas contas
│   └── accounts_remote_datasource.dart  # Operações em contas existentes
├── data/repositories/
│   └── accounts_repository_impl.dart    # Coordena cache + remote
├── domain/repositories/
│   └── accounts_repository.dart         # Contratos
├── domain/usecases/
│   ├── get_cached_accounts.dart         # Lista contas cacheadas
│   └── switch_account.dart              # Troca conta ativa
└── presentation/providers/
    └── accounts_providers.dart          # DI Riverpod
```

**Métodos Accounts**:
- `getCachedAccounts()` → apenas cache local
- `updateAccount()` → PATCH /accounts/:id
- `removeAccount()` → DELETE /accounts/:id
- `get/updateAccountInterests()` → interesses da conta
- `save/get/clearActiveAccountId()` → gerencia conta ativa

---

## 📦 Estrutura de Entidades

### Core Entities

```dart
// Account (Unified Model)
class Account {
  final String id;
  final String email;
  final String name;
  final String displayName;
  final String slug;
  final AccountType type;           // 'personal' | 'business'
  final AccountBusiness? business;  // null se personal
  final String? avatar;
  final bool isVerified;
  final DateTime createdAt;
  final DateTime updatedAt;
}

enum AccountType { personal, business }

class AccountBusiness {
  final String cnpj;
  final String? razaoSocial;
  final String? description;
  final String? phone;
}

class AccountInterests {
  final List<String> categories;
  final List<String> tags;
  final List<String> preferences;
}

class AuthResult {
  final Account account;
  final String accessToken;
  final String refreshToken;
}
```

---

## 🔄 Fluxos Principais

### Registro de Nova Conta
```
1. Usuário preenche formulário de registro
2. AuthRepository.register() → POST /auth/register
3. Em caso de sucesso:
   - Salva tokens (AuthLocalStorage)
   - Adiciona conta ao cache (AccountsLocalStorage.addCachedAccount())
   - Define como conta ativa (AccountsLocalStorage.saveActiveAccountId())
```

### Login
```
1. Usuário informa credenciais
2. AuthRepository.login() → POST /auth/login
3. Em caso de sucesso:
   - Salva tokens (AuthLocalStorage)
   - AuthRepository.getMe() → GET /auth/me (dados atualizados)
   - Adiciona conta ao cache (AccountsLocalStorage.addCachedAccount())
   - Define como conta ativa
```

### Switch de Conta
```
1. Usuário escolhe conta do cache local
2. AccountsRepository.saveActiveAccountId(accountId)
3. AuthLocalStorage salva nova conta atual
4. App session notificado da mudança
5. UI atualiza com dados da nova conta ativa
```

### Logout
```
1. AccountsRepository.removeCachedAccount(accountId) - remove do cache
2. AuthLocalStorage.clearAccount() - limpa conta atual
3. Se foi a última conta: redireciona para tela de welcome
4. Se há outras contas: mostra tela de switch para escolher outra
```

---

## 🛠️ Cache Strategy

### AccountsLocalStorage (extends BaseCacheStorage)

**Storage Keys**:
- `cached_accounts` → List<AccountModel> (contas logadas neste dispositivo)
- `active_account_id` → String? (ID da conta atualmente em uso)

**Métodos**:
```dart
Future<void> saveCachedAccounts(List<Account> accounts);
Future<List<AccountModel>> getCachedAccounts();
Future<void> addCachedAccount(Account account);      // Usado no login/register
Future<void> removeCachedAccount(String accountId);  // Usado no logout
Future<void> saveActiveAccountId(String accountId);
Future<String?> getActiveAccountId();
Future<void> clearActiveAccountId();
```

### Cache-First Strategy (Read)

Para `getCachedAccounts()`:
1. Retorna apenas do cache local
2. **Sem fallback remoto** (não existe endpoint para listar "todas as contas do usuário")
3. Lista vazia = usuário nunca logou neste dispositivo

---

## 📡 API Endpoints

### Auth Endpoints
```
POST /auth/register      # Registro (inclui type e profile fields)
POST /auth/login         # Login
POST /auth/refresh       # Refresh tokens
GET  /auth/me            # Dados da conta atual
POST /auth/check         # Verifica disponibilidade
```

### Accounts Endpoints
```
GET    /accounts/:id/interests      # Busca interesses
POST   /accounts/:id/interests      # Atualiza interesses
PATCH  /accounts/:id                # Atualiza conta
DELETE /accounts/:id                # Remove conta
```

**⚠️ Não existe**: `GET /accounts` (não há endpoint para listar todas as contas)

---

## 🗂️ Diretórios e Arquivos Criados

### Data Layer
```
lib/features/auth/data/datasources/
├── accounts_local_storage.dart          # Interface
├── accounts_remote_datasource.dart      # Interface (sem getCachedAccounts!)

lib/features/auth/data/repositories/
├── accounts_repository_impl.dart        # Implementação com caching
```

### Domain Layer
```
lib/features/auth/domain/repositories/
├── accounts_repository.dart             # Interface com Either<AppFailure, T>

lib/features/auth/domain/usecases/
├── get_cached_accounts.dart             # Usecase sem params
├── switch_account.dart                  # Usecase com params

lib/features/auth/domain/tags/
├── accounts_logtags.dart                # Enum de ações
```

### Infra Layer
```
lib/features/auth/infra/
├── accounts_local_storage_impl.dart     # Extends BaseCacheStorage
└── accounts_remote_datasource_impl.dart   # Implementação Dio
```

### Presentation Layer
```
lib/features/auth/presentation/providers/
└── accounts_providers.dart              # DI: datasources, repos, usecases
```

### Core Update
```
lib/core/logger/log_tags.dart
└── LogFeature.accounts                  # Nova feature para logging
```

---

## ✅ Checklist de Implementação - Data Layer (Agent B)

### Completed ✅
- [x] Entities: Account, AccountType, AccountBusiness, AccountInterests, AuthResult
- [x] Models: AccountModel, AccountInterestsModel com Freezed
- [x] AuthLocalStorage limpo (apenas conta única atual)
- [x] AccountsLocalStorage + Impl (cache múltiplas contas)
- [x] AccountsRemoteDatasource + Impl (operações em contas)
- [x] AccountsRepository + Impl (com strategy correta)
- [x] AccountsLogTags + LogFeature.accounts
- [x] Usecases: GetCachedAccounts, SwitchAccount
- [x] DI Providers com Riverpod
- [x] Build runner executado (arquivos .g.dart gerados)

---

## 🎓 Lições Aprendidas / Correções da Implementação

### ❌ Erros Iniciais Corrigidos

1. **Confusão Auth vs Accounts**: Inicialmente adicionamos métodos de account management no AuthRepository
   - **Correção**: Separar completamente. Auth = autenticação, Accounts = gerenciamento de cache

2. **Entendimento errado de "cached accounts"**: Achamos que deveria buscar do backend
   - **Correção**: "Cached accounts" são apenas contas logadas neste dispositivo, não existe endpoint remoto

3. **addAccount no Accounts**: Criamos método para "adicionar conta" no AccountsRepository
   - **Correção**: Contas são adicionadas via registro (Auth.register), não existe endpoint POST /accounts para criar

### ✅ Padrões Confirmados

1. **Clean Architecture**: Domain ← Data ← Infra funcionou perfeitamente
2. **BaseCacheStorage**: Extender para implementações de cache local é o padrão correto
3. **Either<AppFailure, T>**: Tratamento funcional de erros no domain layer
4. **Riverpod Generator**: Providers com @riverpod funcionam bem

---

## 🚀 Próximos Passos (Próximos Agentes)

### Agent C: Session Management & App State
- [x] Implementar AppSessionState multi-account
- [x] Account switching logic
- [x] Session restoration with account selection
- [x] Logout with account cache management

### Agent D: UI & User Experience
- [ ] Account switcher UI
- [ ] Account creation flow
- [ ] Profile switching animations
- [ ] Quick account switch gestures

---

## 📚 Referências

- **Clean Arch Pattern**: `lib/features/favorites/` - implementação de referência
- **Skill**: `.windsurf/workflows/clean_arch_feature_first.md`
