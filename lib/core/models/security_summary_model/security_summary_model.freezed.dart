// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'security_summary_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SecuritySummaryModel _$SecuritySummaryModelFromJson(Map<String, dynamic> json) {
  return _SecuritySummaryModel.fromJson(json);
}

/// @nodoc
mixin _$SecuritySummaryModel {
  double get securityAmount => throw _privateConstructorUsedError;
  double get totalRefunded => throw _privateConstructorUsedError;
  double get totalDeducted => throw _privateConstructorUsedError;
  double get remainingBalance => throw _privateConstructorUsedError;

  /// Serializes this SecuritySummaryModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SecuritySummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SecuritySummaryModelCopyWith<SecuritySummaryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SecuritySummaryModelCopyWith<$Res> {
  factory $SecuritySummaryModelCopyWith(SecuritySummaryModel value,
          $Res Function(SecuritySummaryModel) then) =
      _$SecuritySummaryModelCopyWithImpl<$Res, SecuritySummaryModel>;
  @useResult
  $Res call(
      {double securityAmount,
      double totalRefunded,
      double totalDeducted,
      double remainingBalance});
}

/// @nodoc
class _$SecuritySummaryModelCopyWithImpl<$Res,
        $Val extends SecuritySummaryModel>
    implements $SecuritySummaryModelCopyWith<$Res> {
  _$SecuritySummaryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SecuritySummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? securityAmount = null,
    Object? totalRefunded = null,
    Object? totalDeducted = null,
    Object? remainingBalance = null,
  }) {
    return _then(_value.copyWith(
      securityAmount: null == securityAmount
          ? _value.securityAmount
          : securityAmount // ignore: cast_nullable_to_non_nullable
              as double,
      totalRefunded: null == totalRefunded
          ? _value.totalRefunded
          : totalRefunded // ignore: cast_nullable_to_non_nullable
              as double,
      totalDeducted: null == totalDeducted
          ? _value.totalDeducted
          : totalDeducted // ignore: cast_nullable_to_non_nullable
              as double,
      remainingBalance: null == remainingBalance
          ? _value.remainingBalance
          : remainingBalance // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SecuritySummaryModelImplCopyWith<$Res>
    implements $SecuritySummaryModelCopyWith<$Res> {
  factory _$$SecuritySummaryModelImplCopyWith(_$SecuritySummaryModelImpl value,
          $Res Function(_$SecuritySummaryModelImpl) then) =
      __$$SecuritySummaryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double securityAmount,
      double totalRefunded,
      double totalDeducted,
      double remainingBalance});
}

/// @nodoc
class __$$SecuritySummaryModelImplCopyWithImpl<$Res>
    extends _$SecuritySummaryModelCopyWithImpl<$Res, _$SecuritySummaryModelImpl>
    implements _$$SecuritySummaryModelImplCopyWith<$Res> {
  __$$SecuritySummaryModelImplCopyWithImpl(_$SecuritySummaryModelImpl _value,
      $Res Function(_$SecuritySummaryModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of SecuritySummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? securityAmount = null,
    Object? totalRefunded = null,
    Object? totalDeducted = null,
    Object? remainingBalance = null,
  }) {
    return _then(_$SecuritySummaryModelImpl(
      securityAmount: null == securityAmount
          ? _value.securityAmount
          : securityAmount // ignore: cast_nullable_to_non_nullable
              as double,
      totalRefunded: null == totalRefunded
          ? _value.totalRefunded
          : totalRefunded // ignore: cast_nullable_to_non_nullable
              as double,
      totalDeducted: null == totalDeducted
          ? _value.totalDeducted
          : totalDeducted // ignore: cast_nullable_to_non_nullable
              as double,
      remainingBalance: null == remainingBalance
          ? _value.remainingBalance
          : remainingBalance // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$SecuritySummaryModelImpl implements _SecuritySummaryModel {
  const _$SecuritySummaryModelImpl(
      {this.securityAmount = 0.0,
      this.totalRefunded = 0.0,
      this.totalDeducted = 0.0,
      this.remainingBalance = 0.0});

  factory _$SecuritySummaryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SecuritySummaryModelImplFromJson(json);

  @override
  @JsonKey()
  final double securityAmount;
  @override
  @JsonKey()
  final double totalRefunded;
  @override
  @JsonKey()
  final double totalDeducted;
  @override
  @JsonKey()
  final double remainingBalance;

  @override
  String toString() {
    return 'SecuritySummaryModel(securityAmount: $securityAmount, totalRefunded: $totalRefunded, totalDeducted: $totalDeducted, remainingBalance: $remainingBalance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SecuritySummaryModelImpl &&
            (identical(other.securityAmount, securityAmount) ||
                other.securityAmount == securityAmount) &&
            (identical(other.totalRefunded, totalRefunded) ||
                other.totalRefunded == totalRefunded) &&
            (identical(other.totalDeducted, totalDeducted) ||
                other.totalDeducted == totalDeducted) &&
            (identical(other.remainingBalance, remainingBalance) ||
                other.remainingBalance == remainingBalance));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, securityAmount, totalRefunded,
      totalDeducted, remainingBalance);

  /// Create a copy of SecuritySummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SecuritySummaryModelImplCopyWith<_$SecuritySummaryModelImpl>
      get copyWith =>
          __$$SecuritySummaryModelImplCopyWithImpl<_$SecuritySummaryModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SecuritySummaryModelImplToJson(
      this,
    );
  }
}

abstract class _SecuritySummaryModel implements SecuritySummaryModel {
  const factory _SecuritySummaryModel(
      {final double securityAmount,
      final double totalRefunded,
      final double totalDeducted,
      final double remainingBalance}) = _$SecuritySummaryModelImpl;

  factory _SecuritySummaryModel.fromJson(Map<String, dynamic> json) =
      _$SecuritySummaryModelImpl.fromJson;

  @override
  double get securityAmount;
  @override
  double get totalRefunded;
  @override
  double get totalDeducted;
  @override
  double get remainingBalance;

  /// Create a copy of SecuritySummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SecuritySummaryModelImplCopyWith<_$SecuritySummaryModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
