# Clean Architecture + Feature First - SKILL

> **Projeto**: ibiapabaapp  
> **Padrão**: Clean Architecture com Feature First + Riverpod + Dartz  
> **Data**: Baseado na feature `favorites`

---

## 📁 Estrutura de Diretórios

```
lib/features/{feature_name}/
├── data/
│   ├── datasources/
│   │   ├── {feature}_local_storage.dart          # Contrato (abstract)
│   │   └── {feature}_remote_datasource.dart      # Contrato (abstract)
│   └── repositories/
│       └── {feature}_repository_impl.dart        # Implementação com caching
├── domain/
│   ├── entities/
│   │   └── {entity}.dart                         # Entidade pura (sem dependências)
│   ├── repositories/
│   │   └── {feature}_repository.dart             # Contrato com Either<AppFailure, T>
│   ├── usecases/
│   │   ├── get_all_{entities}.dart               # Usecase com Params
│   │   ├── create_{entity}.dart
│   │   └── delete_{entity}.dart
│   └── tags/
│       └── {feature}_logtags.dart                # Enum de ações para logging
├── infra/
│   ├── models/
│   │   └── {entity}_model.dart                   # Model com Freezed + JsonSerializable
│   ├── {feature}_local_storage_impl.dart         # Implementação cache (extends BaseCacheStorage)
│   └── {feature}_remote_datasource_impl.dart     # Implementação API (Dio)
└── presentation/
    ├── providers/
    │   ├── {feature}_providers.dart              # DI: datasources, repos, usecases
    │   └── {feature}_state_provider.dart          # StateNotifier (controller)
    ├── routes/
    ├── screens/
    └── widgets/
```

---

## 🎯 Princípios Fundamentais

### 1. Camadas e Responsabilidades

| Camada | Responsabilidade | Retorno |
|--------|------------------|---------|
| **Domain/Entity** | Definir objetos de negócio puros | Tipos primitivos |
| **Domain/Repository** | Contrato para operações de dados | `Either<AppFailure, T>` |
| **Domain/Usecase** | Orquestrar uma única operação | `Either<AppFailure, T>` |
| **Data/Datasource** | Contrato para fontes de dados | Tipos primitivos |
| **Infra/Storage** | Implementação cache local | `extends BaseCacheStorage` |
| **Infra/Datasource** | Implementação API remota | Usa `Dio` |
| **Data/Repository** | Coordenar cache + remote + erros | `Either<AppFailure, T>` |
| **Presentation/Provider** | Injeção de dependência | Riverpod providers |
| **Presentation/State** | Gerenciar estado e ações do usuário | `StateNotifier` |

### 2. Regra de Dependência
```
Domain ← Data ← Infra
Domain ← Usecases
Presentation → Usecases → Repository → Datasources
```

**NUNCA** importe `infra` ou `data` no `domain`.

---

## 📝 Padrões de Código

### 1. Entity (Domain)

```dart
// lib/features/{feature}/domain/entities/{entity}.dart
class {Entity} {
  final String? id;
  final String requiredField;
  final String? optionalField;

  {Entity}({
    this.id,
    required this.requiredField,
    this.optionalField,
  });
}
```

**Regras:**
- Sem imports externos
- Campos `final`
- Constructor com `required` para obrigatórios
- Nullable (`?`) para campos opcionais

---

### 2. Model (Infra)

```dart
// lib/features/{feature}/infra/models/{entity}_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:{app}/features/{feature}/domain/entities/{entity}.dart';

part '{entity}_model.freezed.dart';
part '{entity}_model.g.dart';

@freezed
abstract class {Entity}Model with _${Entity}Model implements {Entity} {
  const {Entity}Model._();

  const factory {Entity}Model({
    @JsonKey(name: 'id', includeIfNull: false) String? id,
    @JsonKey(name: 'field_name') required String fieldName,
    @JsonKey(name: 'optional_field', defaultValue: null) String? optionalField,
  }) = _{Entity}Model;

  factory {Entity}Model.fromJson(Map<String, dynamic> json) =>
      _${Entity}ModelFromJson(json);

  static List<{Entity}> fromJsonList(dynamic jsonList) {
    if (jsonList == null) return [];
    return (jsonList as List<dynamic>)
        .map((json) => {Entity}Model.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  static Map<String, dynamic> toMap({Entity} entity) {
    if (entity is {Entity}Model) return entity.toJson();
    return {Entity}Model(
      id: entity.id,
      fieldName: entity.fieldName,
      optionalField: entity.optionalField,
    ).toJson();
  }
}
```

