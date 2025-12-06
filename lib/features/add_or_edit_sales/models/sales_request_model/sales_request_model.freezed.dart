// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sales_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SalesRequestModel _$SalesRequestModelFromJson(Map<String, dynamic> json) {
  return _SalesRequestModel.fromJson(json);
}

/// @nodoc
mixin _$SalesRequestModel {
  @JsonKey(includeToJson: false)
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'staff_id')
  int? get staffId =>
      throw _privateConstructorUsedError; // @JsonKey(name: 'client_id') int? clientId,
// @JsonKey(name: 'client_name') String? clientName,
  @JsonKey(name: 'client_phone')
  String? get clientPhone =>
      throw _privateConstructorUsedError; // @JsonKey(name: 'client_phone_2') String? clientPhone2,
  @JsonKey(name: 'client_address')
  String? get address => throw _privateConstructorUsedError;
  @JsonKey(name: 'sale_date')
  String? get saleDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'variants', toJson: _variantsToJson)
  List<ProductSelectedModel>? get products =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'decrease_stock')
  bool? get stockCountDecrease => throw _privateConstructorUsedError;
  @JsonKey(name: 'description')
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'discount')
  int? get discountAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'paid_amount')
  int? get paidAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_method', toJson: _paymentMethodToJson)
  PaymentMethod? get paymentMethod => throw _privateConstructorUsedError;
  @JsonKey(name: 'send_invoice', includeToJson: true, includeFromJson: false)
  bool get sendPdfToWhatsApp => throw _privateConstructorUsedError;

  /// Serializes this SalesRequestModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SalesRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SalesRequestModelCopyWith<SalesRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SalesRequestModelCopyWith<$Res> {
  factory $SalesRequestModelCopyWith(
          SalesRequestModel value, $Res Function(SalesRequestModel) then) =
      _$SalesRequestModelCopyWithImpl<$Res, SalesRequestModel>;
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) int? id,
      @JsonKey(name: 'staff_id') int? staffId,
      @JsonKey(name: 'client_phone') String? clientPhone,
      @JsonKey(name: 'client_address') String? address,
      @JsonKey(name: 'sale_date') String? saleDate,
      @JsonKey(name: 'variants', toJson: _variantsToJson)
      List<ProductSelectedModel>? products,
      @JsonKey(name: 'decrease_stock') bool? stockCountDecrease,
      @JsonKey(name: 'description') String? description,
      @JsonKey(name: 'discount') int? discountAmount,
      @JsonKey(name: 'paid_amount') int? paidAmount,
      @JsonKey(name: 'payment_method', toJson: _paymentMethodToJson)
      PaymentMethod? paymentMethod,
      @JsonKey(
          name: 'send_invoice', includeToJson: true, includeFromJson: false)
      bool sendPdfToWhatsApp});
}

/// @nodoc
class _$SalesRequestModelCopyWithImpl<$Res, $Val extends SalesRequestModel>
    implements $SalesRequestModelCopyWith<$Res> {
  _$SalesRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SalesRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? staffId = freezed,
    Object? clientPhone = freezed,
    Object? address = freezed,
    Object? saleDate = freezed,
    Object? products = freezed,
    Object? stockCountDecrease = freezed,
    Object? description = freezed,
    Object? discountAmount = freezed,
    Object? paidAmount = freezed,
    Object? paymentMethod = freezed,
    Object? sendPdfToWhatsApp = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      staffId: freezed == staffId
          ? _value.staffId
          : staffId // ignore: cast_nullable_to_non_nullable
              as int?,
      clientPhone: freezed == clientPhone
          ? _value.clientPhone
          : clientPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      saleDate: freezed == saleDate
          ? _value.saleDate
          : saleDate // ignore: cast_nullable_to_non_nullable
              as String?,
      products: freezed == products
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<ProductSelectedModel>?,
      stockCountDecrease: freezed == stockCountDecrease
          ? _value.stockCountDecrease
          : stockCountDecrease // ignore: cast_nullable_to_non_nullable
              as bool?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      discountAmount: freezed == discountAmount
          ? _value.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as int?,
      paidAmount: freezed == paidAmount
          ? _value.paidAmount
          : paidAmount // ignore: cast_nullable_to_non_nullable
              as int?,
      paymentMethod: freezed == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as PaymentMethod?,
      sendPdfToWhatsApp: null == sendPdfToWhatsApp
          ? _value.sendPdfToWhatsApp
          : sendPdfToWhatsApp // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SalesRequestModelImplCopyWith<$Res>
    implements $SalesRequestModelCopyWith<$Res> {
  factory _$$SalesRequestModelImplCopyWith(_$SalesRequestModelImpl value,
          $Res Function(_$SalesRequestModelImpl) then) =
      __$$SalesRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) int? id,
      @JsonKey(name: 'staff_id') int? staffId,
      @JsonKey(name: 'client_phone') String? clientPhone,
      @JsonKey(name: 'client_address') String? address,
      @JsonKey(name: 'sale_date') String? saleDate,
      @JsonKey(name: 'variants', toJson: _variantsToJson)
      List<ProductSelectedModel>? products,
      @JsonKey(name: 'decrease_stock') bool? stockCountDecrease,
      @JsonKey(name: 'description') String? description,
      @JsonKey(name: 'discount') int? discountAmount,
      @JsonKey(name: 'paid_amount') int? paidAmount,
      @JsonKey(name: 'payment_method', toJson: _paymentMethodToJson)
      PaymentMethod? paymentMethod,
      @JsonKey(
          name: 'send_invoice', includeToJson: true, includeFromJson: false)
      bool sendPdfToWhatsApp});
}

