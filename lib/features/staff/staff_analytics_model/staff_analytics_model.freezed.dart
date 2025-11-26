// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'staff_analytics_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StaffAnalyticsModel _$StaffAnalyticsModelFromJson(Map<String, dynamic> json) {
  return _StaffAnalyticsModel.fromJson(json);
}

/// @nodoc
mixin _$StaffAnalyticsModel {
  int get staffId => throw _privateConstructorUsedError;
  String get staffName => throw _privateConstructorUsedError;
  int get year => throw _privateConstructorUsedError;
  @JsonKey(fromJson: Month.fromInt, includeToJson: false)
  Month get month => throw _privateConstructorUsedError;
  String get monthName => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_bookings_count', defaultValue: 0)
  int get totalBookingsCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_sales_count', defaultValue: 0)
  int get totalSalesCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_bookings_pending_count', defaultValue: 0)
  int get totalPendingsCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_bookings_earned_amount', defaultValue: 0)
  int get totalBookingsAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_sales_earning', defaultValue: 0)
  int get totalSalesAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_bookings_pending_amount', defaultValue: 0)
  int get totalPendingAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_earning', defaultValue: 0)
  int get totalAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'performance_percent', defaultValue: 0)
  int get performancePercent => throw _privateConstructorUsedError;

  /// Serializes this StaffAnalyticsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StaffAnalyticsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StaffAnalyticsModelCopyWith<StaffAnalyticsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StaffAnalyticsModelCopyWith<$Res> {
  factory $StaffAnalyticsModelCopyWith(
          StaffAnalyticsModel value, $Res Function(StaffAnalyticsModel) then) =
      _$StaffAnalyticsModelCopyWithImpl<$Res, StaffAnalyticsModel>;
  @useResult
  $Res call(
      {int staffId,
      String staffName,
      int year,
      @JsonKey(fromJson: Month.fromInt, includeToJson: false) Month month,
      String monthName,
      @JsonKey(name: 'total_bookings_count', defaultValue: 0)
      int totalBookingsCount,
      @JsonKey(name: 'total_sales_count', defaultValue: 0) int totalSalesCount,
      @JsonKey(name: 'total_bookings_pending_count', defaultValue: 0)
      int totalPendingsCount,
      @JsonKey(name: 'total_bookings_earned_amount', defaultValue: 0)
      int totalBookingsAmount,
      @JsonKey(name: 'total_sales_earning', defaultValue: 0)
      int totalSalesAmount,
      @JsonKey(name: 'total_bookings_pending_amount', defaultValue: 0)
      int totalPendingAmount,
      @JsonKey(name: 'total_earning', defaultValue: 0) int totalAmount,
      @JsonKey(name: 'performance_percent', defaultValue: 0)
      int performancePercent});
}

