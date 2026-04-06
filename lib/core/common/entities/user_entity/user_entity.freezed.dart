// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserEntity {

 int get id; String get firstName; String get lastName; String get phone; ShopRole? get role; ShopRole? get shopRole; bool get block; bool get haveMultipleShops; bool get isNotificationActive; UserSubscriptionEntity? get subscription; List<UserPasswordSettingsEntity> get passwordSettings; ShopSettingsEntity get shopSettings; UserShopEntity get shopDetails;
/// Create a copy of UserEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserEntityCopyWith<UserEntity> get copyWith => _$UserEntityCopyWithImpl<UserEntity>(this as UserEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.role, role) || other.role == role)&&(identical(other.shopRole, shopRole) || other.shopRole == shopRole)&&(identical(other.block, block) || other.block == block)&&(identical(other.haveMultipleShops, haveMultipleShops) || other.haveMultipleShops == haveMultipleShops)&&(identical(other.isNotificationActive, isNotificationActive) || other.isNotificationActive == isNotificationActive)&&(identical(other.subscription, subscription) || other.subscription == subscription)&&const DeepCollectionEquality().equals(other.passwordSettings, passwordSettings)&&(identical(other.shopSettings, shopSettings) || other.shopSettings == shopSettings)&&(identical(other.shopDetails, shopDetails) || other.shopDetails == shopDetails));
}


@override
int get hashCode => Object.hash(runtimeType,id,firstName,lastName,phone,role,shopRole,block,haveMultipleShops,isNotificationActive,subscription,const DeepCollectionEquality().hash(passwordSettings),shopSettings,shopDetails);

@override
String toString() {
  return 'UserEntity(id: $id, firstName: $firstName, lastName: $lastName, phone: $phone, role: $role, shopRole: $shopRole, block: $block, haveMultipleShops: $haveMultipleShops, isNotificationActive: $isNotificationActive, subscription: $subscription, passwordSettings: $passwordSettings, shopSettings: $shopSettings, shopDetails: $shopDetails)';
}


}

/// @nodoc
abstract mixin class $UserEntityCopyWith<$Res>  {
  factory $UserEntityCopyWith(UserEntity value, $Res Function(UserEntity) _then) = _$UserEntityCopyWithImpl;
@useResult
$Res call({
 int id, String firstName, String lastName, String phone, ShopRole? role, ShopRole? shopRole, bool block, bool haveMultipleShops, bool isNotificationActive, UserSubscriptionEntity? subscription, List<UserPasswordSettingsEntity> passwordSettings, ShopSettingsEntity shopSettings, UserShopEntity shopDetails
});


$UserSubscriptionEntityCopyWith<$Res>? get subscription;$ShopSettingsEntityCopyWith<$Res> get shopSettings;$UserShopEntityCopyWith<$Res> get shopDetails;

}
/// @nodoc
class _$UserEntityCopyWithImpl<$Res>
    implements $UserEntityCopyWith<$Res> {
  _$UserEntityCopyWithImpl(this._self, this._then);

  final UserEntity _self;
  final $Res Function(UserEntity) _then;

/// Create a copy of UserEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? firstName = null,Object? lastName = null,Object? phone = null,Object? role = freezed,Object? shopRole = freezed,Object? block = null,Object? haveMultipleShops = null,Object? isNotificationActive = null,Object? subscription = freezed,Object? passwordSettings = null,Object? shopSettings = null,Object? shopDetails = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as ShopRole?,shopRole: freezed == shopRole ? _self.shopRole : shopRole // ignore: cast_nullable_to_non_nullable
as ShopRole?,block: null == block ? _self.block : block // ignore: cast_nullable_to_non_nullable
as bool,haveMultipleShops: null == haveMultipleShops ? _self.haveMultipleShops : haveMultipleShops // ignore: cast_nullable_to_non_nullable
as bool,isNotificationActive: null == isNotificationActive ? _self.isNotificationActive : isNotificationActive // ignore: cast_nullable_to_non_nullable
as bool,subscription: freezed == subscription ? _self.subscription : subscription // ignore: cast_nullable_to_non_nullable
as UserSubscriptionEntity?,passwordSettings: null == passwordSettings ? _self.passwordSettings : passwordSettings // ignore: cast_nullable_to_non_nullable
as List<UserPasswordSettingsEntity>,shopSettings: null == shopSettings ? _self.shopSettings : shopSettings // ignore: cast_nullable_to_non_nullable
as ShopSettingsEntity,shopDetails: null == shopDetails ? _self.shopDetails : shopDetails // ignore: cast_nullable_to_non_nullable
as UserShopEntity,
  ));
}
/// Create a copy of UserEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserSubscriptionEntityCopyWith<$Res>? get subscription {
    if (_self.subscription == null) {
    return null;
  }

  return $UserSubscriptionEntityCopyWith<$Res>(_self.subscription!, (value) {
    return _then(_self.copyWith(subscription: value));
  });
}/// Create a copy of UserEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShopSettingsEntityCopyWith<$Res> get shopSettings {
  
  return $ShopSettingsEntityCopyWith<$Res>(_self.shopSettings, (value) {
    return _then(_self.copyWith(shopSettings: value));
  });
}/// Create a copy of UserEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserShopEntityCopyWith<$Res> get shopDetails {
  
  return $UserShopEntityCopyWith<$Res>(_self.shopDetails, (value) {
    return _then(_self.copyWith(shopDetails: value));
  });
}
}