/// @nodoc
class __$$SalesRequestModelImplCopyWithImpl<$Res>
    extends _$SalesRequestModelCopyWithImpl<$Res, _$SalesRequestModelImpl>
    implements _$$SalesRequestModelImplCopyWith<$Res> {
  __$$SalesRequestModelImplCopyWithImpl(_$SalesRequestModelImpl _value,
      $Res Function(_$SalesRequestModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of SalesRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? staffId = freezed,
    Object? clientPhone = freezed,
    Object? address = freezed,
    Object? saleDate = freezed,
    Object? products = freezed,
    Object? stockCountDecrease = freezed,
    Object? description = freezed,
    Object? discountAmount = freezed,
    Object? paidAmount = freezed,
    Object? paymentMethod = freezed,
    Object? sendPdfToWhatsApp = null,
  }) {
    return _then(_$SalesRequestModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      staffId: freezed == staffId
          ? _value.staffId
          : staffId // ignore: cast_nullable_to_non_nullable
              as int?,
      clientPhone: freezed == clientPhone
          ? _value.clientPhone
          : clientPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      saleDate: freezed == saleDate
          ? _value.saleDate
          : saleDate // ignore: cast_nullable_to_non_nullable
              as String?,
      products: freezed == products
          ? _value._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<ProductSelectedModel>?,
      stockCountDecrease: freezed == stockCountDecrease
          ? _value.stockCountDecrease
          : stockCountDecrease // ignore: cast_nullable_to_non_nullable
              as bool?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      discountAmount: freezed == discountAmount
          ? _value.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as int?,
      paidAmount: freezed == paidAmount
          ? _value.paidAmount
          : paidAmount // ignore: cast_nullable_to_non_nullable
              as int?,
      paymentMethod: freezed == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as PaymentMethod?,
      sendPdfToWhatsApp: null == sendPdfToWhatsApp
          ? _value.sendPdfToWhatsApp
          : sendPdfToWhatsApp // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$SalesRequestModelImpl implements _SalesRequestModel {
  const _$SalesRequestModelImpl(
      {@JsonKey(includeToJson: false) this.id,
      @JsonKey(name: 'staff_id') this.staffId,
      @JsonKey(name: 'client_phone') this.clientPhone,
      @JsonKey(name: 'client_address') this.address,
      @JsonKey(name: 'sale_date') this.saleDate,
      @JsonKey(name: 'variants', toJson: _variantsToJson)
      final List<ProductSelectedModel>? products,
      @JsonKey(name: 'decrease_stock') this.stockCountDecrease,
      @JsonKey(name: 'description') this.description,
      @JsonKey(name: 'discount') this.discountAmount,
      @JsonKey(name: 'paid_amount') this.paidAmount,
      @JsonKey(name: 'payment_method', toJson: _paymentMethodToJson)
      this.paymentMethod = PaymentMethod.cash,
      @JsonKey(
          name: 'send_invoice', includeToJson: true, includeFromJson: false)
      this.sendPdfToWhatsApp = false})
      : _products = products;

  factory _$SalesRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SalesRequestModelImplFromJson(json);

  @override
  @JsonKey(includeToJson: false)
  final int? id;
  @override
  @JsonKey(name: 'staff_id')
  final int? staffId;
// @JsonKey(name: 'client_id') int? clientId,
// @JsonKey(name: 'client_name') String? clientName,
  @override
  @JsonKey(name: 'client_phone')
  final String? clientPhone;
// @JsonKey(name: 'client_phone_2') String? clientPhone2,
  @override
  @JsonKey(name: 'client_address')
  final String? address;
  @override
  @JsonKey(name: 'sale_date')
  final String? saleDate;
  final List<ProductSelectedModel>? _products;
  @override
  @JsonKey(name: 'variants', toJson: _variantsToJson)
  List<ProductSelectedModel>? get products {
    final value = _products;
    if (value == null) return null;
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'decrease_stock')
  final bool? stockCountDecrease;
  @override
  @JsonKey(name: 'description')
  final String? description;
  @override
  @JsonKey(name: 'discount')
  final int? discountAmount;
  @override
  @JsonKey(name: 'paid_amount')
  final int? paidAmount;
  @override
  @JsonKey(name: 'payment_method', toJson: _paymentMethodToJson)
  final PaymentMethod? paymentMethod;
  @override
  @JsonKey(name: 'send_invoice', includeToJson: true, includeFromJson: false)
  final bool sendPdfToWhatsApp;

  @override
  String toString() {
    return 'SalesRequestModel(id: $id, staffId: $staffId, clientPhone: $clientPhone, address: $address, saleDate: $saleDate, products: $products, stockCountDecrease: $stockCountDecrease, description: $description, discountAmount: $discountAmount, paidAmount: $paidAmount, paymentMethod: $paymentMethod, sendPdfToWhatsApp: $sendPdfToWhatsApp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SalesRequestModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.staffId, staffId) || other.staffId == staffId) &&
            (identical(other.clientPhone, clientPhone) ||
                other.clientPhone == clientPhone) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.saleDate, saleDate) ||
                other.saleDate == saleDate) &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            (identical(other.stockCountDecrease, stockCountDecrease) ||
                other.stockCountDecrease == stockCountDecrease) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.discountAmount, discountAmount) ||
                other.discountAmount == discountAmount) &&
            (identical(other.paidAmount, paidAmount) ||
                other.paidAmount == paidAmount) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.sendPdfToWhatsApp, sendPdfToWhatsApp) ||
                other.sendPdfToWhatsApp == sendPdfToWhatsApp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      staffId,
      clientPhone,
      address,
      saleDate,
      const DeepCollectionEquality().hash(_products),
      stockCountDecrease,
      description,
      discountAmount,
      paidAmount,
      paymentMethod,
      sendPdfToWhatsApp);

  /// Create a copy of SalesRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SalesRequestModelImplCopyWith<_$SalesRequestModelImpl> get copyWith =>
      __$$SalesRequestModelImplCopyWithImpl<_$SalesRequestModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SalesRequestModelImplToJson(
      this,
    );
  }
}

