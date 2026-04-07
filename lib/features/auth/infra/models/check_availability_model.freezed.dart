// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'check_availability_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CheckAvailabilityModel {

@JsonKey(fromJson: _availabilityFieldFromApi, toJson: _availabilityFieldToApi) AvailabilityField get field; String get value; bool get available;
/// Create a copy of CheckAvailabilityModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckAvailabilityModelCopyWith<CheckAvailabilityModel> get copyWith => _$CheckAvailabilityModelCopyWithImpl<CheckAvailabilityModel>(this as CheckAvailabilityModel, _$identity);

  /// Serializes this CheckAvailabilityModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckAvailabilityModel&&(identical(other.field, field) || other.field == field)&&(identical(other.value, value) || other.value == value)&&(identical(other.available, available) || other.available == available));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,field,value,available);

@override
String toString() {
  return 'CheckAvailabilityModel(field: $field, value: $value, available: $available)';
}


}

/// @nodoc
abstract mixin class $CheckAvailabilityModelCopyWith<$Res>  {
  factory $CheckAvailabilityModelCopyWith(CheckAvailabilityModel value, $Res Function(CheckAvailabilityModel) _then) = _$CheckAvailabilityModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(fromJson: _availabilityFieldFromApi, toJson: _availabilityFieldToApi) AvailabilityField field, String value, bool available
});




}
/// @nodoc
class _$CheckAvailabilityModelCopyWithImpl<$Res>
    implements $CheckAvailabilityModelCopyWith<$Res> {
  _$CheckAvailabilityModelCopyWithImpl(this._self, this._then);

  final CheckAvailabilityModel _self;
  final $Res Function(CheckAvailabilityModel) _then;

/// Create a copy of CheckAvailabilityModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? field = null,Object? value = null,Object? available = null,}) {
  return _then(_self.copyWith(
field: null == field ? _self.field : field // ignore: cast_nullable_to_non_nullable
as AvailabilityField,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CheckAvailabilityModel].
extension CheckAvailabilityModelPatterns on CheckAvailabilityModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CheckAvailabilityModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CheckAvailabilityModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CheckAvailabilityModel value)  $default,){
final _that = this;
switch (_that) {
case _CheckAvailabilityModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CheckAvailabilityModel value)?  $default,){
final _that = this;
switch (_that) {
case _CheckAvailabilityModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _availabilityFieldFromApi, toJson: _availabilityFieldToApi)  AvailabilityField field,  String value,  bool available)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CheckAvailabilityModel() when $default != null:
return $default(_that.field,_that.value,_that.available);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _availabilityFieldFromApi, toJson: _availabilityFieldToApi)  AvailabilityField field,  String value,  bool available)  $default,) {final _that = this;
switch (_that) {
case _CheckAvailabilityModel():
return $default(_that.field,_that.value,_that.available);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(fromJson: _availabilityFieldFromApi, toJson: _availabilityFieldToApi)  AvailabilityField field,  String value,  bool available)?  $default,) {final _that = this;
switch (_that) {
case _CheckAvailabilityModel() when $default != null:
return $default(_that.field,_that.value,_that.available);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CheckAvailabilityModel implements CheckAvailabilityModel {
  const _CheckAvailabilityModel({@JsonKey(fromJson: _availabilityFieldFromApi, toJson: _availabilityFieldToApi) required this.field, required this.value, required this.available});
  factory _CheckAvailabilityModel.fromJson(Map<String, dynamic> json) => _$CheckAvailabilityModelFromJson(json);

@override@JsonKey(fromJson: _availabilityFieldFromApi, toJson: _availabilityFieldToApi) final  AvailabilityField field;
@override final  String value;
@override final  bool available;

/// Create a copy of CheckAvailabilityModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckAvailabilityModelCopyWith<_CheckAvailabilityModel> get copyWith => __$CheckAvailabilityModelCopyWithImpl<_CheckAvailabilityModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CheckAvailabilityModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckAvailabilityModel&&(identical(other.field, field) || other.field == field)&&(identical(other.value, value) || other.value == value)&&(identical(other.available, available) || other.available == available));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,field,value,available);

@override
String toString() {
  return 'CheckAvailabilityModel(field: $field, value: $value, available: $available)';
}


}

/// @nodoc
abstract mixin class _$CheckAvailabilityModelCopyWith<$Res> implements $CheckAvailabilityModelCopyWith<$Res> {
  factory _$CheckAvailabilityModelCopyWith(_CheckAvailabilityModel value, $Res Function(_CheckAvailabilityModel) _then) = __$CheckAvailabilityModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(fromJson: _availabilityFieldFromApi, toJson: _availabilityFieldToApi) AvailabilityField field, String value, bool available
});




}
/// @nodoc
class __$CheckAvailabilityModelCopyWithImpl<$Res>
    implements _$CheckAvailabilityModelCopyWith<$Res> {
  __$CheckAvailabilityModelCopyWithImpl(this._self, this._then);

  final _CheckAvailabilityModel _self;
  final $Res Function(_CheckAvailabilityModel) _then;

/// Create a copy of CheckAvailabilityModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? field = null,Object? value = null,Object? available = null,}) {
  return _then(_CheckAvailabilityModel(
field: null == field ? _self.field : field // ignore: cast_nullable_to_non_nullable
as AvailabilityField,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
