// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_booking_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AddBookingModel _$AddBookingModelFromJson(Map<String, dynamic> json) {
  return _AddBookingModel.fromJson(json);
}

/// @nodoc
mixin _$AddBookingModel {
  @JsonKey(name: 'service_id')
  int? get serviceId => throw _privateConstructorUsedError;
  @JsonKey(name: 'advance_amount')
  int? get advanceAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'security_amount')
  int? get securityAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'discount_amount')
  int? get discountAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'sub_services')
  List<ProductSelectedModel>? get products =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'description')
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'booked_date')
  String? get bookedDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'event_date')
  String? get pickupDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'return_date')
  String? get returnDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_method')
  String? get paymentMethod => throw _privateConstructorUsedError;
  @JsonKey(name: 'purchase_mode')
  String? get purchaseMode => throw _privateConstructorUsedError;
  @JsonKey(name: 'delivery_status')
  String? get deliveryStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'staff_name')
  String? get staffName => throw _privateConstructorUsedError;
  @JsonKey(name: 'location_start')
  String? get locationStart => throw _privateConstructorUsedError;
  @JsonKey(name: 'location_from')
  String? get locationFrom => throw _privateConstructorUsedError;
  @JsonKey(name: 'location_to')
  String? get locationTo => throw _privateConstructorUsedError;
  @JsonKey(name: 'client_address')
  String? get address => throw _privateConstructorUsedError;
  @JsonKey(name: 'client_id')
  int? get clientId => throw _privateConstructorUsedError;
  @JsonKey(name: 'booking_status')
  String? get bookingStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'pickup_time', includeToJson: false, includeFromJson: false)
  TimeOfDay? get pickupTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'return_time', includeToJson: false, includeFromJson: false)
  TimeOfDay? get returnTime => throw _privateConstructorUsedError;

  /// Serializes this AddBookingModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AddBookingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddBookingModelCopyWith<AddBookingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddBookingModelCopyWith<$Res> {
  factory $AddBookingModelCopyWith(
          AddBookingModel value, $Res Function(AddBookingModel) then) =
      _$AddBookingModelCopyWithImpl<$Res, AddBookingModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'service_id') int? serviceId,
      @JsonKey(name: 'advance_amount') int? advanceAmount,
      @JsonKey(name: 'security_amount') int? securityAmount,
      @JsonKey(name: 'discount_amount') int? discountAmount,
      @JsonKey(name: 'sub_services') List<ProductSelectedModel>? products,
      @JsonKey(name: 'description') String? description,
      @JsonKey(name: 'booked_date') String? bookedDate,
      @JsonKey(name: 'event_date') String? pickupDate,
      @JsonKey(name: 'return_date') String? returnDate,
      @JsonKey(name: 'payment_method') String? paymentMethod,
      @JsonKey(name: 'purchase_mode') String? purchaseMode,
      @JsonKey(name: 'delivery_status') String? deliveryStatus,
      @JsonKey(name: 'staff_name') String? staffName,
      @JsonKey(name: 'location_start') String? locationStart,
      @JsonKey(name: 'location_from') String? locationFrom,
      @JsonKey(name: 'location_to') String? locationTo,
      @JsonKey(name: 'client_address') String? address,
      @JsonKey(name: 'client_id') int? clientId,
      @JsonKey(name: 'booking_status') String? bookingStatus,
      @JsonKey(
          name: 'pickup_time', includeToJson: false, includeFromJson: false)
      TimeOfDay? pickupTime,
      @JsonKey(
          name: 'return_time', includeToJson: false, includeFromJson: false)
      TimeOfDay? returnTime});
}

