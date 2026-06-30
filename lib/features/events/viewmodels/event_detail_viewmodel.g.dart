// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_detail_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EventDetailViewModel)
final eventDetailViewModelProvider = EventDetailViewModelFamily._();

final class EventDetailViewModelProvider
    extends $AsyncNotifierProvider<EventDetailViewModel, EventDetailData?> {
  EventDetailViewModelProvider._({
    required EventDetailViewModelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'eventDetailViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$eventDetailViewModelHash();

  @override
  String toString() {
    return r'eventDetailViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  EventDetailViewModel create() => EventDetailViewModel();

  @override
  bool operator ==(Object other) {
    return other is EventDetailViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$eventDetailViewModelHash() =>
    r'49e40100fa7ba78f70542b822ac52aa61e86e169';

final class EventDetailViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          EventDetailViewModel,
          AsyncValue<EventDetailData?>,
          EventDetailData?,
          FutureOr<EventDetailData?>,
          String
        > {
  EventDetailViewModelFamily._()
    : super(
        retry: null,
        name: r'eventDetailViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  EventDetailViewModelProvider call(String id) =>
      EventDetailViewModelProvider._(argument: id, from: this);

  @override
  String toString() => r'eventDetailViewModelProvider';
}

abstract class _$EventDetailViewModel extends $AsyncNotifier<EventDetailData?> {
  late final _$args = ref.$arg as String;
  String get id => _$args;

  FutureOr<EventDetailData?> build(String id);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<EventDetailData?>, EventDetailData?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<EventDetailData?>, EventDetailData?>,
              AsyncValue<EventDetailData?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
