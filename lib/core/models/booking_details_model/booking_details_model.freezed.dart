// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_details_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BookingDetailsModel _$BookingDetailsModelFromJson(Map<String, dynamic> json) {
  return _BookingDetailsModel.fromJson(json);
}

/// @nodoc
mixin _$BookingDetailsModel {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'shop_booking_id')
  String get invoiceId => throw _privateConstructorUsedError;
  String? get pickupDate => throw _privateConstructorUsedError;
  String get returnDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'cooling_period_end')
  String? get coolingPeriodDate => throw _privateConstructorUsedError;
  int get totalAmount => throw _privateConstructorUsedError;
  int? get discountAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'advance_amount')
  int get paidAmount => throw _privateConstructorUsedError;
  int? get securityAmount => throw _privateConstructorUsedError;
  @JsonKey(fromJson: PurchaseMode.fromString, defaultValue: PurchaseMode.normal)
  PurchaseMode get purchaseMode => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: BookingStatus.fromString,
      toJson: BookingStatus.toJson,
      defaultValue: BookingStatus.upcoming)
  BookingStatus get bookingStatus => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: PaymentStatus.fromBool,
      toJson: PaymentStatus.toJson,
      defaultValue: PaymentStatus.pending)
  PaymentStatus get paymentStatus => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: DeliveryStatus.fromString,
      toJson: DeliveryStatus.toJson,
      defaultValue: DeliveryStatus.booked)
  DeliveryStatus get deliveryStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'staff_name')
  String? get staffName => throw _privateConstructorUsedError;
  @JsonKey(name: 'staff_id')
  int? get staffId => throw _privateConstructorUsedError;
  @JsonKey(name: 'details', defaultValue: BookingOtherDetailsModel.empty)
  BookingOtherDetailsModel get otherDetails =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String get bookedDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'completed_at')
  String? get bookingCompletedDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'client_address')
  String? get address => throw _privateConstructorUsedError;
  ClientModel get client => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  List<dynamic> get documents => throw _privateConstructorUsedError;
  List<ProductInfoModel> get bookedItems => throw _privateConstructorUsedError;
  @JsonKey(name: 'additional_charges')
  List<AdditionalChargesModel> get additionalCharges =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'payments')
  List<BookingDetailsPaymentHistoryModel> get payments =>
      throw _privateConstructorUsedError;
  List<dynamic> get refunds => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_refunded')
  double get totalRefunded => throw _privateConstructorUsedError;
  @JsonKey(name: 'refundable_balance')
  double get refundableBalance => throw _privateConstructorUsedError;
  @JsonKey(name: 'security_summary')
  SecuritySummaryModel get securitySummary =>
      throw _privateConstructorUsedError;

  /// Serializes this BookingDetailsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BookingDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookingDetailsModelCopyWith<BookingDetailsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingDetailsModelCopyWith<$Res> {
  factory $BookingDetailsModelCopyWith(
          BookingDetailsModel value, $Res Function(BookingDetailsModel) then) =
      _$BookingDetailsModelCopyWithImpl<$Res, BookingDetailsModel>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'shop_booking_id') String invoiceId,
      String? pickupDate,
      String returnDate,
      @JsonKey(name: 'cooling_period_end') String? coolingPeriodDate,
      int totalAmount,
      int? discountAmount,
      @JsonKey(name: 'advance_amount') int paidAmount,
      int? securityAmount,
      @JsonKey(
          fromJson: PurchaseMode.fromString, defaultValue: PurchaseMode.normal)
      PurchaseMode purchaseMode,
      @JsonKey(
          fromJson: BookingStatus.fromString,
          toJson: BookingStatus.toJson,
          defaultValue: BookingStatus.upcoming)
      BookingStatus bookingStatus,
      @JsonKey(
          fromJson: PaymentStatus.fromBool,
          toJson: PaymentStatus.toJson,
          defaultValue: PaymentStatus.pending)
      PaymentStatus paymentStatus,
      @JsonKey(
          fromJson: DeliveryStatus.fromString,
          toJson: DeliveryStatus.toJson,
          defaultValue: DeliveryStatus.booked)
      DeliveryStatus deliveryStatus,
      @JsonKey(name: 'staff_name') String? staffName,
      @JsonKey(name: 'staff_id') int? staffId,
      @JsonKey(name: 'details', defaultValue: BookingOtherDetailsModel.empty)
      BookingOtherDetailsModel otherDetails,
      @JsonKey(name: 'created_at') String bookedDate,
      @JsonKey(name: 'completed_at') String? bookingCompletedDate,
      @JsonKey(name: 'client_address') String? address,
      ClientModel client,
      String? description,
      List<dynamic> documents,
      List<ProductInfoModel> bookedItems,
      @JsonKey(name: 'additional_charges')
      List<AdditionalChargesModel> additionalCharges,
      @JsonKey(name: 'payments')
      List<BookingDetailsPaymentHistoryModel> payments,
      List<dynamic> refunds,
      @JsonKey(name: 'total_refunded') double totalRefunded,
      @JsonKey(name: 'refundable_balance') double refundableBalance,
      @JsonKey(name: 'security_summary') SecuritySummaryModel securitySummary});

  $BookingOtherDetailsModelCopyWith<$Res> get otherDetails;
  $ClientModelCopyWith<$Res> get client;
  $SecuritySummaryModelCopyWith<$Res> get securitySummary;
}