/// Adds pattern-matching-related methods to [UserEntity].
extension UserEntityPatterns on UserEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserEntity value)  $default,){
final _that = this;
switch (_that) {
case _UserEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserEntity value)?  $default,){
final _that = this;
switch (_that) {
case _UserEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String firstName,  String lastName,  String phone,  ShopRole? role,  ShopRole? shopRole,  bool block,  bool haveMultipleShops,  bool isNotificationActive,  UserSubscriptionEntity? subscription,  List<UserPasswordSettingsEntity> passwordSettings,  ShopSettingsEntity shopSettings,  UserShopEntity shopDetails)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserEntity() when $default != null:
return $default(_that.id,_that.firstName,_that.lastName,_that.phone,_that.role,_that.shopRole,_that.block,_that.haveMultipleShops,_that.isNotificationActive,_that.subscription,_that.passwordSettings,_that.shopSettings,_that.shopDetails);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String firstName,  String lastName,  String phone,  ShopRole? role,  ShopRole? shopRole,  bool block,  bool haveMultipleShops,  bool isNotificationActive,  UserSubscriptionEntity? subscription,  List<UserPasswordSettingsEntity> passwordSettings,  ShopSettingsEntity shopSettings,  UserShopEntity shopDetails)  $default,) {final _that = this;
switch (_that) {
case _UserEntity():
return $default(_that.id,_that.firstName,_that.lastName,_that.phone,_that.role,_that.shopRole,_that.block,_that.haveMultipleShops,_that.isNotificationActive,_that.subscription,_that.passwordSettings,_that.shopSettings,_that.shopDetails);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String firstName,  String lastName,  String phone,  ShopRole? role,  ShopRole? shopRole,  bool block,  bool haveMultipleShops,  bool isNotificationActive,  UserSubscriptionEntity? subscription,  List<UserPasswordSettingsEntity> passwordSettings,  ShopSettingsEntity shopSettings,  UserShopEntity shopDetails)?  $default,) {final _that = this;
switch (_that) {
case _UserEntity() when $default != null:
return $default(_that.id,_that.firstName,_that.lastName,_that.phone,_that.role,_that.shopRole,_that.block,_that.haveMultipleShops,_that.isNotificationActive,_that.subscription,_that.passwordSettings,_that.shopSettings,_that.shopDetails);case _:
  return null;

}
}

}

/// @nodoc


class _UserEntity implements UserEntity {
  const _UserEntity({required this.id, required this.firstName, required this.lastName, required this.phone, this.role, this.shopRole, required this.block, required this.haveMultipleShops, required this.isNotificationActive, this.subscription, required final  List<UserPasswordSettingsEntity> passwordSettings, required this.shopSettings, required this.shopDetails}): _passwordSettings = passwordSettings;
  

@override final  int id;
@override final  String firstName;
@override final  String lastName;
@override final  String phone;
@override final  ShopRole? role;
@override final  ShopRole? shopRole;
@override final  bool block;
@override final  bool haveMultipleShops;
@override final  bool isNotificationActive;
@override final  UserSubscriptionEntity? subscription;
 final  List<UserPasswordSettingsEntity> _passwordSettings;
@override List<UserPasswordSettingsEntity> get passwordSettings {
  if (_passwordSettings is EqualUnmodifiableListView) return _passwordSettings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_passwordSettings);
}

