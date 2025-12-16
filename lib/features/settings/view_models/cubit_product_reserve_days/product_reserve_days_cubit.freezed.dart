// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_reserve_days_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProductReserveDaysState {
  int get selectedDays => throw _privateConstructorUsedError;
  ProductReserveDaysStatus get status => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  DateTime? get lastSavedAt => throw _privateConstructorUsedError;

  /// Create a copy of ProductReserveDaysState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductReserveDaysStateCopyWith<ProductReserveDaysState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductReserveDaysStateCopyWith<$Res> {
  factory $ProductReserveDaysStateCopyWith(ProductReserveDaysState value,
          $Res Function(ProductReserveDaysState) then) =
      _$ProductReserveDaysStateCopyWithImpl<$Res, ProductReserveDaysState>;
  @useResult
  $Res call(
      {int selectedDays,
      ProductReserveDaysStatus status,
      String? error,
      DateTime? lastSavedAt});
}

/// @nodoc
class _$ProductReserveDaysStateCopyWithImpl<$Res,
        $Val extends ProductReserveDaysState>
    implements $ProductReserveDaysStateCopyWith<$Res> {
  _$ProductReserveDaysStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductReserveDaysState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedDays = null,
    Object? status = null,
    Object? error = freezed,
    Object? lastSavedAt = freezed,
  }) {
    return _then(_value.copyWith(
      selectedDays: null == selectedDays
          ? _value.selectedDays
          : selectedDays // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ProductReserveDaysStatus,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      lastSavedAt: freezed == lastSavedAt
          ? _value.lastSavedAt
          : lastSavedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductReserveDaysStateImplCopyWith<$Res>
    implements $ProductReserveDaysStateCopyWith<$Res> {
  factory _$$ProductReserveDaysStateImplCopyWith(
          _$ProductReserveDaysStateImpl value,
          $Res Function(_$ProductReserveDaysStateImpl) then) =
      __$$ProductReserveDaysStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int selectedDays,
      ProductReserveDaysStatus status,
      String? error,
      DateTime? lastSavedAt});
}

/// @nodoc
class __$$ProductReserveDaysStateImplCopyWithImpl<$Res>
    extends _$ProductReserveDaysStateCopyWithImpl<$Res,
        _$ProductReserveDaysStateImpl>
    implements _$$ProductReserveDaysStateImplCopyWith<$Res> {
  __$$ProductReserveDaysStateImplCopyWithImpl(
      _$ProductReserveDaysStateImpl _value,
      $Res Function(_$ProductReserveDaysStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductReserveDaysState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedDays = null,
    Object? status = null,
    Object? error = freezed,
    Object? lastSavedAt = freezed,
  }) {
    return _then(_$ProductReserveDaysStateImpl(
      selectedDays: null == selectedDays
          ? _value.selectedDays
          : selectedDays // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ProductReserveDaysStatus,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      lastSavedAt: freezed == lastSavedAt
          ? _value.lastSavedAt
          : lastSavedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$ProductReserveDaysStateImpl implements _ProductReserveDaysState {
  const _$ProductReserveDaysStateImpl(
      {required this.selectedDays,
      required this.status,
      this.error,
      this.lastSavedAt});

  @override
  final int selectedDays;
  @override
  final ProductReserveDaysStatus status;
  @override
  final String? error;
  @override
  final DateTime? lastSavedAt;

  @override
  String toString() {
    return 'ProductReserveDaysState(selectedDays: $selectedDays, status: $status, error: $error, lastSavedAt: $lastSavedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductReserveDaysStateImpl &&
            (identical(other.selectedDays, selectedDays) ||
                other.selectedDays == selectedDays) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.lastSavedAt, lastSavedAt) ||
                other.lastSavedAt == lastSavedAt));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, selectedDays, status, error, lastSavedAt);

  /// Create a copy of ProductReserveDaysState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductReserveDaysStateImplCopyWith<_$ProductReserveDaysStateImpl>
      get copyWith => __$$ProductReserveDaysStateImplCopyWithImpl<
          _$ProductReserveDaysStateImpl>(this, _$identity);
}

abstract class _ProductReserveDaysState implements ProductReserveDaysState {
  const factory _ProductReserveDaysState(
      {required final int selectedDays,
      required final ProductReserveDaysStatus status,
      final String? error,
      final DateTime? lastSavedAt}) = _$ProductReserveDaysStateImpl;

  @override
  int get selectedDays;
  @override
  ProductReserveDaysStatus get status;
  @override
  String? get error;
  @override
  DateTime? get lastSavedAt;

  /// Create a copy of ProductReserveDaysState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductReserveDaysStateImplCopyWith<_$ProductReserveDaysStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
