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

/// @nodoc
mixin _$BookingDetailsModel {
  int get id => throw _privateConstructorUsedError;
  ClientModel get client => throw _privateConstructorUsedError;
  int get totalAmount => throw _privateConstructorUsedError;
  int get paidAmount => throw _privateConstructorUsedError;
  String get invoiceId => throw _privateConstructorUsedError;
  int? get securityAmount => throw _privateConstructorUsedError;
  int? get discountAmount => throw _privateConstructorUsedError;
  String? get pickupDate => throw _privateConstructorUsedError;
  String get returnDate => throw _privateConstructorUsedError;
  PurchaseMode get purchaseMode => throw _privateConstructorUsedError;
  BookingStatus get bookingStatus => throw _privateConstructorUsedError;
  bool get paymentStatus => throw _privateConstructorUsedError;
  String get staffName => throw _privateConstructorUsedError;
  String get bookedDate => throw _privateConstructorUsedError;
  String? get bookingCompletedDate => throw _privateConstructorUsedError;
  List<ProductInfoModel> get bookedItems => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  DeliveryStatus get deliveryStatus => throw _privateConstructorUsedError;
  Map<String, dynamic> get otherDetails => throw _privateConstructorUsedError;

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
      ClientModel client,
      int totalAmount,
      int paidAmount,
      String invoiceId,
      int? securityAmount,
      int? discountAmount,
      String? pickupDate,
      String returnDate,
      PurchaseMode purchaseMode,
      BookingStatus bookingStatus,
      bool paymentStatus,
      String staffName,
      String bookedDate,
      String? bookingCompletedDate,
      List<ProductInfoModel> bookedItems,
      String? description,
      String? address,
      DeliveryStatus deliveryStatus,
      Map<String, dynamic> otherDetails});

  $ClientModelCopyWith<$Res> get client;
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
    Object? client = null,
    Object? totalAmount = null,
    Object? paidAmount = null,
    Object? invoiceId = null,
    Object? securityAmount = freezed,
    Object? discountAmount = freezed,
    Object? pickupDate = freezed,
    Object? returnDate = null,
    Object? purchaseMode = null,
    Object? bookingStatus = null,
    Object? paymentStatus = null,
    Object? staffName = null,
    Object? bookedDate = null,
    Object? bookingCompletedDate = freezed,
    Object? bookedItems = null,
    Object? description = freezed,
    Object? address = freezed,
    Object? deliveryStatus = null,
    Object? otherDetails = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      client: null == client
          ? _value.client
          : client // ignore: cast_nullable_to_non_nullable
              as ClientModel,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as int,
      paidAmount: null == paidAmount
          ? _value.paidAmount
          : paidAmount // ignore: cast_nullable_to_non_nullable
              as int,
      invoiceId: null == invoiceId
          ? _value.invoiceId
          : invoiceId // ignore: cast_nullable_to_non_nullable
              as String,
      securityAmount: freezed == securityAmount
          ? _value.securityAmount
          : securityAmount // ignore: cast_nullable_to_non_nullable
              as int?,
      discountAmount: freezed == discountAmount
          ? _value.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as int?,
      pickupDate: freezed == pickupDate
          ? _value.pickupDate
          : pickupDate // ignore: cast_nullable_to_non_nullable
              as String?,
      returnDate: null == returnDate
          ? _value.returnDate
          : returnDate // ignore: cast_nullable_to_non_nullable
              as String,
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
              as bool,
      staffName: null == staffName
          ? _value.staffName
          : staffName // ignore: cast_nullable_to_non_nullable
              as String,
      bookedDate: null == bookedDate
          ? _value.bookedDate
          : bookedDate // ignore: cast_nullable_to_non_nullable
              as String,
      bookingCompletedDate: freezed == bookingCompletedDate
          ? _value.bookingCompletedDate
          : bookingCompletedDate // ignore: cast_nullable_to_non_nullable
              as String?,
      bookedItems: null == bookedItems
          ? _value.bookedItems
          : bookedItems // ignore: cast_nullable_to_non_nullable
              as List<ProductInfoModel>,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      deliveryStatus: null == deliveryStatus
          ? _value.deliveryStatus
          : deliveryStatus // ignore: cast_nullable_to_non_nullable
              as DeliveryStatus,
      otherDetails: null == otherDetails
          ? _value.otherDetails
          : otherDetails // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
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
      ClientModel client,
      int totalAmount,
      int paidAmount,
      String invoiceId,
      int? securityAmount,
      int? discountAmount,
      String? pickupDate,
      String returnDate,
      PurchaseMode purchaseMode,
      BookingStatus bookingStatus,
      bool paymentStatus,
      String staffName,
      String bookedDate,
      String? bookingCompletedDate,
      List<ProductInfoModel> bookedItems,
      String? description,
      String? address,
      DeliveryStatus deliveryStatus,
      Map<String, dynamic> otherDetails});

  @override
  $ClientModelCopyWith<$Res> get client;
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
    Object? client = null,
    Object? totalAmount = null,
    Object? paidAmount = null,
    Object? invoiceId = null,
    Object? securityAmount = freezed,
    Object? discountAmount = freezed,
    Object? pickupDate = freezed,
    Object? returnDate = null,
    Object? purchaseMode = null,
    Object? bookingStatus = null,
    Object? paymentStatus = null,
    Object? staffName = null,
    Object? bookedDate = null,
    Object? bookingCompletedDate = freezed,
    Object? bookedItems = null,
    Object? description = freezed,
    Object? address = freezed,
    Object? deliveryStatus = null,
    Object? otherDetails = null,
  }) {
    return _then(_$BookingDetailsModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      client: null == client
          ? _value.client
          : client // ignore: cast_nullable_to_non_nullable
              as ClientModel,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as int,
      paidAmount: null == paidAmount
          ? _value.paidAmount
          : paidAmount // ignore: cast_nullable_to_non_nullable
              as int,
      invoiceId: null == invoiceId
          ? _value.invoiceId
          : invoiceId // ignore: cast_nullable_to_non_nullable
              as String,
      securityAmount: freezed == securityAmount
          ? _value.securityAmount
          : securityAmount // ignore: cast_nullable_to_non_nullable
              as int?,
      discountAmount: freezed == discountAmount
          ? _value.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as int?,
      pickupDate: freezed == pickupDate
          ? _value.pickupDate
          : pickupDate // ignore: cast_nullable_to_non_nullable
              as String?,
      returnDate: null == returnDate
          ? _value.returnDate
          : returnDate // ignore: cast_nullable_to_non_nullable
              as String,
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
              as bool,
      staffName: null == staffName
          ? _value.staffName
          : staffName // ignore: cast_nullable_to_non_nullable
              as String,
      bookedDate: null == bookedDate
          ? _value.bookedDate
          : bookedDate // ignore: cast_nullable_to_non_nullable
              as String,
      bookingCompletedDate: freezed == bookingCompletedDate
          ? _value.bookingCompletedDate
          : bookingCompletedDate // ignore: cast_nullable_to_non_nullable
              as String?,
      bookedItems: null == bookedItems
          ? _value._bookedItems
          : bookedItems // ignore: cast_nullable_to_non_nullable
              as List<ProductInfoModel>,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      deliveryStatus: null == deliveryStatus
          ? _value.deliveryStatus
          : deliveryStatus // ignore: cast_nullable_to_non_nullable
              as DeliveryStatus,
      otherDetails: null == otherDetails
          ? _value._otherDetails
          : otherDetails // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc

class _$BookingDetailsModelImpl implements _BookingDetailsModel {
  const _$BookingDetailsModelImpl(
      {required this.id,
      required this.client,
      required this.totalAmount,
      required this.paidAmount,
      required this.invoiceId,
      this.securityAmount,
      this.discountAmount,
      required this.pickupDate,
      required this.returnDate,
      required this.purchaseMode,
      required this.bookingStatus,
      required this.paymentStatus,
      required this.staffName,
      required this.bookedDate,
      this.bookingCompletedDate,
      required final List<ProductInfoModel> bookedItems,
      this.description,
      this.address,
      this.deliveryStatus = DeliveryStatus.booked,
      final Map<String, dynamic> otherDetails = const {}})
      : _bookedItems = bookedItems,
        _otherDetails = otherDetails;

  @override
  final int id;
  @override
  final ClientModel client;
  @override
  final int totalAmount;
  @override
  final int paidAmount;
  @override
  final String invoiceId;
  @override
  final int? securityAmount;
  @override
  final int? discountAmount;
  @override
  final String? pickupDate;
  @override
  final String returnDate;
  @override
  final PurchaseMode purchaseMode;
  @override
  final BookingStatus bookingStatus;
  @override
  final bool paymentStatus;
  @override
  final String staffName;
  @override
  final String bookedDate;
  @override
  final String? bookingCompletedDate;
  final List<ProductInfoModel> _bookedItems;
  @override
  List<ProductInfoModel> get bookedItems {
    if (_bookedItems is EqualUnmodifiableListView) return _bookedItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bookedItems);
  }

  @override
  final String? description;
  @override
  final String? address;
  @override
  @JsonKey()
  final DeliveryStatus deliveryStatus;
  final Map<String, dynamic> _otherDetails;
  @override
  @JsonKey()
  Map<String, dynamic> get otherDetails {
    if (_otherDetails is EqualUnmodifiableMapView) return _otherDetails;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_otherDetails);
  }

  @override
  String toString() {
    return 'BookingDetailsModel(id: $id, client: $client, totalAmount: $totalAmount, paidAmount: $paidAmount, invoiceId: $invoiceId, securityAmount: $securityAmount, discountAmount: $discountAmount, pickupDate: $pickupDate, returnDate: $returnDate, purchaseMode: $purchaseMode, bookingStatus: $bookingStatus, paymentStatus: $paymentStatus, staffName: $staffName, bookedDate: $bookedDate, bookingCompletedDate: $bookingCompletedDate, bookedItems: $bookedItems, description: $description, address: $address, deliveryStatus: $deliveryStatus, otherDetails: $otherDetails)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingDetailsModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.client, client) || other.client == client) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.paidAmount, paidAmount) ||
                other.paidAmount == paidAmount) &&
            (identical(other.invoiceId, invoiceId) ||
                other.invoiceId == invoiceId) &&
            (identical(other.securityAmount, securityAmount) ||
                other.securityAmount == securityAmount) &&
            (identical(other.discountAmount, discountAmount) ||
                other.discountAmount == discountAmount) &&
            (identical(other.pickupDate, pickupDate) ||
                other.pickupDate == pickupDate) &&
            (identical(other.returnDate, returnDate) ||
                other.returnDate == returnDate) &&
            (identical(other.purchaseMode, purchaseMode) ||
                other.purchaseMode == purchaseMode) &&
            (identical(other.bookingStatus, bookingStatus) ||
                other.bookingStatus == bookingStatus) &&
            (identical(other.paymentStatus, paymentStatus) ||
                other.paymentStatus == paymentStatus) &&
            (identical(other.staffName, staffName) ||
                other.staffName == staffName) &&
            (identical(other.bookedDate, bookedDate) ||
                other.bookedDate == bookedDate) &&
            (identical(other.bookingCompletedDate, bookingCompletedDate) ||
                other.bookingCompletedDate == bookingCompletedDate) &&
            const DeepCollectionEquality()
                .equals(other._bookedItems, _bookedItems) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.deliveryStatus, deliveryStatus) ||
                other.deliveryStatus == deliveryStatus) &&
            const DeepCollectionEquality()
                .equals(other._otherDetails, _otherDetails));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        client,
        totalAmount,
        paidAmount,
        invoiceId,
        securityAmount,
        discountAmount,
        pickupDate,
        returnDate,
        purchaseMode,
        bookingStatus,
        paymentStatus,
        staffName,
        bookedDate,
        bookingCompletedDate,
        const DeepCollectionEquality().hash(_bookedItems),
        description,
        address,
        deliveryStatus,
        const DeepCollectionEquality().hash(_otherDetails)
      ]);

  /// Create a copy of BookingDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookingDetailsModelImplCopyWith<_$BookingDetailsModelImpl> get copyWith =>
      __$$BookingDetailsModelImplCopyWithImpl<_$BookingDetailsModelImpl>(
          this, _$identity);
}

