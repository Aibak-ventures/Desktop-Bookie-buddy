// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_history_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PaymentHistoryModel {
  List<MonthlyPaymentsModel> get monthlyPayments =>
      throw _privateConstructorUsedError;

  /// Create a copy of PaymentHistoryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentHistoryModelCopyWith<PaymentHistoryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentHistoryModelCopyWith<$Res> {
  factory $PaymentHistoryModelCopyWith(
          PaymentHistoryModel value, $Res Function(PaymentHistoryModel) then) =
      _$PaymentHistoryModelCopyWithImpl<$Res, PaymentHistoryModel>;
  @useResult
  $Res call({List<MonthlyPaymentsModel> monthlyPayments});
}

/// @nodoc
class _$PaymentHistoryModelCopyWithImpl<$Res, $Val extends PaymentHistoryModel>
    implements $PaymentHistoryModelCopyWith<$Res> {
  _$PaymentHistoryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentHistoryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? monthlyPayments = null,
  }) {
    return _then(_value.copyWith(
      monthlyPayments: null == monthlyPayments
          ? _value.monthlyPayments
          : monthlyPayments // ignore: cast_nullable_to_non_nullable
              as List<MonthlyPaymentsModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaymentHistoryModelImplCopyWith<$Res>
    implements $PaymentHistoryModelCopyWith<$Res> {
  factory _$$PaymentHistoryModelImplCopyWith(_$PaymentHistoryModelImpl value,
          $Res Function(_$PaymentHistoryModelImpl) then) =
      __$$PaymentHistoryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<MonthlyPaymentsModel> monthlyPayments});
}

/// @nodoc
class __$$PaymentHistoryModelImplCopyWithImpl<$Res>
    extends _$PaymentHistoryModelCopyWithImpl<$Res, _$PaymentHistoryModelImpl>
    implements _$$PaymentHistoryModelImplCopyWith<$Res> {
  __$$PaymentHistoryModelImplCopyWithImpl(_$PaymentHistoryModelImpl _value,
      $Res Function(_$PaymentHistoryModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaymentHistoryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? monthlyPayments = null,
  }) {
    return _then(_$PaymentHistoryModelImpl(
      monthlyPayments: null == monthlyPayments
          ? _value._monthlyPayments
          : monthlyPayments // ignore: cast_nullable_to_non_nullable
              as List<MonthlyPaymentsModel>,
    ));
  }
}

/// @nodoc

class _$PaymentHistoryModelImpl implements _PaymentHistoryModel {
  const _$PaymentHistoryModelImpl(
      {required final List<MonthlyPaymentsModel> monthlyPayments})
      : _monthlyPayments = monthlyPayments;

  final List<MonthlyPaymentsModel> _monthlyPayments;
  @override
  List<MonthlyPaymentsModel> get monthlyPayments {
    if (_monthlyPayments is EqualUnmodifiableListView) return _monthlyPayments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_monthlyPayments);
  }

  @override
  String toString() {
    return 'PaymentHistoryModel(monthlyPayments: $monthlyPayments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentHistoryModelImpl &&
            const DeepCollectionEquality()
                .equals(other._monthlyPayments, _monthlyPayments));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_monthlyPayments));

  /// Create a copy of PaymentHistoryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentHistoryModelImplCopyWith<_$PaymentHistoryModelImpl> get copyWith =>
      __$$PaymentHistoryModelImplCopyWithImpl<_$PaymentHistoryModelImpl>(
          this, _$identity);
}

abstract class _PaymentHistoryModel implements PaymentHistoryModel {
  const factory _PaymentHistoryModel(
          {required final List<MonthlyPaymentsModel> monthlyPayments}) =
      _$PaymentHistoryModelImpl;

  @override
  List<MonthlyPaymentsModel> get monthlyPayments;

  /// Create a copy of PaymentHistoryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentHistoryModelImplCopyWith<_$PaymentHistoryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MonthlyPaymentsModel _$MonthlyPaymentsModelFromJson(Map<String, dynamic> json) {
  return _MonthlyPaymentsModel.fromJson(json);
}

