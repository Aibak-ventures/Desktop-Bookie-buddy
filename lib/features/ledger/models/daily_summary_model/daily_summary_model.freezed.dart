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
  LedgerPaymentsSummaryModel get payments => throw _privateConstructorUsedError;
  @JsonKey(name: 'expenses', readValue: _readSummaryValue)
  int get expenses => throw _privateConstructorUsedError;
  @JsonKey(name: 'pendings', readValue: _readSummaryValue)
  int get pendings => throw _privateConstructorUsedError;
  @JsonKey(name: 'security', readValue: _readSummaryValue)
  int get securityAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'bookings', readValue: _readSummaryValue)
  int get bookingAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'sales', readValue: _readSummaryValue)
  int get salesAmount => throw _privateConstructorUsedError;

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
      LedgerPaymentsSummaryModel payments,
      @JsonKey(name: 'expenses', readValue: _readSummaryValue) int expenses,
      @JsonKey(name: 'pendings', readValue: _readSummaryValue) int pendings,
      @JsonKey(name: 'security', readValue: _readSummaryValue)
      int securityAmount,
      @JsonKey(name: 'bookings', readValue: _readSummaryValue)
      int bookingAmount,
      @JsonKey(name: 'sales', readValue: _readSummaryValue) int salesAmount});

  $LedgerPaymentsSummaryModelCopyWith<$Res> get payments;
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
    Object? bookingAmount = null,
    Object? salesAmount = null,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      payments: null == payments
          ? _value.payments
          : payments // ignore: cast_nullable_to_non_nullable
              as LedgerPaymentsSummaryModel,
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
      bookingAmount: null == bookingAmount
          ? _value.bookingAmount
          : bookingAmount // ignore: cast_nullable_to_non_nullable
              as int,
      salesAmount: null == salesAmount
          ? _value.salesAmount
          : salesAmount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  /// Create a copy of DailySummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LedgerPaymentsSummaryModelCopyWith<$Res> get payments {
    return $LedgerPaymentsSummaryModelCopyWith<$Res>(_value.payments, (value) {
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
      LedgerPaymentsSummaryModel payments,
      @JsonKey(name: 'expenses', readValue: _readSummaryValue) int expenses,
      @JsonKey(name: 'pendings', readValue: _readSummaryValue) int pendings,
      @JsonKey(name: 'security', readValue: _readSummaryValue)
      int securityAmount,
      @JsonKey(name: 'bookings', readValue: _readSummaryValue)
      int bookingAmount,
      @JsonKey(name: 'sales', readValue: _readSummaryValue) int salesAmount});

  @override
  $LedgerPaymentsSummaryModelCopyWith<$Res> get payments;
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
    Object? bookingAmount = null,
    Object? salesAmount = null,
  }) {
    return _then(_$DailySummaryModelImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      payments: null == payments
          ? _value.payments
          : payments // ignore: cast_nullable_to_non_nullable
              as LedgerPaymentsSummaryModel,
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
      bookingAmount: null == bookingAmount
          ? _value.bookingAmount
          : bookingAmount // ignore: cast_nullable_to_non_nullable
              as int,
      salesAmount: null == salesAmount
          ? _value.salesAmount
          : salesAmount // ignore: cast_nullable_to_non_nullable
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
      @JsonKey(name: 'expenses', readValue: _readSummaryValue)
      required this.expenses,
      @JsonKey(name: 'pendings', readValue: _readSummaryValue)
      required this.pendings,
      @JsonKey(name: 'security', readValue: _readSummaryValue)
      required this.securityAmount,
      @JsonKey(name: 'bookings', readValue: _readSummaryValue)
      required this.bookingAmount,
      @JsonKey(name: 'sales', readValue: _readSummaryValue)
      required this.salesAmount});

  factory _$DailySummaryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailySummaryModelImplFromJson(json);

  @override
  final String date;
  @override
  final LedgerPaymentsSummaryModel payments;
  @override
  @JsonKey(name: 'expenses', readValue: _readSummaryValue)
  final int expenses;
  @override
  @JsonKey(name: 'pendings', readValue: _readSummaryValue)
  final int pendings;
  @override
  @JsonKey(name: 'security', readValue: _readSummaryValue)
  final int securityAmount;
  @override
  @JsonKey(name: 'bookings', readValue: _readSummaryValue)
  final int bookingAmount;
  @override
  @JsonKey(name: 'sales', readValue: _readSummaryValue)
  final int salesAmount;

  @override
  String toString() {
    return 'DailySummaryModel(date: $date, payments: $payments, expenses: $expenses, pendings: $pendings, securityAmount: $securityAmount, bookingAmount: $bookingAmount, salesAmount: $salesAmount)';
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
                other.securityAmount == securityAmount) &&
            (identical(other.bookingAmount, bookingAmount) ||
                other.bookingAmount == bookingAmount) &&
            (identical(other.salesAmount, salesAmount) ||
                other.salesAmount == salesAmount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, date, payments, expenses,
      pendings, securityAmount, bookingAmount, salesAmount);

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
      required final LedgerPaymentsSummaryModel payments,
      @JsonKey(name: 'expenses', readValue: _readSummaryValue)
      required final int expenses,
      @JsonKey(name: 'pendings', readValue: _readSummaryValue)
      required final int pendings,
      @JsonKey(name: 'security', readValue: _readSummaryValue)
      required final int securityAmount,
      @JsonKey(name: 'bookings', readValue: _readSummaryValue)
      required final int bookingAmount,
      @JsonKey(name: 'sales', readValue: _readSummaryValue)
      required final int salesAmount}) = _$DailySummaryModelImpl;

  factory _DailySummaryModel.fromJson(Map<String, dynamic> json) =
      _$DailySummaryModelImpl.fromJson;

  @override
  String get date;
  @override
  LedgerPaymentsSummaryModel get payments;
  @override
  @JsonKey(name: 'expenses', readValue: _readSummaryValue)
  int get expenses;
  @override
  @JsonKey(name: 'pendings', readValue: _readSummaryValue)
  int get pendings;
  @override
  @JsonKey(name: 'security', readValue: _readSummaryValue)
  int get securityAmount;
  @override
  @JsonKey(name: 'bookings', readValue: _readSummaryValue)
  int get bookingAmount;
  @override
  @JsonKey(name: 'sales', readValue: _readSummaryValue)
  int get salesAmount;

  /// Create a copy of DailySummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailySummaryModelImplCopyWith<_$DailySummaryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
