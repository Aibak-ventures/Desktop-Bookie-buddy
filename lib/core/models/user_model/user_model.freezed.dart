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
  int get id => throw _privateConstructorUsedError; // user info
  @JsonKey(name: 'full_name')
  String get userName => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError; // Shop Info
  @JsonKey(name: 'shop_id')
  int? get shopId => throw _privateConstructorUsedError;
  @JsonKey(name: 'shop_name', defaultValue: 'Shop')
  String get shopName => throw _privateConstructorUsedError;
  @JsonKey(name: 'shop_phone', defaultValue: '9999999999')
  String get shopPhone => throw _privateConstructorUsedError;
  @JsonKey(name: 'shop_address', defaultValue: 'Address')
  String get shopAddress => throw _privateConstructorUsedError;
  @JsonKey(name: 'gst_number')
  String? get gstNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'shop_image')
  String? get shopeImage => throw _privateConstructorUsedError;
  @JsonKey(name: 'terms_and_conditions')
  List<String> get termsAndConditions =>
      throw _privateConstructorUsedError; // Account Control
  @JsonKey(defaultValue: false)
  bool get block => throw _privateConstructorUsedError;
  @JsonKey(name: 'multiple_shops', defaultValue: false)
  bool get haveMultipleShops => throw _privateConstructorUsedError;
  String? get role => throw _privateConstructorUsedError;

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
      @JsonKey(name: 'full_name') String userName,
      String phone,
      String? email,
      @JsonKey(name: 'shop_id') int? shopId,
      @JsonKey(name: 'shop_name', defaultValue: 'Shop') String shopName,
      @JsonKey(name: 'shop_phone', defaultValue: '9999999999') String shopPhone,
      @JsonKey(name: 'shop_address', defaultValue: 'Address')
      String shopAddress,
      @JsonKey(name: 'gst_number') String? gstNo,
      @JsonKey(name: 'shop_image') String? shopeImage,
      @JsonKey(name: 'terms_and_conditions') List<String> termsAndConditions,
      @JsonKey(defaultValue: false) bool block,
      @JsonKey(name: 'multiple_shops', defaultValue: false)
      bool haveMultipleShops,
      String? role});
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
    Object? userName = null,
    Object? phone = null,
    Object? email = freezed,
    Object? shopId = freezed,
    Object? shopName = null,
    Object? shopPhone = null,
    Object? shopAddress = null,
    Object? gstNo = freezed,
    Object? shopeImage = freezed,
    Object? termsAndConditions = null,
    Object? block = null,
    Object? haveMultipleShops = null,
    Object? role = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      shopId: freezed == shopId
          ? _value.shopId
          : shopId // ignore: cast_nullable_to_non_nullable
              as int?,
      shopName: null == shopName
          ? _value.shopName
          : shopName // ignore: cast_nullable_to_non_nullable
              as String,
      shopPhone: null == shopPhone
          ? _value.shopPhone
          : shopPhone // ignore: cast_nullable_to_non_nullable
              as String,
      shopAddress: null == shopAddress
          ? _value.shopAddress
          : shopAddress // ignore: cast_nullable_to_non_nullable
              as String,
      gstNo: freezed == gstNo
          ? _value.gstNo
          : gstNo // ignore: cast_nullable_to_non_nullable
              as String?,
      shopeImage: freezed == shopeImage
          ? _value.shopeImage
          : shopeImage // ignore: cast_nullable_to_non_nullable
              as String?,
      termsAndConditions: null == termsAndConditions
          ? _value.termsAndConditions
          : termsAndConditions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      block: null == block
          ? _value.block
          : block // ignore: cast_nullable_to_non_nullable
              as bool,
      haveMultipleShops: null == haveMultipleShops
          ? _value.haveMultipleShops
          : haveMultipleShops // ignore: cast_nullable_to_non_nullable
              as bool,
      role: freezed == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
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
      @JsonKey(name: 'full_name') String userName,
      String phone,
      String? email,
      @JsonKey(name: 'shop_id') int? shopId,
      @JsonKey(name: 'shop_name', defaultValue: 'Shop') String shopName,
      @JsonKey(name: 'shop_phone', defaultValue: '9999999999') String shopPhone,
      @JsonKey(name: 'shop_address', defaultValue: 'Address')
      String shopAddress,
      @JsonKey(name: 'gst_number') String? gstNo,
      @JsonKey(name: 'shop_image') String? shopeImage,
      @JsonKey(name: 'terms_and_conditions') List<String> termsAndConditions,
      @JsonKey(defaultValue: false) bool block,
      @JsonKey(name: 'multiple_shops', defaultValue: false)
      bool haveMultipleShops,
      String? role});
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
    Object? userName = null,
    Object? phone = null,
    Object? email = freezed,
    Object? shopId = freezed,
    Object? shopName = null,
    Object? shopPhone = null,
    Object? shopAddress = null,
    Object? gstNo = freezed,
    Object? shopeImage = freezed,
    Object? termsAndConditions = null,
    Object? block = null,
    Object? haveMultipleShops = null,
    Object? role = freezed,
  }) {
    return _then(_$UserModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      shopId: freezed == shopId
          ? _value.shopId
          : shopId // ignore: cast_nullable_to_non_nullable
              as int?,
      shopName: null == shopName
          ? _value.shopName
          : shopName // ignore: cast_nullable_to_non_nullable
              as String,
      shopPhone: null == shopPhone
          ? _value.shopPhone
          : shopPhone // ignore: cast_nullable_to_non_nullable
              as String,
      shopAddress: null == shopAddress
          ? _value.shopAddress
          : shopAddress // ignore: cast_nullable_to_non_nullable
              as String,
      gstNo: freezed == gstNo
          ? _value.gstNo
          : gstNo // ignore: cast_nullable_to_non_nullable
              as String?,
      shopeImage: freezed == shopeImage
          ? _value.shopeImage
          : shopeImage // ignore: cast_nullable_to_non_nullable
              as String?,
      termsAndConditions: null == termsAndConditions
          ? _value._termsAndConditions
          : termsAndConditions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      block: null == block
          ? _value.block
          : block // ignore: cast_nullable_to_non_nullable
              as bool,
      haveMultipleShops: null == haveMultipleShops
          ? _value.haveMultipleShops
          : haveMultipleShops // ignore: cast_nullable_to_non_nullable
              as bool,
      role: freezed == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelImpl implements _UserModel {
  const _$UserModelImpl(
      {required this.id,
      @JsonKey(name: 'full_name') required this.userName,
      required this.phone,
      this.email,
      @JsonKey(name: 'shop_id') this.shopId,
      @JsonKey(name: 'shop_name', defaultValue: 'Shop') required this.shopName,
      @JsonKey(name: 'shop_phone', defaultValue: '9999999999')
      required this.shopPhone,
      @JsonKey(name: 'shop_address', defaultValue: 'Address')
      required this.shopAddress,
      @JsonKey(name: 'gst_number') this.gstNo,
      @JsonKey(name: 'shop_image') this.shopeImage,
      @JsonKey(name: 'terms_and_conditions')
      final List<String> termsAndConditions = const [],
      @JsonKey(defaultValue: false) required this.block,
      @JsonKey(name: 'multiple_shops', defaultValue: false)
      required this.haveMultipleShops,
      this.role})
      : _termsAndConditions = termsAndConditions;

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  final int id;
// user info
  @override
  @JsonKey(name: 'full_name')
  final String userName;
  @override
  final String phone;
  @override
  final String? email;
// Shop Info
  @override
  @JsonKey(name: 'shop_id')
  final int? shopId;
  @override
  @JsonKey(name: 'shop_name', defaultValue: 'Shop')
  final String shopName;
  @override
  @JsonKey(name: 'shop_phone', defaultValue: '9999999999')
  final String shopPhone;
  @override
  @JsonKey(name: 'shop_address', defaultValue: 'Address')
  final String shopAddress;
  @override
  @JsonKey(name: 'gst_number')
  final String? gstNo;
  @override
  @JsonKey(name: 'shop_image')
  final String? shopeImage;
  final List<String> _termsAndConditions;
  @override
  @JsonKey(name: 'terms_and_conditions')
  List<String> get termsAndConditions {
    if (_termsAndConditions is EqualUnmodifiableListView)
      return _termsAndConditions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_termsAndConditions);
  }

// Account Control
  @override
  @JsonKey(defaultValue: false)
  final bool block;
  @override
  @JsonKey(name: 'multiple_shops', defaultValue: false)
  final bool haveMultipleShops;
  @override
  final String? role;

  @override
  String toString() {
    return 'UserModel(id: $id, userName: $userName, phone: $phone, email: $email, shopId: $shopId, shopName: $shopName, shopPhone: $shopPhone, shopAddress: $shopAddress, gstNo: $gstNo, shopeImage: $shopeImage, termsAndConditions: $termsAndConditions, block: $block, haveMultipleShops: $haveMultipleShops, role: $role)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.shopId, shopId) || other.shopId == shopId) &&
            (identical(other.shopName, shopName) ||
                other.shopName == shopName) &&
            (identical(other.shopPhone, shopPhone) ||
                other.shopPhone == shopPhone) &&
            (identical(other.shopAddress, shopAddress) ||
                other.shopAddress == shopAddress) &&
            (identical(other.gstNo, gstNo) || other.gstNo == gstNo) &&
            (identical(other.shopeImage, shopeImage) ||
                other.shopeImage == shopeImage) &&
            const DeepCollectionEquality()
                .equals(other._termsAndConditions, _termsAndConditions) &&
            (identical(other.block, block) || other.block == block) &&
            (identical(other.haveMultipleShops, haveMultipleShops) ||
                other.haveMultipleShops == haveMultipleShops) &&
            (identical(other.role, role) || other.role == role));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userName,
      phone,
      email,
      shopId,
      shopName,
      shopPhone,
      shopAddress,
      gstNo,
      shopeImage,
      const DeepCollectionEquality().hash(_termsAndConditions),
      block,
      haveMultipleShops,
      role);

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
      @JsonKey(name: 'full_name') required final String userName,
      required final String phone,
      final String? email,
      @JsonKey(name: 'shop_id') final int? shopId,
      @JsonKey(name: 'shop_name', defaultValue: 'Shop')
      required final String shopName,
      @JsonKey(name: 'shop_phone', defaultValue: '9999999999')
      required final String shopPhone,
      @JsonKey(name: 'shop_address', defaultValue: 'Address')
      required final String shopAddress,
      @JsonKey(name: 'gst_number') final String? gstNo,
      @JsonKey(name: 'shop_image') final String? shopeImage,
      @JsonKey(name: 'terms_and_conditions')
      final List<String> termsAndConditions,
      @JsonKey(defaultValue: false) required final bool block,
      @JsonKey(name: 'multiple_shops', defaultValue: false)
      required final bool haveMultipleShops,
      final String? role}) = _$UserModelImpl;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  int get id; // user info
  @override
  @JsonKey(name: 'full_name')
  String get userName;
  @override
  String get phone;
  @override
  String? get email; // Shop Info
  @override
  @JsonKey(name: 'shop_id')
  int? get shopId;
  @override
  @JsonKey(name: 'shop_name', defaultValue: 'Shop')
  String get shopName;
  @override
  @JsonKey(name: 'shop_phone', defaultValue: '9999999999')
  String get shopPhone;
  @override
  @JsonKey(name: 'shop_address', defaultValue: 'Address')
  String get shopAddress;
  @override
  @JsonKey(name: 'gst_number')
  String? get gstNo;
  @override
  @JsonKey(name: 'shop_image')
  String? get shopeImage;
  @override
  @JsonKey(name: 'terms_and_conditions')
  List<String> get termsAndConditions; // Account Control
  @override
  @JsonKey(defaultValue: false)
  bool get block;
  @override
  @JsonKey(name: 'multiple_shops', defaultValue: false)
  bool get haveMultipleShops;
  @override
  String? get role;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
