// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ledger_sale_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LedgerSaleModel _$LedgerSaleModelFromJson(Map<String, dynamic> json) {
  return _LedgerSaleModel.fromJson(json);
}

/// @nodoc
mixin _$LedgerSaleModel {
// ✅ API: "id"
  @JsonKey(name: 'id')
  int get saleId =>
      throw _privateConstructorUsedError; // ✅ API does NOT have sale_date → derive from created_at
  @JsonKey(name: 'created_at', defaultValue: '')
  String get createdAt =>
      throw _privateConstructorUsedError; // ✅ API: "total_amount"
  @JsonKey(name: 'total_amount', defaultValue: 0)
  int get totalAmount =>
      throw _privateConstructorUsedError; // ✅ API does NOT send client_name in sales
  String get clientName =>
      throw _privateConstructorUsedError; // ✅ API: "items" is STRING, UI expects List
  @JsonKey(name: 'items', fromJson: _itemsFromJson)
  List<String> get products =>
      throw _privateConstructorUsedError; // ✅ API: payment_methods is STRING → convert to List<PaymentMethod>
  @JsonKey(name: 'payment_methods', fromJson: _paymentMethodsFromJson)
  List<PaymentMethod> get paymentMethods => throw _privateConstructorUsedError;

  /// Serializes this LedgerSaleModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LedgerSaleModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LedgerSaleModelCopyWith<LedgerSaleModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LedgerSaleModelCopyWith<$Res> {
  factory $LedgerSaleModelCopyWith(
          LedgerSaleModel value, $Res Function(LedgerSaleModel) then) =
      _$LedgerSaleModelCopyWithImpl<$Res, LedgerSaleModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') int saleId,
      @JsonKey(name: 'created_at', defaultValue: '') String createdAt,
      @JsonKey(name: 'total_amount', defaultValue: 0) int totalAmount,
      String clientName,
      @JsonKey(name: 'items', fromJson: _itemsFromJson) List<String> products,
      @JsonKey(name: 'payment_methods', fromJson: _paymentMethodsFromJson)
      List<PaymentMethod> paymentMethods});
}

