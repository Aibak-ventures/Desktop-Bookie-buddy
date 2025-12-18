// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PaymentModel _$PaymentModelFromJson(Map<String, dynamic> json) {
  return _PaymentModel.fromJson(json);
}

/// @nodoc
mixin _$PaymentModel {
  @JsonKey(name: 'id')
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_amount')
  int get paymentAmount => throw _privateConstructorUsedError;
  @JsonKey(
      name: 'payment_method',
      fromJson: PaymentMethod.fromJson,
      includeToJson: false)
  PaymentMethod get paymentMethod => throw _privateConstructorUsedError;
  @JsonKey(name: 'client_name')
  String? get clientName => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'invoice_id', defaultValue: '')
  String get invoiceId => throw _privateConstructorUsedError;
  @JsonKey(
      name: 'type',
      fromJson: LedgerListType.fromJson,
      toJson: LedgerListType.toJson)
  LedgerListType get type => throw _privateConstructorUsedError;

  /// Serializes this PaymentModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaymentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentModelCopyWith<PaymentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentModelCopyWith<$Res> {
  factory $PaymentModelCopyWith(
          PaymentModel value, $Res Function(PaymentModel) then) =
      _$PaymentModelCopyWithImpl<$Res, PaymentModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') int id,
      @JsonKey(name: 'payment_amount') int paymentAmount,
      @JsonKey(
          name: 'payment_method',
          fromJson: PaymentMethod.fromJson,
          includeToJson: false)
      PaymentMethod paymentMethod,
      @JsonKey(name: 'client_name') String? clientName,
      @JsonKey(name: 'created_at') String createdAt,
      @JsonKey(name: 'invoice_id', defaultValue: '') String invoiceId,
      @JsonKey(
          name: 'type',
          fromJson: LedgerListType.fromJson,
          toJson: LedgerListType.toJson)
      LedgerListType type});
}

/// @nodoc
class _$PaymentModelCopyWithImpl<$Res, $Val extends PaymentModel>
    implements $PaymentModelCopyWith<$Res> {
  _$PaymentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? paymentAmount = null,
    Object? paymentMethod = null,
    Object? clientName = freezed,
    Object? createdAt = null,
    Object? invoiceId = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      paymentAmount: null == paymentAmount
          ? _value.paymentAmount
          : paymentAmount // ignore: cast_nullable_to_non_nullable
              as int,
      paymentMethod: null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as PaymentMethod,
      clientName: freezed == clientName
          ? _value.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      invoiceId: null == invoiceId
          ? _value.invoiceId
          : invoiceId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as LedgerListType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaymentModelImplCopyWith<$Res>
    implements $PaymentModelCopyWith<$Res> {
  factory _$$PaymentModelImplCopyWith(
          _$PaymentModelImpl value, $Res Function(_$PaymentModelImpl) then) =
      __$$PaymentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') int id,
      @JsonKey(name: 'payment_amount') int paymentAmount,
      @JsonKey(
          name: 'payment_method',
          fromJson: PaymentMethod.fromJson,
          includeToJson: false)
      PaymentMethod paymentMethod,
      @JsonKey(name: 'client_name') String? clientName,
      @JsonKey(name: 'created_at') String createdAt,
      @JsonKey(name: 'invoice_id', defaultValue: '') String invoiceId,
      @JsonKey(
          name: 'type',
          fromJson: LedgerListType.fromJson,
          toJson: LedgerListType.toJson)
      LedgerListType type});
}