@override final  ShopSettingsEntity shopSettings;
@override final  UserShopEntity shopDetails;

/// Create a copy of UserEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserEntityCopyWith<_UserEntity> get copyWith => __$UserEntityCopyWithImpl<_UserEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.role, role) || other.role == role)&&(identical(other.shopRole, shopRole) || other.shopRole == shopRole)&&(identical(other.block, block) || other.block == block)&&(identical(other.haveMultipleShops, haveMultipleShops) || other.haveMultipleShops == haveMultipleShops)&&(identical(other.isNotificationActive, isNotificationActive) || other.isNotificationActive == isNotificationActive)&&(identical(other.subscription, subscription) || other.subscription == subscription)&&const DeepCollectionEquality().equals(other._passwordSettings, _passwordSettings)&&(identical(other.shopSettings, shopSettings) || other.shopSettings == shopSettings)&&(identical(other.shopDetails, shopDetails) || other.shopDetails == shopDetails));
}


@override
int get hashCode => Object.hash(runtimeType,id,firstName,lastName,phone,role,shopRole,block,haveMultipleShops,isNotificationActive,subscription,const DeepCollectionEquality().hash(_passwordSettings),shopSettings,shopDetails);

@override
String toString() {
  return 'UserEntity(id: $id, firstName: $firstName, lastName: $lastName, phone: $phone, role: $role, shopRole: $shopRole, block: $block, haveMultipleShops: $haveMultipleShops, isNotificationActive: $isNotificationActive, subscription: $subscription, passwordSettings: $passwordSettings, shopSettings: $shopSettings, shopDetails: $shopDetails)';
}


}

/// @nodoc
abstract mixin class _$UserEntityCopyWith<$Res> implements $UserEntityCopyWith<$Res> {
  factory _$UserEntityCopyWith(_UserEntity value, $Res Function(_UserEntity) _then) = __$UserEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, String firstName, String lastName, String phone, ShopRole? role, ShopRole? shopRole, bool block, bool haveMultipleShops, bool isNotificationActive, UserSubscriptionEntity? subscription, List<UserPasswordSettingsEntity> passwordSettings, ShopSettingsEntity shopSettings, UserShopEntity shopDetails
});


@override $UserSubscriptionEntityCopyWith<$Res>? get subscription;@override $ShopSettingsEntityCopyWith<$Res> get shopSettings;@override $UserShopEntityCopyWith<$Res> get shopDetails;

}
/// @nodoc
class __$UserEntityCopyWithImpl<$Res>
    implements _$UserEntityCopyWith<$Res> {
  __$UserEntityCopyWithImpl(this._self, this._then);

  final _UserEntity _self;
  final $Res Function(_UserEntity) _then;

/// Create a copy of UserEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? firstName = null,Object? lastName = null,Object? phone = null,Object? role = freezed,Object? shopRole = freezed,Object? block = null,Object? haveMultipleShops = null,Object? isNotificationActive = null,Object? subscription = freezed,Object? passwordSettings = null,Object? shopSettings = null,Object? shopDetails = null,}) {
  return _then(_UserEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as ShopRole?,shopRole: freezed == shopRole ? _self.shopRole : shopRole // ignore: cast_nullable_to_non_nullable
as ShopRole?,block: null == block ? _self.block : block // ignore: cast_nullable_to_non_nullable
as bool,haveMultipleShops: null == haveMultipleShops ? _self.haveMultipleShops : haveMultipleShops // ignore: cast_nullable_to_non_nullable
as bool,isNotificationActive: null == isNotificationActive ? _self.isNotificationActive : isNotificationActive // ignore: cast_nullable_to_non_nullable
as bool,subscription: freezed == subscription ? _self.subscription : subscription // ignore: cast_nullable_to_non_nullable
as UserSubscriptionEntity?,passwordSettings: null == passwordSettings ? _self._passwordSettings : passwordSettings // ignore: cast_nullable_to_non_nullable
as List<UserPasswordSettingsEntity>,shopSettings: null == shopSettings ? _self.shopSettings : shopSettings // ignore: cast_nullable_to_non_nullable
as ShopSettingsEntity,shopDetails: null == shopDetails ? _self.shopDetails : shopDetails // ignore: cast_nullable_to_non_nullable
as UserShopEntity,
  ));
}