/// @nodoc
class _$StaffAnalyticsModelCopyWithImpl<$Res, $Val extends StaffAnalyticsModel>
    implements $StaffAnalyticsModelCopyWith<$Res> {
  _$StaffAnalyticsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StaffAnalyticsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? staffId = null,
    Object? staffName = null,
    Object? year = null,
    Object? month = null,
    Object? monthName = null,
    Object? totalBookingsCount = null,
    Object? totalSalesCount = null,
    Object? totalPendingsCount = null,
    Object? totalBookingsAmount = null,
    Object? totalSalesAmount = null,
    Object? totalPendingAmount = null,
    Object? totalAmount = null,
    Object? performancePercent = null,
  }) {
    return _then(_value.copyWith(
      staffId: null == staffId
          ? _value.staffId
          : staffId // ignore: cast_nullable_to_non_nullable
              as int,
      staffName: null == staffName
          ? _value.staffName
          : staffName // ignore: cast_nullable_to_non_nullable
              as String,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as Month,
      monthName: null == monthName
          ? _value.monthName
          : monthName // ignore: cast_nullable_to_non_nullable
              as String,
      totalBookingsCount: null == totalBookingsCount
          ? _value.totalBookingsCount
          : totalBookingsCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalSalesCount: null == totalSalesCount
          ? _value.totalSalesCount
          : totalSalesCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalPendingsCount: null == totalPendingsCount
          ? _value.totalPendingsCount
          : totalPendingsCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalBookingsAmount: null == totalBookingsAmount
          ? _value.totalBookingsAmount
          : totalBookingsAmount // ignore: cast_nullable_to_non_nullable
              as int,
      totalSalesAmount: null == totalSalesAmount
          ? _value.totalSalesAmount
          : totalSalesAmount // ignore: cast_nullable_to_non_nullable
              as int,
      totalPendingAmount: null == totalPendingAmount
          ? _value.totalPendingAmount
          : totalPendingAmount // ignore: cast_nullable_to_non_nullable
              as int,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as int,
      performancePercent: null == performancePercent
          ? _value.performancePercent
          : performancePercent // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StaffAnalyticsModelImplCopyWith<$Res>
    implements $StaffAnalyticsModelCopyWith<$Res> {
  factory _$$StaffAnalyticsModelImplCopyWith(_$StaffAnalyticsModelImpl value,
          $Res Function(_$StaffAnalyticsModelImpl) then) =
      __$$StaffAnalyticsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int staffId,
      String staffName,
      int year,
      @JsonKey(fromJson: Month.fromInt, includeToJson: false) Month month,
      String monthName,
      @JsonKey(name: 'total_bookings_count', defaultValue: 0)
      int totalBookingsCount,
      @JsonKey(name: 'total_sales_count', defaultValue: 0) int totalSalesCount,
      @JsonKey(name: 'total_bookings_pending_count', defaultValue: 0)
      int totalPendingsCount,
      @JsonKey(name: 'total_bookings_earned_amount', defaultValue: 0)
      int totalBookingsAmount,
      @JsonKey(name: 'total_sales_earning', defaultValue: 0)
      int totalSalesAmount,
      @JsonKey(name: 'total_bookings_pending_amount', defaultValue: 0)
      int totalPendingAmount,
      @JsonKey(name: 'total_earning', defaultValue: 0) int totalAmount,
      @JsonKey(name: 'performance_percent', defaultValue: 0)
      int performancePercent});
}

/// @nodoc
class __$$StaffAnalyticsModelImplCopyWithImpl<$Res>
    extends _$StaffAnalyticsModelCopyWithImpl<$Res, _$StaffAnalyticsModelImpl>
    implements _$$StaffAnalyticsModelImplCopyWith<$Res> {
  __$$StaffAnalyticsModelImplCopyWithImpl(_$StaffAnalyticsModelImpl _value,
      $Res Function(_$StaffAnalyticsModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of StaffAnalyticsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? staffId = null,
    Object? staffName = null,
    Object? year = null,
    Object? month = null,
    Object? monthName = null,
    Object? totalBookingsCount = null,
    Object? totalSalesCount = null,
    Object? totalPendingsCount = null,
    Object? totalBookingsAmount = null,
    Object? totalSalesAmount = null,
    Object? totalPendingAmount = null,
    Object? totalAmount = null,
    Object? performancePercent = null,
  }) {
    return _then(_$StaffAnalyticsModelImpl(
      staffId: null == staffId
          ? _value.staffId
          : staffId // ignore: cast_nullable_to_non_nullable
              as int,
      staffName: null == staffName
          ? _value.staffName
          : staffName // ignore: cast_nullable_to_non_nullable
              as String,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as Month,
      monthName: null == monthName
          ? _value.monthName
          : monthName // ignore: cast_nullable_to_non_nullable
              as String,
      totalBookingsCount: null == totalBookingsCount
          ? _value.totalBookingsCount
          : totalBookingsCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalSalesCount: null == totalSalesCount
          ? _value.totalSalesCount
          : totalSalesCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalPendingsCount: null == totalPendingsCount
          ? _value.totalPendingsCount
          : totalPendingsCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalBookingsAmount: null == totalBookingsAmount
          ? _value.totalBookingsAmount
          : totalBookingsAmount // ignore: cast_nullable_to_non_nullable
              as int,
      totalSalesAmount: null == totalSalesAmount
          ? _value.totalSalesAmount
          : totalSalesAmount // ignore: cast_nullable_to_non_nullable
              as int,
      totalPendingAmount: null == totalPendingAmount
          ? _value.totalPendingAmount
          : totalPendingAmount // ignore: cast_nullable_to_non_nullable
              as int,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as int,
      performancePercent: null == performancePercent
          ? _value.performancePercent
          : performancePercent // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$StaffAnalyticsModelImpl implements _StaffAnalyticsModel {
  const _$StaffAnalyticsModelImpl(
      {required this.staffId,
      required this.staffName,
      required this.year,
      @JsonKey(fromJson: Month.fromInt, includeToJson: false)
      required this.month,
      required this.monthName,
      @JsonKey(name: 'total_bookings_count', defaultValue: 0)
      required this.totalBookingsCount,
      @JsonKey(name: 'total_sales_count', defaultValue: 0)
      required this.totalSalesCount,
      @JsonKey(name: 'total_bookings_pending_count', defaultValue: 0)
      required this.totalPendingsCount,
      @JsonKey(name: 'total_bookings_earned_amount', defaultValue: 0)
      required this.totalBookingsAmount,
      @JsonKey(name: 'total_sales_earning', defaultValue: 0)
      required this.totalSalesAmount,
      @JsonKey(name: 'total_bookings_pending_amount', defaultValue: 0)
      required this.totalPendingAmount,
      @JsonKey(name: 'total_earning', defaultValue: 0)
      required this.totalAmount,
      @JsonKey(name: 'performance_percent', defaultValue: 0)
      required this.performancePercent});

  factory _$StaffAnalyticsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$StaffAnalyticsModelImplFromJson(json);

  @override
  final int staffId;
  @override
  final String staffName;
  @override
  final int year;
  @override
  @JsonKey(fromJson: Month.fromInt, includeToJson: false)
  final Month month;
  @override
  final String monthName;
  @override
  @JsonKey(name: 'total_bookings_count', defaultValue: 0)
  final int totalBookingsCount;
  @override
  @JsonKey(name: 'total_sales_count', defaultValue: 0)
  final int totalSalesCount;
  @override
  @JsonKey(name: 'total_bookings_pending_count', defaultValue: 0)
  final int totalPendingsCount;
  @override
  @JsonKey(name: 'total_bookings_earned_amount', defaultValue: 0)
  final int totalBookingsAmount;
  @override
  @JsonKey(name: 'total_sales_earning', defaultValue: 0)
  final int totalSalesAmount;
  @override
  @JsonKey(name: 'total_bookings_pending_amount', defaultValue: 0)
  final int totalPendingAmount;
  @override
  @JsonKey(name: 'total_earning', defaultValue: 0)
  final int totalAmount;
  @override
  @JsonKey(name: 'performance_percent', defaultValue: 0)
  final int performancePercent;

  @override
  String toString() {
    return 'StaffAnalyticsModel(staffId: $staffId, staffName: $staffName, year: $year, month: $month, monthName: $monthName, totalBookingsCount: $totalBookingsCount, totalSalesCount: $totalSalesCount, totalPendingsCount: $totalPendingsCount, totalBookingsAmount: $totalBookingsAmount, totalSalesAmount: $totalSalesAmount, totalPendingAmount: $totalPendingAmount, totalAmount: $totalAmount, performancePercent: $performancePercent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StaffAnalyticsModelImpl &&
            (identical(other.staffId, staffId) || other.staffId == staffId) &&
            (identical(other.staffName, staffName) ||
                other.staffName == staffName) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.monthName, monthName) ||
                other.monthName == monthName) &&
            (identical(other.totalBookingsCount, totalBookingsCount) ||
                other.totalBookingsCount == totalBookingsCount) &&
            (identical(other.totalSalesCount, totalSalesCount) ||
                other.totalSalesCount == totalSalesCount) &&
            (identical(other.totalPendingsCount, totalPendingsCount) ||
                other.totalPendingsCount == totalPendingsCount) &&
            (identical(other.totalBookingsAmount, totalBookingsAmount) ||
                other.totalBookingsAmount == totalBookingsAmount) &&
            (identical(other.totalSalesAmount, totalSalesAmount) ||
                other.totalSalesAmount == totalSalesAmount) &&
            (identical(other.totalPendingAmount, totalPendingAmount) ||
                other.totalPendingAmount == totalPendingAmount) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.performancePercent, performancePercent) ||
                other.performancePercent == performancePercent));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      staffId,
      staffName,
      year,
      month,
      monthName,
      totalBookingsCount,
      totalSalesCount,
      totalPendingsCount,
      totalBookingsAmount,
      totalSalesAmount,
      totalPendingAmount,
      totalAmount,
      performancePercent);

  /// Create a copy of StaffAnalyticsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StaffAnalyticsModelImplCopyWith<_$StaffAnalyticsModelImpl> get copyWith =>
      __$$StaffAnalyticsModelImplCopyWithImpl<_$StaffAnalyticsModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StaffAnalyticsModelImplToJson(
      this,
    );
  }
}

