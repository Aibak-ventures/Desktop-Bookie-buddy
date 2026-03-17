// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'desktop_booking_item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DesktopBookingItemModel _$DesktopBookingItemModelFromJson(
    Map<String, dynamic> json) {
  return _DesktopBookingItemModel.fromJson(json);
}

/// @nodoc
mixin _$DesktopBookingItemModel {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'shop_booking_id')
  String get shopBookingId => throw _privateConstructorUsedError;
  String get client => throw _privateConstructorUsedError;
  @JsonKey(name: 'pickup_date')
  String get pickupDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'return_date')
  String get returnDate => throw _privateConstructorUsedError;
  @JsonKey(
      name: 'payment_status',
      fromJson: _paymentStatusFromBool,
      toJson: _paymentStatusToBool)
  bool get paymentStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'staff_name')
  String? get staffName => throw _privateConstructorUsedError;
  @JsonKey(name: 'staff_color')
  String? get staffColor => throw _privateConstructorUsedError;
  @JsonKey(
      name: 'delivery_status',
      fromJson: DeliveryStatus.fromString,
      toJson: DeliveryStatus.toJson)
  DeliveryStatus? get deliveryStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'booked_items')
  String get bookedItems => throw _privateConstructorUsedError;
  @JsonKey(name: 'advance_amount')
  int get advanceAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'remaining_amount')
  int get remainingAmount => throw _privateConstructorUsedError;

  /// Serializes this DesktopBookingItemModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DesktopBookingItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DesktopBookingItemModelCopyWith<DesktopBookingItemModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DesktopBookingItemModelCopyWith<$Res> {
  factory $DesktopBookingItemModelCopyWith(DesktopBookingItemModel value,
          $Res Function(DesktopBookingItemModel) then) =
      _$DesktopBookingItemModelCopyWithImpl<$Res, DesktopBookingItemModel>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'shop_booking_id') String shopBookingId,
      String client,
      @JsonKey(name: 'pickup_date') String pickupDate,
      @JsonKey(name: 'return_date') String returnDate,
      @JsonKey(
          name: 'payment_status',
          fromJson: _paymentStatusFromBool,
          toJson: _paymentStatusToBool)
      bool paymentStatus,
      @JsonKey(name: 'staff_name') String? staffName,
      @JsonKey(name: 'staff_color') String? staffColor,
      @JsonKey(
          name: 'delivery_status',
          fromJson: DeliveryStatus.fromString,
          toJson: DeliveryStatus.toJson)
      DeliveryStatus? deliveryStatus,
      @JsonKey(name: 'created_at') String createdAt,
      @JsonKey(name: 'booked_items') String bookedItems,
      @JsonKey(name: 'advance_amount') int advanceAmount,
      @JsonKey(name: 'remaining_amount') int remainingAmount});
}

