// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'staff_request_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$StaffRequestEntity {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;

  /// Create a copy of StaffRequestEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StaffRequestEntityCopyWith<StaffRequestEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StaffRequestEntityCopyWith<$Res> {
  factory $StaffRequestEntityCopyWith(
          StaffRequestEntity value, $Res Function(StaffRequestEntity) then) =
      _$StaffRequestEntityCopyWithImpl<$Res, StaffRequestEntity>;
  @useResult
  $Res call({int? id, String? name, String? phoneNumber});
}

/// @nodoc
class _$StaffRequestEntityCopyWithImpl<$Res, $Val extends StaffRequestEntity>
    implements $StaffRequestEntityCopyWith<$Res> {
  _$StaffRequestEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StaffRequestEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? phoneNumber = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StaffRequestEntityImplCopyWith<$Res>
    implements $StaffRequestEntityCopyWith<$Res> {
  factory _$$StaffRequestEntityImplCopyWith(_$StaffRequestEntityImpl value,
          $Res Function(_$StaffRequestEntityImpl) then) =
      __$$StaffRequestEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? name, String? phoneNumber});
}

/// @nodoc
class __$$StaffRequestEntityImplCopyWithImpl<$Res>
    extends _$StaffRequestEntityCopyWithImpl<$Res, _$StaffRequestEntityImpl>
    implements _$$StaffRequestEntityImplCopyWith<$Res> {
  __$$StaffRequestEntityImplCopyWithImpl(_$StaffRequestEntityImpl _value,
      $Res Function(_$StaffRequestEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of StaffRequestEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? phoneNumber = freezed,
  }) {
    return _then(_$StaffRequestEntityImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$StaffRequestEntityImpl implements _StaffRequestEntity {
  const _$StaffRequestEntityImpl({this.id, this.name, this.phoneNumber});

  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? phoneNumber;

  @override
  String toString() {
    return 'StaffRequestEntity(id: $id, name: $name, phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StaffRequestEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, phoneNumber);

  /// Create a copy of StaffRequestEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StaffRequestEntityImplCopyWith<_$StaffRequestEntityImpl> get copyWith =>
      __$$StaffRequestEntityImplCopyWithImpl<_$StaffRequestEntityImpl>(
          this, _$identity);
}

abstract class _StaffRequestEntity implements StaffRequestEntity {
  const factory _StaffRequestEntity(
      {final int? id,
      final String? name,
      final String? phoneNumber}) = _$StaffRequestEntityImpl;

  @override
  int? get id;
  @override
  String? get name;
  @override
  String? get phoneNumber;

  /// Create a copy of StaffRequestEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StaffRequestEntityImplCopyWith<_$StaffRequestEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