/// Create a copy of UserEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserSubscriptionEntityCopyWith<$Res>? get subscription {
    if (_self.subscription == null) {
    return null;
  }

  return $UserSubscriptionEntityCopyWith<$Res>(_self.subscription!, (value) {
    return _then(_self.copyWith(subscription: value));
  });
}/// Create a copy of UserEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShopSettingsEntityCopyWith<$Res> get shopSettings {
  
  return $ShopSettingsEntityCopyWith<$Res>(_self.shopSettings, (value) {
    return _then(_self.copyWith(shopSettings: value));
  });
}/// Create a copy of UserEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserShopEntityCopyWith<$Res> get shopDetails {
  
  return $UserShopEntityCopyWith<$Res>(_self.shopDetails, (value) {
    return _then(_self.copyWith(shopDetails: value));
  });
}
}

/// @nodoc
mixin _$UserSubscriptionEntity {

 String get plan; String get status; String get expiryDate; Set<AppPremiumFeatures> get features; Set<AppPremiumFeatures> get userSpecificFeatures;
/// Create a copy of UserSubscriptionEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserSubscriptionEntityCopyWith<UserSubscriptionEntity> get copyWith => _$UserSubscriptionEntityCopyWithImpl<UserSubscriptionEntity>(this as UserSubscriptionEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserSubscriptionEntity&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.status, status) || other.status == status)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate)&&const DeepCollectionEquality().equals(other.features, features)&&const DeepCollectionEquality().equals(other.userSpecificFeatures, userSpecificFeatures));
}


@override
int get hashCode => Object.hash(runtimeType,plan,status,expiryDate,const DeepCollectionEquality().hash(features),const DeepCollectionEquality().hash(userSpecificFeatures));

@override
String toString() {
  return 'UserSubscriptionEntity(plan: $plan, status: $status, expiryDate: $expiryDate, features: $features, userSpecificFeatures: $userSpecificFeatures)';
}


}

/// @nodoc
abstract mixin class $UserSubscriptionEntityCopyWith<$Res>  {
  factory $UserSubscriptionEntityCopyWith(UserSubscriptionEntity value, $Res Function(UserSubscriptionEntity) _then) = _$UserSubscriptionEntityCopyWithImpl;
@useResult
$Res call({
 String plan, String status, String expiryDate, Set<AppPremiumFeatures> features, Set<AppPremiumFeatures> userSpecificFeatures
});




}
/// @nodoc
class _$UserSubscriptionEntityCopyWithImpl<$Res>
    implements $UserSubscriptionEntityCopyWith<$Res> {
  _$UserSubscriptionEntityCopyWithImpl(this._self, this._then);

  final UserSubscriptionEntity _self;
  final $Res Function(UserSubscriptionEntity) _then;

/// Create a copy of UserSubscriptionEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? plan = null,Object? status = null,Object? expiryDate = null,Object? features = null,Object? userSpecificFeatures = null,}) {
  return _then(_self.copyWith(
plan: null == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,expiryDate: null == expiryDate ? _self.expiryDate : expiryDate // ignore: cast_nullable_to_non_nullable
as String,features: null == features ? _self.features : features // ignore: cast_nullable_to_non_nullable
as Set<AppPremiumFeatures>,userSpecificFeatures: null == userSpecificFeatures ? _self.userSpecificFeatures : userSpecificFeatures // ignore: cast_nullable_to_non_nullable
as Set<AppPremiumFeatures>,
  ));
}

}


/// Adds pattern-matching-related methods to [UserSubscriptionEntity].
extension UserSubscriptionEntityPatterns on UserSubscriptionEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserSubscriptionEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserSubscriptionEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserSubscriptionEntity value)  $default,){
final _that = this;
switch (_that) {
case _UserSubscriptionEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserSubscriptionEntity value)?  $default,){
final _that = this;
switch (_that) {
case _UserSubscriptionEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String plan,  String status,  String expiryDate,  Set<AppPremiumFeatures> features,  Set<AppPremiumFeatures> userSpecificFeatures)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserSubscriptionEntity() when $default != null:
return $default(_that.plan,_that.status,_that.expiryDate,_that.features,_that.userSpecificFeatures);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String plan,  String status,  String expiryDate,  Set<AppPremiumFeatures> features,  Set<AppPremiumFeatures> userSpecificFeatures)  $default,) {final _that = this;
switch (_that) {
case _UserSubscriptionEntity():
return $default(_that.plan,_that.status,_that.expiryDate,_that.features,_that.userSpecificFeatures);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String plan,  String status,  String expiryDate,  Set<AppPremiumFeatures> features,  Set<AppPremiumFeatures> userSpecificFeatures)?  $default,) {final _that = this;
switch (_that) {
case _UserSubscriptionEntity() when $default != null:
return $default(_that.plan,_that.status,_that.expiryDate,_that.features,_that.userSpecificFeatures);case _:
  return null;

}
}

}

