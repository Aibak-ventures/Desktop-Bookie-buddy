// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserModel {

 int get id;@JsonKey(name: 'full_name') String get firstName;@JsonKey(name: 'last_name', defaultValue: '') String get lastName; String get phone;@JsonKey(name: 'role', fromJson: ShopRole.fromJson) ShopRole? get role;@JsonKey(name: 'shop_role', fromJson: ShopRole.fromJson) ShopRole? get shopRole;@JsonKey(defaultValue: false) bool get block;@JsonKey(name: 'multiple_shops', defaultValue: false) bool get haveMultipleShops;@JsonKey(name: 'has_active_notification', defaultValue: false) bool get isNotificationActive;@JsonKey(name: 'subscription') UserSubscriptionModel? get subscription;@JsonKey(name: 'password_settings', fromJson: _passwordSettingsFromJson) List<UserPasswordSettingsModel> get passwordSettings;@JsonKey(name: 'shop_settings') ShopSettingsModel get shopSettings;@JsonKey(name: 'shop') UserShopModel get shopDetails;
/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserModelCopyWith<UserModel> get copyWith => _$UserModelCopyWithImpl<UserModel>(this as UserModel, _$identity);

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.role, role) || other.role == role)&&(identical(other.shopRole, shopRole) || other.shopRole == shopRole)&&(identical(other.block, block) || other.block == block)&&(identical(other.haveMultipleShops, haveMultipleShops) || other.haveMultipleShops == haveMultipleShops)&&(identical(other.isNotificationActive, isNotificationActive) || other.isNotificationActive == isNotificationActive)&&(identical(other.subscription, subscription) || other.subscription == subscription)&&const DeepCollectionEquality().equals(other.passwordSettings, passwordSettings)&&(identical(other.shopSettings, shopSettings) || other.shopSettings == shopSettings)&&(identical(other.shopDetails, shopDetails) || other.shopDetails == shopDetails));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,firstName,lastName,phone,role,shopRole,block,haveMultipleShops,isNotificationActive,subscription,const DeepCollectionEquality().hash(passwordSettings),shopSettings,shopDetails);

@override
String toString() {
  return 'UserModel(id: $id, firstName: $firstName, lastName: $lastName, phone: $phone, role: $role, shopRole: $shopRole, block: $block, haveMultipleShops: $haveMultipleShops, isNotificationActive: $isNotificationActive, subscription: $subscription, passwordSettings: $passwordSettings, shopSettings: $shopSettings, shopDetails: $shopDetails)';
}


}

/// @nodoc
abstract mixin class $UserModelCopyWith<$Res>  {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) _then) = _$UserModelCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'full_name') String firstName,@JsonKey(name: 'last_name', defaultValue: '') String lastName, String phone,@JsonKey(name: 'role', fromJson: ShopRole.fromJson) ShopRole? role,@JsonKey(name: 'shop_role', fromJson: ShopRole.fromJson) ShopRole? shopRole,@JsonKey(defaultValue: false) bool block,@JsonKey(name: 'multiple_shops', defaultValue: false) bool haveMultipleShops,@JsonKey(name: 'has_active_notification', defaultValue: false) bool isNotificationActive,@JsonKey(name: 'subscription') UserSubscriptionModel? subscription,@JsonKey(name: 'password_settings', fromJson: _passwordSettingsFromJson) List<UserPasswordSettingsModel> passwordSettings,@JsonKey(name: 'shop_settings') ShopSettingsModel shopSettings,@JsonKey(name: 'shop') UserShopModel shopDetails
});


$UserSubscriptionModelCopyWith<$Res>? get subscription;$ShopSettingsModelCopyWith<$Res> get shopSettings;$UserShopModelCopyWith<$Res> get shopDetails;

}
/// @nodoc
class _$UserModelCopyWithImpl<$Res>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._self, this._then);

  final UserModel _self;
  final $Res Function(UserModel) _then;

