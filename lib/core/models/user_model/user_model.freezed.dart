// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'full_name')
  String get firstName => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_name', defaultValue: '')
  String get lastName => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  @JsonKey(name: 'shop_role', fromJson: ShopRole.fromString)
  ShopRole? get shopRole => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: false)
  bool get block => throw _privateConstructorUsedError;
  @JsonKey(name: 'multiple_shops', defaultValue: false)
  bool get haveMultipleShops => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_active_notification', defaultValue: false)
  bool get isNotificationActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'subscription')
  UserSubscriptionModel? get subscription => throw _privateConstructorUsedError;
  @JsonKey(name: 'password_settings', fromJson: _passwordSettingsFromJson)
  List<UserPasswordSettingsModel> get passwordSettings =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'shop_settings')
  ShopSettingsModel get shopSettings => throw _privateConstructorUsedError;
  @JsonKey(name: 'shop')
  UserShopModel get shopDetails => throw _privateConstructorUsedError;

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'full_name') String firstName,
      @JsonKey(name: 'last_name', defaultValue: '') String lastName,
      String phone,
      @JsonKey(name: 'shop_role', fromJson: ShopRole.fromString)
      ShopRole? shopRole,
      @JsonKey(defaultValue: false) bool block,
      @JsonKey(name: 'multiple_shops', defaultValue: false)
      bool haveMultipleShops,
      @JsonKey(name: 'has_active_notification', defaultValue: false)
      bool isNotificationActive,
      @JsonKey(name: 'subscription') UserSubscriptionModel? subscription,
      @JsonKey(name: 'password_settings', fromJson: _passwordSettingsFromJson)
      List<UserPasswordSettingsModel> passwordSettings,
      @JsonKey(name: 'shop_settings') ShopSettingsModel shopSettings,
      @JsonKey(name: 'shop') UserShopModel shopDetails});

  $UserSubscriptionModelCopyWith<$Res>? get subscription;
  $ShopSettingsModelCopyWith<$Res> get shopSettings;
  $UserShopModelCopyWith<$Res> get shopDetails;
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? phone = null,
    Object? shopRole = freezed,
    Object? block = null,
    Object? haveMultipleShops = null,
    Object? isNotificationActive = null,
    Object? subscription = freezed,
    Object? passwordSettings = null,
    Object? shopSettings = null,
    Object? shopDetails = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      shopRole: freezed == shopRole
          ? _value.shopRole
          : shopRole // ignore: cast_nullable_to_non_nullable
              as ShopRole?,
      block: null == block
          ? _value.block
          : block // ignore: cast_nullable_to_non_nullable
              as bool,
      haveMultipleShops: null == haveMultipleShops
          ? _value.haveMultipleShops
          : haveMultipleShops // ignore: cast_nullable_to_non_nullable
              as bool,
      isNotificationActive: null == isNotificationActive
          ? _value.isNotificationActive
          : isNotificationActive // ignore: cast_nullable_to_non_nullable
              as bool,
      subscription: freezed == subscription
          ? _value.subscription
          : subscription // ignore: cast_nullable_to_non_nullable
              as UserSubscriptionModel?,
      passwordSettings: null == passwordSettings
          ? _value.passwordSettings
          : passwordSettings // ignore: cast_nullable_to_non_nullable
              as List<UserPasswordSettingsModel>,
      shopSettings: null == shopSettings
          ? _value.shopSettings
          : shopSettings // ignore: cast_nullable_to_non_nullable
              as ShopSettingsModel,
      shopDetails: null == shopDetails
          ? _value.shopDetails
          : shopDetails // ignore: cast_nullable_to_non_nullable
              as UserShopModel,
    ) as $Val);
  }

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserSubscriptionModelCopyWith<$Res>? get subscription {
    if (_value.subscription == null) {
      return null;
    }

    return $UserSubscriptionModelCopyWith<$Res>(_value.subscription!, (value) {
      return _then(_value.copyWith(subscription: value) as $Val);
    });
  }

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ShopSettingsModelCopyWith<$Res> get shopSettings {
    return $ShopSettingsModelCopyWith<$Res>(_value.shopSettings, (value) {
      return _then(_value.copyWith(shopSettings: value) as $Val);
    });
  }

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserShopModelCopyWith<$Res> get shopDetails {
    return $UserShopModelCopyWith<$Res>(_value.shopDetails, (value) {
      return _then(_value.copyWith(shopDetails: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
          _$UserModelImpl value, $Res Function(_$UserModelImpl) then) =
      __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'full_name') String firstName,
      @JsonKey(name: 'last_name', defaultValue: '') String lastName,
      String phone,
      @JsonKey(name: 'shop_role', fromJson: ShopRole.fromString)
      ShopRole? shopRole,
      @JsonKey(defaultValue: false) bool block,
      @JsonKey(name: 'multiple_shops', defaultValue: false)
      bool haveMultipleShops,
      @JsonKey(name: 'has_active_notification', defaultValue: false)
      bool isNotificationActive,
      @JsonKey(name: 'subscription') UserSubscriptionModel? subscription,
      @JsonKey(name: 'password_settings', fromJson: _passwordSettingsFromJson)
      List<UserPasswordSettingsModel> passwordSettings,
      @JsonKey(name: 'shop_settings') ShopSettingsModel shopSettings,
      @JsonKey(name: 'shop') UserShopModel shopDetails});

  @override
  $UserSubscriptionModelCopyWith<$Res>? get subscription;
  @override
  $ShopSettingsModelCopyWith<$Res> get shopSettings;
  @override
  $UserShopModelCopyWith<$Res> get shopDetails;
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
      _$UserModelImpl _value, $Res Function(_$UserModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? phone = null,
    Object? shopRole = freezed,
    Object? block = null,
    Object? haveMultipleShops = null,
    Object? isNotificationActive = null,
    Object? subscription = freezed,
    Object? passwordSettings = null,
    Object? shopSettings = null,
    Object? shopDetails = null,
  }) {
    return _then(_$UserModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      shopRole: freezed == shopRole
          ? _value.shopRole
          : shopRole // ignore: cast_nullable_to_non_nullable
              as ShopRole?,
      block: null == block
          ? _value.block
          : block // ignore: cast_nullable_to_non_nullable
              as bool,
      haveMultipleShops: null == haveMultipleShops
          ? _value.haveMultipleShops
          : haveMultipleShops // ignore: cast_nullable_to_non_nullable
              as bool,
      isNotificationActive: null == isNotificationActive
          ? _value.isNotificationActive
          : isNotificationActive // ignore: cast_nullable_to_non_nullable
              as bool,
      subscription: freezed == subscription
          ? _value.subscription
          : subscription // ignore: cast_nullable_to_non_nullable
              as UserSubscriptionModel?,
      passwordSettings: null == passwordSettings
          ? _value._passwordSettings
          : passwordSettings // ignore: cast_nullable_to_non_nullable
              as List<UserPasswordSettingsModel>,
      shopSettings: null == shopSettings
          ? _value.shopSettings
          : shopSettings // ignore: cast_nullable_to_non_nullable
              as ShopSettingsModel,
      shopDetails: null == shopDetails
          ? _value.shopDetails
          : shopDetails // ignore: cast_nullable_to_non_nullable
              as UserShopModel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelImpl implements _UserModel {
  const _$UserModelImpl(
      {required this.id,
      @JsonKey(name: 'full_name') required this.firstName,
      @JsonKey(name: 'last_name', defaultValue: '') required this.lastName,
      required this.phone,
      @JsonKey(name: 'shop_role', fromJson: ShopRole.fromString) this.shopRole,
      @JsonKey(defaultValue: false) required this.block,
      @JsonKey(name: 'multiple_shops', defaultValue: false)
      required this.haveMultipleShops,
      @JsonKey(name: 'has_active_notification', defaultValue: false)
      required this.isNotificationActive,
      @JsonKey(name: 'subscription') this.subscription,
      @JsonKey(name: 'password_settings', fromJson: _passwordSettingsFromJson)
      required final List<UserPasswordSettingsModel> passwordSettings,
      @JsonKey(name: 'shop_settings') required this.shopSettings,
      @JsonKey(name: 'shop') required this.shopDetails})
      : _passwordSettings = passwordSettings;

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'full_name')
  final String firstName;
  @override
  @JsonKey(name: 'last_name', defaultValue: '')
  final String lastName;
  @override
  final String phone;
  @override
  @JsonKey(name: 'shop_role', fromJson: ShopRole.fromString)
  final ShopRole? shopRole;
  @override
  @JsonKey(defaultValue: false)
  final bool block;
  @override
  @JsonKey(name: 'multiple_shops', defaultValue: false)
  final bool haveMultipleShops;
  @override
  @JsonKey(name: 'has_active_notification', defaultValue: false)
  final bool isNotificationActive;
  @override
  @JsonKey(name: 'subscription')
  final UserSubscriptionModel? subscription;
  final List<UserPasswordSettingsModel> _passwordSettings;
  @override
  @JsonKey(name: 'password_settings', fromJson: _passwordSettingsFromJson)
  List<UserPasswordSettingsModel> get passwordSettings {
    if (_passwordSettings is EqualUnmodifiableListView)
      return _passwordSettings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_passwordSettings);
  }

  @override
  @JsonKey(name: 'shop_settings')
  final ShopSettingsModel shopSettings;
  @override
  @JsonKey(name: 'shop')
  final UserShopModel shopDetails;

  @override
  String toString() {
    return 'UserModel(id: $id, firstName: $firstName, lastName: $lastName, phone: $phone, shopRole: $shopRole, block: $block, haveMultipleShops: $haveMultipleShops, isNotificationActive: $isNotificationActive, subscription: $subscription, passwordSettings: $passwordSettings, shopSettings: $shopSettings, shopDetails: $shopDetails)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.shopRole, shopRole) ||
                other.shopRole == shopRole) &&
            (identical(other.block, block) || other.block == block) &&
            (identical(other.haveMultipleShops, haveMultipleShops) ||
                other.haveMultipleShops == haveMultipleShops) &&
            (identical(other.isNotificationActive, isNotificationActive) ||
                other.isNotificationActive == isNotificationActive) &&
            (identical(other.subscription, subscription) ||
                other.subscription == subscription) &&
            const DeepCollectionEquality()
                .equals(other._passwordSettings, _passwordSettings) &&
            (identical(other.shopSettings, shopSettings) ||
                other.shopSettings == shopSettings) &&
            (identical(other.shopDetails, shopDetails) ||
                other.shopDetails == shopDetails));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      firstName,
      lastName,
      phone,
      shopRole,
      block,
      haveMultipleShops,
      isNotificationActive,
      subscription,
      const DeepCollectionEquality().hash(_passwordSettings),
      shopSettings,
      shopDetails);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(
      this,
    );
  }
}

