// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BookingsModel _$BookingsModelFromJson(Map<String, dynamic> json) {
  return _BookingsModel.fromJson(json);
}

/// @nodoc
mixin _$BookingsModel {
  @JsonKey(name: 'id', readValue: _idCustomRead)
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(
      name: 'client', defaultValue: 'Unknown', readValue: _clientCustomRead)
  String get clientName => throw _privateConstructorUsedError;
  @JsonKey(
      name: 'booking_status',
      fromJson: BookingStatus.fromString,
      toJson: BookingStatus.toJson,
      readValue: _bookingStatusCustomRead)
  BookingStatus get bookingStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'booking_date')
  String? get bookedDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'pickup_date')
  String? get pickupDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'return_date')
  String? get returnDate => throw _privateConstructorUsedError;
  @JsonKey(
      name: 'delivery_status',
      fromJson: DeliveryStatus.fromString,
      toJson: DeliveryStatus.toJson,
      defaultValue: DeliveryStatus.booked)
  DeliveryStatus get deliveryStatus => throw _privateConstructorUsedError;
  @JsonKey(
      name: 'payment_status',
      defaultValue: PaymentStatus.pending,
      fromJson: PaymentStatus.fromBool,
      toJson: PaymentStatus.toJson)
  PaymentStatus get paymentStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'booked_items', readValue: _bookedItemsCustomRead)
  List<String> get bookedItems => throw _privateConstructorUsedError;
  @JsonKey(name: 'type')
  String? get type => throw _privateConstructorUsedError;

  /// Serializes this BookingsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BookingsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookingsModelCopyWith<BookingsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingsModelCopyWith<$Res> {
  factory $BookingsModelCopyWith(
          BookingsModel value, $Res Function(BookingsModel) then) =
      _$BookingsModelCopyWithImpl<$Res, BookingsModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id', readValue: _idCustomRead) int? id,
      @JsonKey(
          name: 'client', defaultValue: 'Unknown', readValue: _clientCustomRead)
      String clientName,
      @JsonKey(
          name: 'booking_status',
          fromJson: BookingStatus.fromString,
          toJson: BookingStatus.toJson,
          readValue: _bookingStatusCustomRead)
      BookingStatus bookingStatus,
      @JsonKey(name: 'booking_date') String? bookedDate,
      @JsonKey(name: 'pickup_date') String? pickupDate,
      @JsonKey(name: 'return_date') String? returnDate,
      @JsonKey(
          name: 'delivery_status',
          fromJson: DeliveryStatus.fromString,
          toJson: DeliveryStatus.toJson,
          defaultValue: DeliveryStatus.booked)
      DeliveryStatus deliveryStatus,
      @JsonKey(
          name: 'payment_status',
          defaultValue: PaymentStatus.pending,
          fromJson: PaymentStatus.fromBool,
          toJson: PaymentStatus.toJson)
      PaymentStatus paymentStatus,
      @JsonKey(name: 'booked_items', readValue: _bookedItemsCustomRead)
      List<String> bookedItems,
      @JsonKey(name: 'type') String? type});
}

