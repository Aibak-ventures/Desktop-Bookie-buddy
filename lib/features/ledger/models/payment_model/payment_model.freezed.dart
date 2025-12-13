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
  int get bookingId => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_amount')
  int get paymentAmount => throw _privateConstructorUsedError;
  @JsonKey(
      name: 'payment_method',
      fromJson: PaymentMethod.fromString,
      toJson: PaymentMethod.toJson)
  PaymentMethod get paymentMethod => throw _privateConstructorUsedError;
  @JsonKey(name: 'client_name', defaultValue: 'Unknown')
  String get clientName => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String get createdAt => throw _privateConstructorUsedError;

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
      {@JsonKey(name: 'id') int bookingId,
      @JsonKey(name: 'payment_amount') int paymentAmount,
      @JsonKey(
          name: 'payment_method',
          fromJson: PaymentMethod.fromString,
          toJson: PaymentMethod.toJson)
      PaymentMethod paymentMethod,
      @JsonKey(name: 'client_name', defaultValue: 'Unknown') String clientName,
      @JsonKey(name: 'created_at') String createdAt});
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
    Object? bookingId = null,
    Object? paymentAmount = null,
    Object? paymentMethod = null,
    Object? clientName = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      bookingId: null == bookingId
          ? _value.bookingId
          : bookingId // ignore: cast_nullable_to_non_nullable
              as int,
      paymentAmount: null == paymentAmount
          ? _value.paymentAmount
          : paymentAmount // ignore: cast_nullable_to_non_nullable
              as int,
      paymentMethod: null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as PaymentMethod,
      clientName: null == clientName
          ? _value.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
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
      {@JsonKey(name: 'id') int bookingId,
      @JsonKey(name: 'payment_amount') int paymentAmount,
      @JsonKey(
          name: 'payment_method',
          fromJson: PaymentMethod.fromString,
          toJson: PaymentMethod.toJson)
      PaymentMethod paymentMethod,
      @JsonKey(name: 'client_name', defaultValue: 'Unknown') String clientName,
      @JsonKey(name: 'created_at') String createdAt});
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
    Object? bookingId = null,
    Object? paymentAmount = null,
    Object? paymentMethod = null,
    Object? clientName = null,
    Object? createdAt = null,
  }) {
    return _then(_$PaymentModelImpl(
      bookingId: null == bookingId
          ? _value.bookingId
          : bookingId // ignore: cast_nullable_to_non_nullable
              as int,
      paymentAmount: null == paymentAmount
          ? _value.paymentAmount
          : paymentAmount // ignore: cast_nullable_to_non_nullable
              as int,
      paymentMethod: null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as PaymentMethod,
      clientName: null == clientName
          ? _value.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PaymentModelImpl implements _PaymentModel {
  const _$PaymentModelImpl(
      {@JsonKey(name: 'id') required this.bookingId,
      @JsonKey(name: 'payment_amount') required this.paymentAmount,
      @JsonKey(
          name: 'payment_method',
          fromJson: PaymentMethod.fromString,
          toJson: PaymentMethod.toJson)
      required this.paymentMethod,
      @JsonKey(name: 'client_name', defaultValue: 'Unknown')
      required this.clientName,
      @JsonKey(name: 'created_at') required this.createdAt});

  factory _$PaymentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentModelImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int bookingId;
  @override
  @JsonKey(name: 'payment_amount')
  final int paymentAmount;
  @override
  @JsonKey(
      name: 'payment_method',
      fromJson: PaymentMethod.fromString,
      toJson: PaymentMethod.toJson)
  final PaymentMethod paymentMethod;
  @override
  @JsonKey(name: 'client_name', defaultValue: 'Unknown')
  final String clientName;
  @override
  @JsonKey(name: 'created_at')
  final String createdAt;

  @override
  String toString() {
    return 'PaymentModel(bookingId: $bookingId, paymentAmount: $paymentAmount, paymentMethod: $paymentMethod, clientName: $clientName, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentModelImpl &&
            (identical(other.bookingId, bookingId) ||
                other.bookingId == bookingId) &&
            (identical(other.paymentAmount, paymentAmount) ||
                other.paymentAmount == paymentAmount) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.clientName, clientName) ||
                other.clientName == clientName) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, bookingId, paymentAmount,
      paymentMethod, clientName, createdAt);

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
          {@JsonKey(name: 'id') required final int bookingId,
          @JsonKey(name: 'payment_amount') required final int paymentAmount,
          @JsonKey(
              name: 'payment_method',
              fromJson: PaymentMethod.fromString,
              toJson: PaymentMethod.toJson)
          required final PaymentMethod paymentMethod,
          @JsonKey(name: 'client_name', defaultValue: 'Unknown')
          required final String clientName,
          @JsonKey(name: 'created_at') required final String createdAt}) =
      _$PaymentModelImpl;

  factory _PaymentModel.fromJson(Map<String, dynamic> json) =
      _$PaymentModelImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  int get bookingId;
  @override
  @JsonKey(name: 'payment_amount')
  int get paymentAmount;
  @override
  @JsonKey(
      name: 'payment_method',
      fromJson: PaymentMethod.fromString,
      toJson: PaymentMethod.toJson)
  PaymentMethod get paymentMethod;
  @override
  @JsonKey(name: 'client_name', defaultValue: 'Unknown')
  String get clientName;
  @override
  @JsonKey(name: 'created_at')
  String get createdAt;

  /// Create a copy of PaymentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentModelImplCopyWith<_$PaymentModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
