// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_detail_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EventDetail)
final eventDetailProvider = EventDetailFamily._();

final class EventDetailProvider
    extends $AsyncNotifierProvider<EventDetail, EventDetailData?> {
  EventDetailProvider._({
    required EventDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'eventDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$eventDetailHash();

  @override
  String toString() {
    return r'eventDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  EventDetail create() => EventDetail();

  @override
  bool operator ==(Object other) {
    return other is EventDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$eventDetailHash() => r'337be3f091e70915be822b2b277b51ebde519abc';

final class EventDetailFamily extends $Family
    with
        $ClassFamilyOverride<
          EventDetail,
          AsyncValue<EventDetailData?>,
          EventDetailData?,
          FutureOr<EventDetailData?>,
          String
        > {
  EventDetailFamily._()
    : super(
        retry: null,
        name: r'eventDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  EventDetailProvider call(String id) =>
      EventDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'eventDetailProvider';
}

abstract class _$EventDetail extends $AsyncNotifier<EventDetailData?> {
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
