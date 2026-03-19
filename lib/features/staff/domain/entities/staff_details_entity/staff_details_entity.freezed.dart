// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'staff_details_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$StaffDetailsEntity {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;

  /// Create a copy of StaffDetailsEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StaffDetailsEntityCopyWith<StaffDetailsEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StaffDetailsEntityCopyWith<$Res> {
  factory $StaffDetailsEntityCopyWith(
          StaffDetailsEntity value, $Res Function(StaffDetailsEntity) then) =
      _$StaffDetailsEntityCopyWithImpl<$Res, StaffDetailsEntity>;
  @useResult
  $Res call({int id, String name, String phoneNumber, String createdAt});
}

/// @nodoc
class _$StaffDetailsEntityCopyWithImpl<$Res, $Val extends StaffDetailsEntity>
    implements $StaffDetailsEntityCopyWith<$Res> {
  _$StaffDetailsEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StaffDetailsEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phoneNumber = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StaffDetailsEntityImplCopyWith<$Res>
    implements $StaffDetailsEntityCopyWith<$Res> {
  factory _$$StaffDetailsEntityImplCopyWith(_$StaffDetailsEntityImpl value,
          $Res Function(_$StaffDetailsEntityImpl) then) =
      __$$StaffDetailsEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, String phoneNumber, String createdAt});
}

/// @nodoc
class __$$StaffDetailsEntityImplCopyWithImpl<$Res>
    extends _$StaffDetailsEntityCopyWithImpl<$Res, _$StaffDetailsEntityImpl>
    implements _$$StaffDetailsEntityImplCopyWith<$Res> {
  __$$StaffDetailsEntityImplCopyWithImpl(_$StaffDetailsEntityImpl _value,
      $Res Function(_$StaffDetailsEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of StaffDetailsEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phoneNumber = null,
    Object? createdAt = null,
  }) {
    return _then(_$StaffDetailsEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$StaffDetailsEntityImpl implements _StaffDetailsEntity {
  const _$StaffDetailsEntityImpl(
      {required this.id,
      required this.name,
      required this.phoneNumber,
      required this.createdAt});

  @override
  final int id;
  @override
  final String name;
  @override
  final String phoneNumber;
  @override
  final String createdAt;

  @override
  String toString() {
    return 'StaffDetailsEntity(id: $id, name: $name, phoneNumber: $phoneNumber, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StaffDetailsEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, phoneNumber, createdAt);

  /// Create a copy of StaffDetailsEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StaffDetailsEntityImplCopyWith<_$StaffDetailsEntityImpl> get copyWith =>
      __$$StaffDetailsEntityImplCopyWithImpl<_$StaffDetailsEntityImpl>(
          this, _$identity);
}

abstract class _StaffDetailsEntity implements StaffDetailsEntity {
  const factory _StaffDetailsEntity(
      {required final int id,
      required final String name,
      required final String phoneNumber,
      required final String createdAt}) = _$StaffDetailsEntityImpl;

  @override
  int get id;
  @override
  String get name;
  @override
  String get phoneNumber;
  @override
  String get createdAt;

  /// Create a copy of StaffDetailsEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StaffDetailsEntityImplCopyWith<_$StaffDetailsEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
