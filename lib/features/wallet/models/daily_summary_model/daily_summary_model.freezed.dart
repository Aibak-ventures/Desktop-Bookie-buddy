// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_summary_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DailySummaryModel _$DailySummaryModelFromJson(Map<String, dynamic> json) {
  return _DailySummaryModel.fromJson(json);
}

/// @nodoc
mixin _$DailySummaryModel {
  String get date => throw _privateConstructorUsedError;
  PaymentsSummary get payments => throw _privateConstructorUsedError;
  @JsonKey(name: 'expenses', readValue: _readValue)
  int get expenses => throw _privateConstructorUsedError;
  @JsonKey(name: 'pendings', readValue: _readValue)
  int get pendings => throw _privateConstructorUsedError;
  @JsonKey(name: 'security', readValue: _readValue)
  int get securityAmount => throw _privateConstructorUsedError;

  /// Serializes this DailySummaryModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DailySummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailySummaryModelCopyWith<DailySummaryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailySummaryModelCopyWith<$Res> {
  factory $DailySummaryModelCopyWith(
          DailySummaryModel value, $Res Function(DailySummaryModel) then) =
      _$DailySummaryModelCopyWithImpl<$Res, DailySummaryModel>;
  @useResult
  $Res call(
      {String date,
      PaymentsSummary payments,
      @JsonKey(name: 'expenses', readValue: _readValue) int expenses,
      @JsonKey(name: 'pendings', readValue: _readValue) int pendings,
      @JsonKey(name: 'security', readValue: _readValue) int securityAmount});

  $PaymentsSummaryCopyWith<$Res> get payments;
}