**Regras:**
- `implements {Entity}` para garantir conformidade
- `@JsonKey(name: 'snake_case')` para mapeamento API
- `fromJsonList` para parse de arrays
- `toMap` para serialização genérica

---

### 3. Local Storage Interface (Data)

```dart
// lib/features/{feature}/data/datasources/{feature}_local_storage.dart
import 'package:{app}/features/{feature}/domain/entities/{entity}.dart';

abstract class {Feature}LocalStorage {
  Future<void> save{Entities}ByProfile({
    required String profileId,
    required List<{Entity}> {entities},
  });
  Future<List<{Entity}>> load{Entities}ByProfile({required String profileId});
  Future<void> clear{Entities}ByProfile({required String profileId});
  Future<void> push{Entity}({required {Entity} {entity}});
  Future<void> pop{Entity}({required {Entity} {entity}});
}
```

---

### 4. Local Storage Implementation (Infra)

```dart
// lib/features/{feature}/infra/{feature}_local_storage_impl.dart
import 'package:{app}/core/cache/base_cache_storage.dart';
import 'package:{app}/features/{feature}/data/datasources/{feature}_local_storage.dart';
import 'package:{app}/features/{feature}/domain/entities/{entity}.dart';
import 'package:{app}/features/{feature}/infra/models/{entity}_model.dart';

class {Feature}LocalStorageImpl extends BaseCacheStorage
    implements {Feature}LocalStorage {
  {Feature}LocalStorageImpl(super.cacheService);

  @override
  String get storeName => '{entities}';  // Nome da store no cache

  @override
  Future<void> save{Entities}ByProfile({
    required String profileId,
    required List<{Entity}> {entities},
  }) async {
    await saveList(
      key: '$profileId.{entities}',
      items: {entities},
      toMap: (i) => {Entity}Model.toMap(i),
    );
  }

  @override
  Future<List<{Entity}>> load{Entities}ByProfile({
    required String profileId,
  }) async {
    return await getList(
      key: '$profileId.{entities}',
      fromJson: (json) => {Entity}Model.fromJson(json),
    );
  }

  @override
  Future<void> push{Entity}({required {Entity} {entity}}) async {
    final cached = await getList<{Entity}>(
      key: '${entity.profileId}.{entities}',
      fromJson: (json) => {Entity}Model.fromJson(json),
    );
    cached.add({entity});
    return save{Entities}ByProfile(
      profileId: {entity}.profileId,
      {entities}: cached,
    );
  }

  @override
  Future<void> pop{Entity}({required {Entity} {entity}}) async {
    final cached = await getList<{Entity}>(
      key: '${entity.profileId}.{entities}',
      fromJson: (json) => {Entity}Model.fromJson(json),
    );
    cached.removeWhere((e) => e.id == {entity}.id);
    return save{Entities}ByProfile(
      profileId: {entity}.profileId,
      {entities}: cached,
    );
  }

  @override
  Future<void> clear{Entities}ByProfile({required String profileId}) async {
    await clearKey('$profileId.{entities}');
  }
}
```

---

### 5. Remote Datasource Interface (Data)

```dart
// lib/features/{feature}/data/datasources/{feature}_remote_datasource.dart
import 'package:{app}/features/{feature}/domain/entities/{entity}.dart';

abstract class {Feature}RemoteDatasource {
  Future<List<{Entity}>> getAll{Entities}ByProfile({required String profileId});
  Future<{Entity}> push{Entity}({required {Entity} {entity}});
  Future<{Entity}> pop{Entity}({required {Entity} {entity}});
}
```

