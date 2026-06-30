// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_result_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SearchResultModel {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchResultModel);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SearchResultModel()';
}


}

/// @nodoc
class $SearchResultModelCopyWith<$Res>  {
$SearchResultModelCopyWith(SearchResultModel _, $Res Function(SearchResultModel) __);
}


/// Adds pattern-matching-related methods to [SearchResultModel].
extension SearchResultModelPatterns on SearchResultModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _CitySearchResultModel value)?  city,TResult Function( _BusinessSearchResultModel value)?  business,TResult Function( _EventSearchResultModel value)?  event,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CitySearchResultModel() when city != null:
return city(_that);case _BusinessSearchResultModel() when business != null:
return business(_that);case _EventSearchResultModel() when event != null:
return event(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _CitySearchResultModel value)  city,required TResult Function( _BusinessSearchResultModel value)  business,required TResult Function( _EventSearchResultModel value)  event,}){
final _that = this;
switch (_that) {
case _CitySearchResultModel():
return city(_that);case _BusinessSearchResultModel():
return business(_that);case _EventSearchResultModel():
return event(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _CitySearchResultModel value)?  city,TResult? Function( _BusinessSearchResultModel value)?  business,TResult? Function( _EventSearchResultModel value)?  event,}){
final _that = this;
switch (_that) {
case _CitySearchResultModel() when city != null:
return city(_that);case _BusinessSearchResultModel() when business != null:
return business(_that);case _EventSearchResultModel() when event != null:
return event(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( CityModel city)?  city,TResult Function( BusinessModel business)?  business,TResult Function( EventModel event)?  event,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CitySearchResultModel() when city != null:
return city(_that.city);case _BusinessSearchResultModel() when business != null:
return business(_that.business);case _EventSearchResultModel() when event != null:
return event(_that.event);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( CityModel city)  city,required TResult Function( BusinessModel business)  business,required TResult Function( EventModel event)  event,}) {final _that = this;
switch (_that) {
case _CitySearchResultModel():
return city(_that.city);case _BusinessSearchResultModel():
return business(_that.business);case _EventSearchResultModel():
return event(_that.event);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( CityModel city)?  city,TResult? Function( BusinessModel business)?  business,TResult? Function( EventModel event)?  event,}) {final _that = this;
switch (_that) {
case _CitySearchResultModel() when city != null:
return city(_that.city);case _BusinessSearchResultModel() when business != null:
return business(_that.business);case _EventSearchResultModel() when event != null:
return event(_that.event);case _:
  return null;

}
}

}

/// @nodoc


class _CitySearchResultModel extends SearchResultModel {
  const _CitySearchResultModel(this.city): super._();
  

 final  CityModel city;

/// Create a copy of SearchResultModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CitySearchResultModelCopyWith<_CitySearchResultModel> get copyWith => __$CitySearchResultModelCopyWithImpl<_CitySearchResultModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CitySearchResultModel&&(identical(other.city, city) || other.city == city));
}


@override
int get hashCode => Object.hash(runtimeType,city);

@override
String toString() {
  return 'SearchResultModel.city(city: $city)';
}


}

/// @nodoc
abstract mixin class _$CitySearchResultModelCopyWith<$Res> implements $SearchResultModelCopyWith<$Res> {
  factory _$CitySearchResultModelCopyWith(_CitySearchResultModel value, $Res Function(_CitySearchResultModel) _then) = __$CitySearchResultModelCopyWithImpl;
@useResult
$Res call({
 CityModel city
});




}
/// @nodoc
class __$CitySearchResultModelCopyWithImpl<$Res>
    implements _$CitySearchResultModelCopyWith<$Res> {
  __$CitySearchResultModelCopyWithImpl(this._self, this._then);

  final _CitySearchResultModel _self;
  final $Res Function(_CitySearchResultModel) _then;

/// Create a copy of SearchResultModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? city = null,}) {
  return _then(_CitySearchResultModel(
null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as CityModel,
  ));
}


}

/// @nodoc


class _BusinessSearchResultModel extends SearchResultModel {
  const _BusinessSearchResultModel(this.business): super._();
  

 final  BusinessModel business;

/// Create a copy of SearchResultModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BusinessSearchResultModelCopyWith<_BusinessSearchResultModel> get copyWith => __$BusinessSearchResultModelCopyWithImpl<_BusinessSearchResultModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BusinessSearchResultModel&&(identical(other.business, business) || other.business == business));
}


@override
int get hashCode => Object.hash(runtimeType,business);

@override
String toString() {
  return 'SearchResultModel.business(business: $business)';
}


}

/// @nodoc
abstract mixin class _$BusinessSearchResultModelCopyWith<$Res> implements $SearchResultModelCopyWith<$Res> {
  factory _$BusinessSearchResultModelCopyWith(_BusinessSearchResultModel value, $Res Function(_BusinessSearchResultModel) _then) = __$BusinessSearchResultModelCopyWithImpl;
@useResult
$Res call({
 BusinessModel business
});




}
/// @nodoc
class __$BusinessSearchResultModelCopyWithImpl<$Res>
    implements _$BusinessSearchResultModelCopyWith<$Res> {
  __$BusinessSearchResultModelCopyWithImpl(this._self, this._then);

  final _BusinessSearchResultModel _self;
  final $Res Function(_BusinessSearchResultModel) _then;

/// Create a copy of SearchResultModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? business = null,}) {
  return _then(_BusinessSearchResultModel(
null == business ? _self.business : business // ignore: cast_nullable_to_non_nullable
as BusinessModel,
  ));
}


}

/// @nodoc


class _EventSearchResultModel extends SearchResultModel {
  const _EventSearchResultModel(this.event): super._();
  

 final  EventModel event;

/// Create a copy of SearchResultModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventSearchResultModelCopyWith<_EventSearchResultModel> get copyWith => __$EventSearchResultModelCopyWithImpl<_EventSearchResultModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventSearchResultModel&&(identical(other.event, event) || other.event == event));
}


@override
int get hashCode => Object.hash(runtimeType,event);

@override
String toString() {
  return 'SearchResultModel.event(event: $event)';
}


}

/// @nodoc
abstract mixin class _$EventSearchResultModelCopyWith<$Res> implements $SearchResultModelCopyWith<$Res> {
  factory _$EventSearchResultModelCopyWith(_EventSearchResultModel value, $Res Function(_EventSearchResultModel) _then) = __$EventSearchResultModelCopyWithImpl;
@useResult
$Res call({
 EventModel event
});




}
/// @nodoc
class __$EventSearchResultModelCopyWithImpl<$Res>
    implements _$EventSearchResultModelCopyWith<$Res> {
  __$EventSearchResultModelCopyWithImpl(this._self, this._then);

  final _EventSearchResultModel _self;
  final $Res Function(_EventSearchResultModel) _then;

/// Create a copy of SearchResultModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? event = null,}) {
  return _then(_EventSearchResultModel(
null == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as EventModel,
  ));
}


}

// dart format on