/// @nodoc
class _$BookingDetailsModelCopyWithImpl<$Res, $Val extends BookingDetailsModel>
    implements $BookingDetailsModelCopyWith<$Res> {
  _$BookingDetailsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookingDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? invoiceId = null,
    Object? pickupDate = freezed,
    Object? returnDate = null,
    Object? coolingPeriodDate = freezed,
    Object? totalAmount = null,
    Object? discountAmount = freezed,
    Object? paidAmount = null,
    Object? securityAmount = freezed,
    Object? purchaseMode = null,
    Object? bookingStatus = null,
    Object? paymentStatus = null,
    Object? deliveryStatus = null,
    Object? staffName = freezed,
    Object? staffId = freezed,
    Object? otherDetails = null,
    Object? bookedDate = null,
    Object? bookingCompletedDate = freezed,
    Object? address = freezed,
    Object? client = null,
    Object? description = freezed,
    Object? documents = null,
    Object? bookedItems = null,
    Object? additionalCharges = null,
    Object? payments = null,
    Object? refunds = null,
    Object? totalRefunded = null,
    Object? refundableBalance = null,
    Object? securitySummary = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      invoiceId: null == invoiceId
          ? _value.invoiceId
          : invoiceId // ignore: cast_nullable_to_non_nullable
              as String,
      pickupDate: freezed == pickupDate
          ? _value.pickupDate
          : pickupDate // ignore: cast_nullable_to_non_nullable
              as String?,
      returnDate: null == returnDate
          ? _value.returnDate
          : returnDate // ignore: cast_nullable_to_non_nullable
              as String,
      coolingPeriodDate: freezed == coolingPeriodDate
          ? _value.coolingPeriodDate
          : coolingPeriodDate // ignore: cast_nullable_to_non_nullable
              as String?,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as int,
      discountAmount: freezed == discountAmount
          ? _value.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as int?,
      paidAmount: null == paidAmount
          ? _value.paidAmount
          : paidAmount // ignore: cast_nullable_to_non_nullable
              as int,
      securityAmount: freezed == securityAmount
          ? _value.securityAmount
          : securityAmount // ignore: cast_nullable_to_non_nullable
              as int?,
      purchaseMode: null == purchaseMode
          ? _value.purchaseMode
          : purchaseMode // ignore: cast_nullable_to_non_nullable
              as PurchaseMode,
      bookingStatus: null == bookingStatus
          ? _value.bookingStatus
          : bookingStatus // ignore: cast_nullable_to_non_nullable
              as BookingStatus,
      paymentStatus: null == paymentStatus
          ? _value.paymentStatus
          : paymentStatus // ignore: cast_nullable_to_non_nullable
              as PaymentStatus,
      deliveryStatus: null == deliveryStatus
          ? _value.deliveryStatus
          : deliveryStatus // ignore: cast_nullable_to_non_nullable
              as DeliveryStatus,
      staffName: freezed == staffName
          ? _value.staffName
          : staffName // ignore: cast_nullable_to_non_nullable
              as String?,
      staffId: freezed == staffId
          ? _value.staffId
          : staffId // ignore: cast_nullable_to_non_nullable
              as int?,
      otherDetails: null == otherDetails
          ? _value.otherDetails
          : otherDetails // ignore: cast_nullable_to_non_nullable
              as BookingOtherDetailsModel,
      bookedDate: null == bookedDate
          ? _value.bookedDate
          : bookedDate // ignore: cast_nullable_to_non_nullable
              as String,
      bookingCompletedDate: freezed == bookingCompletedDate
          ? _value.bookingCompletedDate
          : bookingCompletedDate // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      client: null == client
          ? _value.client
          : client // ignore: cast_nullable_to_non_nullable
              as ClientModel,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      documents: null == documents
          ? _value.documents
          : documents // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      bookedItems: null == bookedItems
          ? _value.bookedItems
          : bookedItems // ignore: cast_nullable_to_non_nullable
              as List<ProductInfoModel>,
      additionalCharges: null == additionalCharges
          ? _value.additionalCharges
          : additionalCharges // ignore: cast_nullable_to_non_nullable
              as List<AdditionalChargesModel>,
      payments: null == payments
          ? _value.payments
          : payments // ignore: cast_nullable_to_non_nullable
              as List<BookingDetailsPaymentHistoryModel>,
      refunds: null == refunds
          ? _value.refunds
          : refunds // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      totalRefunded: null == totalRefunded
          ? _value.totalRefunded
          : totalRefunded // ignore: cast_nullable_to_non_nullable
              as double,
      refundableBalance: null == refundableBalance
          ? _value.refundableBalance
          : refundableBalance // ignore: cast_nullable_to_non_nullable
              as double,
      securitySummary: null == securitySummary
          ? _value.securitySummary
          : securitySummary // ignore: cast_nullable_to_non_nullable
              as SecuritySummaryModel,
    ) as $Val);
  }

  /// Create a copy of BookingDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BookingOtherDetailsModelCopyWith<$Res> get otherDetails {
    return $BookingOtherDetailsModelCopyWith<$Res>(_value.otherDetails,
        (value) {
      return _then(_value.copyWith(otherDetails: value) as $Val);
    });
  }

  /// Create a copy of BookingDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ClientModelCopyWith<$Res> get client {
    return $ClientModelCopyWith<$Res>(_value.client, (value) {
      return _then(_value.copyWith(client: value) as $Val);
    });
  }

  /// Create a copy of BookingDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SecuritySummaryModelCopyWith<$Res> get securitySummary {
    return $SecuritySummaryModelCopyWith<$Res>(_value.securitySummary, (value) {
      return _then(_value.copyWith(securitySummary: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BookingDetailsModelImplCopyWith<$Res>
    implements $BookingDetailsModelCopyWith<$Res> {
  factory _$$BookingDetailsModelImplCopyWith(_$BookingDetailsModelImpl value,
          $Res Function(_$BookingDetailsModelImpl) then) =
      __$$BookingDetailsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'shop_booking_id') String invoiceId,
      String? pickupDate,
      String returnDate,
      @JsonKey(name: 'cooling_period_end') String? coolingPeriodDate,
      int totalAmount,
      int? discountAmount,
      @JsonKey(name: 'advance_amount') int paidAmount,
      int? securityAmount,
      @JsonKey(
          fromJson: PurchaseMode.fromString, defaultValue: PurchaseMode.normal)
      PurchaseMode purchaseMode,
      @JsonKey(
          fromJson: BookingStatus.fromString,
          toJson: BookingStatus.toJson,
          defaultValue: BookingStatus.upcoming)
      BookingStatus bookingStatus,
      @JsonKey(
          fromJson: PaymentStatus.fromBool,
          toJson: PaymentStatus.toJson,
          defaultValue: PaymentStatus.pending)
      PaymentStatus paymentStatus,
      @JsonKey(
          fromJson: DeliveryStatus.fromString,
          toJson: DeliveryStatus.toJson,
          defaultValue: DeliveryStatus.booked)
      DeliveryStatus deliveryStatus,
      @JsonKey(name: 'staff_name') String? staffName,
      @JsonKey(name: 'staff_id') int? staffId,
      @JsonKey(name: 'details', defaultValue: BookingOtherDetailsModel.empty)
      BookingOtherDetailsModel otherDetails,
      @JsonKey(name: 'created_at') String bookedDate,
      @JsonKey(name: 'completed_at') String? bookingCompletedDate,
      @JsonKey(name: 'client_address') String? address,
      ClientModel client,
      String? description,
      List<dynamic> documents,
      List<ProductInfoModel> bookedItems,
      @JsonKey(name: 'additional_charges')
      List<AdditionalChargesModel> additionalCharges,
      @JsonKey(name: 'payments')
      List<BookingDetailsPaymentHistoryModel> payments,
      List<dynamic> refunds,
      @JsonKey(name: 'total_refunded') double totalRefunded,
      @JsonKey(name: 'refundable_balance') double refundableBalance,
      @JsonKey(name: 'security_summary') SecuritySummaryModel securitySummary});

  @override
  $BookingOtherDetailsModelCopyWith<$Res> get otherDetails;
  @override
  $ClientModelCopyWith<$Res> get client;
  @override
  $SecuritySummaryModelCopyWith<$Res> get securitySummary;
}

/// @nodoc
class __$$BookingDetailsModelImplCopyWithImpl<$Res>
    extends _$BookingDetailsModelCopyWithImpl<$Res, _$BookingDetailsModelImpl>
    implements _$$BookingDetailsModelImplCopyWith<$Res> {
  __$$BookingDetailsModelImplCopyWithImpl(_$BookingDetailsModelImpl _value,
      $Res Function(_$BookingDetailsModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookingDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? invoiceId = null,
    Object? pickupDate = freezed,
    Object? returnDate = null,
    Object? coolingPeriodDate = freezed,
    Object? totalAmount = null,
    Object? discountAmount = freezed,
    Object? paidAmount = null,
    Object? securityAmount = freezed,
    Object? purchaseMode = null,
    Object? bookingStatus = null,
    Object? paymentStatus = null,
    Object? deliveryStatus = null,
    Object? staffName = freezed,
    Object? staffId = freezed,
    Object? otherDetails = null,
    Object? bookedDate = null,
    Object? bookingCompletedDate = freezed,
    Object? address = freezed,
    Object? client = null,
    Object? description = freezed,
    Object? documents = null,
    Object? bookedItems = null,
    Object? additionalCharges = null,
    Object? payments = null,
    Object? refunds = null,
    Object? totalRefunded = null,
    Object? refundableBalance = null,
    Object? securitySummary = null,
  }) {
    return _then(_$BookingDetailsModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      invoiceId: null == invoiceId
          ? _value.invoiceId
          : invoiceId // ignore: cast_nullable_to_non_nullable
              as String,
      pickupDate: freezed == pickupDate
          ? _value.pickupDate
          : pickupDate // ignore: cast_nullable_to_non_nullable
              as String?,
      returnDate: null == returnDate
          ? _value.returnDate
          : returnDate // ignore: cast_nullable_to_non_nullable
              as String,
      coolingPeriodDate: freezed == coolingPeriodDate
          ? _value.coolingPeriodDate
          : coolingPeriodDate // ignore: cast_nullable_to_non_nullable
              as String?,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as int,
      discountAmount: freezed == discountAmount
          ? _value.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as int?,
      paidAmount: null == paidAmount
          ? _value.paidAmount
          : paidAmount // ignore: cast_nullable_to_non_nullable
              as int,
      securityAmount: freezed == securityAmount
          ? _value.securityAmount
          : securityAmount // ignore: cast_nullable_to_non_nullable
              as int?,
      purchaseMode: null == purchaseMode
          ? _value.purchaseMode
          : purchaseMode // ignore: cast_nullable_to_non_nullable
              as PurchaseMode,
      bookingStatus: null == bookingStatus
          ? _value.bookingStatus
          : bookingStatus // ignore: cast_nullable_to_non_nullable
              as BookingStatus,
      paymentStatus: null == paymentStatus
          ? _value.paymentStatus
          : paymentStatus // ignore: cast_nullable_to_non_nullable
              as PaymentStatus,
      deliveryStatus: null == deliveryStatus
          ? _value.deliveryStatus
          : deliveryStatus // ignore: cast_nullable_to_non_nullable
              as DeliveryStatus,
      staffName: freezed == staffName
          ? _value.staffName
          : staffName // ignore: cast_nullable_to_non_nullable
              as String?,
      staffId: freezed == staffId
          ? _value.staffId
          : staffId // ignore: cast_nullable_to_non_nullable
              as int?,
      otherDetails: null == otherDetails
          ? _value.otherDetails
          : otherDetails // ignore: cast_nullable_to_non_nullable
              as BookingOtherDetailsModel,
      bookedDate: null == bookedDate
          ? _value.bookedDate
          : bookedDate // ignore: cast_nullable_to_non_nullable
              as String,
      bookingCompletedDate: freezed == bookingCompletedDate
          ? _value.bookingCompletedDate
          : bookingCompletedDate // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      client: null == client
          ? _value.client
          : client // ignore: cast_nullable_to_non_nullable
              as ClientModel,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      documents: null == documents
          ? _value._documents
          : documents // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      bookedItems: null == bookedItems
          ? _value._bookedItems
          : bookedItems // ignore: cast_nullable_to_non_nullable
              as List<ProductInfoModel>,
      additionalCharges: null == additionalCharges
          ? _value._additionalCharges
          : additionalCharges // ignore: cast_nullable_to_non_nullable
              as List<AdditionalChargesModel>,
      payments: null == payments
          ? _value._payments
          : payments // ignore: cast_nullable_to_non_nullable
              as List<BookingDetailsPaymentHistoryModel>,
      refunds: null == refunds
          ? _value._refunds
          : refunds // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      totalRefunded: null == totalRefunded
          ? _value.totalRefunded
          : totalRefunded // ignore: cast_nullable_to_non_nullable
              as double,
      refundableBalance: null == refundableBalance
          ? _value.refundableBalance
          : refundableBalance // ignore: cast_nullable_to_non_nullable
              as double,
      securitySummary: null == securitySummary
          ? _value.securitySummary
          : securitySummary // ignore: cast_nullable_to_non_nullable
              as SecuritySummaryModel,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$BookingDetailsModelImpl implements _BookingDetailsModel {
  const _$BookingDetailsModelImpl(
      {required this.id,
      @JsonKey(name: 'shop_booking_id') required this.invoiceId,
      required this.pickupDate,
      required this.returnDate,
      @JsonKey(name: 'cooling_period_end') this.coolingPeriodDate,
      required this.totalAmount,
      this.discountAmount,
      @JsonKey(name: 'advance_amount') required this.paidAmount,
      this.securityAmount,
      @JsonKey(
          fromJson: PurchaseMode.fromString, defaultValue: PurchaseMode.normal)
      required this.purchaseMode,
      @JsonKey(
          fromJson: BookingStatus.fromString,
          toJson: BookingStatus.toJson,
          defaultValue: BookingStatus.upcoming)
      required this.bookingStatus,
      @JsonKey(
          fromJson: PaymentStatus.fromBool,
          toJson: PaymentStatus.toJson,
          defaultValue: PaymentStatus.pending)
      required this.paymentStatus,
      @JsonKey(
          fromJson: DeliveryStatus.fromString,
          toJson: DeliveryStatus.toJson,
          defaultValue: DeliveryStatus.booked)
      required this.deliveryStatus,
      @JsonKey(name: 'staff_name') this.staffName,
      @JsonKey(name: 'staff_id') this.staffId,
      @JsonKey(name: 'details', defaultValue: BookingOtherDetailsModel.empty)
      required this.otherDetails,
      @JsonKey(name: 'created_at') required this.bookedDate,
      @JsonKey(name: 'completed_at') this.bookingCompletedDate,
      @JsonKey(name: 'client_address') this.address,
      required this.client,
      this.description,
      final List<dynamic> documents = const [],
      required final List<ProductInfoModel> bookedItems,
      @JsonKey(name: 'additional_charges')
      final List<AdditionalChargesModel> additionalCharges = const [],
      @JsonKey(name: 'payments')
      final List<BookingDetailsPaymentHistoryModel> payments = const [],
      final List<dynamic> refunds = const [],
      @JsonKey(name: 'total_refunded') this.totalRefunded = 0.0,
      @JsonKey(name: 'refundable_balance') this.refundableBalance = 0.0,
      @JsonKey(name: 'security_summary')
      this.securitySummary = SecuritySummaryModel.empty})
      : _documents = documents,
        _bookedItems = bookedItems,
        _additionalCharges = additionalCharges,
        _payments = payments,
        _refunds = refunds;

  factory _$BookingDetailsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookingDetailsModelImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'shop_booking_id')
  final String invoiceId;
  @override
  final String? pickupDate;
  @override
  final String returnDate;
  @override
  @JsonKey(name: 'cooling_period_end')
  final String? coolingPeriodDate;
  @override
  final int totalAmount;
  @override
  final int? discountAmount;
  @override
  @JsonKey(name: 'advance_amount')
  final int paidAmount;
  @override
  final int? securityAmount;
  @override
  @JsonKey(fromJson: PurchaseMode.fromString, defaultValue: PurchaseMode.normal)
  final PurchaseMode purchaseMode;
  @override
  @JsonKey(
      fromJson: BookingStatus.fromString,
      toJson: BookingStatus.toJson,
      defaultValue: BookingStatus.upcoming)
  final BookingStatus bookingStatus;
  @override
  @JsonKey(
      fromJson: PaymentStatus.fromBool,
      toJson: PaymentStatus.toJson,
      defaultValue: PaymentStatus.pending)
  final PaymentStatus paymentStatus;
  @override
  @JsonKey(
      fromJson: DeliveryStatus.fromString,
      toJson: DeliveryStatus.toJson,
      defaultValue: DeliveryStatus.booked)
  final DeliveryStatus deliveryStatus;
  @override
  @JsonKey(name: 'staff_name')
  final String? staffName;
  @override
  @JsonKey(name: 'staff_id')
  final int? staffId;
  @override
  @JsonKey(name: 'details', defaultValue: BookingOtherDetailsModel.empty)
  final BookingOtherDetailsModel otherDetails;
  @override
  @JsonKey(name: 'created_at')
  final String bookedDate;
  @override
  @JsonKey(name: 'completed_at')
  final String? bookingCompletedDate;
  @override
  @JsonKey(name: 'client_address')
  final String? address;
  @override
  final ClientModel client;
  @override
  final String? description;
  final List<dynamic> _documents;
  @override
  @JsonKey()
  List<dynamic> get documents {
    if (_documents is EqualUnmodifiableListView) return _documents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_documents);
  }

  final List<ProductInfoModel> _bookedItems;
  @override
  List<ProductInfoModel> get bookedItems {
    if (_bookedItems is EqualUnmodifiableListView) return _bookedItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bookedItems);
  }

  final List<AdditionalChargesModel> _additionalCharges;
  @override
  @JsonKey(name: 'additional_charges')
  List<AdditionalChargesModel> get additionalCharges {
    if (_additionalCharges is EqualUnmodifiableListView)
      return _additionalCharges;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_additionalCharges);
  }

  final List<BookingDetailsPaymentHistoryModel> _payments;
  @override
  @JsonKey(name: 'payments')
  List<BookingDetailsPaymentHistoryModel> get payments {
    if (_payments is EqualUnmodifiableListView) return _payments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_payments);
  }

  final List<dynamic> _refunds;
  @override
  @JsonKey()
  List<dynamic> get refunds {
    if (_refunds is EqualUnmodifiableListView) return _refunds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_refunds);
  }

  @override
  @JsonKey(name: 'total_refunded')
  final double totalRefunded;
  @override
  @JsonKey(name: 'refundable_balance')
  final double refundableBalance;
  @override
  @JsonKey(name: 'security_summary')
  final SecuritySummaryModel securitySummary;

  @override
  String toString() {
    return 'BookingDetailsModel(id: $id, invoiceId: $invoiceId, pickupDate: $pickupDate, returnDate: $returnDate, coolingPeriodDate: $coolingPeriodDate, totalAmount: $totalAmount, discountAmount: $discountAmount, paidAmount: $paidAmount, securityAmount: $securityAmount, purchaseMode: $purchaseMode, bookingStatus: $bookingStatus, paymentStatus: $paymentStatus, deliveryStatus: $deliveryStatus, staffName: $staffName, staffId: $staffId, otherDetails: $otherDetails, bookedDate: $bookedDate, bookingCompletedDate: $bookingCompletedDate, address: $address, client: $client, description: $description, documents: $documents, bookedItems: $bookedItems, additionalCharges: $additionalCharges, payments: $payments, refunds: $refunds, totalRefunded: $totalRefunded, refundableBalance: $refundableBalance, securitySummary: $securitySummary)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingDetailsModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.invoiceId, invoiceId) ||
                other.invoiceId == invoiceId) &&
            (identical(other.pickupDate, pickupDate) ||
                other.pickupDate == pickupDate) &&
            (identical(other.returnDate, returnDate) ||
                other.returnDate == returnDate) &&
            (identical(other.coolingPeriodDate, coolingPeriodDate) ||
                other.coolingPeriodDate == coolingPeriodDate) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.discountAmount, discountAmount) ||
                other.discountAmount == discountAmount) &&
            (identical(other.paidAmount, paidAmount) ||
                other.paidAmount == paidAmount) &&
            (identical(other.securityAmount, securityAmount) ||
                other.securityAmount == securityAmount) &&
            (identical(other.purchaseMode, purchaseMode) ||
                other.purchaseMode == purchaseMode) &&
            (identical(other.bookingStatus, bookingStatus) ||
                other.bookingStatus == bookingStatus) &&
            (identical(other.paymentStatus, paymentStatus) ||
                other.paymentStatus == paymentStatus) &&
            (identical(other.deliveryStatus, deliveryStatus) ||
                other.deliveryStatus == deliveryStatus) &&
            (identical(other.staffName, staffName) ||
                other.staffName == staffName) &&
            (identical(other.staffId, staffId) || other.staffId == staffId) &&
            (identical(other.otherDetails, otherDetails) ||
                other.otherDetails == otherDetails) &&
            (identical(other.bookedDate, bookedDate) ||
                other.bookedDate == bookedDate) &&
            (identical(other.bookingCompletedDate, bookingCompletedDate) ||
                other.bookingCompletedDate == bookingCompletedDate) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.client, client) || other.client == client) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._documents, _documents) &&
            const DeepCollectionEquality()
                .equals(other._bookedItems, _bookedItems) &&
            const DeepCollectionEquality()
                .equals(other._additionalCharges, _additionalCharges) &&
            const DeepCollectionEquality().equals(other._payments, _payments) &&
            const DeepCollectionEquality().equals(other._refunds, _refunds) &&
            (identical(other.totalRefunded, totalRefunded) ||
                other.totalRefunded == totalRefunded) &&
            (identical(other.refundableBalance, refundableBalance) ||
                other.refundableBalance == refundableBalance) &&
            (identical(other.securitySummary, securitySummary) ||
                other.securitySummary == securitySummary));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        invoiceId,
        pickupDate,
        returnDate,
        coolingPeriodDate,
        totalAmount,
        discountAmount,
        paidAmount,
        securityAmount,
        purchaseMode,
        bookingStatus,
        paymentStatus,
        deliveryStatus,
        staffName,
        staffId,
        otherDetails,
        bookedDate,
        bookingCompletedDate,
        address,
        client,
        description,
        const DeepCollectionEquality().hash(_documents),
        const DeepCollectionEquality().hash(_bookedItems),
        const DeepCollectionEquality().hash(_additionalCharges),
        const DeepCollectionEquality().hash(_payments),
        const DeepCollectionEquality().hash(_refunds),
        totalRefunded,
        refundableBalance,
        securitySummary
      ]);

  /// Create a copy of BookingDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookingDetailsModelImplCopyWith<_$BookingDetailsModelImpl> get copyWith =>
      __$$BookingDetailsModelImplCopyWithImpl<_$BookingDetailsModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookingDetailsModelImplToJson(
      this,
    );
  }
}