---

### 6. Remote Datasource Implementation (Infra)

```dart
// lib/features/{feature}/infra/{feature}_remote_datasource_impl.dart
import 'package:dio/dio.dart';
import 'package:{app}/features/{feature}/data/datasources/{feature}_remote_datasource.dart';
import 'package:{app}/features/{feature}/domain/entities/{entity}.dart';
import 'package:{app}/features/{feature}/infra/models/{entity}_model.dart';

class {Feature}RemoteDatasourceImpl implements {Feature}RemoteDatasource {
  final Dio dio;

  {Feature}RemoteDatasourceImpl(this.dio);

  @override
  Future<List<{Entity}>> getAll{Entities}ByProfile({
    required String profileId,
  }) async {
    final response = await dio.get(
      '/{entities}',
      queryParameters: {'profile_id': profileId},
    );
    return {Entity}Model.fromJsonList(response.data);
  }

  @override
  Future<{Entity}> push{Entity}({required {Entity} {entity}}) async {
    final response = await dio.post(
      '/{entities}',
      data: {Entity}Model.toMap({entity}),
    );
    return {Entity}Model.fromJson(response.data);
  }

  @override
  Future<{Entity}> pop{Entity}({required {Entity} {entity}}) async {
    final response = await dio.delete('/{entities}/${entity.id}');
    return {Entity}Model.fromJson(response.data);
  }
}
```

---

### 7. Repository Interface (Domain)

```dart
// lib/features/{feature}/domain/repositories/{feature}_repository.dart
import 'package:dartz/dartz.dart';
import 'package:{app}/core/errors/failures/failures.dart';
import 'package:{app}/features/{feature}/domain/entities/{entity}.dart';

abstract class {Feature}Repository {
  Future<Either<AppFailure, List<{Entity}>>> getAll{Entities}ByProfile({
    required String profileId,
  });
  Future<Either<AppFailure, {Entity}>> push{Entity}({
    required {Entity} {entity},
  });
  Future<Either<AppFailure, {Entity}>> pop{Entity}({
    required {Entity} {entity},
  });
}
```

**Sempre use `Either<AppFailure, T>` para tratamento de erros funcional.**

---

### 8. Repository Implementation (Data)

```dart
// lib/features/{feature}/data/repositories/{feature}_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:{app}/core/errors/failures/failures.dart';
import 'package:{app}/core/logger/handlers/repository_log_handler.dart';
import 'package:{app}/core/logger/log_tags.dart';
import 'package:{app}/features/{feature}/data/datasources/{feature}_local_storage.dart';
import 'package:{app}/features/{feature}/data/datasources/{feature}_remote_datasource.dart';
import 'package:{app}/features/{feature}/domain/entities/{entity}.dart';
import 'package:{app}/features/{feature}/domain/repositories/{feature}_repository.dart';
import 'package:{app}/features/{feature}/domain/tags/{feature}_logtags.dart';
import 'package:logger/logger.dart';

class {Feature}RepositoryImpl
    with RepositoryLogHandler
    implements {Feature}Repository {
  @override
  final Logger logger;
  final {Feature}RemoteDatasource remoteDatasource;
  final {Feature}LocalStorage localStorage;

  {Feature}RepositoryImpl({
    required this.remoteDatasource,
    required this.logger,
    required this.localStorage,
  });

  @override
  LogFeature get feature => LogFeature.{feature};  // Registrar em log_tags.dart

  @override
  Future<Either<AppFailure, List<{Entity}>>> getAll{Entities}ByProfile({
    required String profileId,
  }) async {
    try {
      // 1. Tentar cache primeiro
      final cached = await localStorage.load{Entities}ByProfile(
        profileId: profileId,
      );
      if (cached.isNotEmpty) return Right(cached);

      // 2. Buscar remoto se cache vazio
      final result = await remoteDatasource.getAll{Entities}ByProfile(
        profileId: profileId,
      );
      
      // 3. Salvar no cache
      await localStorage.save{Entities}ByProfile(
        {entities}: result,
        profileId: profileId,
      );
      return Right(result);
    } catch (e, stack) {
      return Left(
        handleRepositoryError(
          exception: e,
          stackTrace: stack,
          action: {Feature}Action.getAll{Entities}ByProfile,
        ),
      );
    }
  }

  @override
  Future<Either<AppFailure, {Entity}>> push{Entity}({
    required {Entity} {entity},
  }) async {
    try {
      // 1. Persistir remoto primeiro
      final result = await remoteDatasource.push{Entity}({entity}: {entity});
      
      // 2. Atualizar cache
      await localStorage.push{Entity}({entity}: result);
      return Right(result);
    } catch (e, stack) {
      return Left(
        handleRepositoryError(
          exception: e,
          stackTrace: stack,
          action: {Feature}Action.push{Entity},
        ),
      );
    }
  }

  @override
  Future<Either<AppFailure, {Entity}>> pop{Entity}({
    required {Entity} {entity},
  }) async {
    try {
      // 1. Remover remoto primeiro
      final result = await remoteDatasource.pop{Entity}({entity}: {entity});
      
      // 2. Atualizar cache
      await localStorage.pop{Entity}({entity}: {entity});
      return Right(result);
    } catch (e, stack) {
      return Left(
        handleRepositoryError(
          exception: e,
          stackTrace: stack,
          action: {Feature}Action.pop{Entity},
        ),
      );
    }
  }
}
```

