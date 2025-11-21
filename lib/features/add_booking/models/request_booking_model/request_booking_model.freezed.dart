// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'request_booking_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RequestBookingModel _$RequestBookingModelFromJson(Map<String, dynamic> json) {
  return _RequestBookingModel.fromJson(json);
}

/// @nodoc
mixin _$RequestBookingModel {
  @JsonKey(name: 'client_id')
  int? get clientId => throw _privateConstructorUsedError;
  @JsonKey(name: 'staff_id')
  int? get staffId => throw _privateConstructorUsedError;
  @JsonKey(name: 'client', toJson: _clientToJson, includeIfNull: false)
  ClientRequestModel? get client => throw _privateConstructorUsedError;
  @JsonKey(name: 'client_address')
  String? get address => throw _privateConstructorUsedError;
  @JsonKey(name: 'booked_date')
  String? get bookedDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'pickup_date')
  String? get pickupDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'return_date')
  String? get returnDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'cooling_period_end')
  String? get coolingPeriodDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'advance_amount')
  int? get advanceAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'security_amount')
  int? get securityAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'discount_amount')
  int? get discountAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'purchase_mode')
  String? get purchaseMode => throw _privateConstructorUsedError;
  @JsonKey(name: 'description')
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_method', toJson: PaymentMethod.toJson)
  PaymentMethod? get paymentMethod => throw _privateConstructorUsedError;
  @JsonKey(name: 'delivery_status', toJson: DeliveryStatus.toJson)
  DeliveryStatus? get deliveryStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'booking_status', toJson: BookingStatus.toJson)
  BookingStatus? get bookingStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'variants', toJson: _productsToJson)
  List<ProductSelectedModel>? get products =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'details')
  BookingOtherDetailsModel? get otherDetails =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'additional_charges')
  List<AdditionalChargesModel>? get additionalCharges =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'service_id', includeToJson: false, includeFromJson: false)
  int? get serviceId => throw _privateConstructorUsedError;
  @JsonKey(name: 'pickup_time', includeToJson: false, includeFromJson: false)
  TimeOfDay? get pickupTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'return_time', includeToJson: false, includeFromJson: false)
  TimeOfDay? get returnTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'send_invoice', includeToJson: true, includeFromJson: false)
  bool get sendPdfToWhatsApp => throw _privateConstructorUsedError;

  /// Serializes this RequestBookingModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RequestBookingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RequestBookingModelCopyWith<RequestBookingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RequestBookingModelCopyWith<$Res> {
  factory $RequestBookingModelCopyWith(
    RequestBookingModel value,
    $Res Function(RequestBookingModel) then,
  ) = _$RequestBookingModelCopyWithImpl<$Res, RequestBookingModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'client_id') int? clientId,
    @JsonKey(name: 'staff_id') int? staffId,
    @JsonKey(name: 'client', toJson: _clientToJson, includeIfNull: false)
    ClientRequestModel? client,
    @JsonKey(name: 'client_address') String? address,
    @JsonKey(name: 'booked_date') String? bookedDate,
    @JsonKey(name: 'pickup_date') String? pickupDate,
    @JsonKey(name: 'return_date') String? returnDate,
    @JsonKey(name: 'cooling_period_end') String? coolingPeriodDate,
    @JsonKey(name: 'advance_amount') int? advanceAmount,
    @JsonKey(name: 'security_amount') int? securityAmount,
    @JsonKey(name: 'discount_amount') int? discountAmount,
    @JsonKey(name: 'purchase_mode') String? purchaseMode,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'payment_method', toJson: PaymentMethod.toJson)
    PaymentMethod? paymentMethod,
    @JsonKey(name: 'delivery_status', toJson: DeliveryStatus.toJson)
    DeliveryStatus? deliveryStatus,
    @JsonKey(name: 'booking_status', toJson: BookingStatus.toJson)
    BookingStatus? bookingStatus,
    @JsonKey(name: 'variants', toJson: _productsToJson)
    List<ProductSelectedModel>? products,
    @JsonKey(name: 'details') BookingOtherDetailsModel? otherDetails,
    @JsonKey(name: 'additional_charges')
    List<AdditionalChargesModel>? additionalCharges,
    @JsonKey(name: 'service_id', includeToJson: false, includeFromJson: false)
    int? serviceId,
    @JsonKey(name: 'pickup_time', includeToJson: false, includeFromJson: false)
    TimeOfDay? pickupTime,
    @JsonKey(name: 'return_time', includeToJson: false, includeFromJson: false)
    TimeOfDay? returnTime,
    @JsonKey(name: 'send_invoice', includeToJson: true, includeFromJson: false)
    bool sendPdfToWhatsApp,
  });

  $ClientRequestModelCopyWith<$Res>? get client;
  $BookingOtherDetailsModelCopyWith<$Res>? get otherDetails;
}

