// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shop_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ShopEntity {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get place => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String? get pincode => throw _privateConstructorUsedError;
  String? get subscriptionStatus => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;

  /// Create a copy of ShopEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShopEntityCopyWith<ShopEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShopEntityCopyWith<$Res> {
  factory $ShopEntityCopyWith(
          ShopEntity value, $Res Function(ShopEntity) then) =
      _$ShopEntityCopyWithImpl<$Res, ShopEntity>;
  @useResult
  $Res call(
      {int id,
      String name,
      String? place,
      String phone,
      String? email,
      String address,
      String? pincode,
      String? subscriptionStatus,
      String? image});
}

/// @nodoc
class _$ShopEntityCopyWithImpl<$Res, $Val extends ShopEntity>
    implements $ShopEntityCopyWith<$Res> {
  _$ShopEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShopEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? place = freezed,
    Object? phone = null,
    Object? email = freezed,
    Object? address = null,
    Object? pincode = freezed,
    Object? subscriptionStatus = freezed,
    Object? image = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      place: freezed == place
          ? _value.place
          : place // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      pincode: freezed == pincode
          ? _value.pincode
          : pincode // ignore: cast_nullable_to_non_nullable
              as String?,
      subscriptionStatus: freezed == subscriptionStatus
          ? _value.subscriptionStatus
          : subscriptionStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ShopEntityImplCopyWith<$Res>
    implements $ShopEntityCopyWith<$Res> {
  factory _$$ShopEntityImplCopyWith(
          _$ShopEntityImpl value, $Res Function(_$ShopEntityImpl) then) =
      __$$ShopEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String? place,
      String phone,
      String? email,
      String address,
      String? pincode,
      String? subscriptionStatus,
      String? image});
}

/// @nodoc
class __$$ShopEntityImplCopyWithImpl<$Res>
    extends _$ShopEntityCopyWithImpl<$Res, _$ShopEntityImpl>
    implements _$$ShopEntityImplCopyWith<$Res> {
  __$$ShopEntityImplCopyWithImpl(
      _$ShopEntityImpl _value, $Res Function(_$ShopEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of ShopEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? place = freezed,
    Object? phone = null,
    Object? email = freezed,
    Object? address = null,
    Object? pincode = freezed,
    Object? subscriptionStatus = freezed,
    Object? image = freezed,
  }) {
    return _then(_$ShopEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      place: freezed == place
          ? _value.place
          : place // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      pincode: freezed == pincode
          ? _value.pincode
          : pincode // ignore: cast_nullable_to_non_nullable
              as String?,
      subscriptionStatus: freezed == subscriptionStatus
          ? _value.subscriptionStatus
          : subscriptionStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ShopEntityImpl implements _ShopEntity {
  const _$ShopEntityImpl(
      {required this.id,
      required this.name,
      this.place,
      required this.phone,
      this.email,
      required this.address,
      this.pincode,
      this.subscriptionStatus,
      this.image});

  @override
  final int id;
  @override
  final String name;
  @override
  final String? place;
  @override
  final String phone;
  @override
  final String? email;
  @override
  final String address;
  @override
  final String? pincode;
  @override
  final String? subscriptionStatus;
  @override
  final String? image;

  @override
  String toString() {
    return 'ShopEntity(id: $id, name: $name, place: $place, phone: $phone, email: $email, address: $address, pincode: $pincode, subscriptionStatus: $subscriptionStatus, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShopEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.place, place) || other.place == place) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.pincode, pincode) || other.pincode == pincode) &&
            (identical(other.subscriptionStatus, subscriptionStatus) ||
                other.subscriptionStatus == subscriptionStatus) &&
            (identical(other.image, image) || other.image == image));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, place, phone, email,
      address, pincode, subscriptionStatus, image);

  /// Create a copy of ShopEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShopEntityImplCopyWith<_$ShopEntityImpl> get copyWith =>
      __$$ShopEntityImplCopyWithImpl<_$ShopEntityImpl>(this, _$identity);
}

abstract class _ShopEntity implements ShopEntity {
  const factory _ShopEntity(
      {required final int id,
      required final String name,
      final String? place,
      required final String phone,
      final String? email,
      required final String address,
      final String? pincode,
      final String? subscriptionStatus,
      final String? image}) = _$ShopEntityImpl;

  @override
  int get id;
  @override
  String get name;
  @override
  String? get place;
  @override
  String get phone;
  @override
  String? get email;
  @override
  String get address;
  @override
  String? get pincode;
  @override
  String? get subscriptionStatus;
  @override
  String? get image;

  /// Create a copy of ShopEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShopEntityImplCopyWith<_$ShopEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