---

### 9. Log Tags (Domain)

```dart
// lib/features/{feature}/domain/tags/{feature}_logtags.dart
import 'package:{app}/core/logger/log_tags.dart';

enum {Feature}Action implements LogTag {
  getAll{Entities}ByProfile('[GET_ALL_{ENTITIES}_BY_PROFILE]'),
  push{Entity}('[PUSH_{ENTITY}]'),
  pop{Entity}('[POP_{ENTITY}]'),
  load{Entities}('[LOAD_{ENTITIES}]'),
  restore('[RESTORE]');

  @override
  final String tag;
  const {Feature}Action(this.tag);
}
```

**Adicione a feature em `core/logger/log_tags.dart`:**
```dart
enum LogFeature implements LogTag {
  // ... outras features
  {feature}('[{FEATURE}]'),  // Adicionar aqui
}
```

---

### 10. Usecase (Domain)

```dart
// lib/features/{feature}/domain/usecases/get_all_{entities}_by_profile.dart
import 'package:dartz/dartz.dart';
import 'package:{app}/core/errors/failures/failures.dart';
import 'package:{app}/core/usecases/usecase.dart';
import 'package:{app}/features/{feature}/domain/entities/{entity}.dart';
import 'package:{app}/features/{feature}/domain/repositories/{feature}_repository.dart';

class GetAll{Entities}ByProfile
    implements Usecase<List<{Entity}>, GetAll{Entities}ByProfileParams> {
  final {Feature}Repository repository;
  GetAll{Entities}ByProfile(this.repository);

  @override
  Future<Either<AppFailure, List<{Entity}>>> call(
    GetAll{Entities}ByProfileParams params,
  ) {
    return repository.getAll{Entities}ByProfile(profileId: params.profileId);
  }
}

class GetAll{Entities}ByProfileParams {
  final String profileId;
  GetAll{Entities}ByProfileParams({required this.profileId});
}
```

**Regras:**
- Implementa `Usecase<SuccessType, Params>`
- Recebe `Params` via classe dedicada
- Delega 100% para o repository

---

### 11. Dependency Injection Providers

