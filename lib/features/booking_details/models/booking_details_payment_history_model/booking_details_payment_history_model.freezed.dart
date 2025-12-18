// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_details_payment_history_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BookingDetailsPaymentHistoryModel _$BookingDetailsPaymentHistoryModelFromJson(
    Map<String, dynamic> json) {
  return _BookingDetailsPaymentHistoryModel.fromJson(json);
}

/// @nodoc
mixin _$BookingDetailsPaymentHistoryModel {
  @JsonKey(name: 'amount')
  int get amount => throw _privateConstructorUsedError;
  @JsonKey(
      name: 'payment_method',
      defaultValue: PaymentMethod.cash,
      fromJson: PaymentMethod.fromJson)
  PaymentMethod get paymentMethod => throw _privateConstructorUsedError;
  @JsonKey(name: 'datetime')
  String get dateTime => throw _privateConstructorUsedError;

  /// Serializes this BookingDetailsPaymentHistoryModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BookingDetailsPaymentHistoryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookingDetailsPaymentHistoryModelCopyWith<BookingDetailsPaymentHistoryModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingDetailsPaymentHistoryModelCopyWith<$Res> {
  factory $BookingDetailsPaymentHistoryModelCopyWith(
          BookingDetailsPaymentHistoryModel value,
          $Res Function(BookingDetailsPaymentHistoryModel) then) =
      _$BookingDetailsPaymentHistoryModelCopyWithImpl<$Res,
          BookingDetailsPaymentHistoryModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'amount') int amount,
      @JsonKey(
          name: 'payment_method',
          defaultValue: PaymentMethod.cash,
          fromJson: PaymentMethod.fromJson)
      PaymentMethod paymentMethod,
      @JsonKey(name: 'datetime') String dateTime});
}

/// @nodoc
class _$BookingDetailsPaymentHistoryModelCopyWithImpl<$Res,
        $Val extends BookingDetailsPaymentHistoryModel>
    implements $BookingDetailsPaymentHistoryModelCopyWith<$Res> {
  _$BookingDetailsPaymentHistoryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookingDetailsPaymentHistoryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? paymentMethod = null,
    Object? dateTime = null,
  }) {
    return _then(_value.copyWith(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      paymentMethod: null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as PaymentMethod,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BookingDetailsPaymentHistoryModelImplCopyWith<$Res>
    implements $BookingDetailsPaymentHistoryModelCopyWith<$Res> {
  factory _$$BookingDetailsPaymentHistoryModelImplCopyWith(
          _$BookingDetailsPaymentHistoryModelImpl value,
          $Res Function(_$BookingDetailsPaymentHistoryModelImpl) then) =
      __$$BookingDetailsPaymentHistoryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'amount') int amount,
      @JsonKey(
          name: 'payment_method',
          defaultValue: PaymentMethod.cash,
          fromJson: PaymentMethod.fromJson)
      PaymentMethod paymentMethod,
      @JsonKey(name: 'datetime') String dateTime});
}

/// @nodoc
class __$$BookingDetailsPaymentHistoryModelImplCopyWithImpl<$Res>
    extends _$BookingDetailsPaymentHistoryModelCopyWithImpl<$Res,
        _$BookingDetailsPaymentHistoryModelImpl>
    implements _$$BookingDetailsPaymentHistoryModelImplCopyWith<$Res> {
  __$$BookingDetailsPaymentHistoryModelImplCopyWithImpl(
      _$BookingDetailsPaymentHistoryModelImpl _value,
      $Res Function(_$BookingDetailsPaymentHistoryModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookingDetailsPaymentHistoryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? paymentMethod = null,
    Object? dateTime = null,
  }) {
    return _then(_$BookingDetailsPaymentHistoryModelImpl(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      paymentMethod: null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as PaymentMethod,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BookingDetailsPaymentHistoryModelImpl
    implements _BookingDetailsPaymentHistoryModel {
  const _$BookingDetailsPaymentHistoryModelImpl(
      {@JsonKey(name: 'amount') required this.amount,
      @JsonKey(
          name: 'payment_method',
          defaultValue: PaymentMethod.cash,
          fromJson: PaymentMethod.fromJson)
      required this.paymentMethod,
      @JsonKey(name: 'datetime') required this.dateTime});

  factory _$BookingDetailsPaymentHistoryModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$BookingDetailsPaymentHistoryModelImplFromJson(json);

  @override
  @JsonKey(name: 'amount')
  final int amount;
  @override
  @JsonKey(
      name: 'payment_method',
      defaultValue: PaymentMethod.cash,
      fromJson: PaymentMethod.fromJson)
  final PaymentMethod paymentMethod;
  @override
  @JsonKey(name: 'datetime')
  final String dateTime;

  @override
  String toString() {
    return 'BookingDetailsPaymentHistoryModel(amount: $amount, paymentMethod: $paymentMethod, dateTime: $dateTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingDetailsPaymentHistoryModelImpl &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, amount, paymentMethod, dateTime);

  /// Create a copy of BookingDetailsPaymentHistoryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookingDetailsPaymentHistoryModelImplCopyWith<
          _$BookingDetailsPaymentHistoryModelImpl>
      get copyWith => __$$BookingDetailsPaymentHistoryModelImplCopyWithImpl<
          _$BookingDetailsPaymentHistoryModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookingDetailsPaymentHistoryModelImplToJson(
      this,
    );
  }
}

abstract class _BookingDetailsPaymentHistoryModel
    implements BookingDetailsPaymentHistoryModel {
  const factory _BookingDetailsPaymentHistoryModel(
          {@JsonKey(name: 'amount') required final int amount,
          @JsonKey(
              name: 'payment_method',
              defaultValue: PaymentMethod.cash,
              fromJson: PaymentMethod.fromJson)
          required final PaymentMethod paymentMethod,
          @JsonKey(name: 'datetime') required final String dateTime}) =
      _$BookingDetailsPaymentHistoryModelImpl;

  factory _BookingDetailsPaymentHistoryModel.fromJson(
          Map<String, dynamic> json) =
      _$BookingDetailsPaymentHistoryModelImpl.fromJson;

  @override
  @JsonKey(name: 'amount')
  int get amount;
  @override
  @JsonKey(
      name: 'payment_method',
      defaultValue: PaymentMethod.cash,
      fromJson: PaymentMethod.fromJson)
  PaymentMethod get paymentMethod;
  @override
  @JsonKey(name: 'datetime')
  String get dateTime;

  /// Create a copy of BookingDetailsPaymentHistoryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookingDetailsPaymentHistoryModelImplCopyWith<
          _$BookingDetailsPaymentHistoryModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