/// @nodoc


class _UserSubscriptionEntity implements UserSubscriptionEntity {
  const _UserSubscriptionEntity({required this.plan, required this.status, required this.expiryDate, required final  Set<AppPremiumFeatures> features, required final  Set<AppPremiumFeatures> userSpecificFeatures}): _features = features,_userSpecificFeatures = userSpecificFeatures;
  

@override final  String plan;
@override final  String status;
@override final  String expiryDate;
 final  Set<AppPremiumFeatures> _features;
@override Set<AppPremiumFeatures> get features {
  if (_features is EqualUnmodifiableSetView) return _features;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_features);
}

 final  Set<AppPremiumFeatures> _userSpecificFeatures;
@override Set<AppPremiumFeatures> get userSpecificFeatures {
  if (_userSpecificFeatures is EqualUnmodifiableSetView) return _userSpecificFeatures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_userSpecificFeatures);
}


/// Create a copy of UserSubscriptionEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserSubscriptionEntityCopyWith<_UserSubscriptionEntity> get copyWith => __$UserSubscriptionEntityCopyWithImpl<_UserSubscriptionEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserSubscriptionEntity&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.status, status) || other.status == status)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate)&&const DeepCollectionEquality().equals(other._features, _features)&&const DeepCollectionEquality().equals(other._userSpecificFeatures, _userSpecificFeatures));
}


@override
int get hashCode => Object.hash(runtimeType,plan,status,expiryDate,const DeepCollectionEquality().hash(_features),const DeepCollectionEquality().hash(_userSpecificFeatures));

@override
String toString() {
  return 'UserSubscriptionEntity(plan: $plan, status: $status, expiryDate: $expiryDate, features: $features, userSpecificFeatures: $userSpecificFeatures)';
}


}

/// @nodoc
abstract mixin class _$UserSubscriptionEntityCopyWith<$Res> implements $UserSubscriptionEntityCopyWith<$Res> {
  factory _$UserSubscriptionEntityCopyWith(_UserSubscriptionEntity value, $Res Function(_UserSubscriptionEntity) _then) = __$UserSubscriptionEntityCopyWithImpl;
@override @useResult
$Res call({
 String plan, String status, String expiryDate, Set<AppPremiumFeatures> features, Set<AppPremiumFeatures> userSpecificFeatures
});




}
/// @nodoc
class __$UserSubscriptionEntityCopyWithImpl<$Res>
    implements _$UserSubscriptionEntityCopyWith<$Res> {
  __$UserSubscriptionEntityCopyWithImpl(this._self, this._then);

  final _UserSubscriptionEntity _self;
  final $Res Function(_UserSubscriptionEntity) _then;

/// Create a copy of UserSubscriptionEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? plan = null,Object? status = null,Object? expiryDate = null,Object? features = null,Object? userSpecificFeatures = null,}) {
  return _then(_UserSubscriptionEntity(
plan: null == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,expiryDate: null == expiryDate ? _self.expiryDate : expiryDate // ignore: cast_nullable_to_non_nullable
as String,features: null == features ? _self._features : features // ignore: cast_nullable_to_non_nullable
as Set<AppPremiumFeatures>,userSpecificFeatures: null == userSpecificFeatures ? _self._userSpecificFeatures : userSpecificFeatures // ignore: cast_nullable_to_non_nullable
as Set<AppPremiumFeatures>,
  ));
}


}

/// @nodoc
mixin _$UserPasswordSettingsEntity {

 SecretPasswordLocations get location; UserPasswordSettingRole get role;
/// Create a copy of UserPasswordSettingsEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserPasswordSettingsEntityCopyWith<UserPasswordSettingsEntity> get copyWith => _$UserPasswordSettingsEntityCopyWithImpl<UserPasswordSettingsEntity>(this as UserPasswordSettingsEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserPasswordSettingsEntity&&(identical(other.location, location) || other.location == location)&&(identical(other.role, role) || other.role == role));
}