/// @nodoc
class _$LedgerSaleModelCopyWithImpl<$Res, $Val extends LedgerSaleModel>
    implements $LedgerSaleModelCopyWith<$Res> {
  _$LedgerSaleModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LedgerSaleModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? saleId = null,
    Object? createdAt = null,
    Object? totalAmount = null,
    Object? clientName = null,
    Object? products = null,
    Object? paymentMethods = null,
  }) {
    return _then(_value.copyWith(
      saleId: null == saleId
          ? _value.saleId
          : saleId // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as int,
      clientName: null == clientName
          ? _value.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String,
      products: null == products
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<String>,
      paymentMethods: null == paymentMethods
          ? _value.paymentMethods
          : paymentMethods // ignore: cast_nullable_to_non_nullable
              as List<PaymentMethod>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LedgerSaleModelImplCopyWith<$Res>
    implements $LedgerSaleModelCopyWith<$Res> {
  factory _$$LedgerSaleModelImplCopyWith(_$LedgerSaleModelImpl value,
          $Res Function(_$LedgerSaleModelImpl) then) =
      __$$LedgerSaleModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') int saleId,
      @JsonKey(name: 'created_at', defaultValue: '') String createdAt,
      @JsonKey(name: 'total_amount', defaultValue: 0) int totalAmount,
      String clientName,
      @JsonKey(name: 'items', fromJson: _itemsFromJson) List<String> products,
      @JsonKey(name: 'payment_methods', fromJson: _paymentMethodsFromJson)
      List<PaymentMethod> paymentMethods});
}

/// @nodoc
class __$$LedgerSaleModelImplCopyWithImpl<$Res>
    extends _$LedgerSaleModelCopyWithImpl<$Res, _$LedgerSaleModelImpl>
    implements _$$LedgerSaleModelImplCopyWith<$Res> {
  __$$LedgerSaleModelImplCopyWithImpl(
      _$LedgerSaleModelImpl _value, $Res Function(_$LedgerSaleModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of LedgerSaleModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? saleId = null,
    Object? createdAt = null,
    Object? totalAmount = null,
    Object? clientName = null,
    Object? products = null,
    Object? paymentMethods = null,
  }) {
    return _then(_$LedgerSaleModelImpl(
      saleId: null == saleId
          ? _value.saleId
          : saleId // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as int,
      clientName: null == clientName
          ? _value.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String,
      products: null == products
          ? _value._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<String>,
      paymentMethods: null == paymentMethods
          ? _value._paymentMethods
          : paymentMethods // ignore: cast_nullable_to_non_nullable
              as List<PaymentMethod>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LedgerSaleModelImpl implements _LedgerSaleModel {
  const _$LedgerSaleModelImpl(
      {@JsonKey(name: 'id') required this.saleId,
      @JsonKey(name: 'created_at', defaultValue: '') required this.createdAt,
      @JsonKey(name: 'total_amount', defaultValue: 0) required this.totalAmount,
      this.clientName = '',
      @JsonKey(name: 'items', fromJson: _itemsFromJson)
      required final List<String> products,
      @JsonKey(name: 'payment_methods', fromJson: _paymentMethodsFromJson)
      required final List<PaymentMethod> paymentMethods})
      : _products = products,
        _paymentMethods = paymentMethods;

  factory _$LedgerSaleModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LedgerSaleModelImplFromJson(json);

// ✅ API: "id"
  @override
  @JsonKey(name: 'id')
  final int saleId;
// ✅ API does NOT have sale_date → derive from created_at
  @override
  @JsonKey(name: 'created_at', defaultValue: '')
  final String createdAt;
// ✅ API: "total_amount"
  @override
  @JsonKey(name: 'total_amount', defaultValue: 0)
  final int totalAmount;
// ✅ API does NOT send client_name in sales
  @override
  @JsonKey()
  final String clientName;
// ✅ API: "items" is STRING, UI expects List
  final List<String> _products;
// ✅ API: "items" is STRING, UI expects List
  @override
  @JsonKey(name: 'items', fromJson: _itemsFromJson)
  List<String> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

// ✅ API: payment_methods is STRING → convert to List<PaymentMethod>
  final List<PaymentMethod> _paymentMethods;
// ✅ API: payment_methods is STRING → convert to List<PaymentMethod>
  @override
  @JsonKey(name: 'payment_methods', fromJson: _paymentMethodsFromJson)
  List<PaymentMethod> get paymentMethods {
    if (_paymentMethods is EqualUnmodifiableListView) return _paymentMethods;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_paymentMethods);
  }

  @override
  String toString() {
    return 'LedgerSaleModel(saleId: $saleId, createdAt: $createdAt, totalAmount: $totalAmount, clientName: $clientName, products: $products, paymentMethods: $paymentMethods)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LedgerSaleModelImpl &&
            (identical(other.saleId, saleId) || other.saleId == saleId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.clientName, clientName) ||
                other.clientName == clientName) &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            const DeepCollectionEquality()
                .equals(other._paymentMethods, _paymentMethods));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      saleId,
      createdAt,
      totalAmount,
      clientName,
      const DeepCollectionEquality().hash(_products),
      const DeepCollectionEquality().hash(_paymentMethods));

  /// Create a copy of LedgerSaleModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LedgerSaleModelImplCopyWith<_$LedgerSaleModelImpl> get copyWith =>
      __$$LedgerSaleModelImplCopyWithImpl<_$LedgerSaleModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LedgerSaleModelImplToJson(
      this,
    );
  }
}

abstract class _LedgerSaleModel implements LedgerSaleModel {
  const factory _LedgerSaleModel(
          {@JsonKey(name: 'id') required final int saleId,
          @JsonKey(name: 'created_at', defaultValue: '')
          required final String createdAt,
          @JsonKey(name: 'total_amount', defaultValue: 0)
          required final int totalAmount,
          final String clientName,
          @JsonKey(name: 'items', fromJson: _itemsFromJson)
          required final List<String> products,
          @JsonKey(name: 'payment_methods', fromJson: _paymentMethodsFromJson)
          required final List<PaymentMethod> paymentMethods}) =
      _$LedgerSaleModelImpl;

  factory _LedgerSaleModel.fromJson(Map<String, dynamic> json) =
      _$LedgerSaleModelImpl.fromJson;

// ✅ API: "id"
  @override
  @JsonKey(name: 'id')
  int get saleId; // ✅ API does NOT have sale_date → derive from created_at
  @override
  @JsonKey(name: 'created_at', defaultValue: '')
  String get createdAt; // ✅ API: "total_amount"
  @override
  @JsonKey(name: 'total_amount', defaultValue: 0)
  int get totalAmount; // ✅ API does NOT send client_name in sales
  @override
  String get clientName; // ✅ API: "items" is STRING, UI expects List
  @override
  @JsonKey(name: 'items', fromJson: _itemsFromJson)
  List<String>
      get products; // ✅ API: payment_methods is STRING → convert to List<PaymentMethod>
  @override
  @JsonKey(name: 'payment_methods', fromJson: _paymentMethodsFromJson)
  List<PaymentMethod> get paymentMethods;

  /// Create a copy of LedgerSaleModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LedgerSaleModelImplCopyWith<_$LedgerSaleModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
