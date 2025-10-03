// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shop_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ShopModel _$ShopModelFromJson(Map<String, dynamic> json) {
  return _ShopModel.fromJson(json);
}

/// @nodoc
mixin _$ShopModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get place => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: 'Address not available')
  String get address => throw _privateConstructorUsedError;
  @JsonKey(name: 'pincode')
  String? get pincode => throw _privateConstructorUsedError;
  @JsonKey(name: 'subscription_status')
  String? get subscriptionStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'img')
  String? get image => throw _privateConstructorUsedError;

  /// Serializes this ShopModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ShopModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShopModelCopyWith<ShopModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShopModelCopyWith<$Res> {
  factory $ShopModelCopyWith(ShopModel value, $Res Function(ShopModel) then) =
      _$ShopModelCopyWithImpl<$Res, ShopModel>;
  @useResult
  $Res call({
    int id,
    String name,
    String? place,
    String phone,
    String? email,
    @JsonKey(defaultValue: 'Address not available') String address,
    @JsonKey(name: 'pincode') String? pincode,
    @JsonKey(name: 'subscription_status') String? subscriptionStatus,
    @JsonKey(name: 'img') String? image,
  });
}

/// @nodoc
class _$ShopModelCopyWithImpl<$Res, $Val extends ShopModel>
    implements $ShopModelCopyWith<$Res> {
  _$ShopModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShopModel
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
    return _then(
      _value.copyWith(
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ShopModelImplCopyWith<$Res>
    implements $ShopModelCopyWith<$Res> {
  factory _$$ShopModelImplCopyWith(
    _$ShopModelImpl value,
    $Res Function(_$ShopModelImpl) then,
  ) = __$$ShopModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    String? place,
    String phone,
    String? email,
    @JsonKey(defaultValue: 'Address not available') String address,
    @JsonKey(name: 'pincode') String? pincode,
    @JsonKey(name: 'subscription_status') String? subscriptionStatus,
    @JsonKey(name: 'img') String? image,
  });
}

/// @nodoc
class __$$ShopModelImplCopyWithImpl<$Res>
    extends _$ShopModelCopyWithImpl<$Res, _$ShopModelImpl>
    implements _$$ShopModelImplCopyWith<$Res> {
  __$$ShopModelImplCopyWithImpl(
    _$ShopModelImpl _value,
    $Res Function(_$ShopModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ShopModel
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
    return _then(
      _$ShopModelImpl(
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
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ShopModelImpl implements _ShopModel {
  const _$ShopModelImpl({
    required this.id,
    required this.name,
    this.place,
    required this.phone,
    this.email,
    @JsonKey(defaultValue: 'Address not available') required this.address,
    @JsonKey(name: 'pincode') this.pincode,
    @JsonKey(name: 'subscription_status') this.subscriptionStatus,
    @JsonKey(name: 'img') this.image,
  });

  factory _$ShopModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShopModelImplFromJson(json);

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
  @JsonKey(defaultValue: 'Address not available')
  final String address;
  @override
  @JsonKey(name: 'pincode')
  final String? pincode;
  @override
  @JsonKey(name: 'subscription_status')
  final String? subscriptionStatus;
  @override
  @JsonKey(name: 'img')
  final String? image;

  @override
  String toString() {
    return 'ShopModel(id: $id, name: $name, place: $place, phone: $phone, email: $email, address: $address, pincode: $pincode, subscriptionStatus: $subscriptionStatus, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShopModelImpl &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    place,
    phone,
    email,
    address,
    pincode,
    subscriptionStatus,
    image,
  );

  /// Create a copy of ShopModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShopModelImplCopyWith<_$ShopModelImpl> get copyWith =>
      __$$ShopModelImplCopyWithImpl<_$ShopModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShopModelImplToJson(this);
  }
}

abstract class _ShopModel implements ShopModel {
  const factory _ShopModel({
    required final int id,
    required final String name,
    final String? place,
    required final String phone,
    final String? email,
    @JsonKey(defaultValue: 'Address not available')
    required final String address,
    @JsonKey(name: 'pincode') final String? pincode,
    @JsonKey(name: 'subscription_status') final String? subscriptionStatus,
    @JsonKey(name: 'img') final String? image,
  }) = _$ShopModelImpl;

  factory _ShopModel.fromJson(Map<String, dynamic> json) =
      _$ShopModelImpl.fromJson;

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
  @JsonKey(defaultValue: 'Address not available')
  String get address;
  @override
  @JsonKey(name: 'pincode')
  String? get pincode;
  @override
  @JsonKey(name: 'subscription_status')
  String? get subscriptionStatus;
  @override
  @JsonKey(name: 'img')
  String? get image;

  /// Create a copy of ShopModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShopModelImplCopyWith<_$ShopModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