/// @nodoc
class _$RequestBookingModelCopyWithImpl<$Res, $Val extends RequestBookingModel>
    implements $RequestBookingModelCopyWith<$Res> {
  _$RequestBookingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RequestBookingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clientId = freezed,
    Object? staffId = freezed,
    Object? client = freezed,
    Object? address = freezed,
    Object? bookedDate = freezed,
    Object? pickupDate = freezed,
    Object? returnDate = freezed,
    Object? coolingPeriodDate = freezed,
    Object? advanceAmount = freezed,
    Object? securityAmount = freezed,
    Object? discountAmount = freezed,
    Object? purchaseMode = freezed,
    Object? description = freezed,
    Object? paymentMethod = freezed,
    Object? deliveryStatus = freezed,
    Object? bookingStatus = freezed,
    Object? products = freezed,
    Object? otherDetails = freezed,
    Object? additionalCharges = freezed,
    Object? serviceId = freezed,
    Object? pickupTime = freezed,
    Object? returnTime = freezed,
    Object? sendPdfToWhatsApp = null,
  }) {
    return _then(
      _value.copyWith(
        clientId: freezed == clientId
            ? _value.clientId
            : clientId // ignore: cast_nullable_to_non_nullable
                as int?,
        staffId: freezed == staffId
            ? _value.staffId
            : staffId // ignore: cast_nullable_to_non_nullable
                as int?,
        client: freezed == client
            ? _value.client
            : client // ignore: cast_nullable_to_non_nullable
                as ClientRequestModel?,
        address: freezed == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
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
        coolingPeriodDate: freezed == coolingPeriodDate
            ? _value.coolingPeriodDate
            : coolingPeriodDate // ignore: cast_nullable_to_non_nullable
                as String?,
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
        purchaseMode: freezed == purchaseMode
            ? _value.purchaseMode
            : purchaseMode // ignore: cast_nullable_to_non_nullable
                as String?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                as String?,
        paymentMethod: freezed == paymentMethod
            ? _value.paymentMethod
            : paymentMethod // ignore: cast_nullable_to_non_nullable
                as PaymentMethod?,
        deliveryStatus: freezed == deliveryStatus
            ? _value.deliveryStatus
            : deliveryStatus // ignore: cast_nullable_to_non_nullable
                as DeliveryStatus?,
        bookingStatus: freezed == bookingStatus
            ? _value.bookingStatus
            : bookingStatus // ignore: cast_nullable_to_non_nullable
                as BookingStatus?,
        products: freezed == products
            ? _value.products
            : products // ignore: cast_nullable_to_non_nullable
                as List<ProductSelectedModel>?,
        otherDetails: freezed == otherDetails
            ? _value.otherDetails
            : otherDetails // ignore: cast_nullable_to_non_nullable
                as BookingOtherDetailsModel?,
        additionalCharges: freezed == additionalCharges
            ? _value.additionalCharges
            : additionalCharges // ignore: cast_nullable_to_non_nullable
                as List<AdditionalChargesModel>?,
        serviceId: freezed == serviceId
            ? _value.serviceId
            : serviceId // ignore: cast_nullable_to_non_nullable
                as int?,
        pickupTime: freezed == pickupTime
            ? _value.pickupTime
            : pickupTime // ignore: cast_nullable_to_non_nullable
                as TimeOfDay?,
        returnTime: freezed == returnTime
            ? _value.returnTime
            : returnTime // ignore: cast_nullable_to_non_nullable
                as TimeOfDay?,
        sendPdfToWhatsApp: null == sendPdfToWhatsApp
            ? _value.sendPdfToWhatsApp
            : sendPdfToWhatsApp // ignore: cast_nullable_to_non_nullable
                as bool,
      ) as $Val,
    );
  }

  /// Create a copy of RequestBookingModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ClientRequestModelCopyWith<$Res>? get client {
    if (_value.client == null) {
      return null;
    }

    return $ClientRequestModelCopyWith<$Res>(_value.client!, (value) {
      return _then(_value.copyWith(client: value) as $Val);
    });
  }

  /// Create a copy of RequestBookingModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BookingOtherDetailsModelCopyWith<$Res>? get otherDetails {
    if (_value.otherDetails == null) {
      return null;
    }

    return $BookingOtherDetailsModelCopyWith<$Res>(_value.otherDetails!, (
      value,
    ) {
      return _then(_value.copyWith(otherDetails: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RequestBookingModelImplCopyWith<$Res>
    implements $RequestBookingModelCopyWith<$Res> {
  factory _$$RequestBookingModelImplCopyWith(
    _$RequestBookingModelImpl value,
    $Res Function(_$RequestBookingModelImpl) then,
  ) = __$$RequestBookingModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'client_id') int? clientId,
    @JsonKey(name: 'staff_id') int? staffId,
    @JsonKey(name: 'client', toJson: _clientToJson, includeIfNull: false)
    ClientRequestModel? client,
    @JsonKey(name: 'client_address') String? address,
    @JsonKey(name: 'booked_date') String? bookedDate,
    @JsonKey(name: 'pickup_date') String? pickupDate,
    @JsonKey(name: 'return_date') String? returnDate,
    @JsonKey(name: 'cooling_period_end') String? coolingPeriodDate,
    @JsonKey(name: 'advance_amount') int? advanceAmount,
    @JsonKey(name: 'security_amount') int? securityAmount,
    @JsonKey(name: 'discount_amount') int? discountAmount,
    @JsonKey(name: 'purchase_mode') String? purchaseMode,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'payment_method', toJson: PaymentMethod.toJson)
    PaymentMethod? paymentMethod,
    @JsonKey(name: 'delivery_status', toJson: DeliveryStatus.toJson)
    DeliveryStatus? deliveryStatus,
    @JsonKey(name: 'booking_status', toJson: BookingStatus.toJson)
    BookingStatus? bookingStatus,
    @JsonKey(name: 'variants', toJson: _productsToJson)
    List<ProductSelectedModel>? products,
    @JsonKey(name: 'details') BookingOtherDetailsModel? otherDetails,
    @JsonKey(name: 'additional_charges')
    List<AdditionalChargesModel>? additionalCharges,
    @JsonKey(name: 'service_id', includeToJson: false, includeFromJson: false)
    int? serviceId,
    @JsonKey(name: 'pickup_time', includeToJson: false, includeFromJson: false)
    TimeOfDay? pickupTime,
    @JsonKey(name: 'return_time', includeToJson: false, includeFromJson: false)
    TimeOfDay? returnTime,
    @JsonKey(name: 'send_invoice', includeToJson: true, includeFromJson: false)
    bool sendPdfToWhatsApp,
  });

  @override
  $ClientRequestModelCopyWith<$Res>? get client;
  @override
  $BookingOtherDetailsModelCopyWith<$Res>? get otherDetails;
}

