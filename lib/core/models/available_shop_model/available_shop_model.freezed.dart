// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'available_shop_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AvailableShopModel _$AvailableShopModelFromJson(Map<String, dynamic> json) {
  return _AvailableShopModel.fromJson(json);
}

/// @nodoc
mixin _$AvailableShopModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get place => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  @JsonKey(name: 'gst_number')
  String? get gstNumber => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get state => throw _privateConstructorUsedError;
  String? get pincode => throw _privateConstructorUsedError;
  @JsonKey(name: 'subscription_status')
  String? get subscriptionStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'subscribed_date')
  String? get subscribedDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'renewal_due_date')
  String? get renewalDueDate => throw _privateConstructorUsedError;
  String? get img => throw _privateConstructorUsedError;

  /// Serializes this AvailableShopModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AvailableShopModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AvailableShopModelCopyWith<AvailableShopModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AvailableShopModelCopyWith<$Res> {
  factory $AvailableShopModelCopyWith(
          AvailableShopModel value, $Res Function(AvailableShopModel) then) =
      _$AvailableShopModelCopyWithImpl<$Res, AvailableShopModel>;
  @useResult
  $Res call(
      {int id,
      String name,
      String? place,
      String? phone,
      String? email,
      String address,
      @JsonKey(name: 'gst_number') String? gstNumber,
      String? city,
      String? state,
      String? pincode,
      @JsonKey(name: 'subscription_status') String? subscriptionStatus,
      @JsonKey(name: 'subscribed_date') String? subscribedDate,
      @JsonKey(name: 'renewal_due_date') String? renewalDueDate,
      String? img});
}

/// @nodoc
class _$AvailableShopModelCopyWithImpl<$Res, $Val extends AvailableShopModel>
    implements $AvailableShopModelCopyWith<$Res> {
  _$AvailableShopModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AvailableShopModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? place = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? address = null,
    Object? gstNumber = freezed,
    Object? city = freezed,
    Object? state = freezed,
    Object? pincode = freezed,
    Object? subscriptionStatus = freezed,
    Object? subscribedDate = freezed,
    Object? renewalDueDate = freezed,
    Object? img = freezed,
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
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      gstNumber: freezed == gstNumber
          ? _value.gstNumber
          : gstNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
      pincode: freezed == pincode
          ? _value.pincode
          : pincode // ignore: cast_nullable_to_non_nullable
              as String?,
      subscriptionStatus: freezed == subscriptionStatus
          ? _value.subscriptionStatus
          : subscriptionStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      subscribedDate: freezed == subscribedDate
          ? _value.subscribedDate
          : subscribedDate // ignore: cast_nullable_to_non_nullable
              as String?,
      renewalDueDate: freezed == renewalDueDate
          ? _value.renewalDueDate
          : renewalDueDate // ignore: cast_nullable_to_non_nullable
              as String?,
      img: freezed == img
          ? _value.img
          : img // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AvailableShopModelImplCopyWith<$Res>
    implements $AvailableShopModelCopyWith<$Res> {
  factory _$$AvailableShopModelImplCopyWith(_$AvailableShopModelImpl value,
          $Res Function(_$AvailableShopModelImpl) then) =
      __$$AvailableShopModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String? place,
      String? phone,
      String? email,
      String address,
      @JsonKey(name: 'gst_number') String? gstNumber,
      String? city,
      String? state,
      String? pincode,
      @JsonKey(name: 'subscription_status') String? subscriptionStatus,
      @JsonKey(name: 'subscribed_date') String? subscribedDate,
      @JsonKey(name: 'renewal_due_date') String? renewalDueDate,
      String? img});
}