/// Create a copy of UserModel
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
as UserSubscriptionModel?,passwordSettings: null == passwordSettings ? _self.passwordSettings : passwordSettings // ignore: cast_nullable_to_non_nullable
as List<UserPasswordSettingsModel>,shopSettings: null == shopSettings ? _self.shopSettings : shopSettings // ignore: cast_nullable_to_non_nullable
as ShopSettingsModel,shopDetails: null == shopDetails ? _self.shopDetails : shopDetails // ignore: cast_nullable_to_non_nullable
as UserShopModel,
  ));
}
/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserSubscriptionModelCopyWith<$Res>? get subscription {
    if (_self.subscription == null) {
    return null;
  }

  return $UserSubscriptionModelCopyWith<$Res>(_self.subscription!, (value) {
    return _then(_self.copyWith(subscription: value));
  });
}/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShopSettingsModelCopyWith<$Res> get shopSettings {
  
  return $ShopSettingsModelCopyWith<$Res>(_self.shopSettings, (value) {
    return _then(_self.copyWith(shopSettings: value));
  });
}/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserShopModelCopyWith<$Res> get shopDetails {
  
  return $UserShopModelCopyWith<$Res>(_self.shopDetails, (value) {
    return _then(_self.copyWith(shopDetails: value));
  });
}
}