/// @nodoc
class _$BookingsModelCopyWithImpl<$Res, $Val extends BookingsModel>
    implements $BookingsModelCopyWith<$Res> {
  _$BookingsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookingsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? clientName = null,
    Object? bookingStatus = null,
    Object? bookedDate = freezed,
    Object? pickupDate = freezed,
    Object? returnDate = freezed,
    Object? deliveryStatus = null,
    Object? paymentStatus = null,
    Object? bookedItems = null,
    Object? type = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      clientName: null == clientName
          ? _value.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String,
      bookingStatus: null == bookingStatus
          ? _value.bookingStatus
          : bookingStatus // ignore: cast_nullable_to_non_nullable
              as BookingStatus,
      bookedDate: freezed == bookedDate
          ? _value.bookedDate
          : bookedDate // ignore: cast_nullable_to_non_nullable
              as String?,
      pickupDate: freezed == pickupDate
          ? _value.pickupDate
          : pickupDate // ignore: cast_nullable_to_non_nullable
              as String?,
      returnDate: freezed == returnDate
          ? _value.returnDate
          : returnDate // ignore: cast_nullable_to_non_nullable
              as String?,
      deliveryStatus: null == deliveryStatus
          ? _value.deliveryStatus
          : deliveryStatus // ignore: cast_nullable_to_non_nullable
              as DeliveryStatus,
      paymentStatus: null == paymentStatus
          ? _value.paymentStatus
          : paymentStatus // ignore: cast_nullable_to_non_nullable
              as PaymentStatus,
      bookedItems: null == bookedItems
          ? _value.bookedItems
          : bookedItems // ignore: cast_nullable_to_non_nullable
              as List<String>,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BookingsModelImplCopyWith<$Res>
    implements $BookingsModelCopyWith<$Res> {
  factory _$$BookingsModelImplCopyWith(
          _$BookingsModelImpl value, $Res Function(_$BookingsModelImpl) then) =
      __$$BookingsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id', readValue: _idCustomRead) int? id,
      @JsonKey(
          name: 'client', defaultValue: 'Unknown', readValue: _clientCustomRead)
      String clientName,
      @JsonKey(
          name: 'booking_status',
          fromJson: BookingStatus.fromString,
          toJson: BookingStatus.toJson,
          readValue: _bookingStatusCustomRead)
      BookingStatus bookingStatus,
      @JsonKey(name: 'booking_date') String? bookedDate,
      @JsonKey(name: 'pickup_date') String? pickupDate,
      @JsonKey(name: 'return_date') String? returnDate,
      @JsonKey(
          name: 'delivery_status',
          fromJson: DeliveryStatus.fromString,
          toJson: DeliveryStatus.toJson,
          defaultValue: DeliveryStatus.booked)
      DeliveryStatus deliveryStatus,
      @JsonKey(
          name: 'payment_status',
          defaultValue: PaymentStatus.pending,
          fromJson: PaymentStatus.fromBool,
          toJson: PaymentStatus.toJson)
      PaymentStatus paymentStatus,
      @JsonKey(name: 'booked_items', readValue: _bookedItemsCustomRead)
      List<String> bookedItems,
      @JsonKey(name: 'type') String? type});
}