abstract class _UserModel implements UserModel {
  const factory _UserModel(
      {required final int id,
      @JsonKey(name: 'full_name') required final String firstName,
      @JsonKey(name: 'last_name', defaultValue: '')
      required final String lastName,
      required final String phone,
      @JsonKey(name: 'shop_role', fromJson: ShopRole.fromString)
      final ShopRole? shopRole,
      @JsonKey(defaultValue: false) required final bool block,
      @JsonKey(name: 'multiple_shops', defaultValue: false)
      required final bool haveMultipleShops,
      @JsonKey(name: 'has_active_notification', defaultValue: false)
      required final bool isNotificationActive,
      @JsonKey(name: 'subscription') final UserSubscriptionModel? subscription,
      @JsonKey(name: 'password_settings', fromJson: _passwordSettingsFromJson)
      required final List<UserPasswordSettingsModel> passwordSettings,
      @JsonKey(name: 'shop_settings')
      required final ShopSettingsModel shopSettings,
      @JsonKey(name: 'shop')
      required final UserShopModel shopDetails}) = _$UserModelImpl;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'full_name')
  String get firstName;
  @override
  @JsonKey(name: 'last_name', defaultValue: '')
  String get lastName;
  @override
  String get phone;
  @override
  @JsonKey(name: 'shop_role', fromJson: ShopRole.fromString)
  ShopRole? get shopRole;
  @override
  @JsonKey(defaultValue: false)
  bool get block;
  @override
  @JsonKey(name: 'multiple_shops', defaultValue: false)
  bool get haveMultipleShops;
  @override
  @JsonKey(name: 'has_active_notification', defaultValue: false)
  bool get isNotificationActive;
  @override
  @JsonKey(name: 'subscription')
  UserSubscriptionModel? get subscription;
  @override
  @JsonKey(name: 'password_settings', fromJson: _passwordSettingsFromJson)
  List<UserPasswordSettingsModel> get passwordSettings;
  @override
  @JsonKey(name: 'shop_settings')
  ShopSettingsModel get shopSettings;
  @override
  @JsonKey(name: 'shop')
  UserShopModel get shopDetails;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserSubscriptionModel _$UserSubscriptionModelFromJson(
    Map<String, dynamic> json) {
  return _UserSubscriptionModel.fromJson(json);
}

