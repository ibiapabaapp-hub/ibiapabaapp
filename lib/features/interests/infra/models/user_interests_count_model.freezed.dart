// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_interests_count_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserInterestsCountModel {

 int get count;
/// Create a copy of UserInterestsCountModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserInterestsCountModelCopyWith<UserInterestsCountModel> get copyWith => _$UserInterestsCountModelCopyWithImpl<UserInterestsCountModel>(this as UserInterestsCountModel, _$identity);

  /// Serializes this UserInterestsCountModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserInterestsCountModel&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,count);

@override
String toString() {
  return 'UserInterestsCountModel(count: $count)';
}


}

/// @nodoc
abstract mixin class $UserInterestsCountModelCopyWith<$Res>  {
  factory $UserInterestsCountModelCopyWith(UserInterestsCountModel value, $Res Function(UserInterestsCountModel) _then) = _$UserInterestsCountModelCopyWithImpl;
@useResult
$Res call({
 int count
});




}
/// @nodoc
class _$UserInterestsCountModelCopyWithImpl<$Res>
    implements $UserInterestsCountModelCopyWith<$Res> {
  _$UserInterestsCountModelCopyWithImpl(this._self, this._then);

  final UserInterestsCountModel _self;
  final $Res Function(UserInterestsCountModel) _then;

/// Create a copy of UserInterestsCountModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? count = null,}) {
  return _then(_self.copyWith(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [UserInterestsCountModel].
extension UserInterestsCountModelPatterns on UserInterestsCountModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserInterestsCountModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserInterestsCountModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserInterestsCountModel value)  $default,){
final _that = this;
switch (_that) {
case _UserInterestsCountModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserInterestsCountModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserInterestsCountModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserInterestsCountModel() when $default != null:
return $default(_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int count)  $default,) {final _that = this;
switch (_that) {
case _UserInterestsCountModel():
return $default(_that.count);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int count)?  $default,) {final _that = this;
switch (_that) {
case _UserInterestsCountModel() when $default != null:
return $default(_that.count);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserInterestsCountModel extends UserInterestsCountModel {
  const _UserInterestsCountModel({required this.count}): super._();
  factory _UserInterestsCountModel.fromJson(Map<String, dynamic> json) => _$UserInterestsCountModelFromJson(json);

@override final  int count;

/// Create a copy of UserInterestsCountModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserInterestsCountModelCopyWith<_UserInterestsCountModel> get copyWith => __$UserInterestsCountModelCopyWithImpl<_UserInterestsCountModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserInterestsCountModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserInterestsCountModel&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,count);

@override
String toString() {
  return 'UserInterestsCountModel(count: $count)';
}


}

/// @nodoc
abstract mixin class _$UserInterestsCountModelCopyWith<$Res> implements $UserInterestsCountModelCopyWith<$Res> {
  factory _$UserInterestsCountModelCopyWith(_UserInterestsCountModel value, $Res Function(_UserInterestsCountModel) _then) = __$UserInterestsCountModelCopyWithImpl;
@override @useResult
$Res call({
 int count
});




}
/// @nodoc
class __$UserInterestsCountModelCopyWithImpl<$Res>
    implements _$UserInterestsCountModelCopyWith<$Res> {
  __$UserInterestsCountModelCopyWithImpl(this._self, this._then);

  final _UserInterestsCountModel _self;
  final $Res Function(_UserInterestsCountModel) _then;

/// Create a copy of UserInterestsCountModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? count = null,}) {
  return _then(_UserInterestsCountModel(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