/// @nodoc
class _$AddBookingModelCopyWithImpl<$Res, $Val extends AddBookingModel>
    implements $AddBookingModelCopyWith<$Res> {
  _$AddBookingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddBookingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serviceId = freezed,
    Object? advanceAmount = freezed,
    Object? securityAmount = freezed,
    Object? discountAmount = freezed,
    Object? products = freezed,
    Object? description = freezed,
    Object? bookedDate = freezed,
    Object? pickupDate = freezed,
    Object? returnDate = freezed,
    Object? paymentMethod = freezed,
    Object? purchaseMode = freezed,
    Object? deliveryStatus = freezed,
    Object? staffName = freezed,
    Object? locationStart = freezed,
    Object? locationFrom = freezed,
    Object? locationTo = freezed,
    Object? address = freezed,
    Object? clientId = freezed,
    Object? bookingStatus = freezed,
    Object? pickupTime = freezed,
    Object? returnTime = freezed,
  }) {
    return _then(_value.copyWith(
      serviceId: freezed == serviceId
          ? _value.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as int?,
      advanceAmount: freezed == advanceAmount
          ? _value.advanceAmount
          : advanceAmount // ignore: cast_nullable_to_non_nullable
              as int?,
      securityAmount: freezed == securityAmount
          ? _value.securityAmount
          : securityAmount // ignore: cast_nullable_to_non_nullable
              as int?,
      discountAmount: freezed == discountAmount
          ? _value.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as int?,
      products: freezed == products
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<ProductSelectedModel>?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
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
      paymentMethod: freezed == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      purchaseMode: freezed == purchaseMode
          ? _value.purchaseMode
          : purchaseMode // ignore: cast_nullable_to_non_nullable
              as String?,
      deliveryStatus: freezed == deliveryStatus
          ? _value.deliveryStatus
          : deliveryStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      staffName: freezed == staffName
          ? _value.staffName
          : staffName // ignore: cast_nullable_to_non_nullable
              as String?,
      locationStart: freezed == locationStart
          ? _value.locationStart
          : locationStart // ignore: cast_nullable_to_non_nullable
              as String?,
      locationFrom: freezed == locationFrom
          ? _value.locationFrom
          : locationFrom // ignore: cast_nullable_to_non_nullable
              as String?,
      locationTo: freezed == locationTo
          ? _value.locationTo
          : locationTo // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      clientId: freezed == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as int?,
      bookingStatus: freezed == bookingStatus
          ? _value.bookingStatus
          : bookingStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      pickupTime: freezed == pickupTime
          ? _value.pickupTime
          : pickupTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay?,
      returnTime: freezed == returnTime
          ? _value.returnTime
          : returnTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddBookingModelImplCopyWith<$Res>
    implements $AddBookingModelCopyWith<$Res> {
  factory _$$AddBookingModelImplCopyWith(_$AddBookingModelImpl value,
          $Res Function(_$AddBookingModelImpl) then) =
      __$$AddBookingModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'service_id') int? serviceId,
      @JsonKey(name: 'advance_amount') int? advanceAmount,
      @JsonKey(name: 'security_amount') int? securityAmount,
      @JsonKey(name: 'discount_amount') int? discountAmount,
      @JsonKey(name: 'sub_services') List<ProductSelectedModel>? products,
      @JsonKey(name: 'description') String? description,
      @JsonKey(name: 'booked_date') String? bookedDate,
      @JsonKey(name: 'event_date') String? pickupDate,
      @JsonKey(name: 'return_date') String? returnDate,
      @JsonKey(name: 'payment_method') String? paymentMethod,
      @JsonKey(name: 'purchase_mode') String? purchaseMode,
      @JsonKey(name: 'delivery_status') String? deliveryStatus,
      @JsonKey(name: 'staff_name') String? staffName,
      @JsonKey(name: 'location_start') String? locationStart,
      @JsonKey(name: 'location_from') String? locationFrom,
      @JsonKey(name: 'location_to') String? locationTo,
      @JsonKey(name: 'client_address') String? address,
      @JsonKey(name: 'client_id') int? clientId,
      @JsonKey(name: 'booking_status') String? bookingStatus,
      @JsonKey(
          name: 'pickup_time', includeToJson: false, includeFromJson: false)
      TimeOfDay? pickupTime,
      @JsonKey(
          name: 'return_time', includeToJson: false, includeFromJson: false)
      TimeOfDay? returnTime});
}