/// @nodoc
class __$$RequestBookingModelImplCopyWithImpl<$Res>
    extends _$RequestBookingModelCopyWithImpl<$Res, _$RequestBookingModelImpl>
    implements _$$RequestBookingModelImplCopyWith<$Res> {
  __$$RequestBookingModelImplCopyWithImpl(
    _$RequestBookingModelImpl _value,
    $Res Function(_$RequestBookingModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RequestBookingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clientId = freezed,
    Object? staffId = freezed,
    Object? client = freezed,
    Object? address = freezed,
    Object? bookedDate = freezed,
    Object? pickupDate = freezed,
    Object? returnDate = freezed,
    Object? coolingPeriodDate = freezed,
    Object? advanceAmount = freezed,
    Object? securityAmount = freezed,
    Object? discountAmount = freezed,
    Object? purchaseMode = freezed,
    Object? description = freezed,
    Object? paymentMethod = freezed,
    Object? deliveryStatus = freezed,
    Object? bookingStatus = freezed,
    Object? products = freezed,
    Object? otherDetails = freezed,
    Object? additionalCharges = freezed,
    Object? serviceId = freezed,
    Object? pickupTime = freezed,
    Object? returnTime = freezed,
    Object? sendPdfToWhatsApp = null,
  }) {
    return _then(
      _$RequestBookingModelImpl(
        clientId: freezed == clientId
            ? _value.clientId
            : clientId // ignore: cast_nullable_to_non_nullable
                as int?,
        staffId: freezed == staffId
            ? _value.staffId
            : staffId // ignore: cast_nullable_to_non_nullable
                as int?,
        client: freezed == client
            ? _value.client
            : client // ignore: cast_nullable_to_non_nullable
                as ClientRequestModel?,
        address: freezed == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
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
        coolingPeriodDate: freezed == coolingPeriodDate
            ? _value.coolingPeriodDate
            : coolingPeriodDate // ignore: cast_nullable_to_non_nullable
                as String?,
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
        purchaseMode: freezed == purchaseMode
            ? _value.purchaseMode
            : purchaseMode // ignore: cast_nullable_to_non_nullable
                as String?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                as String?,
        paymentMethod: freezed == paymentMethod
            ? _value.paymentMethod
            : paymentMethod // ignore: cast_nullable_to_non_nullable
                as PaymentMethod?,
        deliveryStatus: freezed == deliveryStatus
            ? _value.deliveryStatus
            : deliveryStatus // ignore: cast_nullable_to_non_nullable
                as DeliveryStatus?,
        bookingStatus: freezed == bookingStatus
            ? _value.bookingStatus
            : bookingStatus // ignore: cast_nullable_to_non_nullable
                as BookingStatus?,
        products: freezed == products
            ? _value._products
            : products // ignore: cast_nullable_to_non_nullable
                as List<ProductSelectedModel>?,
        otherDetails: freezed == otherDetails
            ? _value.otherDetails
            : otherDetails // ignore: cast_nullable_to_non_nullable
                as BookingOtherDetailsModel?,
        additionalCharges: freezed == additionalCharges
            ? _value._additionalCharges
            : additionalCharges // ignore: cast_nullable_to_non_nullable
                as List<AdditionalChargesModel>?,
        serviceId: freezed == serviceId
            ? _value.serviceId
            : serviceId // ignore: cast_nullable_to_non_nullable
                as int?,
        pickupTime: freezed == pickupTime
            ? _value.pickupTime
            : pickupTime // ignore: cast_nullable_to_non_nullable
                as TimeOfDay?,
        returnTime: freezed == returnTime
            ? _value.returnTime
            : returnTime // ignore: cast_nullable_to_non_nullable
                as TimeOfDay?,
        sendPdfToWhatsApp: null == sendPdfToWhatsApp
            ? _value.sendPdfToWhatsApp
            : sendPdfToWhatsApp // ignore: cast_nullable_to_non_nullable
                as bool,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$RequestBookingModelImpl implements _RequestBookingModel {
  const _$RequestBookingModelImpl({
    @JsonKey(name: 'client_id') this.clientId,
    @JsonKey(name: 'staff_id') this.staffId,
    @JsonKey(name: 'client', toJson: _clientToJson, includeIfNull: false)
    this.client,
    @JsonKey(name: 'client_address') this.address,
    @JsonKey(name: 'booked_date') this.bookedDate,
    @JsonKey(name: 'pickup_date') this.pickupDate,
    @JsonKey(name: 'return_date') this.returnDate,
    @JsonKey(name: 'cooling_period_end') this.coolingPeriodDate,
    @JsonKey(name: 'advance_amount') this.advanceAmount,
    @JsonKey(name: 'security_amount') this.securityAmount,
    @JsonKey(name: 'discount_amount') this.discountAmount,
    @JsonKey(name: 'purchase_mode') this.purchaseMode,
    @JsonKey(name: 'description') this.description,
    @JsonKey(name: 'payment_method', toJson: PaymentMethod.toJson)
    this.paymentMethod,
    @JsonKey(name: 'delivery_status', toJson: DeliveryStatus.toJson)
    this.deliveryStatus,
    @JsonKey(name: 'booking_status', toJson: BookingStatus.toJson)
    this.bookingStatus,
    @JsonKey(name: 'variants', toJson: _productsToJson)
    final List<ProductSelectedModel>? products,
    @JsonKey(name: 'details') this.otherDetails,
    @JsonKey(name: 'additional_charges')
    final List<AdditionalChargesModel>? additionalCharges,
    @JsonKey(name: 'service_id', includeToJson: false, includeFromJson: false)
    this.serviceId,
    @JsonKey(name: 'pickup_time', includeToJson: false, includeFromJson: false)
    this.pickupTime,
    @JsonKey(name: 'return_time', includeToJson: false, includeFromJson: false)
    this.returnTime,
    @JsonKey(name: 'send_invoice', includeToJson: true, includeFromJson: false)
    this.sendPdfToWhatsApp = false,
  })  : _products = products,
        _additionalCharges = additionalCharges;

  factory _$RequestBookingModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RequestBookingModelImplFromJson(json);

  @override
  @JsonKey(name: 'client_id')
  final int? clientId;
  @override
  @JsonKey(name: 'staff_id')
  final int? staffId;
  @override
  @JsonKey(name: 'client', toJson: _clientToJson, includeIfNull: false)
  final ClientRequestModel? client;
  @override
  @JsonKey(name: 'client_address')
  final String? address;
  @override
  @JsonKey(name: 'booked_date')
  final String? bookedDate;
  @override
  @JsonKey(name: 'pickup_date')
  final String? pickupDate;
  @override
  @JsonKey(name: 'return_date')
  final String? returnDate;
  @override
  @JsonKey(name: 'cooling_period_end')
  final String? coolingPeriodDate;
  @override
  @JsonKey(name: 'advance_amount')
  final int? advanceAmount;
  @override
  @JsonKey(name: 'security_amount')
  final int? securityAmount;
  @override
  @JsonKey(name: 'discount_amount')
  final int? discountAmount;
  @override
  @JsonKey(name: 'purchase_mode')
  final String? purchaseMode;
  @override
  @JsonKey(name: 'description')
  final String? description;
  @override
  @JsonKey(name: 'payment_method', toJson: PaymentMethod.toJson)
  final PaymentMethod? paymentMethod;
  @override
  @JsonKey(name: 'delivery_status', toJson: DeliveryStatus.toJson)
  final DeliveryStatus? deliveryStatus;
  @override
  @JsonKey(name: 'booking_status', toJson: BookingStatus.toJson)
  final BookingStatus? bookingStatus;
  final List<ProductSelectedModel>? _products;
  @override
  @JsonKey(name: 'variants', toJson: _productsToJson)
  List<ProductSelectedModel>? get products {
    final value = _products;
    if (value == null) return null;
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'details')
  final BookingOtherDetailsModel? otherDetails;
  final List<AdditionalChargesModel>? _additionalCharges;
  @override
  @JsonKey(name: 'additional_charges')
  List<AdditionalChargesModel>? get additionalCharges {
    final value = _additionalCharges;
    if (value == null) return null;
    if (_additionalCharges is EqualUnmodifiableListView)
      return _additionalCharges;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'service_id', includeToJson: false, includeFromJson: false)
  final int? serviceId;
  @override
  @JsonKey(name: 'pickup_time', includeToJson: false, includeFromJson: false)
  final TimeOfDay? pickupTime;
  @override
  @JsonKey(name: 'return_time', includeToJson: false, includeFromJson: false)
  final TimeOfDay? returnTime;
  @override
  @JsonKey(name: 'send_invoice', includeToJson: true, includeFromJson: false)
  final bool sendPdfToWhatsApp;

  @override
  String toString() {
    return 'RequestBookingModel(clientId: $clientId, staffId: $staffId, client: $client, address: $address, bookedDate: $bookedDate, pickupDate: $pickupDate, returnDate: $returnDate, coolingPeriodDate: $coolingPeriodDate, advanceAmount: $advanceAmount, securityAmount: $securityAmount, discountAmount: $discountAmount, purchaseMode: $purchaseMode, description: $description, paymentMethod: $paymentMethod, deliveryStatus: $deliveryStatus, bookingStatus: $bookingStatus, products: $products, otherDetails: $otherDetails, additionalCharges: $additionalCharges, serviceId: $serviceId, pickupTime: $pickupTime, returnTime: $returnTime, sendPdfToWhatsApp: $sendPdfToWhatsApp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestBookingModelImpl &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.staffId, staffId) || other.staffId == staffId) &&
            (identical(other.client, client) || other.client == client) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.bookedDate, bookedDate) ||
                other.bookedDate == bookedDate) &&
            (identical(other.pickupDate, pickupDate) ||
                other.pickupDate == pickupDate) &&
            (identical(other.returnDate, returnDate) ||
                other.returnDate == returnDate) &&
            (identical(other.coolingPeriodDate, coolingPeriodDate) ||
                other.coolingPeriodDate == coolingPeriodDate) &&
            (identical(other.advanceAmount, advanceAmount) ||
                other.advanceAmount == advanceAmount) &&
            (identical(other.securityAmount, securityAmount) ||
                other.securityAmount == securityAmount) &&
            (identical(other.discountAmount, discountAmount) ||
                other.discountAmount == discountAmount) &&
            (identical(other.purchaseMode, purchaseMode) ||
                other.purchaseMode == purchaseMode) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.deliveryStatus, deliveryStatus) ||
                other.deliveryStatus == deliveryStatus) &&
            (identical(other.bookingStatus, bookingStatus) ||
                other.bookingStatus == bookingStatus) &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            (identical(other.otherDetails, otherDetails) ||
                other.otherDetails == otherDetails) &&
            const DeepCollectionEquality().equals(
              other._additionalCharges,
              _additionalCharges,
            ) &&
            (identical(other.serviceId, serviceId) ||
                other.serviceId == serviceId) &&
            (identical(other.pickupTime, pickupTime) ||
                other.pickupTime == pickupTime) &&
            (identical(other.returnTime, returnTime) ||
                other.returnTime == returnTime) &&
            (identical(other.sendPdfToWhatsApp, sendPdfToWhatsApp) ||
                other.sendPdfToWhatsApp == sendPdfToWhatsApp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        clientId,
        staffId,
        client,
        address,
        bookedDate,
        pickupDate,
        returnDate,
        coolingPeriodDate,
        advanceAmount,
        securityAmount,
        discountAmount,
        purchaseMode,
        description,
        paymentMethod,
        deliveryStatus,
        bookingStatus,
        const DeepCollectionEquality().hash(_products),
        otherDetails,
        const DeepCollectionEquality().hash(_additionalCharges),
        serviceId,
        pickupTime,
        returnTime,
        sendPdfToWhatsApp,
      ]);

  /// Create a copy of RequestBookingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RequestBookingModelImplCopyWith<_$RequestBookingModelImpl> get copyWith =>
      __$$RequestBookingModelImplCopyWithImpl<_$RequestBookingModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RequestBookingModelImplToJson(this);
  }
}