/// @nodoc
class __$$PaymentModelImplCopyWithImpl<$Res>
    extends _$PaymentModelCopyWithImpl<$Res, _$PaymentModelImpl>
    implements _$$PaymentModelImplCopyWith<$Res> {
  __$$PaymentModelImplCopyWithImpl(
      _$PaymentModelImpl _value, $Res Function(_$PaymentModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaymentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? paymentAmount = null,
    Object? paymentMethod = null,
    Object? clientName = freezed,
    Object? createdAt = null,
    Object? invoiceId = null,
    Object? type = null,
  }) {
    return _then(_$PaymentModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      paymentAmount: null == paymentAmount
          ? _value.paymentAmount
          : paymentAmount // ignore: cast_nullable_to_non_nullable
              as int,
      paymentMethod: null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as PaymentMethod,
      clientName: freezed == clientName
          ? _value.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      invoiceId: null == invoiceId
          ? _value.invoiceId
          : invoiceId // ignore: cast_nullable_to_non_nullable
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
class _$PaymentModelImpl implements _PaymentModel {
  const _$PaymentModelImpl(
      {@JsonKey(name: 'id') required this.id,
      @JsonKey(name: 'payment_amount') required this.paymentAmount,
      @JsonKey(
          name: 'payment_method',
          fromJson: PaymentMethod.fromJson,
          includeToJson: false)
      required this.paymentMethod,
      @JsonKey(name: 'client_name') this.clientName,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'invoice_id', defaultValue: '') required this.invoiceId,
      @JsonKey(
          name: 'type',
          fromJson: LedgerListType.fromJson,
          toJson: LedgerListType.toJson)
      required this.type});

  factory _$PaymentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentModelImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int id;
  @override
  @JsonKey(name: 'payment_amount')
  final int paymentAmount;
  @override
  @JsonKey(
      name: 'payment_method',
      fromJson: PaymentMethod.fromJson,
      includeToJson: false)
  final PaymentMethod paymentMethod;
  @override
  @JsonKey(name: 'client_name')
  final String? clientName;
  @override
  @JsonKey(name: 'created_at')
  final String createdAt;
  @override
  @JsonKey(name: 'invoice_id', defaultValue: '')
  final String invoiceId;
  @override
  @JsonKey(
      name: 'type',
      fromJson: LedgerListType.fromJson,
      toJson: LedgerListType.toJson)
  final LedgerListType type;

  @override
  String toString() {
    return 'PaymentModel(id: $id, paymentAmount: $paymentAmount, paymentMethod: $paymentMethod, clientName: $clientName, createdAt: $createdAt, invoiceId: $invoiceId, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.paymentAmount, paymentAmount) ||
                other.paymentAmount == paymentAmount) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.clientName, clientName) ||
                other.clientName == clientName) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.invoiceId, invoiceId) ||
                other.invoiceId == invoiceId) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, paymentAmount, paymentMethod,
      clientName, createdAt, invoiceId, type);

  /// Create a copy of PaymentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentModelImplCopyWith<_$PaymentModelImpl> get copyWith =>
      __$$PaymentModelImplCopyWithImpl<_$PaymentModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentModelImplToJson(
      this,
    );
  }
}

abstract class _PaymentModel implements PaymentModel {
  const factory _PaymentModel(
      {@JsonKey(name: 'id') required final int id,
      @JsonKey(name: 'payment_amount') required final int paymentAmount,
      @JsonKey(
          name: 'payment_method',
          fromJson: PaymentMethod.fromJson,
          includeToJson: false)
      required final PaymentMethod paymentMethod,
      @JsonKey(name: 'client_name') final String? clientName,
      @JsonKey(name: 'created_at') required final String createdAt,
      @JsonKey(name: 'invoice_id', defaultValue: '')
      required final String invoiceId,
      @JsonKey(
          name: 'type',
          fromJson: LedgerListType.fromJson,
          toJson: LedgerListType.toJson)
      required final LedgerListType type}) = _$PaymentModelImpl;

  factory _PaymentModel.fromJson(Map<String, dynamic> json) =
      _$PaymentModelImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  int get id;
  @override
  @JsonKey(name: 'payment_amount')
  int get paymentAmount;
  @override
  @JsonKey(
      name: 'payment_method',
      fromJson: PaymentMethod.fromJson,
      includeToJson: false)
  PaymentMethod get paymentMethod;
  @override
  @JsonKey(name: 'client_name')
  String? get clientName;
  @override
  @JsonKey(name: 'created_at')
  String get createdAt;
  @override
  @JsonKey(name: 'invoice_id', defaultValue: '')
  String get invoiceId;
  @override
  @JsonKey(
      name: 'type',
      fromJson: LedgerListType.fromJson,
      toJson: LedgerListType.toJson)
  LedgerListType get type;

  /// Create a copy of PaymentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentModelImplCopyWith<_$PaymentModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
