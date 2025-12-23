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
  @JsonKey(name: 'id')
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'invoice_id', defaultValue: '')
  String get invoiceId => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_amount')
  int get totalAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'items', defaultValue: '')
  String get products => throw _privateConstructorUsedError;
  @JsonKey(
      name: 'payment_methods',
      fromJson: PaymentMethod.fromJson,
      defaultValue: PaymentMethod.cash)
  PaymentMethod get paymentMethods => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String get date => throw _privateConstructorUsedError;
  @JsonKey(
      name: 'type',
      fromJson: LedgerListType.fromJson,
      toJson: LedgerListType.toJson)
  LedgerListType get type => throw _privateConstructorUsedError;

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
      {@JsonKey(name: 'id') int id,
      @JsonKey(name: 'invoice_id', defaultValue: '') String invoiceId,
      @JsonKey(name: 'total_amount') int totalAmount,
      @JsonKey(name: 'items', defaultValue: '') String products,
      @JsonKey(
          name: 'payment_methods',
          fromJson: PaymentMethod.fromJson,
          defaultValue: PaymentMethod.cash)
      PaymentMethod paymentMethods,
      @JsonKey(name: 'created_at') String date,
      @JsonKey(
          name: 'type',
          fromJson: LedgerListType.fromJson,
          toJson: LedgerListType.toJson)
      LedgerListType type});
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
    Object? id = null,
    Object? invoiceId = null,
    Object? totalAmount = null,
    Object? products = null,
    Object? paymentMethods = null,
    Object? date = null,
    Object? type = null,
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
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as int,
      products: null == products
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as String,
      paymentMethods: null == paymentMethods
          ? _value.paymentMethods
          : paymentMethods // ignore: cast_nullable_to_non_nullable
              as PaymentMethod,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as LedgerListType,
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
      {@JsonKey(name: 'id') int id,
      @JsonKey(name: 'invoice_id', defaultValue: '') String invoiceId,
      @JsonKey(name: 'total_amount') int totalAmount,
      @JsonKey(name: 'items', defaultValue: '') String products,
      @JsonKey(
          name: 'payment_methods',
          fromJson: PaymentMethod.fromJson,
          defaultValue: PaymentMethod.cash)
      PaymentMethod paymentMethods,
      @JsonKey(name: 'created_at') String date,
      @JsonKey(
          name: 'type',
          fromJson: LedgerListType.fromJson,
          toJson: LedgerListType.toJson)
      LedgerListType type});
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
    Object? id = null,
    Object? invoiceId = null,
    Object? totalAmount = null,
    Object? products = null,
    Object? paymentMethods = null,
    Object? date = null,
    Object? type = null,
  }) {
    return _then(_$LedgerSaleModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      invoiceId: null == invoiceId
          ? _value.invoiceId
          : invoiceId // ignore: cast_nullable_to_non_nullable
              as String,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as int,
      products: null == products
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as String,
      paymentMethods: null == paymentMethods
          ? _value.paymentMethods
          : paymentMethods // ignore: cast_nullable_to_non_nullable
              as PaymentMethod,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as LedgerListType,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LedgerSaleModelImpl implements _LedgerSaleModel {
  const _$LedgerSaleModelImpl(
      {@JsonKey(name: 'id') required this.id,
      @JsonKey(name: 'invoice_id', defaultValue: '') required this.invoiceId,
      @JsonKey(name: 'total_amount') required this.totalAmount,
      @JsonKey(name: 'items', defaultValue: '') required this.products,
      @JsonKey(
          name: 'payment_methods',
          fromJson: PaymentMethod.fromJson,
          defaultValue: PaymentMethod.cash)
      required this.paymentMethods,
      @JsonKey(name: 'created_at') required this.date,
      @JsonKey(
          name: 'type',
          fromJson: LedgerListType.fromJson,
          toJson: LedgerListType.toJson)
      required this.type});

  factory _$LedgerSaleModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LedgerSaleModelImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int id;
  @override
  @JsonKey(name: 'invoice_id', defaultValue: '')
  final String invoiceId;
  @override
  @JsonKey(name: 'total_amount')
  final int totalAmount;
  @override
  @JsonKey(name: 'items', defaultValue: '')
  final String products;
  @override
  @JsonKey(
      name: 'payment_methods',
      fromJson: PaymentMethod.fromJson,
      defaultValue: PaymentMethod.cash)
  final PaymentMethod paymentMethods;
  @override
  @JsonKey(name: 'created_at')
  final String date;
  @override
  @JsonKey(
      name: 'type',
      fromJson: LedgerListType.fromJson,
      toJson: LedgerListType.toJson)
  final LedgerListType type;

  @override
  String toString() {
    return 'LedgerSaleModel(id: $id, invoiceId: $invoiceId, totalAmount: $totalAmount, products: $products, paymentMethods: $paymentMethods, date: $date, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LedgerSaleModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.invoiceId, invoiceId) ||
                other.invoiceId == invoiceId) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.products, products) ||
                other.products == products) &&
            (identical(other.paymentMethods, paymentMethods) ||
                other.paymentMethods == paymentMethods) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, invoiceId, totalAmount,
      products, paymentMethods, date, type);

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
      {@JsonKey(name: 'id') required final int id,
      @JsonKey(name: 'invoice_id', defaultValue: '')
      required final String invoiceId,
      @JsonKey(name: 'total_amount') required final int totalAmount,
      @JsonKey(name: 'items', defaultValue: '') required final String products,
      @JsonKey(
          name: 'payment_methods',
          fromJson: PaymentMethod.fromJson,
          defaultValue: PaymentMethod.cash)
      required final PaymentMethod paymentMethods,
      @JsonKey(name: 'created_at') required final String date,
      @JsonKey(
          name: 'type',
          fromJson: LedgerListType.fromJson,
          toJson: LedgerListType.toJson)
      required final LedgerListType type}) = _$LedgerSaleModelImpl;

  factory _LedgerSaleModel.fromJson(Map<String, dynamic> json) =
      _$LedgerSaleModelImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  int get id;
  @override
  @JsonKey(name: 'invoice_id', defaultValue: '')
  String get invoiceId;
  @override
  @JsonKey(name: 'total_amount')
  int get totalAmount;
  @override
  @JsonKey(name: 'items', defaultValue: '')
  String get products;
  @override
  @JsonKey(
      name: 'payment_methods',
      fromJson: PaymentMethod.fromJson,
      defaultValue: PaymentMethod.cash)
  PaymentMethod get paymentMethods;
  @override
  @JsonKey(name: 'created_at')
  String get date;
  @override
  @JsonKey(
      name: 'type',
      fromJson: LedgerListType.fromJson,
      toJson: LedgerListType.toJson)
  LedgerListType get type;

  /// Create a copy of LedgerSaleModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LedgerSaleModelImplCopyWith<_$LedgerSaleModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