/// @nodoc
class __$$AddBookingModelImplCopyWithImpl<$Res>
    extends _$AddBookingModelCopyWithImpl<$Res, _$AddBookingModelImpl>
    implements _$$AddBookingModelImplCopyWith<$Res> {
  __$$AddBookingModelImplCopyWithImpl(
      _$AddBookingModelImpl _value, $Res Function(_$AddBookingModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddBookingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serviceId = freezed,
    Object? advanceAmount = freezed,
    Object? securityAmount = freezed,
    Object? discountAmount = freezed,
    Object? products = freezed,
    Object? description = freezed,
    Object? bookedDate = freezed,
    Object? pickupDate = freezed,
    Object? returnDate = freezed,
    Object? paymentMethod = freezed,
    Object? purchaseMode = freezed,
    Object? deliveryStatus = freezed,
    Object? staffName = freezed,
    Object? locationStart = freezed,
    Object? locationFrom = freezed,
    Object? locationTo = freezed,
    Object? address = freezed,
    Object? clientId = freezed,
    Object? bookingStatus = freezed,
    Object? pickupTime = freezed,
    Object? returnTime = freezed,
  }) {
    return _then(_$AddBookingModelImpl(
      serviceId: freezed == serviceId
          ? _value.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as int?,
      advanceAmount: freezed == advanceAmount
          ? _value.advanceAmount
          : advanceAmount // ignore: cast_nullable_to_non_nullable
              as int?,
      securityAmount: freezed == securityAmount
          ? _value.securityAmount
          : securityAmount // ignore: cast_nullable_to_non_nullable
              as int?,
      discountAmount: freezed == discountAmount
          ? _value.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as int?,
      products: freezed == products
          ? _value._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<ProductSelectedModel>?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
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
      paymentMethod: freezed == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      purchaseMode: freezed == purchaseMode
          ? _value.purchaseMode
          : purchaseMode // ignore: cast_nullable_to_non_nullable
              as String?,
      deliveryStatus: freezed == deliveryStatus
          ? _value.deliveryStatus
          : deliveryStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      staffName: freezed == staffName
          ? _value.staffName
          : staffName // ignore: cast_nullable_to_non_nullable
              as String?,
      locationStart: freezed == locationStart
          ? _value.locationStart
          : locationStart // ignore: cast_nullable_to_non_nullable
              as String?,
      locationFrom: freezed == locationFrom
          ? _value.locationFrom
          : locationFrom // ignore: cast_nullable_to_non_nullable
              as String?,
      locationTo: freezed == locationTo
          ? _value.locationTo
          : locationTo // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      clientId: freezed == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as int?,
      bookingStatus: freezed == bookingStatus
          ? _value.bookingStatus
          : bookingStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      pickupTime: freezed == pickupTime
          ? _value.pickupTime
          : pickupTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay?,
      returnTime: freezed == returnTime
          ? _value.returnTime
          : returnTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AddBookingModelImpl implements _AddBookingModel {
  const _$AddBookingModelImpl(
      {@JsonKey(name: 'service_id') this.serviceId,
      @JsonKey(name: 'advance_amount') this.advanceAmount,
      @JsonKey(name: 'security_amount') this.securityAmount,
      @JsonKey(name: 'discount_amount') this.discountAmount,
      @JsonKey(name: 'sub_services') final List<ProductSelectedModel>? products,
      @JsonKey(name: 'description') this.description,
      @JsonKey(name: 'booked_date') this.bookedDate,
      @JsonKey(name: 'event_date') this.pickupDate,
      @JsonKey(name: 'return_date') this.returnDate,
      @JsonKey(name: 'payment_method') this.paymentMethod,
      @JsonKey(name: 'purchase_mode') this.purchaseMode,
      @JsonKey(name: 'delivery_status') this.deliveryStatus,
      @JsonKey(name: 'staff_name') this.staffName,
      @JsonKey(name: 'location_start') this.locationStart,
      @JsonKey(name: 'location_from') this.locationFrom,
      @JsonKey(name: 'location_to') this.locationTo,
      @JsonKey(name: 'client_address') this.address,
      @JsonKey(name: 'client_id') this.clientId,
      @JsonKey(name: 'booking_status') this.bookingStatus,
      @JsonKey(
          name: 'pickup_time', includeToJson: false, includeFromJson: false)
      this.pickupTime,
      @JsonKey(
          name: 'return_time', includeToJson: false, includeFromJson: false)
      this.returnTime})
      : _products = products;

  factory _$AddBookingModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddBookingModelImplFromJson(json);

  @override
  @JsonKey(name: 'service_id')
  final int? serviceId;
  @override
  @JsonKey(name: 'advance_amount')
  final int? advanceAmount;
  @override
  @JsonKey(name: 'security_amount')
  final int? securityAmount;
  @override
  @JsonKey(name: 'discount_amount')
  final int? discountAmount;
  final List<ProductSelectedModel>? _products;
  @override
  @JsonKey(name: 'sub_services')
  List<ProductSelectedModel>? get products {
    final value = _products;
    if (value == null) return null;
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'description')
  final String? description;
  @override
  @JsonKey(name: 'booked_date')
  final String? bookedDate;
  @override
  @JsonKey(name: 'event_date')
  final String? pickupDate;
  @override
  @JsonKey(name: 'return_date')
  final String? returnDate;
  @override
  @JsonKey(name: 'payment_method')
  final String? paymentMethod;
  @override
  @JsonKey(name: 'purchase_mode')
  final String? purchaseMode;
  @override
  @JsonKey(name: 'delivery_status')
  final String? deliveryStatus;
  @override
  @JsonKey(name: 'staff_name')
  final String? staffName;
  @override
  @JsonKey(name: 'location_start')
  final String? locationStart;
  @override
  @JsonKey(name: 'location_from')
  final String? locationFrom;
  @override
  @JsonKey(name: 'location_to')
  final String? locationTo;
  @override
  @JsonKey(name: 'client_address')
  final String? address;
  @override
  @JsonKey(name: 'client_id')
  final int? clientId;
  @override
  @JsonKey(name: 'booking_status')
  final String? bookingStatus;
  @override
  @JsonKey(name: 'pickup_time', includeToJson: false, includeFromJson: false)
  final TimeOfDay? pickupTime;
  @override
  @JsonKey(name: 'return_time', includeToJson: false, includeFromJson: false)
  final TimeOfDay? returnTime;

  @override
  String toString() {
    return 'AddBookingModel(serviceId: $serviceId, advanceAmount: $advanceAmount, securityAmount: $securityAmount, discountAmount: $discountAmount, products: $products, description: $description, bookedDate: $bookedDate, pickupDate: $pickupDate, returnDate: $returnDate, paymentMethod: $paymentMethod, purchaseMode: $purchaseMode, deliveryStatus: $deliveryStatus, staffName: $staffName, locationStart: $locationStart, locationFrom: $locationFrom, locationTo: $locationTo, address: $address, clientId: $clientId, bookingStatus: $bookingStatus, pickupTime: $pickupTime, returnTime: $returnTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddBookingModelImpl &&
            (identical(other.serviceId, serviceId) ||
                other.serviceId == serviceId) &&
            (identical(other.advanceAmount, advanceAmount) ||
                other.advanceAmount == advanceAmount) &&
            (identical(other.securityAmount, securityAmount) ||
                other.securityAmount == securityAmount) &&
            (identical(other.discountAmount, discountAmount) ||
                other.discountAmount == discountAmount) &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.bookedDate, bookedDate) ||
                other.bookedDate == bookedDate) &&
            (identical(other.pickupDate, pickupDate) ||
                other.pickupDate == pickupDate) &&
            (identical(other.returnDate, returnDate) ||
                other.returnDate == returnDate) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.purchaseMode, purchaseMode) ||
                other.purchaseMode == purchaseMode) &&
            (identical(other.deliveryStatus, deliveryStatus) ||
                other.deliveryStatus == deliveryStatus) &&
            (identical(other.staffName, staffName) ||
                other.staffName == staffName) &&
            (identical(other.locationStart, locationStart) ||
                other.locationStart == locationStart) &&
            (identical(other.locationFrom, locationFrom) ||
                other.locationFrom == locationFrom) &&
            (identical(other.locationTo, locationTo) ||
                other.locationTo == locationTo) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.bookingStatus, bookingStatus) ||
                other.bookingStatus == bookingStatus) &&
            (identical(other.pickupTime, pickupTime) ||
                other.pickupTime == pickupTime) &&
            (identical(other.returnTime, returnTime) ||
                other.returnTime == returnTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        serviceId,
        advanceAmount,
        securityAmount,
        discountAmount,
        const DeepCollectionEquality().hash(_products),
        description,
        bookedDate,
        pickupDate,
        returnDate,
        paymentMethod,
        purchaseMode,
        deliveryStatus,
        staffName,
        locationStart,
        locationFrom,
        locationTo,
        address,
        clientId,
        bookingStatus,
        pickupTime,
        returnTime
      ]);

  /// Create a copy of AddBookingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddBookingModelImplCopyWith<_$AddBookingModelImpl> get copyWith =>
      __$$AddBookingModelImplCopyWithImpl<_$AddBookingModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddBookingModelImplToJson(
      this,
    );
  }
}

