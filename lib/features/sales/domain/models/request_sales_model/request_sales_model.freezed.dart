// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'request_sales_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RequestSalesModel _$RequestSalesModelFromJson(Map<String, dynamic> json) {
  return _RequestSalesModel.fromJson(json);
}

/// @nodoc
mixin _$RequestSalesModel {
  @JsonKey(name: 'staff_id')
  int? get staffId => throw _privateConstructorUsedError;
  @JsonKey(name: 'client_phone')
  String? get clientPhone => throw _privateConstructorUsedError;
  @JsonKey(name: 'client_address')
  String? get clientAddress => throw _privateConstructorUsedError;
  @JsonKey(name: 'sale_date')
  String? get saleDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'description')
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'send_invoice')
  bool get sendInvoice => throw _privateConstructorUsedError;
  @JsonKey(name: 'variants')
  List<Map<String, dynamic>>? get variants =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'paid_amount')
  int? get paidAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_method')
  PaymentMethod? get paymentMethod => throw _privateConstructorUsedError;
  @JsonKey(name: 'discount')
  int? get discount => throw _privateConstructorUsedError;
  @JsonKey(name: 'decrease_stock')
  bool get decreaseStock => throw _privateConstructorUsedError;

  /// Serializes this RequestSalesModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RequestSalesModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RequestSalesModelCopyWith<RequestSalesModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RequestSalesModelCopyWith<$Res> {
  factory $RequestSalesModelCopyWith(
          RequestSalesModel value, $Res Function(RequestSalesModel) then) =
      _$RequestSalesModelCopyWithImpl<$Res, RequestSalesModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'staff_id') int? staffId,
      @JsonKey(name: 'client_phone') String? clientPhone,
      @JsonKey(name: 'client_address') String? clientAddress,
      @JsonKey(name: 'sale_date') String? saleDate,
      @JsonKey(name: 'description') String? description,
      @JsonKey(name: 'send_invoice') bool sendInvoice,
      @JsonKey(name: 'variants') List<Map<String, dynamic>>? variants,
      @JsonKey(name: 'paid_amount') int? paidAmount,
      @JsonKey(name: 'payment_method') PaymentMethod? paymentMethod,
      @JsonKey(name: 'discount') int? discount,
      @JsonKey(name: 'decrease_stock') bool decreaseStock});
}

/// @nodoc
class _$RequestSalesModelCopyWithImpl<$Res, $Val extends RequestSalesModel>
    implements $RequestSalesModelCopyWith<$Res> {
  _$RequestSalesModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RequestSalesModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? staffId = freezed,
    Object? clientPhone = freezed,
    Object? clientAddress = freezed,
    Object? saleDate = freezed,
    Object? description = freezed,
    Object? sendInvoice = null,
    Object? variants = freezed,
    Object? paidAmount = freezed,
    Object? paymentMethod = freezed,
    Object? discount = freezed,
    Object? decreaseStock = null,
  }) {
    return _then(_value.copyWith(
      staffId: freezed == staffId
          ? _value.staffId
          : staffId // ignore: cast_nullable_to_non_nullable
              as int?,
      clientPhone: freezed == clientPhone
          ? _value.clientPhone
          : clientPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      clientAddress: freezed == clientAddress
          ? _value.clientAddress
          : clientAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      saleDate: freezed == saleDate
          ? _value.saleDate
          : saleDate // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      sendInvoice: null == sendInvoice
          ? _value.sendInvoice
          : sendInvoice // ignore: cast_nullable_to_non_nullable
              as bool,
      variants: freezed == variants
          ? _value.variants
          : variants // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>?,
      paidAmount: freezed == paidAmount
          ? _value.paidAmount
          : paidAmount // ignore: cast_nullable_to_non_nullable
              as int?,
      paymentMethod: freezed == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as PaymentMethod?,
      discount: freezed == discount
          ? _value.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as int?,
      decreaseStock: null == decreaseStock
          ? _value.decreaseStock
          : decreaseStock // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RequestSalesModelImplCopyWith<$Res>
    implements $RequestSalesModelCopyWith<$Res> {
  factory _$$RequestSalesModelImplCopyWith(_$RequestSalesModelImpl value,
          $Res Function(_$RequestSalesModelImpl) then) =
      __$$RequestSalesModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'staff_id') int? staffId,
      @JsonKey(name: 'client_phone') String? clientPhone,
      @JsonKey(name: 'client_address') String? clientAddress,
      @JsonKey(name: 'sale_date') String? saleDate,
      @JsonKey(name: 'description') String? description,
      @JsonKey(name: 'send_invoice') bool sendInvoice,
      @JsonKey(name: 'variants') List<Map<String, dynamic>>? variants,
      @JsonKey(name: 'paid_amount') int? paidAmount,
      @JsonKey(name: 'payment_method') PaymentMethod? paymentMethod,
      @JsonKey(name: 'discount') int? discount,
      @JsonKey(name: 'decrease_stock') bool decreaseStock});
}