abstract class _BookingDetailsModel implements BookingDetailsModel {
  const factory _BookingDetailsModel(
      {required final int id,
      @JsonKey(name: 'shop_booking_id') required final String invoiceId,
      required final String? pickupDate,
      required final String returnDate,
      @JsonKey(name: 'cooling_period_end') final String? coolingPeriodDate,
      required final int totalAmount,
      final int? discountAmount,
      @JsonKey(name: 'advance_amount') required final int paidAmount,
      final int? securityAmount,
      @JsonKey(
          fromJson: PurchaseMode.fromString, defaultValue: PurchaseMode.normal)
      required final PurchaseMode purchaseMode,
      @JsonKey(
          fromJson: BookingStatus.fromString,
          toJson: BookingStatus.toJson,
          defaultValue: BookingStatus.upcoming)
      required final BookingStatus bookingStatus,
      @JsonKey(
          fromJson: PaymentStatus.fromBool,
          toJson: PaymentStatus.toJson,
          defaultValue: PaymentStatus.pending)
      required final PaymentStatus paymentStatus,
      @JsonKey(
          fromJson: DeliveryStatus.fromString,
          toJson: DeliveryStatus.toJson,
          defaultValue: DeliveryStatus.booked)
      required final DeliveryStatus deliveryStatus,
      @JsonKey(name: 'staff_name') final String? staffName,
      @JsonKey(name: 'staff_id') final int? staffId,
      @JsonKey(name: 'details', defaultValue: BookingOtherDetailsModel.empty)
      required final BookingOtherDetailsModel otherDetails,
      @JsonKey(name: 'created_at') required final String bookedDate,
      @JsonKey(name: 'completed_at') final String? bookingCompletedDate,
      @JsonKey(name: 'client_address') final String? address,
      required final ClientModel client,
      final String? description,
      final List<dynamic> documents,
      required final List<ProductInfoModel> bookedItems,
      @JsonKey(name: 'additional_charges')
      final List<AdditionalChargesModel> additionalCharges,
      @JsonKey(name: 'payments')
      final List<BookingDetailsPaymentHistoryModel> payments,
      final List<dynamic> refunds,
      @JsonKey(name: 'total_refunded') final double totalRefunded,
      @JsonKey(name: 'refundable_balance') final double refundableBalance,
      @JsonKey(name: 'security_summary')
      final SecuritySummaryModel securitySummary}) = _$BookingDetailsModelImpl;

