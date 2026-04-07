// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_interest_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserInterestModel {

 List<String> get companyIds; List<String> get eventIds;
/// Create a copy of UserInterestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserInterestModelCopyWith<UserInterestModel> get copyWith => _$UserInterestModelCopyWithImpl<UserInterestModel>(this as UserInterestModel, _$identity);

  /// Serializes this UserInterestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserInterestModel&&const DeepCollectionEquality().equals(other.companyIds, companyIds)&&const DeepCollectionEquality().equals(other.eventIds, eventIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(companyIds),const DeepCollectionEquality().hash(eventIds));

@override
String toString() {
  return 'UserInterestModel(companyIds: $companyIds, eventIds: $eventIds)';
}


}

/// @nodoc
abstract mixin class $UserInterestModelCopyWith<$Res>  {
  factory $UserInterestModelCopyWith(UserInterestModel value, $Res Function(UserInterestModel) _then) = _$UserInterestModelCopyWithImpl;
@useResult
$Res call({
 List<String> companyIds, List<String> eventIds
});




}
/// @nodoc
class _$UserInterestModelCopyWithImpl<$Res>
    implements $UserInterestModelCopyWith<$Res> {
  _$UserInterestModelCopyWithImpl(this._self, this._then);

  final UserInterestModel _self;
  final $Res Function(UserInterestModel) _then;

/// Create a copy of UserInterestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? companyIds = null,Object? eventIds = null,}) {
  return _then(_self.copyWith(
companyIds: null == companyIds ? _self.companyIds : companyIds // ignore: cast_nullable_to_non_nullable
as List<String>,eventIds: null == eventIds ? _self.eventIds : eventIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [UserInterestModel].
extension UserInterestModelPatterns on UserInterestModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserInterestModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserInterestModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserInterestModel value)  $default,){
final _that = this;
switch (_that) {
case _UserInterestModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserInterestModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserInterestModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> companyIds,  List<String> eventIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserInterestModel() when $default != null:
return $default(_that.companyIds,_that.eventIds);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> companyIds,  List<String> eventIds)  $default,) {final _that = this;
switch (_that) {
case _UserInterestModel():
return $default(_that.companyIds,_that.eventIds);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> companyIds,  List<String> eventIds)?  $default,) {final _that = this;
switch (_that) {
case _UserInterestModel() when $default != null:
return $default(_that.companyIds,_that.eventIds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserInterestModel extends UserInterestModel {
  const _UserInterestModel({final  List<String> companyIds = const [], final  List<String> eventIds = const []}): _companyIds = companyIds,_eventIds = eventIds,super._();
  factory _UserInterestModel.fromJson(Map<String, dynamic> json) => _$UserInterestModelFromJson(json);

 final  List<String> _companyIds;
@override@JsonKey() List<String> get companyIds {
  if (_companyIds is EqualUnmodifiableListView) return _companyIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_companyIds);
}

 final  List<String> _eventIds;
@override@JsonKey() List<String> get eventIds {
  if (_eventIds is EqualUnmodifiableListView) return _eventIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_eventIds);
}


/// Create a copy of UserInterestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserInterestModelCopyWith<_UserInterestModel> get copyWith => __$UserInterestModelCopyWithImpl<_UserInterestModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserInterestModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserInterestModel&&const DeepCollectionEquality().equals(other._companyIds, _companyIds)&&const DeepCollectionEquality().equals(other._eventIds, _eventIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_companyIds),const DeepCollectionEquality().hash(_eventIds));

@override
String toString() {
  return 'UserInterestModel(companyIds: $companyIds, eventIds: $eventIds)';
}


}

/// @nodoc
abstract mixin class _$UserInterestModelCopyWith<$Res> implements $UserInterestModelCopyWith<$Res> {
  factory _$UserInterestModelCopyWith(_UserInterestModel value, $Res Function(_UserInterestModel) _then) = __$UserInterestModelCopyWithImpl;
@override @useResult
$Res call({
 List<String> companyIds, List<String> eventIds
});




}
/// @nodoc
class __$UserInterestModelCopyWithImpl<$Res>
    implements _$UserInterestModelCopyWith<$Res> {
  __$UserInterestModelCopyWithImpl(this._self, this._then);

  final _UserInterestModel _self;
  final $Res Function(_UserInterestModel) _then;

/// Create a copy of UserInterestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? companyIds = null,Object? eventIds = null,}) {
  return _then(_UserInterestModel(
companyIds: null == companyIds ? _self._companyIds : companyIds // ignore: cast_nullable_to_non_nullable
as List<String>,eventIds: null == eventIds ? _self._eventIds : eventIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