abstract class _RequestBookingModel implements RequestBookingModel {
  const factory _RequestBookingModel({
    @JsonKey(name: 'client_id') final int? clientId,
    @JsonKey(name: 'staff_id') final int? staffId,
    @JsonKey(name: 'client', toJson: _clientToJson, includeIfNull: false)
    final ClientRequestModel? client,
    @JsonKey(name: 'client_address') final String? address,
    @JsonKey(name: 'booked_date') final String? bookedDate,
    @JsonKey(name: 'pickup_date') final String? pickupDate,
    @JsonKey(name: 'return_date') final String? returnDate,
    @JsonKey(name: 'cooling_period_end') final String? coolingPeriodDate,
    @JsonKey(name: 'advance_amount') final int? advanceAmount,
    @JsonKey(name: 'security_amount') final int? securityAmount,
    @JsonKey(name: 'discount_amount') final int? discountAmount,
    @JsonKey(name: 'purchase_mode') final String? purchaseMode,
    @JsonKey(name: 'description') final String? description,
    @JsonKey(name: 'payment_method', toJson: PaymentMethod.toJson)
    final PaymentMethod? paymentMethod,
    @JsonKey(name: 'delivery_status', toJson: DeliveryStatus.toJson)
    final DeliveryStatus? deliveryStatus,
    @JsonKey(name: 'booking_status', toJson: BookingStatus.toJson)
    final BookingStatus? bookingStatus,
    @JsonKey(name: 'variants', toJson: _productsToJson)
    final List<ProductSelectedModel>? products,
    @JsonKey(name: 'details') final BookingOtherDetailsModel? otherDetails,
    @JsonKey(name: 'additional_charges')
    final List<AdditionalChargesModel>? additionalCharges,
    @JsonKey(name: 'service_id', includeToJson: false, includeFromJson: false)
    final int? serviceId,
    @JsonKey(name: 'pickup_time', includeToJson: false, includeFromJson: false)
    final TimeOfDay? pickupTime,
    @JsonKey(name: 'return_time', includeToJson: false, includeFromJson: false)
    final TimeOfDay? returnTime,
    @JsonKey(name: 'send_invoice', includeToJson: true, includeFromJson: false)
    final bool sendPdfToWhatsApp,
  }) = _$RequestBookingModelImpl;