abstract class _AddBookingModel implements AddBookingModel {
  const factory _AddBookingModel(
      {@JsonKey(name: 'service_id') final int? serviceId,
      @JsonKey(name: 'advance_amount') final int? advanceAmount,
      @JsonKey(name: 'security_amount') final int? securityAmount,
      @JsonKey(name: 'discount_amount') final int? discountAmount,
      @JsonKey(name: 'sub_services') final List<ProductSelectedModel>? products,
      @JsonKey(name: 'description') final String? description,
      @JsonKey(name: 'booked_date') final String? bookedDate,
      @JsonKey(name: 'event_date') final String? pickupDate,
      @JsonKey(name: 'return_date') final String? returnDate,
      @JsonKey(name: 'payment_method') final String? paymentMethod,
      @JsonKey(name: 'purchase_mode') final String? purchaseMode,
      @JsonKey(name: 'delivery_status') final String? deliveryStatus,
      @JsonKey(name: 'staff_name') final String? staffName,
      @JsonKey(name: 'location_start') final String? locationStart,
      @JsonKey(name: 'location_from') final String? locationFrom,
      @JsonKey(name: 'location_to') final String? locationTo,
      @JsonKey(name: 'client_address') final String? address,
      @JsonKey(name: 'client_id') final int? clientId,
      @JsonKey(name: 'booking_status') final String? bookingStatus,
      @JsonKey(
          name: 'pickup_time', includeToJson: false, includeFromJson: false)
      final TimeOfDay? pickupTime,
      @JsonKey(
          name: 'return_time', includeToJson: false, includeFromJson: false)
      final TimeOfDay? returnTime}) = _$AddBookingModelImpl;