/// @nodoc
class _$DesktopBookingItemModelCopyWithImpl<$Res,
        $Val extends DesktopBookingItemModel>
    implements $DesktopBookingItemModelCopyWith<$Res> {
  _$DesktopBookingItemModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DesktopBookingItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? shopBookingId = null,
    Object? client = null,
    Object? pickupDate = null,
    Object? returnDate = null,
    Object? paymentStatus = null,
    Object? staffName = freezed,
    Object? staffColor = freezed,
    Object? deliveryStatus = freezed,
    Object? createdAt = null,
    Object? bookedItems = null,
    Object? advanceAmount = null,
    Object? remainingAmount = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      shopBookingId: null == shopBookingId
          ? _value.shopBookingId
          : shopBookingId // ignore: cast_nullable_to_non_nullable
              as String,
      client: null == client
          ? _value.client
          : client // ignore: cast_nullable_to_non_nullable
              as String,
      pickupDate: null == pickupDate
          ? _value.pickupDate
          : pickupDate // ignore: cast_nullable_to_non_nullable
              as String,
      returnDate: null == returnDate
          ? _value.returnDate
          : returnDate // ignore: cast_nullable_to_non_nullable
              as String,
      paymentStatus: null == paymentStatus
          ? _value.paymentStatus
          : paymentStatus // ignore: cast_nullable_to_non_nullable
              as bool,
      staffName: freezed == staffName
          ? _value.staffName
          : staffName // ignore: cast_nullable_to_non_nullable
              as String?,
      staffColor: freezed == staffColor
          ? _value.staffColor
          : staffColor // ignore: cast_nullable_to_non_nullable
              as String?,
      deliveryStatus: freezed == deliveryStatus
          ? _value.deliveryStatus
          : deliveryStatus // ignore: cast_nullable_to_non_nullable
              as DeliveryStatus?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      bookedItems: null == bookedItems
          ? _value.bookedItems
          : bookedItems // ignore: cast_nullable_to_non_nullable
              as String,
      advanceAmount: null == advanceAmount
          ? _value.advanceAmount
          : advanceAmount // ignore: cast_nullable_to_non_nullable
              as int,
      remainingAmount: null == remainingAmount
          ? _value.remainingAmount
          : remainingAmount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DesktopBookingItemModelImplCopyWith<$Res>
    implements $DesktopBookingItemModelCopyWith<$Res> {
  factory _$$DesktopBookingItemModelImplCopyWith(
          _$DesktopBookingItemModelImpl value,
          $Res Function(_$DesktopBookingItemModelImpl) then) =
      __$$DesktopBookingItemModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'shop_booking_id') String shopBookingId,
      String client,
      @JsonKey(name: 'pickup_date') String pickupDate,
      @JsonKey(name: 'return_date') String returnDate,
      @JsonKey(
          name: 'payment_status',
          fromJson: _paymentStatusFromBool,
          toJson: _paymentStatusToBool)
      bool paymentStatus,
      @JsonKey(name: 'staff_name') String? staffName,
      @JsonKey(name: 'staff_color') String? staffColor,
      @JsonKey(
          name: 'delivery_status',
          fromJson: DeliveryStatus.fromString,
          toJson: DeliveryStatus.toJson)
      DeliveryStatus? deliveryStatus,
      @JsonKey(name: 'created_at') String createdAt,
      @JsonKey(name: 'booked_items') String bookedItems,
      @JsonKey(name: 'advance_amount') int advanceAmount,
      @JsonKey(name: 'remaining_amount') int remainingAmount});
}

