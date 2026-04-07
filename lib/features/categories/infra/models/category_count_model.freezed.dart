// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category_count_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CategoryCountModel {

@JsonKey(name: 'city') int get cities;@JsonKey(name: 'company_category') int get companies;@JsonKey(name: 'event_category') int get events; int get children;
/// Create a copy of CategoryCountModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryCountModelCopyWith<CategoryCountModel> get copyWith => _$CategoryCountModelCopyWithImpl<CategoryCountModel>(this as CategoryCountModel, _$identity);

  /// Serializes this CategoryCountModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryCountModel&&(identical(other.cities, cities) || other.cities == cities)&&(identical(other.companies, companies) || other.companies == companies)&&(identical(other.events, events) || other.events == events)&&(identical(other.children, children) || other.children == children));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cities,companies,events,children);

@override
String toString() {
  return 'CategoryCountModel(cities: $cities, companies: $companies, events: $events, children: $children)';
}


}

/// @nodoc
abstract mixin class $CategoryCountModelCopyWith<$Res>  {
  factory $CategoryCountModelCopyWith(CategoryCountModel value, $Res Function(CategoryCountModel) _then) = _$CategoryCountModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'city') int cities,@JsonKey(name: 'company_category') int companies,@JsonKey(name: 'event_category') int events, int children
});




}
/// @nodoc
class _$CategoryCountModelCopyWithImpl<$Res>
    implements $CategoryCountModelCopyWith<$Res> {
  _$CategoryCountModelCopyWithImpl(this._self, this._then);

  final CategoryCountModel _self;
  final $Res Function(CategoryCountModel) _then;

/// Create a copy of CategoryCountModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cities = null,Object? companies = null,Object? events = null,Object? children = null,}) {
  return _then(_self.copyWith(
cities: null == cities ? _self.cities : cities // ignore: cast_nullable_to_non_nullable
as int,companies: null == companies ? _self.companies : companies // ignore: cast_nullable_to_non_nullable
as int,events: null == events ? _self.events : events // ignore: cast_nullable_to_non_nullable
as int,children: null == children ? _self.children : children // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CategoryCountModel].
extension CategoryCountModelPatterns on CategoryCountModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategoryCountModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategoryCountModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategoryCountModel value)  $default,){
final _that = this;
switch (_that) {
case _CategoryCountModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategoryCountModel value)?  $default,){
final _that = this;
switch (_that) {
case _CategoryCountModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'city')  int cities, @JsonKey(name: 'company_category')  int companies, @JsonKey(name: 'event_category')  int events,  int children)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategoryCountModel() when $default != null:
return $default(_that.cities,_that.companies,_that.events,_that.children);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'city')  int cities, @JsonKey(name: 'company_category')  int companies, @JsonKey(name: 'event_category')  int events,  int children)  $default,) {final _that = this;
switch (_that) {
case _CategoryCountModel():
return $default(_that.cities,_that.companies,_that.events,_that.children);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'city')  int cities, @JsonKey(name: 'company_category')  int companies, @JsonKey(name: 'event_category')  int events,  int children)?  $default,) {final _that = this;
switch (_that) {
case _CategoryCountModel() when $default != null:
return $default(_that.cities,_that.companies,_that.events,_that.children);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CategoryCountModel implements CategoryCountModel {
  const _CategoryCountModel({@JsonKey(name: 'city') required this.cities, @JsonKey(name: 'company_category') required this.companies, @JsonKey(name: 'event_category') required this.events, required this.children});
  factory _CategoryCountModel.fromJson(Map<String, dynamic> json) => _$CategoryCountModelFromJson(json);

@override@JsonKey(name: 'city') final  int cities;
@override@JsonKey(name: 'company_category') final  int companies;
@override@JsonKey(name: 'event_category') final  int events;
@override final  int children;

/// Create a copy of CategoryCountModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoryCountModelCopyWith<_CategoryCountModel> get copyWith => __$CategoryCountModelCopyWithImpl<_CategoryCountModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CategoryCountModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoryCountModel&&(identical(other.cities, cities) || other.cities == cities)&&(identical(other.companies, companies) || other.companies == companies)&&(identical(other.events, events) || other.events == events)&&(identical(other.children, children) || other.children == children));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cities,companies,events,children);

@override
String toString() {
  return 'CategoryCountModel(cities: $cities, companies: $companies, events: $events, children: $children)';
}


}

/// @nodoc
abstract mixin class _$CategoryCountModelCopyWith<$Res> implements $CategoryCountModelCopyWith<$Res> {
  factory _$CategoryCountModelCopyWith(_CategoryCountModel value, $Res Function(_CategoryCountModel) _then) = __$CategoryCountModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'city') int cities,@JsonKey(name: 'company_category') int companies,@JsonKey(name: 'event_category') int events, int children
});




}
/// @nodoc
class __$CategoryCountModelCopyWithImpl<$Res>
    implements _$CategoryCountModelCopyWith<$Res> {
  __$CategoryCountModelCopyWithImpl(this._self, this._then);

  final _CategoryCountModel _self;
  final $Res Function(_CategoryCountModel) _then;

/// Create a copy of CategoryCountModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cities = null,Object? companies = null,Object? events = null,Object? children = null,}) {
  return _then(_CategoryCountModel(
cities: null == cities ? _self.cities : cities // ignore: cast_nullable_to_non_nullable
as int,companies: null == companies ? _self.companies : companies // ignore: cast_nullable_to_non_nullable
as int,events: null == events ? _self.events : events // ignore: cast_nullable_to_non_nullable
as int,children: null == children ? _self.children : children // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