/// @nodoc
class __$$RequestSalesModelImplCopyWithImpl<$Res>
    extends _$RequestSalesModelCopyWithImpl<$Res, _$RequestSalesModelImpl>
    implements _$$RequestSalesModelImplCopyWith<$Res> {
  __$$RequestSalesModelImplCopyWithImpl(_$RequestSalesModelImpl _value,
      $Res Function(_$RequestSalesModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of RequestSalesModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? staffId = freezed,
    Object? clientPhone = freezed,
    Object? clientAddress = freezed,
    Object? saleDate = freezed,
    Object? description = freezed,
    Object? sendInvoice = null,
    Object? variants = freezed,
    Object? paidAmount = freezed,
    Object? paymentMethod = freezed,
    Object? discount = freezed,
    Object? decreaseStock = null,
  }) {
    return _then(_$RequestSalesModelImpl(
      staffId: freezed == staffId
          ? _value.staffId
          : staffId // ignore: cast_nullable_to_non_nullable
              as int?,
      clientPhone: freezed == clientPhone
          ? _value.clientPhone
          : clientPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      clientAddress: freezed == clientAddress
          ? _value.clientAddress
          : clientAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      saleDate: freezed == saleDate
          ? _value.saleDate
          : saleDate // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      sendInvoice: null == sendInvoice
          ? _value.sendInvoice
          : sendInvoice // ignore: cast_nullable_to_non_nullable
              as bool,
      variants: freezed == variants
          ? _value._variants
          : variants // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>?,
      paidAmount: freezed == paidAmount
          ? _value.paidAmount
          : paidAmount // ignore: cast_nullable_to_non_nullable
              as int?,
      paymentMethod: freezed == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as PaymentMethod?,
      discount: freezed == discount
          ? _value.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as int?,
      decreaseStock: null == decreaseStock
          ? _value.decreaseStock
          : decreaseStock // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$RequestSalesModelImpl implements _RequestSalesModel {
  const _$RequestSalesModelImpl(
      {@JsonKey(name: 'staff_id') this.staffId,
      @JsonKey(name: 'client_phone') this.clientPhone,
      @JsonKey(name: 'client_address') this.clientAddress,
      @JsonKey(name: 'sale_date') this.saleDate,
      @JsonKey(name: 'description') this.description,
      @JsonKey(name: 'send_invoice') this.sendInvoice = false,
      @JsonKey(name: 'variants') final List<Map<String, dynamic>>? variants,
      @JsonKey(name: 'paid_amount') this.paidAmount,
      @JsonKey(name: 'payment_method') this.paymentMethod,
      @JsonKey(name: 'discount') this.discount,
      @JsonKey(name: 'decrease_stock') this.decreaseStock = false})
      : _variants = variants;

  factory _$RequestSalesModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RequestSalesModelImplFromJson(json);

  @override
  @JsonKey(name: 'staff_id')
  final int? staffId;
  @override
  @JsonKey(name: 'client_phone')
  final String? clientPhone;
  @override
  @JsonKey(name: 'client_address')
  final String? clientAddress;
  @override
  @JsonKey(name: 'sale_date')
  final String? saleDate;
  @override
  @JsonKey(name: 'description')
  final String? description;
  @override
  @JsonKey(name: 'send_invoice')
  final bool sendInvoice;
  final List<Map<String, dynamic>>? _variants;
  @override
  @JsonKey(name: 'variants')
  List<Map<String, dynamic>>? get variants {
    final value = _variants;
    if (value == null) return null;
    if (_variants is EqualUnmodifiableListView) return _variants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'paid_amount')
  final int? paidAmount;
  @override
  @JsonKey(name: 'payment_method')
  final PaymentMethod? paymentMethod;
  @override
  @JsonKey(name: 'discount')
  final int? discount;
  @override
  @JsonKey(name: 'decrease_stock')
  final bool decreaseStock;

  @override
  String toString() {
    return 'RequestSalesModel(staffId: $staffId, clientPhone: $clientPhone, clientAddress: $clientAddress, saleDate: $saleDate, description: $description, sendInvoice: $sendInvoice, variants: $variants, paidAmount: $paidAmount, paymentMethod: $paymentMethod, discount: $discount, decreaseStock: $decreaseStock)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestSalesModelImpl &&
            (identical(other.staffId, staffId) || other.staffId == staffId) &&
            (identical(other.clientPhone, clientPhone) ||
                other.clientPhone == clientPhone) &&
            (identical(other.clientAddress, clientAddress) ||
                other.clientAddress == clientAddress) &&
            (identical(other.saleDate, saleDate) ||
                other.saleDate == saleDate) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.sendInvoice, sendInvoice) ||
                other.sendInvoice == sendInvoice) &&
            const DeepCollectionEquality().equals(other._variants, _variants) &&
            (identical(other.paidAmount, paidAmount) ||
                other.paidAmount == paidAmount) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.discount, discount) ||
                other.discount == discount) &&
            (identical(other.decreaseStock, decreaseStock) ||
                other.decreaseStock == decreaseStock));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      staffId,
      clientPhone,
      clientAddress,
      saleDate,
      description,
      sendInvoice,
      const DeepCollectionEquality().hash(_variants),
      paidAmount,
      paymentMethod,
      discount,
      decreaseStock);

  /// Create a copy of RequestSalesModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RequestSalesModelImplCopyWith<_$RequestSalesModelImpl> get copyWith =>
      __$$RequestSalesModelImplCopyWithImpl<_$RequestSalesModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RequestSalesModelImplToJson(
      this,
    );
  }
}

