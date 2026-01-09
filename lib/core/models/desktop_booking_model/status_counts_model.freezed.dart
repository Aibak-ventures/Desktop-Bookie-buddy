// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'status_counts_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StatusCountsModel _$StatusCountsModelFromJson(Map<String, dynamic> json) {
  return _StatusCountsModel.fromJson(json);
}

/// @nodoc
mixin _$StatusCountsModel {
  int get completed => throw _privateConstructorUsedError;
  int get upcoming => throw _privateConstructorUsedError;
  int get returns => throw _privateConstructorUsedError;
  int get pending => throw _privateConstructorUsedError;
  @JsonKey(name: 'not_returned')
  int get notReturned => throw _privateConstructorUsedError;

  /// Serializes this StatusCountsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StatusCountsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StatusCountsModelCopyWith<StatusCountsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatusCountsModelCopyWith<$Res> {
  factory $StatusCountsModelCopyWith(
          StatusCountsModel value, $Res Function(StatusCountsModel) then) =
      _$StatusCountsModelCopyWithImpl<$Res, StatusCountsModel>;
  @useResult
  $Res call(
      {int completed,
      int upcoming,
      int returns,
      int pending,
      @JsonKey(name: 'not_returned') int notReturned});
}

/// @nodoc
class _$StatusCountsModelCopyWithImpl<$Res, $Val extends StatusCountsModel>
    implements $StatusCountsModelCopyWith<$Res> {
  _$StatusCountsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StatusCountsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? completed = null,
    Object? upcoming = null,
    Object? returns = null,
    Object? pending = null,
    Object? notReturned = null,
  }) {
    return _then(_value.copyWith(
      completed: null == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as int,
      upcoming: null == upcoming
          ? _value.upcoming
          : upcoming // ignore: cast_nullable_to_non_nullable
              as int,
      returns: null == returns
          ? _value.returns
          : returns // ignore: cast_nullable_to_non_nullable
              as int,
      pending: null == pending
          ? _value.pending
          : pending // ignore: cast_nullable_to_non_nullable
              as int,
      notReturned: null == notReturned
          ? _value.notReturned
          : notReturned // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StatusCountsModelImplCopyWith<$Res>
    implements $StatusCountsModelCopyWith<$Res> {
  factory _$$StatusCountsModelImplCopyWith(_$StatusCountsModelImpl value,
          $Res Function(_$StatusCountsModelImpl) then) =
      __$$StatusCountsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int completed,
      int upcoming,
      int returns,
      int pending,
      @JsonKey(name: 'not_returned') int notReturned});
}

/// @nodoc
class __$$StatusCountsModelImplCopyWithImpl<$Res>
    extends _$StatusCountsModelCopyWithImpl<$Res, _$StatusCountsModelImpl>
    implements _$$StatusCountsModelImplCopyWith<$Res> {
  __$$StatusCountsModelImplCopyWithImpl(_$StatusCountsModelImpl _value,
      $Res Function(_$StatusCountsModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of StatusCountsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? completed = null,
    Object? upcoming = null,
    Object? returns = null,
    Object? pending = null,
    Object? notReturned = null,
  }) {
    return _then(_$StatusCountsModelImpl(
      completed: null == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as int,
      upcoming: null == upcoming
          ? _value.upcoming
          : upcoming // ignore: cast_nullable_to_non_nullable
              as int,
      returns: null == returns
          ? _value.returns
          : returns // ignore: cast_nullable_to_non_nullable
              as int,
      pending: null == pending
          ? _value.pending
          : pending // ignore: cast_nullable_to_non_nullable
              as int,
      notReturned: null == notReturned
          ? _value.notReturned
          : notReturned // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StatusCountsModelImpl implements _StatusCountsModel {
  const _$StatusCountsModelImpl(
      {this.completed = 0,
      this.upcoming = 0,
      this.returns = 0,
      this.pending = 0,
      @JsonKey(name: 'not_returned') this.notReturned = 0});

  factory _$StatusCountsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$StatusCountsModelImplFromJson(json);

  @override
  @JsonKey()
  final int completed;
  @override
  @JsonKey()
  final int upcoming;
  @override
  @JsonKey()
  final int returns;
  @override
  @JsonKey()
  final int pending;
  @override
  @JsonKey(name: 'not_returned')
  final int notReturned;

  @override
  String toString() {
    return 'StatusCountsModel(completed: $completed, upcoming: $upcoming, returns: $returns, pending: $pending, notReturned: $notReturned)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatusCountsModelImpl &&
            (identical(other.completed, completed) ||
                other.completed == completed) &&
            (identical(other.upcoming, upcoming) ||
                other.upcoming == upcoming) &&
            (identical(other.returns, returns) || other.returns == returns) &&
            (identical(other.pending, pending) || other.pending == pending) &&
            (identical(other.notReturned, notReturned) ||
                other.notReturned == notReturned));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, completed, upcoming, returns, pending, notReturned);

  /// Create a copy of StatusCountsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StatusCountsModelImplCopyWith<_$StatusCountsModelImpl> get copyWith =>
      __$$StatusCountsModelImplCopyWithImpl<_$StatusCountsModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StatusCountsModelImplToJson(
      this,
    );
  }
}

abstract class _StatusCountsModel implements StatusCountsModel {
  const factory _StatusCountsModel(
          {final int completed,
          final int upcoming,
          final int returns,
          final int pending,
          @JsonKey(name: 'not_returned') final int notReturned}) =
      _$StatusCountsModelImpl;

  factory _StatusCountsModel.fromJson(Map<String, dynamic> json) =
      _$StatusCountsModelImpl.fromJson;

  @override
  int get completed;
  @override
  int get upcoming;
  @override
  int get returns;
  @override
  int get pending;
  @override
  @JsonKey(name: 'not_returned')
  int get notReturned;

  /// Create a copy of StatusCountsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StatusCountsModelImplCopyWith<_$StatusCountsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