/// Adds pattern-matching-related methods to [UserModel].
extension UserModelPatterns on UserModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserModel value)  $default,){
final _that = this;
switch (_that) {
case _UserModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'full_name')  String firstName, @JsonKey(name: 'last_name', defaultValue: '')  String lastName,  String phone, @JsonKey(name: 'role', fromJson: ShopRole.fromJson)  ShopRole? role, @JsonKey(name: 'shop_role', fromJson: ShopRole.fromJson)  ShopRole? shopRole, @JsonKey(defaultValue: false)  bool block, @JsonKey(name: 'multiple_shops', defaultValue: false)  bool haveMultipleShops, @JsonKey(name: 'has_active_notification', defaultValue: false)  bool isNotificationActive, @JsonKey(name: 'subscription')  UserSubscriptionModel? subscription, @JsonKey(name: 'password_settings', fromJson: _passwordSettingsFromJson)  List<UserPasswordSettingsModel> passwordSettings, @JsonKey(name: 'shop_settings')  ShopSettingsModel shopSettings, @JsonKey(name: 'shop')  UserShopModel shopDetails)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'full_name')  String firstName, @JsonKey(name: 'last_name', defaultValue: '')  String lastName,  String phone, @JsonKey(name: 'role', fromJson: ShopRole.fromJson)  ShopRole? role, @JsonKey(name: 'shop_role', fromJson: ShopRole.fromJson)  ShopRole? shopRole, @JsonKey(defaultValue: false)  bool block, @JsonKey(name: 'multiple_shops', defaultValue: false)  bool haveMultipleShops, @JsonKey(name: 'has_active_notification', defaultValue: false)  bool isNotificationActive, @JsonKey(name: 'subscription')  UserSubscriptionModel? subscription, @JsonKey(name: 'password_settings', fromJson: _passwordSettingsFromJson)  List<UserPasswordSettingsModel> passwordSettings, @JsonKey(name: 'shop_settings')  ShopSettingsModel shopSettings, @JsonKey(name: 'shop')  UserShopModel shopDetails)  $default,) {final _that = this;
switch (_that) {
case _UserModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'full_name')  String firstName, @JsonKey(name: 'last_name', defaultValue: '')  String lastName,  String phone, @JsonKey(name: 'role', fromJson: ShopRole.fromJson)  ShopRole? role, @JsonKey(name: 'shop_role', fromJson: ShopRole.fromJson)  ShopRole? shopRole, @JsonKey(defaultValue: false)  bool block, @JsonKey(name: 'multiple_shops', defaultValue: false)  bool haveMultipleShops, @JsonKey(name: 'has_active_notification', defaultValue: false)  bool isNotificationActive, @JsonKey(name: 'subscription')  UserSubscriptionModel? subscription, @JsonKey(name: 'password_settings', fromJson: _passwordSettingsFromJson)  List<UserPasswordSettingsModel> passwordSettings, @JsonKey(name: 'shop_settings')  ShopSettingsModel shopSettings, @JsonKey(name: 'shop')  UserShopModel shopDetails)?  $default,) {final _that = this;
switch (_that) {
case _UserModel() when $default != null:
return $default(_that.id,_that.firstName,_that.lastName,_that.phone,_that.role,_that.shopRole,_that.block,_that.haveMultipleShops,_that.isNotificationActive,_that.subscription,_that.passwordSettings,_that.shopSettings,_that.shopDetails);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserModel implements UserModel {
  const _UserModel({required this.id, @JsonKey(name: 'full_name') required this.firstName, @JsonKey(name: 'last_name', defaultValue: '') required this.lastName, required this.phone, @JsonKey(name: 'role', fromJson: ShopRole.fromJson) this.role, @JsonKey(name: 'shop_role', fromJson: ShopRole.fromJson) this.shopRole, @JsonKey(defaultValue: false) required this.block, @JsonKey(name: 'multiple_shops', defaultValue: false) required this.haveMultipleShops, @JsonKey(name: 'has_active_notification', defaultValue: false) required this.isNotificationActive, @JsonKey(name: 'subscription') this.subscription, @JsonKey(name: 'password_settings', fromJson: _passwordSettingsFromJson) required final  List<UserPasswordSettingsModel> passwordSettings, @JsonKey(name: 'shop_settings') required this.shopSettings, @JsonKey(name: 'shop') required this.shopDetails}): _passwordSettings = passwordSettings;
  factory _UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

@override final  int id;
@override@JsonKey(name: 'full_name') final  String firstName;
@override@JsonKey(name: 'last_name', defaultValue: '') final  String lastName;
@override final  String phone;
@override@JsonKey(name: 'role', fromJson: ShopRole.fromJson) final  ShopRole? role;
@override@JsonKey(name: 'shop_role', fromJson: ShopRole.fromJson) final  ShopRole? shopRole;
@override@JsonKey(defaultValue: false) final  bool block;
@override@JsonKey(name: 'multiple_shops', defaultValue: false) final  bool haveMultipleShops;
@override@JsonKey(name: 'has_active_notification', defaultValue: false) final  bool isNotificationActive;
@override@JsonKey(name: 'subscription') final  UserSubscriptionModel? subscription;
 final  List<UserPasswordSettingsModel> _passwordSettings;
@override@JsonKey(name: 'password_settings', fromJson: _passwordSettingsFromJson) List<UserPasswordSettingsModel> get passwordSettings {
  if (_passwordSettings is EqualUnmodifiableListView) return _passwordSettings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_passwordSettings);
}

@override@JsonKey(name: 'shop_settings') final  ShopSettingsModel shopSettings;
@override@JsonKey(name: 'shop') final  UserShopModel shopDetails;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserModelCopyWith<_UserModel> get copyWith => __$UserModelCopyWithImpl<_UserModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.role, role) || other.role == role)&&(identical(other.shopRole, shopRole) || other.shopRole == shopRole)&&(identical(other.block, block) || other.block == block)&&(identical(other.haveMultipleShops, haveMultipleShops) || other.haveMultipleShops == haveMultipleShops)&&(identical(other.isNotificationActive, isNotificationActive) || other.isNotificationActive == isNotificationActive)&&(identical(other.subscription, subscription) || other.subscription == subscription)&&const DeepCollectionEquality().equals(other._passwordSettings, _passwordSettings)&&(identical(other.shopSettings, shopSettings) || other.shopSettings == shopSettings)&&(identical(other.shopDetails, shopDetails) || other.shopDetails == shopDetails));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,firstName,lastName,phone,role,shopRole,block,haveMultipleShops,isNotificationActive,subscription,const DeepCollectionEquality().hash(_passwordSettings),shopSettings,shopDetails);

@override
String toString() {
  return 'UserModel(id: $id, firstName: $firstName, lastName: $lastName, phone: $phone, role: $role, shopRole: $shopRole, block: $block, haveMultipleShops: $haveMultipleShops, isNotificationActive: $isNotificationActive, subscription: $subscription, passwordSettings: $passwordSettings, shopSettings: $shopSettings, shopDetails: $shopDetails)';
}


}