/// @nodoc
class __$$DesktopBookingItemModelImplCopyWithImpl<$Res>
    extends _$DesktopBookingItemModelCopyWithImpl<$Res,
        _$DesktopBookingItemModelImpl>
    implements _$$DesktopBookingItemModelImplCopyWith<$Res> {
  __$$DesktopBookingItemModelImplCopyWithImpl(
      _$DesktopBookingItemModelImpl _value,
      $Res Function(_$DesktopBookingItemModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of DesktopBookingItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? shopBookingId = null,
    Object? client = null,
    Object? pickupDate = null,
    Object? returnDate = null,
    Object? paymentStatus = null,
    Object? staffName = freezed,
    Object? staffColor = freezed,
    Object? deliveryStatus = freezed,
    Object? createdAt = null,
    Object? bookedItems = null,
    Object? advanceAmount = null,
    Object? remainingAmount = null,
  }) {
    return _then(_$DesktopBookingItemModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      shopBookingId: null == shopBookingId
          ? _value.shopBookingId
          : shopBookingId // ignore: cast_nullable_to_non_nullable
              as String,
      client: null == client
          ? _value.client
          : client // ignore: cast_nullable_to_non_nullable
              as String,
      pickupDate: null == pickupDate
          ? _value.pickupDate
          : pickupDate // ignore: cast_nullable_to_non_nullable
              as String,
      returnDate: null == returnDate
          ? _value.returnDate
          : returnDate // ignore: cast_nullable_to_non_nullable
              as String,
      paymentStatus: null == paymentStatus
          ? _value.paymentStatus
          : paymentStatus // ignore: cast_nullable_to_non_nullable
              as bool,
      staffName: freezed == staffName
          ? _value.staffName
          : staffName // ignore: cast_nullable_to_non_nullable
              as String?,
      staffColor: freezed == staffColor
          ? _value.staffColor
          : staffColor // ignore: cast_nullable_to_non_nullable
              as String?,
      deliveryStatus: freezed == deliveryStatus
          ? _value.deliveryStatus
          : deliveryStatus // ignore: cast_nullable_to_non_nullable
              as DeliveryStatus?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      bookedItems: null == bookedItems
          ? _value.bookedItems
          : bookedItems // ignore: cast_nullable_to_non_nullable
              as String,
      advanceAmount: null == advanceAmount
          ? _value.advanceAmount
          : advanceAmount // ignore: cast_nullable_to_non_nullable
              as int,
      remainingAmount: null == remainingAmount
          ? _value.remainingAmount
          : remainingAmount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DesktopBookingItemModelImpl implements _DesktopBookingItemModel {
  const _$DesktopBookingItemModelImpl(
      {required this.id,
      @JsonKey(name: 'shop_booking_id') required this.shopBookingId,
      required this.client,
      @JsonKey(name: 'pickup_date') required this.pickupDate,
      @JsonKey(name: 'return_date') required this.returnDate,
      @JsonKey(
          name: 'payment_status',
          fromJson: _paymentStatusFromBool,
          toJson: _paymentStatusToBool)
      required this.paymentStatus,
      @JsonKey(name: 'staff_name') this.staffName,
      @JsonKey(name: 'staff_color') this.staffColor,
      @JsonKey(
          name: 'delivery_status',
          fromJson: DeliveryStatus.fromString,
          toJson: DeliveryStatus.toJson)
      this.deliveryStatus,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'booked_items') required this.bookedItems,
      @JsonKey(name: 'advance_amount') required this.advanceAmount,
      @JsonKey(name: 'remaining_amount') required this.remainingAmount});

  factory _$DesktopBookingItemModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DesktopBookingItemModelImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'shop_booking_id')
  final String shopBookingId;
  @override
  final String client;
  @override
  @JsonKey(name: 'pickup_date')
  final String pickupDate;
  @override
  @JsonKey(name: 'return_date')
  final String returnDate;
  @override
  @JsonKey(
      name: 'payment_status',
      fromJson: _paymentStatusFromBool,
      toJson: _paymentStatusToBool)
  final bool paymentStatus;
  @override
  @JsonKey(name: 'staff_name')
  final String? staffName;
  @override
  @JsonKey(name: 'staff_color')
  final String? staffColor;
  @override
  @JsonKey(
      name: 'delivery_status',
      fromJson: DeliveryStatus.fromString,
      toJson: DeliveryStatus.toJson)
  final DeliveryStatus? deliveryStatus;
  @override
  @JsonKey(name: 'created_at')
  final String createdAt;
  @override
  @JsonKey(name: 'booked_items')
  final String bookedItems;
  @override
  @JsonKey(name: 'advance_amount')
  final int advanceAmount;
  @override
  @JsonKey(name: 'remaining_amount')
  final int remainingAmount;

  @override
  String toString() {
    return 'DesktopBookingItemModel(id: $id, shopBookingId: $shopBookingId, client: $client, pickupDate: $pickupDate, returnDate: $returnDate, paymentStatus: $paymentStatus, staffName: $staffName, staffColor: $staffColor, deliveryStatus: $deliveryStatus, createdAt: $createdAt, bookedItems: $bookedItems, advanceAmount: $advanceAmount, remainingAmount: $remainingAmount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DesktopBookingItemModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.shopBookingId, shopBookingId) ||
                other.shopBookingId == shopBookingId) &&
            (identical(other.client, client) || other.client == client) &&
            (identical(other.pickupDate, pickupDate) ||
                other.pickupDate == pickupDate) &&
            (identical(other.returnDate, returnDate) ||
                other.returnDate == returnDate) &&
            (identical(other.paymentStatus, paymentStatus) ||
                other.paymentStatus == paymentStatus) &&
            (identical(other.staffName, staffName) ||
                other.staffName == staffName) &&
            (identical(other.staffColor, staffColor) ||
                other.staffColor == staffColor) &&
            (identical(other.deliveryStatus, deliveryStatus) ||
                other.deliveryStatus == deliveryStatus) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.bookedItems, bookedItems) ||
                other.bookedItems == bookedItems) &&
            (identical(other.advanceAmount, advanceAmount) ||
                other.advanceAmount == advanceAmount) &&
            (identical(other.remainingAmount, remainingAmount) ||
                other.remainingAmount == remainingAmount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      shopBookingId,
      client,
      pickupDate,
      returnDate,
      paymentStatus,
      staffName,
      staffColor,
      deliveryStatus,
      createdAt,
      bookedItems,
      advanceAmount,
      remainingAmount);

  /// Create a copy of DesktopBookingItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DesktopBookingItemModelImplCopyWith<_$DesktopBookingItemModelImpl>
      get copyWith => __$$DesktopBookingItemModelImplCopyWithImpl<
          _$DesktopBookingItemModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DesktopBookingItemModelImplToJson(
      this,
    );
  }
}

