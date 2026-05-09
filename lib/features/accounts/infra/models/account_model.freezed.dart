// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AccountModel {

 String get id; String get email;@JsonKey(name: 'phone_number') String? get phoneNumber; String get name; bool get active;@JsonKey(name: 'is_verified') bool get isVerified;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(name: 'updated_at') DateTime get updatedAt; String get slug;@JsonKey(name: 'display_name') String get displayName; String? get bio;@JsonKey(name: 'avatar_url') String? get avatarUrl;@AccountTypeConverter() AccountType get type; AccountInterestsModel? get interests; AccountBusinessModel? get business;@GenderConverter() Gender? get gender;
/// Create a copy of AccountModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountModelCopyWith<AccountModel> get copyWith => _$AccountModelCopyWithImpl<AccountModel>(this as AccountModel, _$identity);

  /// Serializes this AccountModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountModel&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.name, name) || other.name == name)&&(identical(other.active, active) || other.active == active)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.type, type) || other.type == type)&&(identical(other.interests, interests) || other.interests == interests)&&(identical(other.business, business) || other.business == business)&&(identical(other.gender, gender) || other.gender == gender));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,phoneNumber,name,active,isVerified,createdAt,updatedAt,slug,displayName,bio,avatarUrl,type,interests,business,gender);

@override
String toString() {
  return 'AccountModel(id: $id, email: $email, phoneNumber: $phoneNumber, name: $name, active: $active, isVerified: $isVerified, createdAt: $createdAt, updatedAt: $updatedAt, slug: $slug, displayName: $displayName, bio: $bio, avatarUrl: $avatarUrl, type: $type, interests: $interests, business: $business, gender: $gender)';
}


}

/// @nodoc
abstract mixin class $AccountModelCopyWith<$Res>  {
  factory $AccountModelCopyWith(AccountModel value, $Res Function(AccountModel) _then) = _$AccountModelCopyWithImpl;
@useResult
$Res call({
 String id, String email,@JsonKey(name: 'phone_number') String? phoneNumber, String name, bool active,@JsonKey(name: 'is_verified') bool isVerified,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt, String slug,@JsonKey(name: 'display_name') String displayName, String? bio,@JsonKey(name: 'avatar_url') String? avatarUrl,@AccountTypeConverter() AccountType type, AccountInterestsModel? interests, AccountBusinessModel? business,@GenderConverter() Gender? gender
});


$AccountInterestsModelCopyWith<$Res>? get interests;$AccountBusinessModelCopyWith<$Res>? get business;

}
/// @nodoc
class _$AccountModelCopyWithImpl<$Res>
    implements $AccountModelCopyWith<$Res> {
  _$AccountModelCopyWithImpl(this._self, this._then);

  final AccountModel _self;
  final $Res Function(AccountModel) _then;

/// Create a copy of AccountModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? email = null,Object? phoneNumber = freezed,Object? name = null,Object? active = null,Object? isVerified = null,Object? createdAt = null,Object? updatedAt = null,Object? slug = null,Object? displayName = null,Object? bio = freezed,Object? avatarUrl = freezed,Object? type = null,Object? interests = freezed,Object? business = freezed,Object? gender = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as AccountType,interests: freezed == interests ? _self.interests : interests // ignore: cast_nullable_to_non_nullable
as AccountInterestsModel?,business: freezed == business ? _self.business : business // ignore: cast_nullable_to_non_nullable
as AccountBusinessModel?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as Gender?,
  ));
}
/// Create a copy of AccountModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AccountInterestsModelCopyWith<$Res>? get interests {
    if (_self.interests == null) {
    return null;
  }

  return $AccountInterestsModelCopyWith<$Res>(_self.interests!, (value) {
    return _then(_self.copyWith(interests: value));
  });
}/// Create a copy of AccountModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AccountBusinessModelCopyWith<$Res>? get business {
    if (_self.business == null) {
    return null;
  }

  return $AccountBusinessModelCopyWith<$Res>(_self.business!, (value) {
    return _then(_self.copyWith(business: value));
  });
}
}