```dart
// lib/features/{feature}/presentation/providers/{feature}_providers.dart
import 'package:{app}/core/cache/cache_database_provider.dart';
import 'package:{app}/core/logger/logger.dart';
import 'package:{app}/core/network/dio_provider.dart';
import 'package:{app}/features/{feature}/data/datasources/{feature}_local_storage.dart';
import 'package:{app}/features/{feature}/data/datasources/{feature}_remote_datasource.dart';
import 'package:{app}/features/{feature}/data/repositories/{feature}_repository_impl.dart';
import 'package:{app}/features/{feature}/domain/repositories/{feature}_repository.dart';
import 'package:{app}/features/{feature}/domain/usecases/get_all_{entities}_by_profile.dart';
import 'package:{app}/features/{feature}/domain/usecases/pop_{entity}.dart';
import 'package:{app}/features/{feature}/domain/usecases/push_{entity}.dart';
import 'package:{app}/features/{feature}/infra/{feature}_local_storage_impl.dart';
import 'package:{app}/features/{feature}/infra/{feature}_remote_datasource_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '{feature}_providers.g.dart';

// ============ DATA ============
@riverpod
{Feature}RemoteDatasource {feature}RemoteDatasource(Ref ref) {
  final dio = ref.watch(dioProvider);
  return {Feature}RemoteDatasourceImpl(dio);
}

@riverpod
{Feature}LocalStorage {feature}LocalStorage(Ref ref) {
  final cacheService = ref.watch(cacheDatabaseServiceProvider);
  return {Feature}LocalStorageImpl(cacheService);
}

@riverpod
{Feature}Repository {feature}Repository(Ref ref) {
  final logger = ref.watch(loggerProvider);
  final remote = ref.watch({feature}RemoteDatasourceProvider);
  final local = ref.watch({feature}LocalStorageProvider);
  return {Feature}RepositoryImpl(
    remoteDatasource: remote,
    localStorage: local,
    logger: logger,
  );
}

// ============ USECASES ============
@riverpod
GetAll{Entities}ByProfile getAll{Entities}ByProfile(Ref ref) {
  final repository = ref.watch({feature}RepositoryProvider);
  return GetAll{Entities}ByProfile(repository);
}

@riverpod
Push{Entity} push{Entity}(Ref ref) {
  final repository = ref.watch({feature}RepositoryProvider);
  return Push{Entity}(repository);
}

@riverpod
Pop{Entity} pop{Entity}(Ref ref) {
  final repository = ref.watch({feature}RepositoryProvider);
  return Pop{Entity}(repository);
}
```

---

### 12. State Provider (Controller)