/// @nodoc
class __$$AvailableShopModelImplCopyWithImpl<$Res>
    extends _$AvailableShopModelCopyWithImpl<$Res, _$AvailableShopModelImpl>
    implements _$$AvailableShopModelImplCopyWith<$Res> {
  __$$AvailableShopModelImplCopyWithImpl(_$AvailableShopModelImpl _value,
      $Res Function(_$AvailableShopModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of AvailableShopModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? place = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? address = null,
    Object? gstNumber = freezed,
    Object? city = freezed,
    Object? state = freezed,
    Object? pincode = freezed,
    Object? subscriptionStatus = freezed,
    Object? subscribedDate = freezed,
    Object? renewalDueDate = freezed,
    Object? img = freezed,
  }) {
    return _then(_$AvailableShopModelImpl(
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
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      gstNumber: freezed == gstNumber
          ? _value.gstNumber
          : gstNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
      pincode: freezed == pincode
          ? _value.pincode
          : pincode // ignore: cast_nullable_to_non_nullable
              as String?,
      subscriptionStatus: freezed == subscriptionStatus
          ? _value.subscriptionStatus
          : subscriptionStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      subscribedDate: freezed == subscribedDate
          ? _value.subscribedDate
          : subscribedDate // ignore: cast_nullable_to_non_nullable
              as String?,
      renewalDueDate: freezed == renewalDueDate
          ? _value.renewalDueDate
          : renewalDueDate // ignore: cast_nullable_to_non_nullable
              as String?,
      img: freezed == img
          ? _value.img
          : img // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AvailableShopModelImpl implements _AvailableShopModel {
  const _$AvailableShopModelImpl(
      {required this.id,
      required this.name,
      this.place,
      this.phone,
      this.email,
      required this.address,
      @JsonKey(name: 'gst_number') this.gstNumber,
      this.city,
      this.state,
      this.pincode,
      @JsonKey(name: 'subscription_status') this.subscriptionStatus,
      @JsonKey(name: 'subscribed_date') this.subscribedDate,
      @JsonKey(name: 'renewal_due_date') this.renewalDueDate,
      this.img});

  factory _$AvailableShopModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AvailableShopModelImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String? place;
  @override
  final String? phone;
  @override
  final String? email;
  @override
  final String address;
  @override
  @JsonKey(name: 'gst_number')
  final String? gstNumber;
  @override
  final String? city;
  @override
  final String? state;
  @override
  final String? pincode;
  @override
  @JsonKey(name: 'subscription_status')
  final String? subscriptionStatus;
  @override
  @JsonKey(name: 'subscribed_date')
  final String? subscribedDate;
  @override
  @JsonKey(name: 'renewal_due_date')
  final String? renewalDueDate;
  @override
  final String? img;

  @override
  String toString() {
    return 'AvailableShopModel(id: $id, name: $name, place: $place, phone: $phone, email: $email, address: $address, gstNumber: $gstNumber, city: $city, state: $state, pincode: $pincode, subscriptionStatus: $subscriptionStatus, subscribedDate: $subscribedDate, renewalDueDate: $renewalDueDate, img: $img)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AvailableShopModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.place, place) || other.place == place) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.gstNumber, gstNumber) ||
                other.gstNumber == gstNumber) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.pincode, pincode) || other.pincode == pincode) &&
            (identical(other.subscriptionStatus, subscriptionStatus) ||
                other.subscriptionStatus == subscriptionStatus) &&
            (identical(other.subscribedDate, subscribedDate) ||
                other.subscribedDate == subscribedDate) &&
            (identical(other.renewalDueDate, renewalDueDate) ||
                other.renewalDueDate == renewalDueDate) &&
            (identical(other.img, img) || other.img == img));
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
      gstNumber,
      city,
      state,
      pincode,
      subscriptionStatus,
      subscribedDate,
      renewalDueDate,
      img);

  /// Create a copy of AvailableShopModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AvailableShopModelImplCopyWith<_$AvailableShopModelImpl> get copyWith =>
      __$$AvailableShopModelImplCopyWithImpl<_$AvailableShopModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AvailableShopModelImplToJson(
      this,
    );
  }
}

abstract class _AvailableShopModel implements AvailableShopModel {
  const factory _AvailableShopModel(
      {required final int id,
      required final String name,
      final String? place,
      final String? phone,
      final String? email,
      required final String address,
      @JsonKey(name: 'gst_number') final String? gstNumber,
      final String? city,
      final String? state,
      final String? pincode,
      @JsonKey(name: 'subscription_status') final String? subscriptionStatus,
      @JsonKey(name: 'subscribed_date') final String? subscribedDate,
      @JsonKey(name: 'renewal_due_date') final String? renewalDueDate,
      final String? img}) = _$AvailableShopModelImpl;

  factory _AvailableShopModel.fromJson(Map<String, dynamic> json) =
      _$AvailableShopModelImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String? get place;
  @override
  String? get phone;
  @override
  String? get email;
  @override
  String get address;
  @override
  @JsonKey(name: 'gst_number')
  String? get gstNumber;
  @override
  String? get city;
  @override
  String? get state;
  @override
  String? get pincode;
  @override
  @JsonKey(name: 'subscription_status')
  String? get subscriptionStatus;
  @override
  @JsonKey(name: 'subscribed_date')
  String? get subscribedDate;
  @override
  @JsonKey(name: 'renewal_due_date')
  String? get renewalDueDate;
  @override
  String? get img;

  /// Create a copy of AvailableShopModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AvailableShopModelImplCopyWith<_$AvailableShopModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
