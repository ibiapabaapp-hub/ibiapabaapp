// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'business_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BusinessModel {

 String get id; String get slug; String? get cnpj; String get name; String? get bio; String? get avatar;@JsonKey(unknownEnumValue: ReachLevel.local, name: 'max_reach_level') ReachLevel get maxReachLevel;@JsonKey(name: 'cover_img_url') String? get coverImgUrl; List<String> get categories;@JsonKey(name: 'created_at') DateTime get createdAt;
/// Create a copy of BusinessModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BusinessModelCopyWith<BusinessModel> get copyWith => _$BusinessModelCopyWithImpl<BusinessModel>(this as BusinessModel, _$identity);

  /// Serializes this BusinessModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BusinessModel&&(identical(other.id, id) || other.id == id)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.cnpj, cnpj) || other.cnpj == cnpj)&&(identical(other.name, name) || other.name == name)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.maxReachLevel, maxReachLevel) || other.maxReachLevel == maxReachLevel)&&(identical(other.coverImgUrl, coverImgUrl) || other.coverImgUrl == coverImgUrl)&&const DeepCollectionEquality().equals(other.categories, categories)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,slug,cnpj,name,bio,avatar,maxReachLevel,coverImgUrl,const DeepCollectionEquality().hash(categories),createdAt);