/// Adds pattern-matching-related methods to [AccountModel].
extension AccountModelPatterns on AccountModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccountModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccountModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccountModel value)  $default,){
final _that = this;
switch (_that) {
case _AccountModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccountModel value)?  $default,){
final _that = this;
switch (_that) {
case _AccountModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String email, @JsonKey(name: 'phone_number')  String? phoneNumber,  String name,  bool active, @JsonKey(name: 'is_verified')  bool isVerified, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt,  String slug, @JsonKey(name: 'display_name')  String displayName,  String? bio, @JsonKey(name: 'avatar_url')  String? avatarUrl, @AccountTypeConverter()  AccountType type,  AccountInterestsModel? interests,  AccountBusinessModel? business, @GenderConverter()  Gender? gender)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccountModel() when $default != null:
return $default(_that.id,_that.email,_that.phoneNumber,_that.name,_that.active,_that.isVerified,_that.createdAt,_that.updatedAt,_that.slug,_that.displayName,_that.bio,_that.avatarUrl,_that.type,_that.interests,_that.business,_that.gender);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String email, @JsonKey(name: 'phone_number')  String? phoneNumber,  String name,  bool active, @JsonKey(name: 'is_verified')  bool isVerified, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt,  String slug, @JsonKey(name: 'display_name')  String displayName,  String? bio, @JsonKey(name: 'avatar_url')  String? avatarUrl, @AccountTypeConverter()  AccountType type,  AccountInterestsModel? interests,  AccountBusinessModel? business, @GenderConverter()  Gender? gender)  $default,) {final _that = this;
switch (_that) {
case _AccountModel():
return $default(_that.id,_that.email,_that.phoneNumber,_that.name,_that.active,_that.isVerified,_that.createdAt,_that.updatedAt,_that.slug,_that.displayName,_that.bio,_that.avatarUrl,_that.type,_that.interests,_that.business,_that.gender);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String email, @JsonKey(name: 'phone_number')  String? phoneNumber,  String name,  bool active, @JsonKey(name: 'is_verified')  bool isVerified, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt,  String slug, @JsonKey(name: 'display_name')  String displayName,  String? bio, @JsonKey(name: 'avatar_url')  String? avatarUrl, @AccountTypeConverter()  AccountType type,  AccountInterestsModel? interests,  AccountBusinessModel? business, @GenderConverter()  Gender? gender)?  $default,) {final _that = this;
switch (_that) {
case _AccountModel() when $default != null:
return $default(_that.id,_that.email,_that.phoneNumber,_that.name,_that.active,_that.isVerified,_that.createdAt,_that.updatedAt,_that.slug,_that.displayName,_that.bio,_that.avatarUrl,_that.type,_that.interests,_that.business,_that.gender);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AccountModel implements AccountModel {
  const _AccountModel({required this.id, required this.email, @JsonKey(name: 'phone_number') this.phoneNumber, required this.name, required this.active, @JsonKey(name: 'is_verified') required this.isVerified, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt, required this.slug, @JsonKey(name: 'display_name') required this.displayName, this.bio, @JsonKey(name: 'avatar_url') this.avatarUrl, @AccountTypeConverter() required this.type, this.interests, this.business, @GenderConverter() this.gender});
  factory _AccountModel.fromJson(Map<String, dynamic> json) => _$AccountModelFromJson(json);

@override final  String id;
@override final  String email;
@override@JsonKey(name: 'phone_number') final  String? phoneNumber;
@override final  String name;
@override final  bool active;
@override@JsonKey(name: 'is_verified') final  bool isVerified;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime updatedAt;
@override final  String slug;
@override@JsonKey(name: 'display_name') final  String displayName;
@override final  String? bio;
@override@JsonKey(name: 'avatar_url') final  String? avatarUrl;
@override@AccountTypeConverter() final  AccountType type;
@override final  AccountInterestsModel? interests;
@override final  AccountBusinessModel? business;
@override@GenderConverter() final  Gender? gender;

/// Create a copy of AccountModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountModelCopyWith<_AccountModel> get copyWith => __$AccountModelCopyWithImpl<_AccountModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AccountModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccountModel&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.name, name) || other.name == name)&&(identical(other.active, active) || other.active == active)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.type, type) || other.type == type)&&(identical(other.interests, interests) || other.interests == interests)&&(identical(other.business, business) || other.business == business)&&(identical(other.gender, gender) || other.gender == gender));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,phoneNumber,name,active,isVerified,createdAt,updatedAt,slug,displayName,bio,avatarUrl,type,interests,business,gender);

@override
String toString() {
  return 'AccountModel(id: $id, email: $email, phoneNumber: $phoneNumber, name: $name, active: $active, isVerified: $isVerified, createdAt: $createdAt, updatedAt: $updatedAt, slug: $slug, displayName: $displayName, bio: $bio, avatarUrl: $avatarUrl, type: $type, interests: $interests, business: $business, gender: $gender)';
}


}

/// @nodoc
abstract mixin class _$AccountModelCopyWith<$Res> implements $AccountModelCopyWith<$Res> {
  factory _$AccountModelCopyWith(_AccountModel value, $Res Function(_AccountModel) _then) = __$AccountModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String email,@JsonKey(name: 'phone_number') String? phoneNumber, String name, bool active,@JsonKey(name: 'is_verified') bool isVerified,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt, String slug,@JsonKey(name: 'display_name') String displayName, String? bio,@JsonKey(name: 'avatar_url') String? avatarUrl,@AccountTypeConverter() AccountType type, AccountInterestsModel? interests, AccountBusinessModel? business,@GenderConverter() Gender? gender
});


@override $AccountInterestsModelCopyWith<$Res>? get interests;@override $AccountBusinessModelCopyWith<$Res>? get business;

}
/// @nodoc
class __$AccountModelCopyWithImpl<$Res>
    implements _$AccountModelCopyWith<$Res> {
  __$AccountModelCopyWithImpl(this._self, this._then);

  final _AccountModel _self;
  final $Res Function(_AccountModel) _then;

/// Create a copy of AccountModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? email = null,Object? phoneNumber = freezed,Object? name = null,Object? active = null,Object? isVerified = null,Object? createdAt = null,Object? updatedAt = null,Object? slug = null,Object? displayName = null,Object? bio = freezed,Object? avatarUrl = freezed,Object? type = null,Object? interests = freezed,Object? business = freezed,Object? gender = freezed,}) {
  return _then(_AccountModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as AccountType,interests: freezed == interests ? _self.interests : interests // ignore: cast_nullable_to_non_nullable
as AccountInterestsModel?,business: freezed == business ? _self.business : business // ignore: cast_nullable_to_non_nullable
as AccountBusinessModel?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as Gender?,
  ));
}

/// Create a copy of AccountModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AccountInterestsModelCopyWith<$Res>? get interests {
    if (_self.interests == null) {
    return null;
  }

  return $AccountInterestsModelCopyWith<$Res>(_self.interests!, (value) {
    return _then(_self.copyWith(interests: value));
  });
}/// Create a copy of AccountModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AccountBusinessModelCopyWith<$Res>? get business {
    if (_self.business == null) {
    return null;
  }

  return $AccountBusinessModelCopyWith<$Res>(_self.business!, (value) {
    return _then(_self.copyWith(business: value));
  });
}
}

// dart format on