/// @nodoc
class __$$BookingsModelImplCopyWithImpl<$Res>
    extends _$BookingsModelCopyWithImpl<$Res, _$BookingsModelImpl>
    implements _$$BookingsModelImplCopyWith<$Res> {
  __$$BookingsModelImplCopyWithImpl(
      _$BookingsModelImpl _value, $Res Function(_$BookingsModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookingsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? clientName = null,
    Object? bookingStatus = null,
    Object? bookedDate = freezed,
    Object? pickupDate = freezed,
    Object? returnDate = freezed,
    Object? deliveryStatus = null,
    Object? paymentStatus = null,
    Object? bookedItems = null,
    Object? type = freezed,
  }) {
    return _then(_$BookingsModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      clientName: null == clientName
          ? _value.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String,
      bookingStatus: null == bookingStatus
          ? _value.bookingStatus
          : bookingStatus // ignore: cast_nullable_to_non_nullable
              as BookingStatus,
      bookedDate: freezed == bookedDate
          ? _value.bookedDate
          : bookedDate // ignore: cast_nullable_to_non_nullable
              as String?,
      pickupDate: freezed == pickupDate
          ? _value.pickupDate
          : pickupDate // ignore: cast_nullable_to_non_nullable
              as String?,
      returnDate: freezed == returnDate
          ? _value.returnDate
          : returnDate // ignore: cast_nullable_to_non_nullable
              as String?,
      deliveryStatus: null == deliveryStatus
          ? _value.deliveryStatus
          : deliveryStatus // ignore: cast_nullable_to_non_nullable
              as DeliveryStatus,
      paymentStatus: null == paymentStatus
          ? _value.paymentStatus
          : paymentStatus // ignore: cast_nullable_to_non_nullable
              as PaymentStatus,
      bookedItems: null == bookedItems
          ? _value._bookedItems
          : bookedItems // ignore: cast_nullable_to_non_nullable
              as List<String>,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BookingsModelImpl implements _BookingsModel {
  const _$BookingsModelImpl(
      {@JsonKey(name: 'id', readValue: _idCustomRead) this.id,
      @JsonKey(
          name: 'client', defaultValue: 'Unknown', readValue: _clientCustomRead)
      required this.clientName,
      @JsonKey(
          name: 'booking_status',
          fromJson: BookingStatus.fromString,
          toJson: BookingStatus.toJson,
          readValue: _bookingStatusCustomRead)
      required this.bookingStatus,
      @JsonKey(name: 'booking_date') this.bookedDate,
      @JsonKey(name: 'pickup_date') this.pickupDate,
      @JsonKey(name: 'return_date') this.returnDate,
      @JsonKey(
          name: 'delivery_status',
          fromJson: DeliveryStatus.fromString,
          toJson: DeliveryStatus.toJson,
          defaultValue: DeliveryStatus.booked)
      required this.deliveryStatus,
      @JsonKey(
          name: 'payment_status',
          defaultValue: PaymentStatus.pending,
          fromJson: PaymentStatus.fromBool,
          toJson: PaymentStatus.toJson)
      required this.paymentStatus,
      @JsonKey(name: 'booked_items', readValue: _bookedItemsCustomRead)
      final List<String> bookedItems = const [],
      @JsonKey(name: 'type') this.type})
      : _bookedItems = bookedItems;

  factory _$BookingsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookingsModelImplFromJson(json);

  @override
  @JsonKey(name: 'id', readValue: _idCustomRead)
  final int? id;
  @override
  @JsonKey(
      name: 'client', defaultValue: 'Unknown', readValue: _clientCustomRead)
  final String clientName;
  @override
  @JsonKey(
      name: 'booking_status',
      fromJson: BookingStatus.fromString,
      toJson: BookingStatus.toJson,
      readValue: _bookingStatusCustomRead)
  final BookingStatus bookingStatus;
  @override
  @JsonKey(name: 'booking_date')
  final String? bookedDate;
  @override
  @JsonKey(name: 'pickup_date')
  final String? pickupDate;
  @override
  @JsonKey(name: 'return_date')
  final String? returnDate;
  @override
  @JsonKey(
      name: 'delivery_status',
      fromJson: DeliveryStatus.fromString,
      toJson: DeliveryStatus.toJson,
      defaultValue: DeliveryStatus.booked)
  final DeliveryStatus deliveryStatus;
  @override
  @JsonKey(
      name: 'payment_status',
      defaultValue: PaymentStatus.pending,
      fromJson: PaymentStatus.fromBool,
      toJson: PaymentStatus.toJson)
  final PaymentStatus paymentStatus;
  final List<String> _bookedItems;
  @override
  @JsonKey(name: 'booked_items', readValue: _bookedItemsCustomRead)
  List<String> get bookedItems {
    if (_bookedItems is EqualUnmodifiableListView) return _bookedItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bookedItems);
  }

  @override
  @JsonKey(name: 'type')
  final String? type;

  @override
  String toString() {
    return 'BookingsModel(id: $id, clientName: $clientName, bookingStatus: $bookingStatus, bookedDate: $bookedDate, pickupDate: $pickupDate, returnDate: $returnDate, deliveryStatus: $deliveryStatus, paymentStatus: $paymentStatus, bookedItems: $bookedItems, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingsModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.clientName, clientName) ||
                other.clientName == clientName) &&
            (identical(other.bookingStatus, bookingStatus) ||
                other.bookingStatus == bookingStatus) &&
            (identical(other.bookedDate, bookedDate) ||
                other.bookedDate == bookedDate) &&
            (identical(other.pickupDate, pickupDate) ||
                other.pickupDate == pickupDate) &&
            (identical(other.returnDate, returnDate) ||
                other.returnDate == returnDate) &&
            (identical(other.deliveryStatus, deliveryStatus) ||
                other.deliveryStatus == deliveryStatus) &&
            (identical(other.paymentStatus, paymentStatus) ||
                other.paymentStatus == paymentStatus) &&
            const DeepCollectionEquality()
                .equals(other._bookedItems, _bookedItems) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      clientName,
      bookingStatus,
      bookedDate,
      pickupDate,
      returnDate,
      deliveryStatus,
      paymentStatus,
      const DeepCollectionEquality().hash(_bookedItems),
      type);

  /// Create a copy of BookingsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookingsModelImplCopyWith<_$BookingsModelImpl> get copyWith =>
      __$$BookingsModelImplCopyWithImpl<_$BookingsModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookingsModelImplToJson(
      this,
    );
  }
}

