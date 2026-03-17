// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ledger_expense_grouped_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LedgerExpenseGroupedModel _$LedgerExpenseGroupedModelFromJson(
    Map<String, dynamic> json) {
  return _LedgerExpenseGroupedModel.fromJson(json);
}

/// @nodoc
mixin _$LedgerExpenseGroupedModel {
  List<LedgerExpenseDailyModel> get dailyExpenses =>
      throw _privateConstructorUsedError;

  /// Serializes this LedgerExpenseGroupedModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LedgerExpenseGroupedModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LedgerExpenseGroupedModelCopyWith<LedgerExpenseGroupedModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LedgerExpenseGroupedModelCopyWith<$Res> {
  factory $LedgerExpenseGroupedModelCopyWith(LedgerExpenseGroupedModel value,
          $Res Function(LedgerExpenseGroupedModel) then) =
      _$LedgerExpenseGroupedModelCopyWithImpl<$Res, LedgerExpenseGroupedModel>;
  @useResult
  $Res call({List<LedgerExpenseDailyModel> dailyExpenses});
}

/// @nodoc
class _$LedgerExpenseGroupedModelCopyWithImpl<$Res,
        $Val extends LedgerExpenseGroupedModel>
    implements $LedgerExpenseGroupedModelCopyWith<$Res> {
  _$LedgerExpenseGroupedModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LedgerExpenseGroupedModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dailyExpenses = null,
  }) {
    return _then(_value.copyWith(
      dailyExpenses: null == dailyExpenses
          ? _value.dailyExpenses
          : dailyExpenses // ignore: cast_nullable_to_non_nullable
              as List<LedgerExpenseDailyModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LedgerExpenseGroupedModelImplCopyWith<$Res>
    implements $LedgerExpenseGroupedModelCopyWith<$Res> {
  factory _$$LedgerExpenseGroupedModelImplCopyWith(
          _$LedgerExpenseGroupedModelImpl value,
          $Res Function(_$LedgerExpenseGroupedModelImpl) then) =
      __$$LedgerExpenseGroupedModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<LedgerExpenseDailyModel> dailyExpenses});
}

/// @nodoc
class __$$LedgerExpenseGroupedModelImplCopyWithImpl<$Res>
    extends _$LedgerExpenseGroupedModelCopyWithImpl<$Res,
        _$LedgerExpenseGroupedModelImpl>
    implements _$$LedgerExpenseGroupedModelImplCopyWith<$Res> {
  __$$LedgerExpenseGroupedModelImplCopyWithImpl(
      _$LedgerExpenseGroupedModelImpl _value,
      $Res Function(_$LedgerExpenseGroupedModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of LedgerExpenseGroupedModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dailyExpenses = null,
  }) {
    return _then(_$LedgerExpenseGroupedModelImpl(
      dailyExpenses: null == dailyExpenses
          ? _value._dailyExpenses
          : dailyExpenses // ignore: cast_nullable_to_non_nullable
              as List<LedgerExpenseDailyModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LedgerExpenseGroupedModelImpl implements _LedgerExpenseGroupedModel {
  const _$LedgerExpenseGroupedModelImpl(
      {required final List<LedgerExpenseDailyModel> dailyExpenses})
      : _dailyExpenses = dailyExpenses;

  factory _$LedgerExpenseGroupedModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LedgerExpenseGroupedModelImplFromJson(json);

  final List<LedgerExpenseDailyModel> _dailyExpenses;
  @override
  List<LedgerExpenseDailyModel> get dailyExpenses {
    if (_dailyExpenses is EqualUnmodifiableListView) return _dailyExpenses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dailyExpenses);
  }

  @override
  String toString() {
    return 'LedgerExpenseGroupedModel(dailyExpenses: $dailyExpenses)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LedgerExpenseGroupedModelImpl &&
            const DeepCollectionEquality()
                .equals(other._dailyExpenses, _dailyExpenses));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_dailyExpenses));

  /// Create a copy of LedgerExpenseGroupedModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LedgerExpenseGroupedModelImplCopyWith<_$LedgerExpenseGroupedModelImpl>
      get copyWith => __$$LedgerExpenseGroupedModelImplCopyWithImpl<
          _$LedgerExpenseGroupedModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LedgerExpenseGroupedModelImplToJson(
      this,
    );
  }
}

abstract class _LedgerExpenseGroupedModel implements LedgerExpenseGroupedModel {
  const factory _LedgerExpenseGroupedModel(
          {required final List<LedgerExpenseDailyModel> dailyExpenses}) =
      _$LedgerExpenseGroupedModelImpl;

  factory _LedgerExpenseGroupedModel.fromJson(Map<String, dynamic> json) =
      _$LedgerExpenseGroupedModelImpl.fromJson;

  @override
  List<LedgerExpenseDailyModel> get dailyExpenses;

  /// Create a copy of LedgerExpenseGroupedModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LedgerExpenseGroupedModelImplCopyWith<_$LedgerExpenseGroupedModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

LedgerExpenseDailyModel _$LedgerExpenseDailyModelFromJson(
    Map<String, dynamic> json) {
  return _LedgerExpenseDailyModel.fromJson(json);
}

/// @nodoc
mixin _$LedgerExpenseDailyModel {
  String get date => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_expense', defaultValue: 0)
  int get total => throw _privateConstructorUsedError;
  List<ExpenseModel> get expenses => throw _privateConstructorUsedError;

  /// Serializes this LedgerExpenseDailyModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LedgerExpenseDailyModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LedgerExpenseDailyModelCopyWith<LedgerExpenseDailyModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LedgerExpenseDailyModelCopyWith<$Res> {
  factory $LedgerExpenseDailyModelCopyWith(LedgerExpenseDailyModel value,
          $Res Function(LedgerExpenseDailyModel) then) =
      _$LedgerExpenseDailyModelCopyWithImpl<$Res, LedgerExpenseDailyModel>;
  @useResult
  $Res call(
      {String date,
      @JsonKey(name: 'total_expense', defaultValue: 0) int total,
      List<ExpenseModel> expenses});
}

/// @nodoc
class _$LedgerExpenseDailyModelCopyWithImpl<$Res,
        $Val extends LedgerExpenseDailyModel>
    implements $LedgerExpenseDailyModelCopyWith<$Res> {
  _$LedgerExpenseDailyModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LedgerExpenseDailyModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? total = null,
    Object? expenses = null,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      expenses: null == expenses
          ? _value.expenses
          : expenses // ignore: cast_nullable_to_non_nullable
              as List<ExpenseModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LedgerExpenseDailyModelImplCopyWith<$Res>
    implements $LedgerExpenseDailyModelCopyWith<$Res> {
  factory _$$LedgerExpenseDailyModelImplCopyWith(
          _$LedgerExpenseDailyModelImpl value,
          $Res Function(_$LedgerExpenseDailyModelImpl) then) =
      __$$LedgerExpenseDailyModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String date,
      @JsonKey(name: 'total_expense', defaultValue: 0) int total,
      List<ExpenseModel> expenses});
}

/// @nodoc
class __$$LedgerExpenseDailyModelImplCopyWithImpl<$Res>
    extends _$LedgerExpenseDailyModelCopyWithImpl<$Res,
        _$LedgerExpenseDailyModelImpl>
    implements _$$LedgerExpenseDailyModelImplCopyWith<$Res> {
  __$$LedgerExpenseDailyModelImplCopyWithImpl(
      _$LedgerExpenseDailyModelImpl _value,
      $Res Function(_$LedgerExpenseDailyModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of LedgerExpenseDailyModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? total = null,
    Object? expenses = null,
  }) {
    return _then(_$LedgerExpenseDailyModelImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      expenses: null == expenses
          ? _value._expenses
          : expenses // ignore: cast_nullable_to_non_nullable
              as List<ExpenseModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LedgerExpenseDailyModelImpl implements _LedgerExpenseDailyModel {
  const _$LedgerExpenseDailyModelImpl(
      {required this.date,
      @JsonKey(name: 'total_expense', defaultValue: 0) required this.total,
      required final List<ExpenseModel> expenses})
      : _expenses = expenses;

  factory _$LedgerExpenseDailyModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LedgerExpenseDailyModelImplFromJson(json);

  @override
  final String date;
  @override
  @JsonKey(name: 'total_expense', defaultValue: 0)
  final int total;
  final List<ExpenseModel> _expenses;
  @override
  List<ExpenseModel> get expenses {
    if (_expenses is EqualUnmodifiableListView) return _expenses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_expenses);
  }

  @override
  String toString() {
    return 'LedgerExpenseDailyModel(date: $date, total: $total, expenses: $expenses)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LedgerExpenseDailyModelImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.total, total) || other.total == total) &&
            const DeepCollectionEquality().equals(other._expenses, _expenses));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, date, total, const DeepCollectionEquality().hash(_expenses));

  /// Create a copy of LedgerExpenseDailyModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LedgerExpenseDailyModelImplCopyWith<_$LedgerExpenseDailyModelImpl>
      get copyWith => __$$LedgerExpenseDailyModelImplCopyWithImpl<
          _$LedgerExpenseDailyModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LedgerExpenseDailyModelImplToJson(
      this,
    );
  }
}

abstract class _LedgerExpenseDailyModel implements LedgerExpenseDailyModel {
  const factory _LedgerExpenseDailyModel(
      {required final String date,
      @JsonKey(name: 'total_expense', defaultValue: 0) required final int total,
      required final List<ExpenseModel>
          expenses}) = _$LedgerExpenseDailyModelImpl;

  factory _LedgerExpenseDailyModel.fromJson(Map<String, dynamic> json) =
      _$LedgerExpenseDailyModelImpl.fromJson;

  @override
  String get date;
  @override
  @JsonKey(name: 'total_expense', defaultValue: 0)
  int get total;
  @override
  List<ExpenseModel> get expenses;

  /// Create a copy of LedgerExpenseDailyModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LedgerExpenseDailyModelImplCopyWith<_$LedgerExpenseDailyModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
