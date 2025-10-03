// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ledger_payment_grouped_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LedgerPaymentGroupedModel _$LedgerPaymentGroupedModelFromJson(
  Map<String, dynamic> json,
) {
  return _LedgerPaymentGroupedModel.fromJson(json);
}

/// @nodoc
mixin _$LedgerPaymentGroupedModel {
  List<LedgerPaymentsDailyModel> get dailyPayments =>
      throw _privateConstructorUsedError;

  /// Serializes this LedgerPaymentGroupedModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LedgerPaymentGroupedModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LedgerPaymentGroupedModelCopyWith<LedgerPaymentGroupedModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LedgerPaymentGroupedModelCopyWith<$Res> {
  factory $LedgerPaymentGroupedModelCopyWith(
    LedgerPaymentGroupedModel value,
    $Res Function(LedgerPaymentGroupedModel) then,
  ) = _$LedgerPaymentGroupedModelCopyWithImpl<$Res, LedgerPaymentGroupedModel>;
  @useResult
  $Res call({List<LedgerPaymentsDailyModel> dailyPayments});
}

/// @nodoc
class _$LedgerPaymentGroupedModelCopyWithImpl<
  $Res,
  $Val extends LedgerPaymentGroupedModel
>
    implements $LedgerPaymentGroupedModelCopyWith<$Res> {
  _$LedgerPaymentGroupedModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LedgerPaymentGroupedModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? dailyPayments = null}) {
    return _then(
      _value.copyWith(
            dailyPayments: null == dailyPayments
                ? _value.dailyPayments
                : dailyPayments // ignore: cast_nullable_to_non_nullable
                      as List<LedgerPaymentsDailyModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LedgerPaymentGroupedModelImplCopyWith<$Res>
    implements $LedgerPaymentGroupedModelCopyWith<$Res> {
  factory _$$LedgerPaymentGroupedModelImplCopyWith(
    _$LedgerPaymentGroupedModelImpl value,
    $Res Function(_$LedgerPaymentGroupedModelImpl) then,
  ) = __$$LedgerPaymentGroupedModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<LedgerPaymentsDailyModel> dailyPayments});
}

/// @nodoc
class __$$LedgerPaymentGroupedModelImplCopyWithImpl<$Res>
    extends
        _$LedgerPaymentGroupedModelCopyWithImpl<
          $Res,
          _$LedgerPaymentGroupedModelImpl
        >
    implements _$$LedgerPaymentGroupedModelImplCopyWith<$Res> {
  __$$LedgerPaymentGroupedModelImplCopyWithImpl(
    _$LedgerPaymentGroupedModelImpl _value,
    $Res Function(_$LedgerPaymentGroupedModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LedgerPaymentGroupedModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? dailyPayments = null}) {
    return _then(
      _$LedgerPaymentGroupedModelImpl(
        dailyPayments: null == dailyPayments
            ? _value._dailyPayments
            : dailyPayments // ignore: cast_nullable_to_non_nullable
                  as List<LedgerPaymentsDailyModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LedgerPaymentGroupedModelImpl implements _LedgerPaymentGroupedModel {
  const _$LedgerPaymentGroupedModelImpl({
    required final List<LedgerPaymentsDailyModel> dailyPayments,
  }) : _dailyPayments = dailyPayments;

  factory _$LedgerPaymentGroupedModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LedgerPaymentGroupedModelImplFromJson(json);

  final List<LedgerPaymentsDailyModel> _dailyPayments;
  @override
  List<LedgerPaymentsDailyModel> get dailyPayments {
    if (_dailyPayments is EqualUnmodifiableListView) return _dailyPayments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dailyPayments);
  }

  @override
  String toString() {
    return 'LedgerPaymentGroupedModel(dailyPayments: $dailyPayments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LedgerPaymentGroupedModelImpl &&
            const DeepCollectionEquality().equals(
              other._dailyPayments,
              _dailyPayments,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_dailyPayments),
  );

  /// Create a copy of LedgerPaymentGroupedModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LedgerPaymentGroupedModelImplCopyWith<_$LedgerPaymentGroupedModelImpl>
  get copyWith =>
      __$$LedgerPaymentGroupedModelImplCopyWithImpl<
        _$LedgerPaymentGroupedModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LedgerPaymentGroupedModelImplToJson(this);
  }
}

abstract class _LedgerPaymentGroupedModel implements LedgerPaymentGroupedModel {
  const factory _LedgerPaymentGroupedModel({
    required final List<LedgerPaymentsDailyModel> dailyPayments,
  }) = _$LedgerPaymentGroupedModelImpl;

  factory _LedgerPaymentGroupedModel.fromJson(Map<String, dynamic> json) =
      _$LedgerPaymentGroupedModelImpl.fromJson;

  @override
  List<LedgerPaymentsDailyModel> get dailyPayments;

  /// Create a copy of LedgerPaymentGroupedModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LedgerPaymentGroupedModelImplCopyWith<_$LedgerPaymentGroupedModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

LedgerPaymentsDailyModel _$LedgerPaymentsDailyModelFromJson(
  Map<String, dynamic> json,
) {
  return _LedgerPaymentsDailyModel.fromJson(json);
}

/// @nodoc
mixin _$LedgerPaymentsDailyModel {
  String get date => throw _privateConstructorUsedError;
  List<PaymentModel> get payments => throw _privateConstructorUsedError;
  LedgerPaymentsSummaryModel? get paymentsSummary =>
      throw _privateConstructorUsedError;

  /// Serializes this LedgerPaymentsDailyModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LedgerPaymentsDailyModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LedgerPaymentsDailyModelCopyWith<LedgerPaymentsDailyModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LedgerPaymentsDailyModelCopyWith<$Res> {
  factory $LedgerPaymentsDailyModelCopyWith(
    LedgerPaymentsDailyModel value,
    $Res Function(LedgerPaymentsDailyModel) then,
  ) = _$LedgerPaymentsDailyModelCopyWithImpl<$Res, LedgerPaymentsDailyModel>;
  @useResult
  $Res call({
    String date,
    List<PaymentModel> payments,
    LedgerPaymentsSummaryModel? paymentsSummary,
  });

  $LedgerPaymentsSummaryModelCopyWith<$Res>? get paymentsSummary;
}

/// @nodoc
class _$LedgerPaymentsDailyModelCopyWithImpl<
  $Res,
  $Val extends LedgerPaymentsDailyModel
>
    implements $LedgerPaymentsDailyModelCopyWith<$Res> {
  _$LedgerPaymentsDailyModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LedgerPaymentsDailyModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? payments = null,
    Object? paymentsSummary = freezed,
  }) {
    return _then(
      _value.copyWith(
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as String,
            payments: null == payments
                ? _value.payments
                : payments // ignore: cast_nullable_to_non_nullable
                      as List<PaymentModel>,
            paymentsSummary: freezed == paymentsSummary
                ? _value.paymentsSummary
                : paymentsSummary // ignore: cast_nullable_to_non_nullable
                      as LedgerPaymentsSummaryModel?,
          )
          as $Val,
    );
  }

  /// Create a copy of LedgerPaymentsDailyModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LedgerPaymentsSummaryModelCopyWith<$Res>? get paymentsSummary {
    if (_value.paymentsSummary == null) {
      return null;
    }

    return $LedgerPaymentsSummaryModelCopyWith<$Res>(_value.paymentsSummary!, (
      value,
    ) {
      return _then(_value.copyWith(paymentsSummary: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LedgerPaymentsDailyModelImplCopyWith<$Res>
    implements $LedgerPaymentsDailyModelCopyWith<$Res> {
  factory _$$LedgerPaymentsDailyModelImplCopyWith(
    _$LedgerPaymentsDailyModelImpl value,
    $Res Function(_$LedgerPaymentsDailyModelImpl) then,
  ) = __$$LedgerPaymentsDailyModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String date,
    List<PaymentModel> payments,
    LedgerPaymentsSummaryModel? paymentsSummary,
  });

  @override
  $LedgerPaymentsSummaryModelCopyWith<$Res>? get paymentsSummary;
}

/// @nodoc
class __$$LedgerPaymentsDailyModelImplCopyWithImpl<$Res>
    extends
        _$LedgerPaymentsDailyModelCopyWithImpl<
          $Res,
          _$LedgerPaymentsDailyModelImpl
        >
    implements _$$LedgerPaymentsDailyModelImplCopyWith<$Res> {
  __$$LedgerPaymentsDailyModelImplCopyWithImpl(
    _$LedgerPaymentsDailyModelImpl _value,
    $Res Function(_$LedgerPaymentsDailyModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LedgerPaymentsDailyModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? payments = null,
    Object? paymentsSummary = freezed,
  }) {
    return _then(
      _$LedgerPaymentsDailyModelImpl(
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as String,
        payments: null == payments
            ? _value._payments
            : payments // ignore: cast_nullable_to_non_nullable
                  as List<PaymentModel>,
        paymentsSummary: freezed == paymentsSummary
            ? _value.paymentsSummary
            : paymentsSummary // ignore: cast_nullable_to_non_nullable
                  as LedgerPaymentsSummaryModel?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LedgerPaymentsDailyModelImpl implements _LedgerPaymentsDailyModel {
  const _$LedgerPaymentsDailyModelImpl({
    required this.date,
    required final List<PaymentModel> payments,
    this.paymentsSummary,
  }) : _payments = payments;

  factory _$LedgerPaymentsDailyModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LedgerPaymentsDailyModelImplFromJson(json);

  @override
  final String date;
  final List<PaymentModel> _payments;
  @override
  List<PaymentModel> get payments {
    if (_payments is EqualUnmodifiableListView) return _payments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_payments);
  }

  @override
  final LedgerPaymentsSummaryModel? paymentsSummary;

  @override
  String toString() {
    return 'LedgerPaymentsDailyModel(date: $date, payments: $payments, paymentsSummary: $paymentsSummary)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LedgerPaymentsDailyModelImpl &&
            (identical(other.date, date) || other.date == date) &&
            const DeepCollectionEquality().equals(other._payments, _payments) &&
            (identical(other.paymentsSummary, paymentsSummary) ||
                other.paymentsSummary == paymentsSummary));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    date,
    const DeepCollectionEquality().hash(_payments),
    paymentsSummary,
  );

  /// Create a copy of LedgerPaymentsDailyModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LedgerPaymentsDailyModelImplCopyWith<_$LedgerPaymentsDailyModelImpl>
  get copyWith =>
      __$$LedgerPaymentsDailyModelImplCopyWithImpl<
        _$LedgerPaymentsDailyModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LedgerPaymentsDailyModelImplToJson(this);
  }
}

abstract class _LedgerPaymentsDailyModel implements LedgerPaymentsDailyModel {
  const factory _LedgerPaymentsDailyModel({
    required final String date,
    required final List<PaymentModel> payments,
    final LedgerPaymentsSummaryModel? paymentsSummary,
  }) = _$LedgerPaymentsDailyModelImpl;

  factory _LedgerPaymentsDailyModel.fromJson(Map<String, dynamic> json) =
      _$LedgerPaymentsDailyModelImpl.fromJson;

  @override
  String get date;
  @override
  List<PaymentModel> get payments;
  @override
  LedgerPaymentsSummaryModel? get paymentsSummary;

  /// Create a copy of LedgerPaymentsDailyModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LedgerPaymentsDailyModelImplCopyWith<_$LedgerPaymentsDailyModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