/// @nodoc
abstract mixin class _$UserModelCopyWith<$Res> implements $UserModelCopyWith<$Res> {
  factory _$UserModelCopyWith(_UserModel value, $Res Function(_UserModel) _then) = __$UserModelCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'full_name') String firstName,@JsonKey(name: 'last_name', defaultValue: '') String lastName, String phone,@JsonKey(name: 'role', fromJson: ShopRole.fromJson) ShopRole? role,@JsonKey(name: 'shop_role', fromJson: ShopRole.fromJson) ShopRole? shopRole,@JsonKey(defaultValue: false) bool block,@JsonKey(name: 'multiple_shops', defaultValue: false) bool haveMultipleShops,@JsonKey(name: 'has_active_notification', defaultValue: false) bool isNotificationActive,@JsonKey(name: 'subscription') UserSubscriptionModel? subscription,@JsonKey(name: 'password_settings', fromJson: _passwordSettingsFromJson) List<UserPasswordSettingsModel> passwordSettings,@JsonKey(name: 'shop_settings') ShopSettingsModel shopSettings,@JsonKey(name: 'shop') UserShopModel shopDetails
});


@override $UserSubscriptionModelCopyWith<$Res>? get subscription;@override $ShopSettingsModelCopyWith<$Res> get shopSettings;@override $UserShopModelCopyWith<$Res> get shopDetails;

}
/// @nodoc
class __$UserModelCopyWithImpl<$Res>
    implements _$UserModelCopyWith<$Res> {
  __$UserModelCopyWithImpl(this._self, this._then);

  final _UserModel _self;
  final $Res Function(_UserModel) _then;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? firstName = null,Object? lastName = null,Object? phone = null,Object? role = freezed,Object? shopRole = freezed,Object? block = null,Object? haveMultipleShops = null,Object? isNotificationActive = null,Object? subscription = freezed,Object? passwordSettings = null,Object? shopSettings = null,Object? shopDetails = null,}) {
  return _then(_UserModel(
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
as UserSubscriptionModel?,passwordSettings: null == passwordSettings ? _self._passwordSettings : passwordSettings // ignore: cast_nullable_to_non_nullable
as List<UserPasswordSettingsModel>,shopSettings: null == shopSettings ? _self.shopSettings : shopSettings // ignore: cast_nullable_to_non_nullable
as ShopSettingsModel,shopDetails: null == shopDetails ? _self.shopDetails : shopDetails // ignore: cast_nullable_to_non_nullable
as UserShopModel,
  ));
}

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserSubscriptionModelCopyWith<$Res>? get subscription {
    if (_self.subscription == null) {
    return null;
  }

  return $UserSubscriptionModelCopyWith<$Res>(_self.subscription!, (value) {
    return _then(_self.copyWith(subscription: value));
  });
}/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShopSettingsModelCopyWith<$Res> get shopSettings {
  
  return $ShopSettingsModelCopyWith<$Res>(_self.shopSettings, (value) {
    return _then(_self.copyWith(shopSettings: value));
  });
}/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserShopModelCopyWith<$Res> get shopDetails {
  
  return $UserShopModelCopyWith<$Res>(_self.shopDetails, (value) {
    return _then(_self.copyWith(shopDetails: value));
  });
}
}


/// @nodoc
mixin _$UserSubscriptionModel {

 String get plan; String get status;@JsonKey(name: 'expiry_date', defaultValue: '') String get expiryDate;@JsonKey(name: 'features', defaultValue: const {}, fromJson: AppPremiumFeatures.fromList, toJson: AppPremiumFeatures.toJsonList) Set<AppPremiumFeatures> get features;@JsonKey(name: 'user_features', defaultValue: const {}, fromJson: AppPremiumFeatures.fromList, toJson: AppPremiumFeatures.toJsonList) Set<AppPremiumFeatures> get userSpecificFeatures;
/// Create a copy of UserSubscriptionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserSubscriptionModelCopyWith<UserSubscriptionModel> get copyWith => _$UserSubscriptionModelCopyWithImpl<UserSubscriptionModel>(this as UserSubscriptionModel, _$identity);

  /// Serializes this UserSubscriptionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserSubscriptionModel&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.status, status) || other.status == status)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate)&&const DeepCollectionEquality().equals(other.features, features)&&const DeepCollectionEquality().equals(other.userSpecificFeatures, userSpecificFeatures));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,plan,status,expiryDate,const DeepCollectionEquality().hash(features),const DeepCollectionEquality().hash(userSpecificFeatures));

@override
String toString() {
  return 'UserSubscriptionModel(plan: $plan, status: $status, expiryDate: $expiryDate, features: $features, userSpecificFeatures: $userSpecificFeatures)';
}


}