/// @nodoc
mixin _$UserSubscriptionModel {
  String get plan => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  List<String> get features => throw _privateConstructorUsedError;
  @JsonKey(name: 'expiry_date')
  String? get expiryDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'days_remaining')
  int? get daysRemaining => throw _privateConstructorUsedError;

  /// Serializes this UserSubscriptionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserSubscriptionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserSubscriptionModelCopyWith<UserSubscriptionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserSubscriptionModelCopyWith<$Res> {
  factory $UserSubscriptionModelCopyWith(UserSubscriptionModel value,
          $Res Function(UserSubscriptionModel) then) =
      _$UserSubscriptionModelCopyWithImpl<$Res, UserSubscriptionModel>;
  @useResult
  $Res call(
      {String plan,
      String status,
      List<String> features,
      @JsonKey(name: 'expiry_date') String? expiryDate,
      @JsonKey(name: 'days_remaining') int? daysRemaining});
}

/// @nodoc
class _$UserSubscriptionModelCopyWithImpl<$Res,
        $Val extends UserSubscriptionModel>
    implements $UserSubscriptionModelCopyWith<$Res> {
  _$UserSubscriptionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserSubscriptionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? plan = null,
    Object? status = null,
    Object? features = null,
    Object? expiryDate = freezed,
    Object? daysRemaining = freezed,
  }) {
    return _then(_value.copyWith(
      plan: null == plan
          ? _value.plan
          : plan // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      features: null == features
          ? _value.features
          : features // ignore: cast_nullable_to_non_nullable
              as List<String>,
      expiryDate: freezed == expiryDate
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as String?,
      daysRemaining: freezed == daysRemaining
          ? _value.daysRemaining
          : daysRemaining // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserSubscriptionModelImplCopyWith<$Res>
    implements $UserSubscriptionModelCopyWith<$Res> {
  factory _$$UserSubscriptionModelImplCopyWith(
          _$UserSubscriptionModelImpl value,
          $Res Function(_$UserSubscriptionModelImpl) then) =
      __$$UserSubscriptionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String plan,
      String status,
      List<String> features,
      @JsonKey(name: 'expiry_date') String? expiryDate,
      @JsonKey(name: 'days_remaining') int? daysRemaining});
}

/// @nodoc
class __$$UserSubscriptionModelImplCopyWithImpl<$Res>
    extends _$UserSubscriptionModelCopyWithImpl<$Res,
        _$UserSubscriptionModelImpl>
    implements _$$UserSubscriptionModelImplCopyWith<$Res> {
  __$$UserSubscriptionModelImplCopyWithImpl(_$UserSubscriptionModelImpl _value,
      $Res Function(_$UserSubscriptionModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserSubscriptionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? plan = null,
    Object? status = null,
    Object? features = null,
    Object? expiryDate = freezed,
    Object? daysRemaining = freezed,
  }) {
    return _then(_$UserSubscriptionModelImpl(
      plan: null == plan
          ? _value.plan
          : plan // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      features: null == features
          ? _value._features
          : features // ignore: cast_nullable_to_non_nullable
              as List<String>,
      expiryDate: freezed == expiryDate
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as String?,
      daysRemaining: freezed == daysRemaining
          ? _value.daysRemaining
          : daysRemaining // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserSubscriptionModelImpl implements _UserSubscriptionModel {
  const _$UserSubscriptionModelImpl(
      {required this.plan,
      required this.status,
      required final List<String> features,
      @JsonKey(name: 'expiry_date') this.expiryDate,
      @JsonKey(name: 'days_remaining') this.daysRemaining})
      : _features = features;

  factory _$UserSubscriptionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserSubscriptionModelImplFromJson(json);

  @override
  final String plan;
  @override
  final String status;
  final List<String> _features;
  @override
  List<String> get features {
    if (_features is EqualUnmodifiableListView) return _features;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_features);
  }

  @override
  @JsonKey(name: 'expiry_date')
  final String? expiryDate;
  @override
  @JsonKey(name: 'days_remaining')
  final int? daysRemaining;

  @override
  String toString() {
    return 'UserSubscriptionModel(plan: $plan, status: $status, features: $features, expiryDate: $expiryDate, daysRemaining: $daysRemaining)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserSubscriptionModelImpl &&
            (identical(other.plan, plan) || other.plan == plan) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._features, _features) &&
            (identical(other.expiryDate, expiryDate) ||
                other.expiryDate == expiryDate) &&
            (identical(other.daysRemaining, daysRemaining) ||
                other.daysRemaining == daysRemaining));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      plan,
      status,
      const DeepCollectionEquality().hash(_features),
      expiryDate,
      daysRemaining);

  /// Create a copy of UserSubscriptionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserSubscriptionModelImplCopyWith<_$UserSubscriptionModelImpl>
      get copyWith => __$$UserSubscriptionModelImplCopyWithImpl<
          _$UserSubscriptionModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserSubscriptionModelImplToJson(
      this,
    );
  }
}