  factory _AddBookingModel.fromJson(Map<String, dynamic> json) =
      _$AddBookingModelImpl.fromJson;

  @override
  @JsonKey(name: 'service_id')
  int? get serviceId;
  @override
  @JsonKey(name: 'advance_amount')
  int? get advanceAmount;
  @override
  @JsonKey(name: 'security_amount')
  int? get securityAmount;
  @override
  @JsonKey(name: 'discount_amount')
  int? get discountAmount;
  @override
  @JsonKey(name: 'sub_services')
  List<ProductSelectedModel>? get products;
  @override
  @JsonKey(name: 'description')
  String? get description;
  @override
  @JsonKey(name: 'booked_date')
  String? get bookedDate;
  @override
  @JsonKey(name: 'event_date')
  String? get pickupDate;
  @override
  @JsonKey(name: 'return_date')
  String? get returnDate;
  @override
  @JsonKey(name: 'payment_method')
  String? get paymentMethod;
  @override
  @JsonKey(name: 'purchase_mode')
  String? get purchaseMode;
  @override
  @JsonKey(name: 'delivery_status')
  String? get deliveryStatus;
  @override
  @JsonKey(name: 'staff_name')
  String? get staffName;
  @override
  @JsonKey(name: 'location_start')
  String? get locationStart;
  @override
  @JsonKey(name: 'location_from')
  String? get locationFrom;
  @override
  @JsonKey(name: 'location_to')
  String? get locationTo;
  @override
  @JsonKey(name: 'client_address')
  String? get address;
  @override
  @JsonKey(name: 'client_id')
  int? get clientId;
  @override
  @JsonKey(name: 'booking_status')
  String? get bookingStatus;
  @override
  @JsonKey(name: 'pickup_time', includeToJson: false, includeFromJson: false)
  TimeOfDay? get pickupTime;
  @override
  @JsonKey(name: 'return_time', includeToJson: false, includeFromJson: false)
  TimeOfDay? get returnTime;

  /// Create a copy of AddBookingModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddBookingModelImplCopyWith<_$AddBookingModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