abstract class _BookingsModel implements BookingsModel {
  const factory _BookingsModel(
      {@JsonKey(name: 'id', readValue: _idCustomRead) final int? id,
      @JsonKey(
          name: 'client', defaultValue: 'Unknown', readValue: _clientCustomRead)
      required final String clientName,
      @JsonKey(
          name: 'booking_status',
          fromJson: BookingStatus.fromString,
          toJson: BookingStatus.toJson,
          readValue: _bookingStatusCustomRead)
      required final BookingStatus bookingStatus,
      @JsonKey(name: 'booking_date') final String? bookedDate,
      @JsonKey(name: 'pickup_date') final String? pickupDate,
      @JsonKey(name: 'return_date') final String? returnDate,
      @JsonKey(
          name: 'delivery_status',
          fromJson: DeliveryStatus.fromString,
          toJson: DeliveryStatus.toJson,
          defaultValue: DeliveryStatus.booked)
      required final DeliveryStatus deliveryStatus,
      @JsonKey(
          name: 'payment_status',
          defaultValue: PaymentStatus.pending,
          fromJson: PaymentStatus.fromBool,
          toJson: PaymentStatus.toJson)
      required final PaymentStatus paymentStatus,
      @JsonKey(name: 'booked_items', readValue: _bookedItemsCustomRead)
      final List<String> bookedItems,
      @JsonKey(name: 'type') final String? type}) = _$BookingsModelImpl;

  factory _BookingsModel.fromJson(Map<String, dynamic> json) =
      _$BookingsModelImpl.fromJson;

  @override
  @JsonKey(name: 'id', readValue: _idCustomRead)
  int? get id;
  @override
  @JsonKey(
      name: 'client', defaultValue: 'Unknown', readValue: _clientCustomRead)
  String get clientName;
  @override
  @JsonKey(
      name: 'booking_status',
      fromJson: BookingStatus.fromString,
      toJson: BookingStatus.toJson,
      readValue: _bookingStatusCustomRead)
  BookingStatus get bookingStatus;
  @override
  @JsonKey(name: 'booking_date')
  String? get bookedDate;
  @override
  @JsonKey(name: 'pickup_date')
  String? get pickupDate;
  @override
  @JsonKey(name: 'return_date')
  String? get returnDate;
  @override
  @JsonKey(
      name: 'delivery_status',
      fromJson: DeliveryStatus.fromString,
      toJson: DeliveryStatus.toJson,
      defaultValue: DeliveryStatus.booked)
  DeliveryStatus get deliveryStatus;
  @override
  @JsonKey(
      name: 'payment_status',
      defaultValue: PaymentStatus.pending,
      fromJson: PaymentStatus.fromBool,
      toJson: PaymentStatus.toJson)
  PaymentStatus get paymentStatus;
  @override
  @JsonKey(name: 'booked_items', readValue: _bookedItemsCustomRead)
  List<String> get bookedItems;
  @override
  @JsonKey(name: 'type')
  String? get type;

  /// Create a copy of BookingsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookingsModelImplCopyWith<_$BookingsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