abstract class _UserSubscriptionModel implements UserSubscriptionModel {
  const factory _UserSubscriptionModel(
          {required final String plan,
          required final String status,
          required final List<String> features,
          @JsonKey(name: 'expiry_date') final String? expiryDate,
          @JsonKey(name: 'days_remaining') final int? daysRemaining}) =
      _$UserSubscriptionModelImpl;

  factory _UserSubscriptionModel.fromJson(Map<String, dynamic> json) =
      _$UserSubscriptionModelImpl.fromJson;

  @override
  String get plan;
  @override
  String get status;
  @override
  List<String> get features;
  @override
  @JsonKey(name: 'expiry_date')
  String? get expiryDate;
  @override
  @JsonKey(name: 'days_remaining')
  int? get daysRemaining;

  /// Create a copy of UserSubscriptionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserSubscriptionModelImplCopyWith<_$UserSubscriptionModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

UserPasswordSettingsModel _$UserPasswordSettingsModelFromJson(
    Map<String, dynamic> json) {
  return _UserPasswordSettingsModel.fromJson(json);
}

/// @nodoc
mixin _$UserPasswordSettingsModel {
  SecretPasswordLocations get location => throw _privateConstructorUsedError;
  UserPasswordSettingRole get role => throw _privateConstructorUsedError;

  /// Serializes this UserPasswordSettingsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserPasswordSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserPasswordSettingsModelCopyWith<UserPasswordSettingsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserPasswordSettingsModelCopyWith<$Res> {
  factory $UserPasswordSettingsModelCopyWith(UserPasswordSettingsModel value,
          $Res Function(UserPasswordSettingsModel) then) =
      _$UserPasswordSettingsModelCopyWithImpl<$Res, UserPasswordSettingsModel>;
  @useResult
  $Res call({SecretPasswordLocations location, UserPasswordSettingRole role});
}

/// @nodoc
class _$UserPasswordSettingsModelCopyWithImpl<$Res,
        $Val extends UserPasswordSettingsModel>
    implements $UserPasswordSettingsModelCopyWith<$Res> {
  _$UserPasswordSettingsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserPasswordSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = null,
    Object? role = null,
  }) {
    return _then(_value.copyWith(
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as SecretPasswordLocations,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as UserPasswordSettingRole,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserPasswordSettingsModelImplCopyWith<$Res>
    implements $UserPasswordSettingsModelCopyWith<$Res> {
  factory _$$UserPasswordSettingsModelImplCopyWith(
          _$UserPasswordSettingsModelImpl value,
          $Res Function(_$UserPasswordSettingsModelImpl) then) =
      __$$UserPasswordSettingsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SecretPasswordLocations location, UserPasswordSettingRole role});
}

/// @nodoc
class __$$UserPasswordSettingsModelImplCopyWithImpl<$Res>
    extends _$UserPasswordSettingsModelCopyWithImpl<$Res,
        _$UserPasswordSettingsModelImpl>
    implements _$$UserPasswordSettingsModelImplCopyWith<$Res> {
  __$$UserPasswordSettingsModelImplCopyWithImpl(
      _$UserPasswordSettingsModelImpl _value,
      $Res Function(_$UserPasswordSettingsModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserPasswordSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = null,
    Object? role = null,
  }) {
    return _then(_$UserPasswordSettingsModelImpl(
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as SecretPasswordLocations,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as UserPasswordSettingRole,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserPasswordSettingsModelImpl implements _UserPasswordSettingsModel {
  const _$UserPasswordSettingsModelImpl(
      {required this.location, required this.role});

  factory _$UserPasswordSettingsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserPasswordSettingsModelImplFromJson(json);

  @override
  final SecretPasswordLocations location;
  @override
  final UserPasswordSettingRole role;

  @override
  String toString() {
    return 'UserPasswordSettingsModel(location: $location, role: $role)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserPasswordSettingsModelImpl &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.role, role) || other.role == role));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, location, role);

  /// Create a copy of UserPasswordSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserPasswordSettingsModelImplCopyWith<_$UserPasswordSettingsModelImpl>
      get copyWith => __$$UserPasswordSettingsModelImplCopyWithImpl<
          _$UserPasswordSettingsModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserPasswordSettingsModelImplToJson(
      this,
    );
  }
}

abstract class _UserPasswordSettingsModel implements UserPasswordSettingsModel {
  const factory _UserPasswordSettingsModel(
          {required final SecretPasswordLocations location,
          required final UserPasswordSettingRole role}) =
      _$UserPasswordSettingsModelImpl;

  factory _UserPasswordSettingsModel.fromJson(Map<String, dynamic> json) =
      _$UserPasswordSettingsModelImpl.fromJson;

  @override
  SecretPasswordLocations get location;
  @override
  UserPasswordSettingRole get role;

  /// Create a copy of UserPasswordSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserPasswordSettingsModelImplCopyWith<_$UserPasswordSettingsModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