abstract class _StaffAnalyticsModel implements StaffAnalyticsModel {
  const factory _StaffAnalyticsModel(
      {required final int staffId,
      required final String staffName,
      required final int year,
      @JsonKey(fromJson: Month.fromInt, includeToJson: false)
      required final Month month,
      required final String monthName,
      @JsonKey(name: 'total_bookings_count', defaultValue: 0)
      required final int totalBookingsCount,
      @JsonKey(name: 'total_sales_count', defaultValue: 0)
      required final int totalSalesCount,
      @JsonKey(name: 'total_bookings_pending_count', defaultValue: 0)
      required final int totalPendingsCount,
      @JsonKey(name: 'total_bookings_earned_amount', defaultValue: 0)
      required final int totalBookingsAmount,
      @JsonKey(name: 'total_sales_earning', defaultValue: 0)
      required final int totalSalesAmount,
      @JsonKey(name: 'total_bookings_pending_amount', defaultValue: 0)
      required final int totalPendingAmount,
      @JsonKey(name: 'total_earning', defaultValue: 0)
      required final int totalAmount,
      @JsonKey(name: 'performance_percent', defaultValue: 0)
      required final int performancePercent}) = _$StaffAnalyticsModelImpl;

  factory _StaffAnalyticsModel.fromJson(Map<String, dynamic> json) =
      _$StaffAnalyticsModelImpl.fromJson;

  @override
  int get staffId;
  @override
  String get staffName;
  @override
  int get year;
  @override
  @JsonKey(fromJson: Month.fromInt, includeToJson: false)
  Month get month;
  @override
  String get monthName;
  @override
  @JsonKey(name: 'total_bookings_count', defaultValue: 0)
  int get totalBookingsCount;
  @override
  @JsonKey(name: 'total_sales_count', defaultValue: 0)
  int get totalSalesCount;
  @override
  @JsonKey(name: 'total_bookings_pending_count', defaultValue: 0)
  int get totalPendingsCount;
  @override
  @JsonKey(name: 'total_bookings_earned_amount', defaultValue: 0)
  int get totalBookingsAmount;
  @override
  @JsonKey(name: 'total_sales_earning', defaultValue: 0)
  int get totalSalesAmount;
  @override
  @JsonKey(name: 'total_bookings_pending_amount', defaultValue: 0)
  int get totalPendingAmount;
  @override
  @JsonKey(name: 'total_earning', defaultValue: 0)
  int get totalAmount;
  @override
  @JsonKey(name: 'performance_percent', defaultValue: 0)
  int get performancePercent;

  /// Create a copy of StaffAnalyticsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StaffAnalyticsModelImplCopyWith<_$StaffAnalyticsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