@override
String toString() {
  return 'BusinessModel(id: $id, slug: $slug, cnpj: $cnpj, name: $name, bio: $bio, avatar: $avatar, maxReachLevel: $maxReachLevel, coverImgUrl: $coverImgUrl, categories: $categories, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $BusinessModelCopyWith<$Res>  {
  factory $BusinessModelCopyWith(BusinessModel value, $Res Function(BusinessModel) _then) = _$BusinessModelCopyWithImpl;
@useResult
$Res call({
 String id, String slug, String? cnpj, String name, String? bio, String? avatar,@JsonKey(unknownEnumValue: ReachLevel.local, name: 'max_reach_level') ReachLevel maxReachLevel,@JsonKey(name: 'cover_img_url') String? coverImgUrl, List<String> categories,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class _$BusinessModelCopyWithImpl<$Res>
    implements $BusinessModelCopyWith<$Res> {
  _$BusinessModelCopyWithImpl(this._self, this._then);

  final BusinessModel _self;
  final $Res Function(BusinessModel) _then;

/// Create a copy of BusinessModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? slug = null,Object? cnpj = freezed,Object? name = null,Object? bio = freezed,Object? avatar = freezed,Object? maxReachLevel = null,Object? coverImgUrl = freezed,Object? categories = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,cnpj: freezed == cnpj ? _self.cnpj : cnpj // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,maxReachLevel: null == maxReachLevel ? _self.maxReachLevel : maxReachLevel // ignore: cast_nullable_to_non_nullable
as ReachLevel,coverImgUrl: freezed == coverImgUrl ? _self.coverImgUrl : coverImgUrl // ignore: cast_nullable_to_non_nullable
as String?,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [BusinessModel].
extension BusinessModelPatterns on BusinessModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BusinessModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BusinessModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BusinessModel value)  $default,){
final _that = this;
switch (_that) {
case _BusinessModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BusinessModel value)?  $default,){
final _that = this;
switch (_that) {
case _BusinessModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String slug,  String? cnpj,  String name,  String? bio,  String? avatar, @JsonKey(unknownEnumValue: ReachLevel.local, name: 'max_reach_level')  ReachLevel maxReachLevel, @JsonKey(name: 'cover_img_url')  String? coverImgUrl,  List<String> categories, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BusinessModel() when $default != null:
return $default(_that.id,_that.slug,_that.cnpj,_that.name,_that.bio,_that.avatar,_that.maxReachLevel,_that.coverImgUrl,_that.categories,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String slug,  String? cnpj,  String name,  String? bio,  String? avatar, @JsonKey(unknownEnumValue: ReachLevel.local, name: 'max_reach_level')  ReachLevel maxReachLevel, @JsonKey(name: 'cover_img_url')  String? coverImgUrl,  List<String> categories, @JsonKey(name: 'created_at')  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _BusinessModel():
return $default(_that.id,_that.slug,_that.cnpj,_that.name,_that.bio,_that.avatar,_that.maxReachLevel,_that.coverImgUrl,_that.categories,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String slug,  String? cnpj,  String name,  String? bio,  String? avatar, @JsonKey(unknownEnumValue: ReachLevel.local, name: 'max_reach_level')  ReachLevel maxReachLevel, @JsonKey(name: 'cover_img_url')  String? coverImgUrl,  List<String> categories, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _BusinessModel() when $default != null:
return $default(_that.id,_that.slug,_that.cnpj,_that.name,_that.bio,_that.avatar,_that.maxReachLevel,_that.coverImgUrl,_that.categories,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BusinessModel extends BusinessModel {
  const _BusinessModel({this.id = '', this.slug = '', this.cnpj, this.name = '', this.bio, this.avatar, @JsonKey(unknownEnumValue: ReachLevel.local, name: 'max_reach_level') required this.maxReachLevel, @JsonKey(name: 'cover_img_url') this.coverImgUrl, final  List<String> categories = const [], @JsonKey(name: 'created_at') required this.createdAt}): _categories = categories,super._();
  factory _BusinessModel.fromJson(Map<String, dynamic> json) => _$BusinessModelFromJson(json);

@override@JsonKey() final  String id;
@override@JsonKey() final  String slug;
@override final  String? cnpj;
@override@JsonKey() final  String name;
@override final  String? bio;
@override final  String? avatar;
@override@JsonKey(unknownEnumValue: ReachLevel.local, name: 'max_reach_level') final  ReachLevel maxReachLevel;
@override@JsonKey(name: 'cover_img_url') final  String? coverImgUrl;
 final  List<String> _categories;
@override@JsonKey() List<String> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

@override@JsonKey(name: 'created_at') final  DateTime createdAt;

/// Create a copy of BusinessModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BusinessModelCopyWith<_BusinessModel> get copyWith => __$BusinessModelCopyWithImpl<_BusinessModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BusinessModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BusinessModel&&(identical(other.id, id) || other.id == id)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.cnpj, cnpj) || other.cnpj == cnpj)&&(identical(other.name, name) || other.name == name)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.maxReachLevel, maxReachLevel) || other.maxReachLevel == maxReachLevel)&&(identical(other.coverImgUrl, coverImgUrl) || other.coverImgUrl == coverImgUrl)&&const DeepCollectionEquality().equals(other._categories, _categories)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,slug,cnpj,name,bio,avatar,maxReachLevel,coverImgUrl,const DeepCollectionEquality().hash(_categories),createdAt);

@override
String toString() {
  return 'BusinessModel(id: $id, slug: $slug, cnpj: $cnpj, name: $name, bio: $bio, avatar: $avatar, maxReachLevel: $maxReachLevel, coverImgUrl: $coverImgUrl, categories: $categories, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$BusinessModelCopyWith<$Res> implements $BusinessModelCopyWith<$Res> {
  factory _$BusinessModelCopyWith(_BusinessModel value, $Res Function(_BusinessModel) _then) = __$BusinessModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String slug, String? cnpj, String name, String? bio, String? avatar,@JsonKey(unknownEnumValue: ReachLevel.local, name: 'max_reach_level') ReachLevel maxReachLevel,@JsonKey(name: 'cover_img_url') String? coverImgUrl, List<String> categories,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class __$BusinessModelCopyWithImpl<$Res>
    implements _$BusinessModelCopyWith<$Res> {
  __$BusinessModelCopyWithImpl(this._self, this._then);

  final _BusinessModel _self;
  final $Res Function(_BusinessModel) _then;

/// Create a copy of BusinessModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? slug = null,Object? cnpj = freezed,Object? name = null,Object? bio = freezed,Object? avatar = freezed,Object? maxReachLevel = null,Object? coverImgUrl = freezed,Object? categories = null,Object? createdAt = null,}) {
  return _then(_BusinessModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,cnpj: freezed == cnpj ? _self.cnpj : cnpj // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,maxReachLevel: null == maxReachLevel ? _self.maxReachLevel : maxReachLevel // ignore: cast_nullable_to_non_nullable
as ReachLevel,coverImgUrl: freezed == coverImgUrl ? _self.coverImgUrl : coverImgUrl // ignore: cast_nullable_to_non_nullable
as String?,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