```dart
// lib/features/{feature}/presentation/providers/{feature}_state_provider.dart
import 'package:{app}/core/errors/failures/failures.dart';
import 'package:{app}/core/logger/handlers/controller_log_handler.dart';
import 'package:{app}/core/logger/log_tags.dart';
import 'package:{app}/core/logger/logger.dart';
import 'package:{app}/features/{feature}/domain/entities/{entity}.dart';
import 'package:{app}/features/{feature}/domain/tags/{feature}_logtags.dart'
    as {feature}_tags;
import 'package:{app}/features/{feature}/domain/usecases/get_all_{entities}_by_profile.dart';
import 'package:{app}/features/{feature}/domain/usecases/pop_{entity}.dart';
import 'package:{app}/features/{feature}/domain/usecases/push_{entity}.dart';
import 'package:{app}/features/{feature}/presentation/providers/{feature}_providers.dart';
import 'package:{app}/features/profiles/presentation/providers/profile_state_provider.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '{feature}_state_provider.g.dart';

@riverpod
class {Feature}State extends _$ {Feature}State with ControllerLogHandler {
  @override
  late final Logger logger = ref.read(loggerProvider);

  @override
  LogFeature get feature => LogFeature.{feature};

  @override
  {Feature}StateData build() {
    // Escutar mudanças de perfil (pattern comum)
    ref.listen(profileStateProvider, (previous, next) {
      if (next.activeProfile != null &&
          previous?.activeProfile?.id != next.activeProfile?.id) {
        _onActiveProfileChanged(next.activeProfile!.id);
      }
    });

    return const {Feature}StateData();
  }

  Future<void> _onActiveProfileChanged(String profileId) async {
    await _load{Entities}ForProfile(profileId);
  }

  Future<void> _load{Entities}ForProfile(String profileId) async {
    try {
      final result = await ref
          .read(getAll{Entities}ByProfileProvider)
          .call(GetAll{Entities}ByProfileParams(profileId: profileId));

      if (!ref.mounted) return;

      result.fold(
        (failure) {
          state = {Feature}StateData(failure: failure);
          logControllerError(
            action: {feature}_tags.{Feature}Action.load{Entities},
            failure: failure,
          );
        },
        ({entities}) {
          state = {Feature}StateData({entities}: {entities});
          logControllerSuccess(action: {feature}_tags.{Feature}Action.load{Entities});
        },
      );
    } catch (e, s) {
      logControllerError(
        action: {feature}_tags.{Feature}Action.load{Entities},
        failure: e,
        stackTrace: s,
      );
    }
  }

  Future<void> restore() async {
    try {
      final profileState = ref.read(profileStateProvider);
      if (profileState.activeProfile == null) return;

      await _load{Entities}ForProfile(profileState.activeProfile!.id);
      if (!state.hasError) {
        logControllerSuccess(action: {feature}_tags.{Feature}Action.restore);
      }
    } catch (e, s) {
      logControllerError(
        action: {feature}_tags.{Feature}Action.restore,
        failure: e,
        stackTrace: s,
      );
    }
  }

  Future<void> push{Entity}({Entity} {entity}) async {
    try {
      final profileState = ref.read(profileStateProvider);
      if (profileState.activeProfile == null) return;

      final result = await ref
          .read(push{Entity}Provider)
          .call(Push{Entity}Params({entity}: {entity}));

      if (!ref.mounted) return;

      result.fold(
        (failure) {
          state = {Feature}StateData(
            {entities}: state.{entities},
            failure: failure,
          );
          logControllerError(
            action: {feature}_tags.{Feature}Action.push{Entity},
            failure: failure,
          );
        },
        ({entity}) {
          final updated = [...state.{entities}, {entity}];
          state = {Feature}StateData({entities}: updated);
          logControllerSuccess(action: {feature}_tags.{Feature}Action.push{Entity});
        },
      );
    } catch (e, s) {
      final failure = const InternalFailure('Erro ao adicionar {entity}');
      state = {Feature}StateData({entities}: state.{entities}, failure: failure);
      logControllerError(
        action: {feature}_tags.{Feature}Action.push{Entity},
        failure: e,
        stackTrace: s,
      );
    }
  }

  Future<void> pop{Entity}({Entity} {entity}) async {
    try {
      final profileState = ref.read(profileStateProvider);
      if (profileState.activeProfile == null) return;

      final result = await ref
          .read(pop{Entity}Provider)
          .call(Pop{Entity}Params({entity}: {entity}));

      if (!ref.mounted) return;

      result.fold(
        (failure) {
          state = {Feature}StateData(
            {entities}: state.{entities},
            failure: failure,
          );
          logControllerError(
            action: {feature}_tags.{Feature}Action.pop{Entity},
            failure: failure,
          );
        },
        ({entity}) {
          final updated = state.{entities}
              .where((e) => e.id != {entity}.id)
              .toList();
          state = {Feature}StateData({entities}: updated);
          logControllerSuccess(action: {feature}_tags.{Feature}Action.pop{Entity});
        },
      );
    } catch (e, s) {
      final failure = const InternalFailure('Erro ao remover {entity}');
      state = {Feature}StateData({entities}: state.{entities}, failure: failure);
      logControllerError(
        action: {feature}_tags.{Feature}Action.pop{Entity},
        failure: e,
        stackTrace: s,
      );
    }
  }
}

// ============ STATE DATA ============
class {Feature}StateData {
  final List<{Entity}> {entities};
  final AppFailure? failure;

  const {Feature}StateData({this.{entities} = const [], this.failure});

  bool get hasError => failure != null;

  {Feature}StateData copyWith({
    List<{Entity}>? {entities},
    AppFailure? failure,
  }) {
    return {Feature}StateData(
      {entities}: {entities} ?? this.{entities},
      failure: failure ?? this.failure,
    );
  }
}
```

