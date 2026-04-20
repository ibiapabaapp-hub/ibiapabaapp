// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(eventsRemoteDatasource)
final eventsRemoteDatasourceProvider = EventsRemoteDatasourceProvider._();

final class EventsRemoteDatasourceProvider
    extends
        $FunctionalProvider<
          EventsRemoteDatasource,
          EventsRemoteDatasource,
          EventsRemoteDatasource
        >
    with $Provider<EventsRemoteDatasource> {
  EventsRemoteDatasourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eventsRemoteDatasourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eventsRemoteDatasourceHash();

  @$internal
  @override
  $ProviderElement<EventsRemoteDatasource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  EventsRemoteDatasource create(Ref ref) {
    return eventsRemoteDatasource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EventsRemoteDatasource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EventsRemoteDatasource>(value),
    );
  }
}

String _$eventsRemoteDatasourceHash() =>
    r'e165d1c667f332f79f7d5145d99836a9427d9fb3';

@ProviderFor(eventsRepository)
final eventsRepositoryProvider = EventsRepositoryProvider._();

final class EventsRepositoryProvider
    extends
        $FunctionalProvider<
          EventsRepository,
          EventsRepository,
          EventsRepository
        >
    with $Provider<EventsRepository> {
  EventsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eventsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eventsRepositoryHash();

  @$internal
  @override
  $ProviderElement<EventsRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  EventsRepository create(Ref ref) {
    return eventsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EventsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EventsRepository>(value),
    );
  }
}

String _$eventsRepositoryHash() => r'8cd9c382b397525fcb22c471d6635243c54e5c95';

@ProviderFor(getAllEvents)
final getAllEventsProvider = GetAllEventsProvider._();

final class GetAllEventsProvider
    extends $FunctionalProvider<GetAllEvents, GetAllEvents, GetAllEvents>
    with $Provider<GetAllEvents> {
  GetAllEventsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getAllEventsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getAllEventsHash();

  @$internal
  @override
  $ProviderElement<GetAllEvents> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetAllEvents create(Ref ref) {
    return getAllEvents(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetAllEvents value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetAllEvents>(value),
    );
  }
}

String _$getAllEventsHash() => r'8a050b82c1e27bc7240e29c722a4de9ed52e6d49';

@ProviderFor(getEventById)
final getEventByIdProvider = GetEventByIdProvider._();

final class GetEventByIdProvider
    extends $FunctionalProvider<GetEventById, GetEventById, GetEventById>
    with $Provider<GetEventById> {
  GetEventByIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getEventByIdProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getEventByIdHash();

  @$internal
  @override
  $ProviderElement<GetEventById> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetEventById create(Ref ref) {
    return getEventById(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetEventById value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetEventById>(value),
    );
  }
}

String _$getEventByIdHash() => r'72d0e5ac8b9e8dd1156c7751f2fb39feb3770678';