/// @nodoc
mixin _$MonthlyPaymentsModel {
  String get month => throw _privateConstructorUsedError;
  @JsonKey(name: 'daily_payments')
  List<DailyPaymentsModel> get dailyPayments =>
      throw _privateConstructorUsedError;

  /// Serializes this MonthlyPaymentsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MonthlyPaymentsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MonthlyPaymentsModelCopyWith<MonthlyPaymentsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MonthlyPaymentsModelCopyWith<$Res> {
  factory $MonthlyPaymentsModelCopyWith(MonthlyPaymentsModel value,
          $Res Function(MonthlyPaymentsModel) then) =
      _$MonthlyPaymentsModelCopyWithImpl<$Res, MonthlyPaymentsModel>;
  @useResult
  $Res call(
      {String month,
      @JsonKey(name: 'daily_payments') List<DailyPaymentsModel> dailyPayments});
}

/// @nodoc
class _$MonthlyPaymentsModelCopyWithImpl<$Res,
        $Val extends MonthlyPaymentsModel>
    implements $MonthlyPaymentsModelCopyWith<$Res> {
  _$MonthlyPaymentsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MonthlyPaymentsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? month = null,
    Object? dailyPayments = null,
  }) {
    return _then(_value.copyWith(
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as String,
      dailyPayments: null == dailyPayments
          ? _value.dailyPayments
          : dailyPayments // ignore: cast_nullable_to_non_nullable
              as List<DailyPaymentsModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MonthlyPaymentsModelImplCopyWith<$Res>
    implements $MonthlyPaymentsModelCopyWith<$Res> {
  factory _$$MonthlyPaymentsModelImplCopyWith(_$MonthlyPaymentsModelImpl value,
          $Res Function(_$MonthlyPaymentsModelImpl) then) =
      __$$MonthlyPaymentsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String month,
      @JsonKey(name: 'daily_payments') List<DailyPaymentsModel> dailyPayments});
}

/// @nodoc
class __$$MonthlyPaymentsModelImplCopyWithImpl<$Res>
    extends _$MonthlyPaymentsModelCopyWithImpl<$Res, _$MonthlyPaymentsModelImpl>
    implements _$$MonthlyPaymentsModelImplCopyWith<$Res> {
  __$$MonthlyPaymentsModelImplCopyWithImpl(_$MonthlyPaymentsModelImpl _value,
      $Res Function(_$MonthlyPaymentsModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of MonthlyPaymentsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? month = null,
    Object? dailyPayments = null,
  }) {
    return _then(_$MonthlyPaymentsModelImpl(
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as String,
      dailyPayments: null == dailyPayments
          ? _value._dailyPayments
          : dailyPayments // ignore: cast_nullable_to_non_nullable
              as List<DailyPaymentsModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MonthlyPaymentsModelImpl implements _MonthlyPaymentsModel {
  const _$MonthlyPaymentsModelImpl(
      {required this.month,
      @JsonKey(name: 'daily_payments')
      required final List<DailyPaymentsModel> dailyPayments})
      : _dailyPayments = dailyPayments;

  factory _$MonthlyPaymentsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MonthlyPaymentsModelImplFromJson(json);

  @override
  final String month;
  final List<DailyPaymentsModel> _dailyPayments;
  @override
  @JsonKey(name: 'daily_payments')
  List<DailyPaymentsModel> get dailyPayments {
    if (_dailyPayments is EqualUnmodifiableListView) return _dailyPayments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dailyPayments);
  }

  @override
  String toString() {
    return 'MonthlyPaymentsModel(month: $month, dailyPayments: $dailyPayments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MonthlyPaymentsModelImpl &&
            (identical(other.month, month) || other.month == month) &&
            const DeepCollectionEquality()
                .equals(other._dailyPayments, _dailyPayments));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, month, const DeepCollectionEquality().hash(_dailyPayments));

  /// Create a copy of MonthlyPaymentsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MonthlyPaymentsModelImplCopyWith<_$MonthlyPaymentsModelImpl>
      get copyWith =>
          __$$MonthlyPaymentsModelImplCopyWithImpl<_$MonthlyPaymentsModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MonthlyPaymentsModelImplToJson(
      this,
    );
  }
}

abstract class _MonthlyPaymentsModel implements MonthlyPaymentsModel {
  const factory _MonthlyPaymentsModel(
          {required final String month,
          @JsonKey(name: 'daily_payments')
          required final List<DailyPaymentsModel> dailyPayments}) =
      _$MonthlyPaymentsModelImpl;

  factory _MonthlyPaymentsModel.fromJson(Map<String, dynamic> json) =
      _$MonthlyPaymentsModelImpl.fromJson;

  @override
  String get month;
  @override
  @JsonKey(name: 'daily_payments')
  List<DailyPaymentsModel> get dailyPayments;

  /// Create a copy of MonthlyPaymentsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MonthlyPaymentsModelImplCopyWith<_$MonthlyPaymentsModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

DailyPaymentsModel _$DailyPaymentsModelFromJson(Map<String, dynamic> json) {
  return _DailyPaymentsModel.fromJson(json);
}

/// @nodoc
mixin _$DailyPaymentsModel {
  String get date => throw _privateConstructorUsedError;
  List<PaymentModel> get payments => throw _privateConstructorUsedError;

  /// Serializes this DailyPaymentsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DailyPaymentsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailyPaymentsModelCopyWith<DailyPaymentsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyPaymentsModelCopyWith<$Res> {
  factory $DailyPaymentsModelCopyWith(
          DailyPaymentsModel value, $Res Function(DailyPaymentsModel) then) =
      _$DailyPaymentsModelCopyWithImpl<$Res, DailyPaymentsModel>;
  @useResult
  $Res call({String date, List<PaymentModel> payments});
}

/// @nodoc
class _$DailyPaymentsModelCopyWithImpl<$Res, $Val extends DailyPaymentsModel>
    implements $DailyPaymentsModelCopyWith<$Res> {
  _$DailyPaymentsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailyPaymentsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? payments = null,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      payments: null == payments
          ? _value.payments
          : payments // ignore: cast_nullable_to_non_nullable
              as List<PaymentModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DailyPaymentsModelImplCopyWith<$Res>
    implements $DailyPaymentsModelCopyWith<$Res> {
  factory _$$DailyPaymentsModelImplCopyWith(_$DailyPaymentsModelImpl value,
          $Res Function(_$DailyPaymentsModelImpl) then) =
      __$$DailyPaymentsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String date, List<PaymentModel> payments});
}

/// @nodoc
class __$$DailyPaymentsModelImplCopyWithImpl<$Res>
    extends _$DailyPaymentsModelCopyWithImpl<$Res, _$DailyPaymentsModelImpl>
    implements _$$DailyPaymentsModelImplCopyWith<$Res> {
  __$$DailyPaymentsModelImplCopyWithImpl(_$DailyPaymentsModelImpl _value,
      $Res Function(_$DailyPaymentsModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailyPaymentsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? payments = null,
  }) {
    return _then(_$DailyPaymentsModelImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      payments: null == payments
          ? _value._payments
          : payments // ignore: cast_nullable_to_non_nullable
              as List<PaymentModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DailyPaymentsModelImpl implements _DailyPaymentsModel {
  const _$DailyPaymentsModelImpl(
      {required this.date, required final List<PaymentModel> payments})
      : _payments = payments;

  factory _$DailyPaymentsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyPaymentsModelImplFromJson(json);

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
  String toString() {
    return 'DailyPaymentsModel(date: $date, payments: $payments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyPaymentsModelImpl &&
            (identical(other.date, date) || other.date == date) &&
            const DeepCollectionEquality().equals(other._payments, _payments));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, date, const DeepCollectionEquality().hash(_payments));

  /// Create a copy of DailyPaymentsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyPaymentsModelImplCopyWith<_$DailyPaymentsModelImpl> get copyWith =>
      __$$DailyPaymentsModelImplCopyWithImpl<_$DailyPaymentsModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyPaymentsModelImplToJson(
      this,
    );
  }
}

abstract class _DailyPaymentsModel implements DailyPaymentsModel {
  const factory _DailyPaymentsModel(
      {required final String date,
      required final List<PaymentModel> payments}) = _$DailyPaymentsModelImpl;

  factory _DailyPaymentsModel.fromJson(Map<String, dynamic> json) =
      _$DailyPaymentsModelImpl.fromJson;

  @override
  String get date;
  @override
  List<PaymentModel> get payments;

  /// Create a copy of DailyPaymentsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailyPaymentsModelImplCopyWith<_$DailyPaymentsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