abstract class _BookingDetailsModel implements BookingDetailsModel {
  const factory _BookingDetailsModel(
      {required final int id,
      required final ClientModel client,
      required final int totalAmount,
      required final int paidAmount,
      required final String invoiceId,
      final int? securityAmount,
      final int? discountAmount,
      required final String? pickupDate,
      required final String returnDate,
      required final PurchaseMode purchaseMode,
      required final BookingStatus bookingStatus,
      required final bool paymentStatus,
      required final String staffName,
      required final String bookedDate,
      final String? bookingCompletedDate,
      required final List<ProductInfoModel> bookedItems,
      final String? description,
      final String? address,
      final DeliveryStatus deliveryStatus,
      final Map<String, dynamic> otherDetails}) = _$BookingDetailsModelImpl;

  @override
  int get id;
  @override
  ClientModel get client;
  @override
  int get totalAmount;
  @override
  int get paidAmount;
  @override
  String get invoiceId;
  @override
  int? get securityAmount;
  @override
  int? get discountAmount;
  @override
  String? get pickupDate;
  @override
  String get returnDate;
  @override
  PurchaseMode get purchaseMode;
  @override
  BookingStatus get bookingStatus;
  @override
  bool get paymentStatus;
  @override
  String get staffName;
  @override
  String get bookedDate;
  @override
  String? get bookingCompletedDate;
  @override
  List<ProductInfoModel> get bookedItems;
  @override
  String? get description;
  @override
  String? get address;
  @override
  DeliveryStatus get deliveryStatus;
  @override
  Map<String, dynamic> get otherDetails;

  /// Create a copy of BookingDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookingDetailsModelImplCopyWith<_$BookingDetailsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
