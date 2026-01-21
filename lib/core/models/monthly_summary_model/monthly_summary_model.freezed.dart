// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'monthly_summary_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MonthlySummaryModel _$MonthlySummaryModelFromJson(Map<String, dynamic> json) {
  return _MonthlySummaryModel.fromJson(json);
}

/// @nodoc
mixin _$MonthlySummaryModel {
  @JsonKey(name: 'month')
  String get month => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_bookings')
  int get totalBookings => throw _privateConstructorUsedError;
  @JsonKey(name: 'revenue')
  double get revenue => throw _privateConstructorUsedError;

  /// Serializes this MonthlySummaryModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MonthlySummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MonthlySummaryModelCopyWith<MonthlySummaryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MonthlySummaryModelCopyWith<$Res> {
  factory $MonthlySummaryModelCopyWith(
          MonthlySummaryModel value, $Res Function(MonthlySummaryModel) then) =
      _$MonthlySummaryModelCopyWithImpl<$Res, MonthlySummaryModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'month') String month,
      @JsonKey(name: 'total_bookings') int totalBookings,
      @JsonKey(name: 'revenue') double revenue});
}

/// @nodoc
class _$MonthlySummaryModelCopyWithImpl<$Res, $Val extends MonthlySummaryModel>
    implements $MonthlySummaryModelCopyWith<$Res> {
  _$MonthlySummaryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MonthlySummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? month = null,
    Object? totalBookings = null,
    Object? revenue = null,
  }) {
    return _then(_value.copyWith(
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as String,
      totalBookings: null == totalBookings
          ? _value.totalBookings
          : totalBookings // ignore: cast_nullable_to_non_nullable
              as int,
      revenue: null == revenue
          ? _value.revenue
          : revenue // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MonthlySummaryModelImplCopyWith<$Res>
    implements $MonthlySummaryModelCopyWith<$Res> {
  factory _$$MonthlySummaryModelImplCopyWith(_$MonthlySummaryModelImpl value,
          $Res Function(_$MonthlySummaryModelImpl) then) =
      __$$MonthlySummaryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'month') String month,
      @JsonKey(name: 'total_bookings') int totalBookings,
      @JsonKey(name: 'revenue') double revenue});
}

/// @nodoc
class __$$MonthlySummaryModelImplCopyWithImpl<$Res>
    extends _$MonthlySummaryModelCopyWithImpl<$Res, _$MonthlySummaryModelImpl>
    implements _$$MonthlySummaryModelImplCopyWith<$Res> {
  __$$MonthlySummaryModelImplCopyWithImpl(_$MonthlySummaryModelImpl _value,
      $Res Function(_$MonthlySummaryModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of MonthlySummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? month = null,
    Object? totalBookings = null,
    Object? revenue = null,
  }) {
    return _then(_$MonthlySummaryModelImpl(
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as String,
      totalBookings: null == totalBookings
          ? _value.totalBookings
          : totalBookings // ignore: cast_nullable_to_non_nullable
              as int,
      revenue: null == revenue
          ? _value.revenue
          : revenue // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MonthlySummaryModelImpl implements _MonthlySummaryModel {
  const _$MonthlySummaryModelImpl(
      {@JsonKey(name: 'month') required this.month,
      @JsonKey(name: 'total_bookings') this.totalBookings = 0,
      @JsonKey(name: 'revenue') this.revenue = 0.0});

  factory _$MonthlySummaryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MonthlySummaryModelImplFromJson(json);

  @override
  @JsonKey(name: 'month')
  final String month;
  @override
  @JsonKey(name: 'total_bookings')
  final int totalBookings;
  @override
  @JsonKey(name: 'revenue')
  final double revenue;

  @override
  String toString() {
    return 'MonthlySummaryModel(month: $month, totalBookings: $totalBookings, revenue: $revenue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MonthlySummaryModelImpl &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.totalBookings, totalBookings) ||
                other.totalBookings == totalBookings) &&
            (identical(other.revenue, revenue) || other.revenue == revenue));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, month, totalBookings, revenue);

  /// Create a copy of MonthlySummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MonthlySummaryModelImplCopyWith<_$MonthlySummaryModelImpl> get copyWith =>
      __$$MonthlySummaryModelImplCopyWithImpl<_$MonthlySummaryModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MonthlySummaryModelImplToJson(
      this,
    );
  }
}

abstract class _MonthlySummaryModel implements MonthlySummaryModel {
  const factory _MonthlySummaryModel(
          {@JsonKey(name: 'month') required final String month,
          @JsonKey(name: 'total_bookings') final int totalBookings,
          @JsonKey(name: 'revenue') final double revenue}) =
      _$MonthlySummaryModelImpl;

  factory _MonthlySummaryModel.fromJson(Map<String, dynamic> json) =
      _$MonthlySummaryModelImpl.fromJson;

  @override
  @JsonKey(name: 'month')
  String get month;
  @override
  @JsonKey(name: 'total_bookings')
  int get totalBookings;
  @override
  @JsonKey(name: 'revenue')
  double get revenue;

  /// Create a copy of MonthlySummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MonthlySummaryModelImplCopyWith<_$MonthlySummaryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