---

## 🔄 Padrão de Caching

### Estratégia: **Cache-First com Fallback Remoto**

```
Read Operation:
  1. Ler do cache local
  2. Se vazio → buscar remoto
  3. Salvar remoto no cache
  4. Retornar dados

Write Operation:
  1. Persistir remoto primeiro
  2. Se sucesso → atualizar cache
  3. Retornar resultado

Delete Operation:
  1. Remover remoto primeiro
  2. Se sucesso → remover do cache
  3. Retornar resultado
```

### BaseCacheStorage (Core)

```dart
// Extenda esta classe para implementações de cache
class {Feature}LocalStorageImpl extends BaseCacheStorage
    implements {Feature}LocalStorage {
  
  @override
  String get storeName => '{entities}';  // Identificador único
  
  // Métodos disponíveis:
  // - saveObject<T>() / getObject<T>()
  // - saveList<T>() / getList<T>()
  // - clearKey() / clear()
}
```

---

## ✅ Checklist de Implementação

### Setup Inicial
- [ ] Criar estrutura de diretórios
- [ ] Adicionar feature em `LogFeature` (core/logger/log_tags.dart)
- [ ] Criar entity em `domain/entities/`
- [ ] Criar model com Freezed em `infra/models/`
- [ ] Rodar `dart run build_runner build --delete-conflicting-outputs`

### Camada de Dados
- [ ] Criar interfaces de datasources em `data/datasources/`
- [ ] Implementar local storage em `infra/` (extends BaseCacheStorage)
- [ ] Implementar remote datasource em `infra/` (com Dio)
- [ ] Criar log tags em `domain/tags/`

### Camada de Domínio
- [ ] Criar interface de repository em `domain/repositories/`
- [ ] Implementar repository em `data/repositories/` (com caching)
- [ ] Criar usecases em `domain/usecases/` (um por operação)

### Camada de Apresentação
- [ ] Criar DI providers em `presentation/providers/`
- [ ] Criar state provider em `presentation/providers/`
- [ ] Rodar `dart run build_runner build --delete-conflicting-outputs`

---

## 🧪 Testes Sugeridos

```dart
// Testar:
1. Repository retorna cached data quando disponível
2. Repository busca remoto quando cache vazio
3. Repository salva no cache após buscar remoto
4. Repository atualiza cache após write operations
5. Repository retorna Left(failure) em erros
6. State provider atualiza UI corretamente
7. State provider lida com erros gracefulmente
```

---

## 📚 Dependências Principais

```yaml
dependencies:
  dartz: ^0.10.1           # Either<Failure, Success>
  dio: ^5.x.x              # HTTP client
  freezed_annotation: ^2.x # Immutable models
  json_annotation: ^4.x    # JSON serialization
  logger: ^2.x             # Logging
  riverpod_annotation: ^2.x # State management

dev_dependencies:
  build_runner: ^2.x
  freezed: ^2.x
  json_serializable: ^6.x
  riverpod_generator: ^2.x
```

---

## 🎨 Convenções de Nomenclatura

| Elemento | Convenção | Exemplo |
|----------|-----------|---------|
| Feature | camelCase | `favorites`, `userProfile` |
| Entity | PascalCase singular | `Favorite`, `UserProfile` |
| Model | PascalCase + Model | `FavoriteModel` |
| Repository | PascalCase + Repository | `FavoritesRepository` |
| Datasource | PascalCase + Datasource | `FavoritesRemoteDatasource` |
| Usecase | PascalCase (verbo + objeto) | `GetAllFavoritesByProfile` |
| Provider | camelCase + Provider | `favoritesRepositoryProvider` |
| State | PascalCase + State | `FavoritesState` |
| StateData | PascalCase + StateData | `FavoritesStateData` |
| LogTag | SCREAMING_SNAKE_CASE | `[GET_ALL_FAVORITES]` |

---

> **Referência completa**: `lib/features/favorites/` - Esta feature implementa 100% destes padrões.
