// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_monthly_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProductMonthlyDataModel _$ProductMonthlyDataModelFromJson(
    Map<String, dynamic> json) {
  return _ProductMonthlyDataModel.fromJson(json);
}

/// @nodoc
mixin _$ProductMonthlyDataModel {
  int get year => throw _privateConstructorUsedError;
  int get month => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_expense')
  double get totalExpense => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_earned')
  double get totalEarned => throw _privateConstructorUsedError;

  /// Serializes this ProductMonthlyDataModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProductMonthlyDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductMonthlyDataModelCopyWith<ProductMonthlyDataModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductMonthlyDataModelCopyWith<$Res> {
  factory $ProductMonthlyDataModelCopyWith(ProductMonthlyDataModel value,
          $Res Function(ProductMonthlyDataModel) then) =
      _$ProductMonthlyDataModelCopyWithImpl<$Res, ProductMonthlyDataModel>;
  @useResult
  $Res call(
      {int year,
      int month,
      @JsonKey(name: 'total_expense') double totalExpense,
      @JsonKey(name: 'total_earned') double totalEarned});
}

/// @nodoc
class _$ProductMonthlyDataModelCopyWithImpl<$Res,
        $Val extends ProductMonthlyDataModel>
    implements $ProductMonthlyDataModelCopyWith<$Res> {
  _$ProductMonthlyDataModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductMonthlyDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? month = null,
    Object? totalExpense = null,
    Object? totalEarned = null,
  }) {
    return _then(_value.copyWith(
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as int,
      totalExpense: null == totalExpense
          ? _value.totalExpense
          : totalExpense // ignore: cast_nullable_to_non_nullable
              as double,
      totalEarned: null == totalEarned
          ? _value.totalEarned
          : totalEarned // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductMonthlyDataModelImplCopyWith<$Res>
    implements $ProductMonthlyDataModelCopyWith<$Res> {
  factory _$$ProductMonthlyDataModelImplCopyWith(
          _$ProductMonthlyDataModelImpl value,
          $Res Function(_$ProductMonthlyDataModelImpl) then) =
      __$$ProductMonthlyDataModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int year,
      int month,
      @JsonKey(name: 'total_expense') double totalExpense,
      @JsonKey(name: 'total_earned') double totalEarned});
}

/// @nodoc
class __$$ProductMonthlyDataModelImplCopyWithImpl<$Res>
    extends _$ProductMonthlyDataModelCopyWithImpl<$Res,
        _$ProductMonthlyDataModelImpl>
    implements _$$ProductMonthlyDataModelImplCopyWith<$Res> {
  __$$ProductMonthlyDataModelImplCopyWithImpl(
      _$ProductMonthlyDataModelImpl _value,
      $Res Function(_$ProductMonthlyDataModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductMonthlyDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? month = null,
    Object? totalExpense = null,
    Object? totalEarned = null,
  }) {
    return _then(_$ProductMonthlyDataModelImpl(
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as int,
      totalExpense: null == totalExpense
          ? _value.totalExpense
          : totalExpense // ignore: cast_nullable_to_non_nullable
              as double,
      totalEarned: null == totalEarned
          ? _value.totalEarned
          : totalEarned // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductMonthlyDataModelImpl implements _ProductMonthlyDataModel {
  const _$ProductMonthlyDataModelImpl(
      {required this.year,
      required this.month,
      @JsonKey(name: 'total_expense') required this.totalExpense,
      @JsonKey(name: 'total_earned') required this.totalEarned});

  factory _$ProductMonthlyDataModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductMonthlyDataModelImplFromJson(json);

  @override
  final int year;
  @override
  final int month;
  @override
  @JsonKey(name: 'total_expense')
  final double totalExpense;
  @override
  @JsonKey(name: 'total_earned')
  final double totalEarned;

  @override
  String toString() {
    return 'ProductMonthlyDataModel(year: $year, month: $month, totalExpense: $totalExpense, totalEarned: $totalEarned)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductMonthlyDataModelImpl &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.totalExpense, totalExpense) ||
                other.totalExpense == totalExpense) &&
            (identical(other.totalEarned, totalEarned) ||
                other.totalEarned == totalEarned));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, year, month, totalExpense, totalEarned);

  /// Create a copy of ProductMonthlyDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductMonthlyDataModelImplCopyWith<_$ProductMonthlyDataModelImpl>
      get copyWith => __$$ProductMonthlyDataModelImplCopyWithImpl<
          _$ProductMonthlyDataModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductMonthlyDataModelImplToJson(
      this,
    );
  }
}

abstract class _ProductMonthlyDataModel implements ProductMonthlyDataModel {
  const factory _ProductMonthlyDataModel(
          {required final int year,
          required final int month,
          @JsonKey(name: 'total_expense') required final double totalExpense,
          @JsonKey(name: 'total_earned') required final double totalEarned}) =
      _$ProductMonthlyDataModelImpl;

  factory _ProductMonthlyDataModel.fromJson(Map<String, dynamic> json) =
      _$ProductMonthlyDataModelImpl.fromJson;

  @override
  int get year;
  @override
  int get month;
  @override
  @JsonKey(name: 'total_expense')
  double get totalExpense;
  @override
  @JsonKey(name: 'total_earned')
  double get totalEarned;

  /// Create a copy of ProductMonthlyDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductMonthlyDataModelImplCopyWith<_$ProductMonthlyDataModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