abstract class _SalesRequestModel implements SalesRequestModel {
  const factory _SalesRequestModel(
      {@JsonKey(includeToJson: false) final int? id,
      @JsonKey(name: 'staff_id') final int? staffId,
      @JsonKey(name: 'client_phone') final String? clientPhone,
      @JsonKey(name: 'client_address') final String? address,
      @JsonKey(name: 'sale_date') final String? saleDate,
      @JsonKey(name: 'variants', toJson: _variantsToJson)
      final List<ProductSelectedModel>? products,
      @JsonKey(name: 'decrease_stock') final bool? stockCountDecrease,
      @JsonKey(name: 'description') final String? description,
      @JsonKey(name: 'discount') final int? discountAmount,
      @JsonKey(name: 'paid_amount') final int? paidAmount,
      @JsonKey(name: 'payment_method', toJson: _paymentMethodToJson)
      final PaymentMethod? paymentMethod,
      @JsonKey(
          name: 'send_invoice', includeToJson: true, includeFromJson: false)
      final bool sendPdfToWhatsApp}) = _$SalesRequestModelImpl;

  factory _SalesRequestModel.fromJson(Map<String, dynamic> json) =
      _$SalesRequestModelImpl.fromJson;

  @override
  @JsonKey(includeToJson: false)
  int? get id;
  @override
  @JsonKey(name: 'staff_id')
  int? get staffId; // @JsonKey(name: 'client_id') int? clientId,
// @JsonKey(name: 'client_name') String? clientName,
  @override
  @JsonKey(name: 'client_phone')
  String?
      get clientPhone; // @JsonKey(name: 'client_phone_2') String? clientPhone2,
  @override
  @JsonKey(name: 'client_address')
  String? get address;
  @override
  @JsonKey(name: 'sale_date')
  String? get saleDate;
  @override
  @JsonKey(name: 'variants', toJson: _variantsToJson)
  List<ProductSelectedModel>? get products;
  @override
  @JsonKey(name: 'decrease_stock')
  bool? get stockCountDecrease;
  @override
  @JsonKey(name: 'description')
  String? get description;
  @override
  @JsonKey(name: 'discount')
  int? get discountAmount;
  @override
  @JsonKey(name: 'paid_amount')
  int? get paidAmount;
  @override
  @JsonKey(name: 'payment_method', toJson: _paymentMethodToJson)
  PaymentMethod? get paymentMethod;
  @override
  @JsonKey(name: 'send_invoice', includeToJson: true, includeFromJson: false)
  bool get sendPdfToWhatsApp;

  /// Create a copy of SalesRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SalesRequestModelImplCopyWith<_$SalesRequestModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