  factory _RequestBookingModel.fromJson(Map<String, dynamic> json) =
      _$RequestBookingModelImpl.fromJson;

  @override
  @JsonKey(name: 'client_id')
  int? get clientId;
  @override
  @JsonKey(name: 'staff_id')
  int? get staffId;
  @override
  @JsonKey(name: 'client', toJson: _clientToJson, includeIfNull: false)
  ClientRequestModel? get client;
  @override
  @JsonKey(name: 'client_address')
  String? get address;
  @override
  @JsonKey(name: 'booked_date')
  String? get bookedDate;
  @override
  @JsonKey(name: 'pickup_date')
  String? get pickupDate;
  @override
  @JsonKey(name: 'return_date')
  String? get returnDate;
  @override
  @JsonKey(name: 'cooling_period_end')
  String? get coolingPeriodDate;
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
  @JsonKey(name: 'purchase_mode')
  String? get purchaseMode;
  @override
  @JsonKey(name: 'description')
  String? get description;
  @override
  @JsonKey(name: 'payment_method', toJson: PaymentMethod.toJson)
  PaymentMethod? get paymentMethod;
  @override
  @JsonKey(name: 'delivery_status', toJson: DeliveryStatus.toJson)
  DeliveryStatus? get deliveryStatus;
  @override
  @JsonKey(name: 'booking_status', toJson: BookingStatus.toJson)
  BookingStatus? get bookingStatus;
  @override
  @JsonKey(name: 'variants', toJson: _productsToJson)
  List<ProductSelectedModel>? get products;
  @override
  @JsonKey(name: 'details')
  BookingOtherDetailsModel? get otherDetails;
  @override
  @JsonKey(name: 'additional_charges')
  List<AdditionalChargesModel>? get additionalCharges;
  @override
  @JsonKey(name: 'service_id', includeToJson: false, includeFromJson: false)
  int? get serviceId;
  @override
  @JsonKey(name: 'pickup_time', includeToJson: false, includeFromJson: false)
  TimeOfDay? get pickupTime;
  @override
  @JsonKey(name: 'return_time', includeToJson: false, includeFromJson: false)
  TimeOfDay? get returnTime;
  @override
  @JsonKey(name: 'send_invoice', includeToJson: true, includeFromJson: false)
  bool get sendPdfToWhatsApp;

  /// Create a copy of RequestBookingModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RequestBookingModelImplCopyWith<_$RequestBookingModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