/// @nodoc
abstract mixin class $UserSubscriptionModelCopyWith<$Res>  {
  factory $UserSubscriptionModelCopyWith(UserSubscriptionModel value, $Res Function(UserSubscriptionModel) _then) = _$UserSubscriptionModelCopyWithImpl;
@useResult
$Res call({
 String plan, String status,@JsonKey(name: 'expiry_date', defaultValue: '') String expiryDate,@JsonKey(name: 'features', defaultValue: const {}, fromJson: AppPremiumFeatures.fromList, toJson: AppPremiumFeatures.toJsonList) Set<AppPremiumFeatures> features,@JsonKey(name: 'user_features', defaultValue: const {}, fromJson: AppPremiumFeatures.fromList, toJson: AppPremiumFeatures.toJsonList) Set<AppPremiumFeatures> userSpecificFeatures
});




}
/// @nodoc
class _$UserSubscriptionModelCopyWithImpl<$Res>
    implements $UserSubscriptionModelCopyWith<$Res> {
  _$UserSubscriptionModelCopyWithImpl(this._self, this._then);

  final UserSubscriptionModel _self;
  final $Res Function(UserSubscriptionModel) _then;

/// Create a copy of UserSubscriptionModel
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


/// Adds pattern-matching-related methods to [UserSubscriptionModel].
extension UserSubscriptionModelPatterns on UserSubscriptionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserSubscriptionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserSubscriptionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserSubscriptionModel value)  $default,){
final _that = this;
switch (_that) {
case _UserSubscriptionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserSubscriptionModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserSubscriptionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String plan,  String status, @JsonKey(name: 'expiry_date', defaultValue: '')  String expiryDate, @JsonKey(name: 'features', defaultValue: const {}, fromJson: AppPremiumFeatures.fromList, toJson: AppPremiumFeatures.toJsonList)  Set<AppPremiumFeatures> features, @JsonKey(name: 'user_features', defaultValue: const {}, fromJson: AppPremiumFeatures.fromList, toJson: AppPremiumFeatures.toJsonList)  Set<AppPremiumFeatures> userSpecificFeatures)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserSubscriptionModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String plan,  String status, @JsonKey(name: 'expiry_date', defaultValue: '')  String expiryDate, @JsonKey(name: 'features', defaultValue: const {}, fromJson: AppPremiumFeatures.fromList, toJson: AppPremiumFeatures.toJsonList)  Set<AppPremiumFeatures> features, @JsonKey(name: 'user_features', defaultValue: const {}, fromJson: AppPremiumFeatures.fromList, toJson: AppPremiumFeatures.toJsonList)  Set<AppPremiumFeatures> userSpecificFeatures)  $default,) {final _that = this;
switch (_that) {
case _UserSubscriptionModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String plan,  String status, @JsonKey(name: 'expiry_date', defaultValue: '')  String expiryDate, @JsonKey(name: 'features', defaultValue: const {}, fromJson: AppPremiumFeatures.fromList, toJson: AppPremiumFeatures.toJsonList)  Set<AppPremiumFeatures> features, @JsonKey(name: 'user_features', defaultValue: const {}, fromJson: AppPremiumFeatures.fromList, toJson: AppPremiumFeatures.toJsonList)  Set<AppPremiumFeatures> userSpecificFeatures)?  $default,) {final _that = this;
switch (_that) {
case _UserSubscriptionModel() when $default != null:
return $default(_that.plan,_that.status,_that.expiryDate,_that.features,_that.userSpecificFeatures);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserSubscriptionModel implements UserSubscriptionModel {
  const _UserSubscriptionModel({required this.plan, required this.status, @JsonKey(name: 'expiry_date', defaultValue: '') required this.expiryDate, @JsonKey(name: 'features', defaultValue: const {}, fromJson: AppPremiumFeatures.fromList, toJson: AppPremiumFeatures.toJsonList) required final  Set<AppPremiumFeatures> features, @JsonKey(name: 'user_features', defaultValue: const {}, fromJson: AppPremiumFeatures.fromList, toJson: AppPremiumFeatures.toJsonList) required final  Set<AppPremiumFeatures> userSpecificFeatures}): _features = features,_userSpecificFeatures = userSpecificFeatures;
  factory _UserSubscriptionModel.fromJson(Map<String, dynamic> json) => _$UserSubscriptionModelFromJson(json);

@override final  String plan;
@override final  String status;
@override@JsonKey(name: 'expiry_date', defaultValue: '') final  String expiryDate;
 final  Set<AppPremiumFeatures> _features;
@override@JsonKey(name: 'features', defaultValue: const {}, fromJson: AppPremiumFeatures.fromList, toJson: AppPremiumFeatures.toJsonList) Set<AppPremiumFeatures> get features {
  if (_features is EqualUnmodifiableSetView) return _features;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_features);
}

 final  Set<AppPremiumFeatures> _userSpecificFeatures;
@override@JsonKey(name: 'user_features', defaultValue: const {}, fromJson: AppPremiumFeatures.fromList, toJson: AppPremiumFeatures.toJsonList) Set<AppPremiumFeatures> get userSpecificFeatures {
  if (_userSpecificFeatures is EqualUnmodifiableSetView) return _userSpecificFeatures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_userSpecificFeatures);
}


/// Create a copy of UserSubscriptionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserSubscriptionModelCopyWith<_UserSubscriptionModel> get copyWith => __$UserSubscriptionModelCopyWithImpl<_UserSubscriptionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserSubscriptionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserSubscriptionModel&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.status, status) || other.status == status)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate)&&const DeepCollectionEquality().equals(other._features, _features)&&const DeepCollectionEquality().equals(other._userSpecificFeatures, _userSpecificFeatures));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,plan,status,expiryDate,const DeepCollectionEquality().hash(_features),const DeepCollectionEquality().hash(_userSpecificFeatures));

@override
String toString() {
  return 'UserSubscriptionModel(plan: $plan, status: $status, expiryDate: $expiryDate, features: $features, userSpecificFeatures: $userSpecificFeatures)';
}


}