@override
int get hashCode => Object.hash(runtimeType,location,role);

@override
String toString() {
  return 'UserPasswordSettingsEntity(location: $location, role: $role)';
}


}

/// @nodoc
abstract mixin class $UserPasswordSettingsEntityCopyWith<$Res>  {
  factory $UserPasswordSettingsEntityCopyWith(UserPasswordSettingsEntity value, $Res Function(UserPasswordSettingsEntity) _then) = _$UserPasswordSettingsEntityCopyWithImpl;
@useResult
$Res call({
 SecretPasswordLocations location, UserPasswordSettingRole role
});




}
/// @nodoc
class _$UserPasswordSettingsEntityCopyWithImpl<$Res>
    implements $UserPasswordSettingsEntityCopyWith<$Res> {
  _$UserPasswordSettingsEntityCopyWithImpl(this._self, this._then);

  final UserPasswordSettingsEntity _self;
  final $Res Function(UserPasswordSettingsEntity) _then;

/// Create a copy of UserPasswordSettingsEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? location = null,Object? role = null,}) {
  return _then(_self.copyWith(
location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as SecretPasswordLocations,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as UserPasswordSettingRole,
  ));
}

}


/// Adds pattern-matching-related methods to [UserPasswordSettingsEntity].
extension UserPasswordSettingsEntityPatterns on UserPasswordSettingsEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserPasswordSettingsEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserPasswordSettingsEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserPasswordSettingsEntity value)  $default,){
final _that = this;
switch (_that) {
case _UserPasswordSettingsEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserPasswordSettingsEntity value)?  $default,){
final _that = this;
switch (_that) {
case _UserPasswordSettingsEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SecretPasswordLocations location,  UserPasswordSettingRole role)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserPasswordSettingsEntity() when $default != null:
return $default(_that.location,_that.role);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SecretPasswordLocations location,  UserPasswordSettingRole role)  $default,) {final _that = this;
switch (_that) {
case _UserPasswordSettingsEntity():
return $default(_that.location,_that.role);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SecretPasswordLocations location,  UserPasswordSettingRole role)?  $default,) {final _that = this;
switch (_that) {
case _UserPasswordSettingsEntity() when $default != null:
return $default(_that.location,_that.role);case _:
  return null;

}
}

}

/// @nodoc


class _UserPasswordSettingsEntity implements UserPasswordSettingsEntity {
  const _UserPasswordSettingsEntity({required this.location, required this.role});
  

@override final  SecretPasswordLocations location;
@override final  UserPasswordSettingRole role;

/// Create a copy of UserPasswordSettingsEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserPasswordSettingsEntityCopyWith<_UserPasswordSettingsEntity> get copyWith => __$UserPasswordSettingsEntityCopyWithImpl<_UserPasswordSettingsEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserPasswordSettingsEntity&&(identical(other.location, location) || other.location == location)&&(identical(other.role, role) || other.role == role));
}


@override
int get hashCode => Object.hash(runtimeType,location,role);

@override
String toString() {
  return 'UserPasswordSettingsEntity(location: $location, role: $role)';
}


}

/// @nodoc
abstract mixin class _$UserPasswordSettingsEntityCopyWith<$Res> implements $UserPasswordSettingsEntityCopyWith<$Res> {
  factory _$UserPasswordSettingsEntityCopyWith(_UserPasswordSettingsEntity value, $Res Function(_UserPasswordSettingsEntity) _then) = __$UserPasswordSettingsEntityCopyWithImpl;
@override @useResult
$Res call({
 SecretPasswordLocations location, UserPasswordSettingRole role
});




}
/// @nodoc
class __$UserPasswordSettingsEntityCopyWithImpl<$Res>
    implements _$UserPasswordSettingsEntityCopyWith<$Res> {
  __$UserPasswordSettingsEntityCopyWithImpl(this._self, this._then);

  final _UserPasswordSettingsEntity _self;
  final $Res Function(_UserPasswordSettingsEntity) _then;

/// Create a copy of UserPasswordSettingsEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? location = null,Object? role = null,}) {
  return _then(_UserPasswordSettingsEntity(
location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as SecretPasswordLocations,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as UserPasswordSettingRole,
  ));
}


}

// dart format on