abstract class _RequestSalesModel implements RequestSalesModel {
  const factory _RequestSalesModel(
          {@JsonKey(name: 'staff_id') final int? staffId,
          @JsonKey(name: 'client_phone') final String? clientPhone,
          @JsonKey(name: 'client_address') final String? clientAddress,
          @JsonKey(name: 'sale_date') final String? saleDate,
          @JsonKey(name: 'description') final String? description,
          @JsonKey(name: 'send_invoice') final bool sendInvoice,
          @JsonKey(name: 'variants') final List<Map<String, dynamic>>? variants,
          @JsonKey(name: 'paid_amount') final int? paidAmount,
          @JsonKey(name: 'payment_method') final PaymentMethod? paymentMethod,
          @JsonKey(name: 'discount') final int? discount,
          @JsonKey(name: 'decrease_stock') final bool decreaseStock}) =
      _$RequestSalesModelImpl;

  factory _RequestSalesModel.fromJson(Map<String, dynamic> json) =
      _$RequestSalesModelImpl.fromJson;

  @override
  @JsonKey(name: 'staff_id')
  int? get staffId;
  @override
  @JsonKey(name: 'client_phone')
  String? get clientPhone;
  @override
  @JsonKey(name: 'client_address')
  String? get clientAddress;
  @override
  @JsonKey(name: 'sale_date')
  String? get saleDate;
  @override
  @JsonKey(name: 'description')
  String? get description;
  @override
  @JsonKey(name: 'send_invoice')
  bool get sendInvoice;
  @override
  @JsonKey(name: 'variants')
  List<Map<String, dynamic>>? get variants;
  @override
  @JsonKey(name: 'paid_amount')
  int? get paidAmount;
  @override
  @JsonKey(name: 'payment_method')
  PaymentMethod? get paymentMethod;
  @override
  @JsonKey(name: 'discount')
  int? get discount;
  @override
  @JsonKey(name: 'decrease_stock')
  bool get decreaseStock;

  /// Create a copy of RequestSalesModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RequestSalesModelImplCopyWith<_$RequestSalesModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