  factory _BookingDetailsModel.fromJson(Map<String, dynamic> json) =
      _$BookingDetailsModelImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'shop_booking_id')
  String get invoiceId;
  @override
  String? get pickupDate;
  @override
  String get returnDate;
  @override
  @JsonKey(name: 'cooling_period_end')
  String? get coolingPeriodDate;
  @override
  int get totalAmount;
  @override
  int? get discountAmount;
  @override
  @JsonKey(name: 'advance_amount')
  int get paidAmount;
  @override
  int? get securityAmount;
  @override
  @JsonKey(fromJson: PurchaseMode.fromString, defaultValue: PurchaseMode.normal)
  PurchaseMode get purchaseMode;
  @override
  @JsonKey(
      fromJson: BookingStatus.fromString,
      toJson: BookingStatus.toJson,
      defaultValue: BookingStatus.upcoming)
  BookingStatus get bookingStatus;
  @override
  @JsonKey(
      fromJson: PaymentStatus.fromBool,
      toJson: PaymentStatus.toJson,
      defaultValue: PaymentStatus.pending)
  PaymentStatus get paymentStatus;
  @override
  @JsonKey(
      fromJson: DeliveryStatus.fromString,
      toJson: DeliveryStatus.toJson,
      defaultValue: DeliveryStatus.booked)
  DeliveryStatus get deliveryStatus;
  @override
  @JsonKey(name: 'staff_name')
  String? get staffName;
  @override
  @JsonKey(name: 'staff_id')
  int? get staffId;
  @override
  @JsonKey(name: 'details', defaultValue: BookingOtherDetailsModel.empty)
  BookingOtherDetailsModel get otherDetails;
  @override
  @JsonKey(name: 'created_at')
  String get bookedDate;
  @override
  @JsonKey(name: 'completed_at')
  String? get bookingCompletedDate;
  @override
  @JsonKey(name: 'client_address')
  String? get address;
  @override
  ClientModel get client;
  @override
  String? get description;
  @override
  List<dynamic> get documents;
  @override
  List<ProductInfoModel> get bookedItems;
  @override
  @JsonKey(name: 'additional_charges')
  List<AdditionalChargesModel> get additionalCharges;
  @override
  @JsonKey(name: 'payments')
  List<BookingDetailsPaymentHistoryModel> get payments;
  @override
  List<dynamic> get refunds;
  @override
  @JsonKey(name: 'total_refunded')
  double get totalRefunded;
  @override
  @JsonKey(name: 'refundable_balance')
  double get refundableBalance;
  @override
  @JsonKey(name: 'security_summary')
  SecuritySummaryModel get securitySummary;

  /// Create a copy of BookingDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookingDetailsModelImplCopyWith<_$BookingDetailsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