/// @nodoc
abstract mixin class _$UserSubscriptionModelCopyWith<$Res> implements $UserSubscriptionModelCopyWith<$Res> {
  factory _$UserSubscriptionModelCopyWith(_UserSubscriptionModel value, $Res Function(_UserSubscriptionModel) _then) = __$UserSubscriptionModelCopyWithImpl;
@override @useResult
$Res call({
 String plan, String status,@JsonKey(name: 'expiry_date', defaultValue: '') String expiryDate,@JsonKey(name: 'features', defaultValue: const {}, fromJson: AppPremiumFeatures.fromList, toJson: AppPremiumFeatures.toJsonList) Set<AppPremiumFeatures> features,@JsonKey(name: 'user_features', defaultValue: const {}, fromJson: AppPremiumFeatures.fromList, toJson: AppPremiumFeatures.toJsonList) Set<AppPremiumFeatures> userSpecificFeatures
});




}
/// @nodoc
class __$UserSubscriptionModelCopyWithImpl<$Res>
    implements _$UserSubscriptionModelCopyWith<$Res> {
  __$UserSubscriptionModelCopyWithImpl(this._self, this._then);

  final _UserSubscriptionModel _self;
  final $Res Function(_UserSubscriptionModel) _then;

/// Create a copy of UserSubscriptionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? plan = null,Object? status = null,Object? expiryDate = null,Object? features = null,Object? userSpecificFeatures = null,}) {
  return _then(_UserSubscriptionModel(
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
mixin _$UserPasswordSettingsModel {

 SecretPasswordLocations get location; UserPasswordSettingRole get role;
/// Create a copy of UserPasswordSettingsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserPasswordSettingsModelCopyWith<UserPasswordSettingsModel> get copyWith => _$UserPasswordSettingsModelCopyWithImpl<UserPasswordSettingsModel>(this as UserPasswordSettingsModel, _$identity);

  /// Serializes this UserPasswordSettingsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserPasswordSettingsModel&&(identical(other.location, location) || other.location == location)&&(identical(other.role, role) || other.role == role));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,location,role);

@override
String toString() {
  return 'UserPasswordSettingsModel(location: $location, role: $role)';
}


}

/// @nodoc
abstract mixin class $UserPasswordSettingsModelCopyWith<$Res>  {
  factory $UserPasswordSettingsModelCopyWith(UserPasswordSettingsModel value, $Res Function(UserPasswordSettingsModel) _then) = _$UserPasswordSettingsModelCopyWithImpl;
@useResult
$Res call({
 SecretPasswordLocations location, UserPasswordSettingRole role
});




}
/// @nodoc
class _$UserPasswordSettingsModelCopyWithImpl<$Res>
    implements $UserPasswordSettingsModelCopyWith<$Res> {
  _$UserPasswordSettingsModelCopyWithImpl(this._self, this._then);

  final UserPasswordSettingsModel _self;
  final $Res Function(UserPasswordSettingsModel) _then;

/// Create a copy of UserPasswordSettingsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? location = null,Object? role = null,}) {
  return _then(_self.copyWith(
location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as SecretPasswordLocations,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as UserPasswordSettingRole,
  ));
}

}


/// Adds pattern-matching-related methods to [UserPasswordSettingsModel].
extension UserPasswordSettingsModelPatterns on UserPasswordSettingsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserPasswordSettingsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserPasswordSettingsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserPasswordSettingsModel value)  $default,){
final _that = this;
switch (_that) {
case _UserPasswordSettingsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserPasswordSettingsModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserPasswordSettingsModel() when $default != null:
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
case _UserPasswordSettingsModel() when $default != null:
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
case _UserPasswordSettingsModel():
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
case _UserPasswordSettingsModel() when $default != null:
return $default(_that.location,_that.role);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserPasswordSettingsModel implements UserPasswordSettingsModel {
  const _UserPasswordSettingsModel({required this.location, required this.role});
  factory _UserPasswordSettingsModel.fromJson(Map<String, dynamic> json) => _$UserPasswordSettingsModelFromJson(json);

@override final  SecretPasswordLocations location;
@override final  UserPasswordSettingRole role;

/// Create a copy of UserPasswordSettingsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserPasswordSettingsModelCopyWith<_UserPasswordSettingsModel> get copyWith => __$UserPasswordSettingsModelCopyWithImpl<_UserPasswordSettingsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserPasswordSettingsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserPasswordSettingsModel&&(identical(other.location, location) || other.location == location)&&(identical(other.role, role) || other.role == role));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,location,role);

@override
String toString() {
  return 'UserPasswordSettingsModel(location: $location, role: $role)';
}


}

/// @nodoc
abstract mixin class _$UserPasswordSettingsModelCopyWith<$Res> implements $UserPasswordSettingsModelCopyWith<$Res> {
  factory _$UserPasswordSettingsModelCopyWith(_UserPasswordSettingsModel value, $Res Function(_UserPasswordSettingsModel) _then) = __$UserPasswordSettingsModelCopyWithImpl;
@override @useResult
$Res call({
 SecretPasswordLocations location, UserPasswordSettingRole role
});




}
/// @nodoc
class __$UserPasswordSettingsModelCopyWithImpl<$Res>
    implements _$UserPasswordSettingsModelCopyWith<$Res> {
  __$UserPasswordSettingsModelCopyWithImpl(this._self, this._then);

  final _UserPasswordSettingsModel _self;
  final $Res Function(_UserPasswordSettingsModel) _then;

/// Create a copy of UserPasswordSettingsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? location = null,Object? role = null,}) {
  return _then(_UserPasswordSettingsModel(
location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as SecretPasswordLocations,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as UserPasswordSettingRole,
  ));
}


}

// dart format on