/// @nodoc
class _$DailySummaryModelCopyWithImpl<$Res, $Val extends DailySummaryModel>
    implements $DailySummaryModelCopyWith<$Res> {
  _$DailySummaryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailySummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? payments = null,
    Object? expenses = null,
    Object? pendings = null,
    Object? securityAmount = null,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      payments: null == payments
          ? _value.payments
          : payments // ignore: cast_nullable_to_non_nullable
              as PaymentsSummary,
      expenses: null == expenses
          ? _value.expenses
          : expenses // ignore: cast_nullable_to_non_nullable
              as int,
      pendings: null == pendings
          ? _value.pendings
          : pendings // ignore: cast_nullable_to_non_nullable
              as int,
      securityAmount: null == securityAmount
          ? _value.securityAmount
          : securityAmount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  /// Create a copy of DailySummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaymentsSummaryCopyWith<$Res> get payments {
    return $PaymentsSummaryCopyWith<$Res>(_value.payments, (value) {
      return _then(_value.copyWith(payments: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DailySummaryModelImplCopyWith<$Res>
    implements $DailySummaryModelCopyWith<$Res> {
  factory _$$DailySummaryModelImplCopyWith(_$DailySummaryModelImpl value,
          $Res Function(_$DailySummaryModelImpl) then) =
      __$$DailySummaryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String date,
      PaymentsSummary payments,
      @JsonKey(name: 'expenses', readValue: _readValue) int expenses,
      @JsonKey(name: 'pendings', readValue: _readValue) int pendings,
      @JsonKey(name: 'security', readValue: _readValue) int securityAmount});

  @override
  $PaymentsSummaryCopyWith<$Res> get payments;
}

/// @nodoc
class __$$DailySummaryModelImplCopyWithImpl<$Res>
    extends _$DailySummaryModelCopyWithImpl<$Res, _$DailySummaryModelImpl>
    implements _$$DailySummaryModelImplCopyWith<$Res> {
  __$$DailySummaryModelImplCopyWithImpl(_$DailySummaryModelImpl _value,
      $Res Function(_$DailySummaryModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailySummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? payments = null,
    Object? expenses = null,
    Object? pendings = null,
    Object? securityAmount = null,
  }) {
    return _then(_$DailySummaryModelImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      payments: null == payments
          ? _value.payments
          : payments // ignore: cast_nullable_to_non_nullable
              as PaymentsSummary,
      expenses: null == expenses
          ? _value.expenses
          : expenses // ignore: cast_nullable_to_non_nullable
              as int,
      pendings: null == pendings
          ? _value.pendings
          : pendings // ignore: cast_nullable_to_non_nullable
              as int,
      securityAmount: null == securityAmount
          ? _value.securityAmount
          : securityAmount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DailySummaryModelImpl implements _DailySummaryModel {
  const _$DailySummaryModelImpl(
      {required this.date,
      required this.payments,
      @JsonKey(name: 'expenses', readValue: _readValue) required this.expenses,
      @JsonKey(name: 'pendings', readValue: _readValue) required this.pendings,
      @JsonKey(name: 'security', readValue: _readValue)
      required this.securityAmount});

  factory _$DailySummaryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailySummaryModelImplFromJson(json);

  @override
  final String date;
  @override
  final PaymentsSummary payments;
  @override
  @JsonKey(name: 'expenses', readValue: _readValue)
  final int expenses;
  @override
  @JsonKey(name: 'pendings', readValue: _readValue)
  final int pendings;
  @override
  @JsonKey(name: 'security', readValue: _readValue)
  final int securityAmount;

  @override
  String toString() {
    return 'DailySummaryModel(date: $date, payments: $payments, expenses: $expenses, pendings: $pendings, securityAmount: $securityAmount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailySummaryModelImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.payments, payments) ||
                other.payments == payments) &&
            (identical(other.expenses, expenses) ||
                other.expenses == expenses) &&
            (identical(other.pendings, pendings) ||
                other.pendings == pendings) &&
            (identical(other.securityAmount, securityAmount) ||
                other.securityAmount == securityAmount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, date, payments, expenses, pendings, securityAmount);

  /// Create a copy of DailySummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailySummaryModelImplCopyWith<_$DailySummaryModelImpl> get copyWith =>
      __$$DailySummaryModelImplCopyWithImpl<_$DailySummaryModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DailySummaryModelImplToJson(
      this,
    );
  }
}

abstract class _DailySummaryModel implements DailySummaryModel {
  const factory _DailySummaryModel(
      {required final String date,
      required final PaymentsSummary payments,
      @JsonKey(name: 'expenses', readValue: _readValue)
      required final int expenses,
      @JsonKey(name: 'pendings', readValue: _readValue)
      required final int pendings,
      @JsonKey(name: 'security', readValue: _readValue)
      required final int securityAmount}) = _$DailySummaryModelImpl;

  factory _DailySummaryModel.fromJson(Map<String, dynamic> json) =
      _$DailySummaryModelImpl.fromJson;

  @override
  String get date;
  @override
  PaymentsSummary get payments;
  @override
  @JsonKey(name: 'expenses', readValue: _readValue)
  int get expenses;
  @override
  @JsonKey(name: 'pendings', readValue: _readValue)
  int get pendings;
  @override
  @JsonKey(name: 'security', readValue: _readValue)
  int get securityAmount;

  /// Create a copy of DailySummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailySummaryModelImplCopyWith<_$DailySummaryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PaymentsSummary _$PaymentsSummaryFromJson(Map<String, dynamic> json) {
  return _PaymentsSummary.fromJson(json);
}

/// @nodoc
mixin _$PaymentsSummary {
  int get gpay => throw _privateConstructorUsedError;
  int get cash => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;

  /// Serializes this PaymentsSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaymentsSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentsSummaryCopyWith<PaymentsSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentsSummaryCopyWith<$Res> {
  factory $PaymentsSummaryCopyWith(
          PaymentsSummary value, $Res Function(PaymentsSummary) then) =
      _$PaymentsSummaryCopyWithImpl<$Res, PaymentsSummary>;
  @useResult
  $Res call({int gpay, int cash, int total});
}

/// @nodoc
class _$PaymentsSummaryCopyWithImpl<$Res, $Val extends PaymentsSummary>
    implements $PaymentsSummaryCopyWith<$Res> {
  _$PaymentsSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentsSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gpay = null,
    Object? cash = null,
    Object? total = null,
  }) {
    return _then(_value.copyWith(
      gpay: null == gpay
          ? _value.gpay
          : gpay // ignore: cast_nullable_to_non_nullable
              as int,
      cash: null == cash
          ? _value.cash
          : cash // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaymentsSummaryImplCopyWith<$Res>
    implements $PaymentsSummaryCopyWith<$Res> {
  factory _$$PaymentsSummaryImplCopyWith(_$PaymentsSummaryImpl value,
          $Res Function(_$PaymentsSummaryImpl) then) =
      __$$PaymentsSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int gpay, int cash, int total});
}

/// @nodoc
class __$$PaymentsSummaryImplCopyWithImpl<$Res>
    extends _$PaymentsSummaryCopyWithImpl<$Res, _$PaymentsSummaryImpl>
    implements _$$PaymentsSummaryImplCopyWith<$Res> {
  __$$PaymentsSummaryImplCopyWithImpl(
      _$PaymentsSummaryImpl _value, $Res Function(_$PaymentsSummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaymentsSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gpay = null,
    Object? cash = null,
    Object? total = null,
  }) {
    return _then(_$PaymentsSummaryImpl(
      gpay: null == gpay
          ? _value.gpay
          : gpay // ignore: cast_nullable_to_non_nullable
              as int,
      cash: null == cash
          ? _value.cash
          : cash // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PaymentsSummaryImpl implements _PaymentsSummary {
  const _$PaymentsSummaryImpl(
      {required this.gpay, required this.cash, required this.total});

  factory _$PaymentsSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentsSummaryImplFromJson(json);

  @override
  final int gpay;
  @override
  final int cash;
  @override
  final int total;

  @override
  String toString() {
    return 'PaymentsSummary(gpay: $gpay, cash: $cash, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentsSummaryImpl &&
            (identical(other.gpay, gpay) || other.gpay == gpay) &&
            (identical(other.cash, cash) || other.cash == cash) &&
            (identical(other.total, total) || other.total == total));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, gpay, cash, total);

  /// Create a copy of PaymentsSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentsSummaryImplCopyWith<_$PaymentsSummaryImpl> get copyWith =>
      __$$PaymentsSummaryImplCopyWithImpl<_$PaymentsSummaryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentsSummaryImplToJson(
      this,
    );
  }
}

abstract class _PaymentsSummary implements PaymentsSummary {
  const factory _PaymentsSummary(
      {required final int gpay,
      required final int cash,
      required final int total}) = _$PaymentsSummaryImpl;

  factory _PaymentsSummary.fromJson(Map<String, dynamic> json) =
      _$PaymentsSummaryImpl.fromJson;

  @override
  int get gpay;
  @override
  int get cash;
  @override
  int get total;

  /// Create a copy of PaymentsSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentsSummaryImplCopyWith<_$PaymentsSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
