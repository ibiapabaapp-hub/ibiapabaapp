// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EventsViewModel)
final eventsViewModelProvider = EventsViewModelProvider._();

final class EventsViewModelProvider
    extends $AsyncNotifierProvider<EventsViewModel, List<Event>> {
  EventsViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eventsViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eventsViewModelHash();

  @$internal
  @override
  EventsViewModel create() => EventsViewModel();
}

String _$eventsViewModelHash() => r'fd083e21455640127e7e07ecb7f0861792597a31';

abstract class _$EventsViewModel extends $AsyncNotifier<List<Event>> {
  FutureOr<List<Event>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Event>>, List<Event>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Event>>, List<Event>>,
              AsyncValue<List<Event>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
