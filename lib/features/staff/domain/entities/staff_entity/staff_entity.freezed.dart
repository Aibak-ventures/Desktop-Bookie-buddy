// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'staff_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$StaffEntity {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;

  /// Create a copy of StaffEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StaffEntityCopyWith<StaffEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StaffEntityCopyWith<$Res> {
  factory $StaffEntityCopyWith(
          StaffEntity value, $Res Function(StaffEntity) then) =
      _$StaffEntityCopyWithImpl<$Res, StaffEntity>;
  @useResult
  $Res call({int id, String name, String phoneNumber});
}

/// @nodoc
class _$StaffEntityCopyWithImpl<$Res, $Val extends StaffEntity>
    implements $StaffEntityCopyWith<$Res> {
  _$StaffEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StaffEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phoneNumber = null,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StaffEntityImplCopyWith<$Res>
    implements $StaffEntityCopyWith<$Res> {
  factory _$$StaffEntityImplCopyWith(
          _$StaffEntityImpl value, $Res Function(_$StaffEntityImpl) then) =
      __$$StaffEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, String phoneNumber});
}

/// @nodoc
class __$$StaffEntityImplCopyWithImpl<$Res>
    extends _$StaffEntityCopyWithImpl<$Res, _$StaffEntityImpl>
    implements _$$StaffEntityImplCopyWith<$Res> {
  __$$StaffEntityImplCopyWithImpl(
      _$StaffEntityImpl _value, $Res Function(_$StaffEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of StaffEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phoneNumber = null,
  }) {
    return _then(_$StaffEntityImpl(
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
    ));
  }
}

/// @nodoc

class _$StaffEntityImpl implements _StaffEntity {
  const _$StaffEntityImpl(
      {required this.id, required this.name, required this.phoneNumber});

  @override
  final int id;
  @override
  final String name;
  @override
  final String phoneNumber;

  @override
  String toString() {
    return 'StaffEntity(id: $id, name: $name, phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StaffEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, phoneNumber);

  /// Create a copy of StaffEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StaffEntityImplCopyWith<_$StaffEntityImpl> get copyWith =>
      __$$StaffEntityImplCopyWithImpl<_$StaffEntityImpl>(this, _$identity);
}

abstract class _StaffEntity implements StaffEntity {
  const factory _StaffEntity(
      {required final int id,
      required final String name,
      required final String phoneNumber}) = _$StaffEntityImpl;

  @override
  int get id;
  @override
  String get name;
  @override
  String get phoneNumber;

  /// Create a copy of StaffEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StaffEntityImplCopyWith<_$StaffEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
