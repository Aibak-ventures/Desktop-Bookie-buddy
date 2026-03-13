// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_button_default_action_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AddButtonDefaultActionState {
  AddButtonDefaultAction get action => throw _privateConstructorUsedError;
  AddButtonDefaultActionStatus get status => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  DateTime? get lastSavedAt => throw _privateConstructorUsedError;

  /// Create a copy of AddButtonDefaultActionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddButtonDefaultActionStateCopyWith<AddButtonDefaultActionState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddButtonDefaultActionStateCopyWith<$Res> {
  factory $AddButtonDefaultActionStateCopyWith(
          AddButtonDefaultActionState value,
          $Res Function(AddButtonDefaultActionState) then) =
      _$AddButtonDefaultActionStateCopyWithImpl<$Res,
          AddButtonDefaultActionState>;
  @useResult
  $Res call(
      {AddButtonDefaultAction action,
      AddButtonDefaultActionStatus status,
      String? error,
      DateTime? lastSavedAt});
}

/// @nodoc
class _$AddButtonDefaultActionStateCopyWithImpl<$Res,
        $Val extends AddButtonDefaultActionState>
    implements $AddButtonDefaultActionStateCopyWith<$Res> {
  _$AddButtonDefaultActionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddButtonDefaultActionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? action = null,
    Object? status = null,
    Object? error = freezed,
    Object? lastSavedAt = freezed,
  }) {
    return _then(_value.copyWith(
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as AddButtonDefaultAction,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AddButtonDefaultActionStatus,
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
abstract class _$$AddButtonDefaultActionStateImplCopyWith<$Res>
    implements $AddButtonDefaultActionStateCopyWith<$Res> {
  factory _$$AddButtonDefaultActionStateImplCopyWith(
          _$AddButtonDefaultActionStateImpl value,
          $Res Function(_$AddButtonDefaultActionStateImpl) then) =
      __$$AddButtonDefaultActionStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AddButtonDefaultAction action,
      AddButtonDefaultActionStatus status,
      String? error,
      DateTime? lastSavedAt});
}

/// @nodoc
class __$$AddButtonDefaultActionStateImplCopyWithImpl<$Res>
    extends _$AddButtonDefaultActionStateCopyWithImpl<$Res,
        _$AddButtonDefaultActionStateImpl>
    implements _$$AddButtonDefaultActionStateImplCopyWith<$Res> {
  __$$AddButtonDefaultActionStateImplCopyWithImpl(
      _$AddButtonDefaultActionStateImpl _value,
      $Res Function(_$AddButtonDefaultActionStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddButtonDefaultActionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? action = null,
    Object? status = null,
    Object? error = freezed,
    Object? lastSavedAt = freezed,
  }) {
    return _then(_$AddButtonDefaultActionStateImpl(
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as AddButtonDefaultAction,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AddButtonDefaultActionStatus,
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

class _$AddButtonDefaultActionStateImpl
    implements _AddButtonDefaultActionState {
  const _$AddButtonDefaultActionStateImpl(
      {required this.action,
      required this.status,
      this.error,
      this.lastSavedAt});

  @override
  final AddButtonDefaultAction action;
  @override
  final AddButtonDefaultActionStatus status;
  @override
  final String? error;
  @override
  final DateTime? lastSavedAt;

  @override
  String toString() {
    return 'AddButtonDefaultActionState(action: $action, status: $status, error: $error, lastSavedAt: $lastSavedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddButtonDefaultActionStateImpl &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.lastSavedAt, lastSavedAt) ||
                other.lastSavedAt == lastSavedAt));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, action, status, error, lastSavedAt);

  /// Create a copy of AddButtonDefaultActionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddButtonDefaultActionStateImplCopyWith<_$AddButtonDefaultActionStateImpl>
      get copyWith => __$$AddButtonDefaultActionStateImplCopyWithImpl<
          _$AddButtonDefaultActionStateImpl>(this, _$identity);
}

abstract class _AddButtonDefaultActionState
    implements AddButtonDefaultActionState {
  const factory _AddButtonDefaultActionState(
      {required final AddButtonDefaultAction action,
      required final AddButtonDefaultActionStatus status,
      final String? error,
      final DateTime? lastSavedAt}) = _$AddButtonDefaultActionStateImpl;

  @override
  AddButtonDefaultAction get action;
  @override
  AddButtonDefaultActionStatus get status;
  @override
  String? get error;
  @override
  DateTime? get lastSavedAt;

  /// Create a copy of AddButtonDefaultActionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddButtonDefaultActionStateImplCopyWith<_$AddButtonDefaultActionStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