abstract class _DesktopBookingItemModel implements DesktopBookingItemModel {
  const factory _DesktopBookingItemModel(
      {required final int id,
      @JsonKey(name: 'shop_booking_id') required final String shopBookingId,
      required final String client,
      @JsonKey(name: 'pickup_date') required final String pickupDate,
      @JsonKey(name: 'return_date') required final String returnDate,
      @JsonKey(
          name: 'payment_status',
          fromJson: _paymentStatusFromBool,
          toJson: _paymentStatusToBool)
      required final bool paymentStatus,
      @JsonKey(name: 'staff_name') final String? staffName,
      @JsonKey(name: 'staff_color') final String? staffColor,
      @JsonKey(
          name: 'delivery_status',
          fromJson: DeliveryStatus.fromString,
          toJson: DeliveryStatus.toJson)
      final DeliveryStatus? deliveryStatus,
      @JsonKey(name: 'created_at') required final String createdAt,
      @JsonKey(name: 'booked_items') required final String bookedItems,
      @JsonKey(name: 'advance_amount') required final int advanceAmount,
      @JsonKey(name: 'remaining_amount')
      required final int remainingAmount}) = _$DesktopBookingItemModelImpl;

  factory _DesktopBookingItemModel.fromJson(Map<String, dynamic> json) =
      _$DesktopBookingItemModelImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'shop_booking_id')
  String get shopBookingId;
  @override
  String get client;
  @override
  @JsonKey(name: 'pickup_date')
  String get pickupDate;
  @override
  @JsonKey(name: 'return_date')
  String get returnDate;
  @override
  @JsonKey(
      name: 'payment_status',
      fromJson: _paymentStatusFromBool,
      toJson: _paymentStatusToBool)
  bool get paymentStatus;
  @override
  @JsonKey(name: 'staff_name')
  String? get staffName;
  @override
  @JsonKey(name: 'staff_color')
  String? get staffColor;
  @override
  @JsonKey(
      name: 'delivery_status',
      fromJson: DeliveryStatus.fromString,
      toJson: DeliveryStatus.toJson)
  DeliveryStatus? get deliveryStatus;
  @override
  @JsonKey(name: 'created_at')
  String get createdAt;
  @override
  @JsonKey(name: 'booked_items')
  String get bookedItems;
  @override
  @JsonKey(name: 'advance_amount')
  int get advanceAmount;
  @override
  @JsonKey(name: 'remaining_amount')
  int get remainingAmount;

  /// Create a copy of DesktopBookingItemModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DesktopBookingItemModelImplCopyWith<_$DesktopBookingItemModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
