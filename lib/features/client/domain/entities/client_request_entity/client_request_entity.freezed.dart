// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'client_request_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ClientRequestEntity {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  int? get phone1 => throw _privateConstructorUsedError;
  int? get phone2 => throw _privateConstructorUsedError;

  /// Create a copy of ClientRequestEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClientRequestEntityCopyWith<ClientRequestEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientRequestEntityCopyWith<$Res> {
  factory $ClientRequestEntityCopyWith(
          ClientRequestEntity value, $Res Function(ClientRequestEntity) then) =
      _$ClientRequestEntityCopyWithImpl<$Res, ClientRequestEntity>;
  @useResult
  $Res call({int? id, String? name, int? phone1, int? phone2});
}

/// @nodoc
class _$ClientRequestEntityCopyWithImpl<$Res, $Val extends ClientRequestEntity>
    implements $ClientRequestEntityCopyWith<$Res> {
  _$ClientRequestEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClientRequestEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? phone1 = freezed,
    Object? phone2 = freezed,
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
      phone1: freezed == phone1
          ? _value.phone1
          : phone1 // ignore: cast_nullable_to_non_nullable
              as int?,
      phone2: freezed == phone2
          ? _value.phone2
          : phone2 // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClientRequestEntityImplCopyWith<$Res>
    implements $ClientRequestEntityCopyWith<$Res> {
  factory _$$ClientRequestEntityImplCopyWith(_$ClientRequestEntityImpl value,
          $Res Function(_$ClientRequestEntityImpl) then) =
      __$$ClientRequestEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? name, int? phone1, int? phone2});
}

/// @nodoc
class __$$ClientRequestEntityImplCopyWithImpl<$Res>
    extends _$ClientRequestEntityCopyWithImpl<$Res, _$ClientRequestEntityImpl>
    implements _$$ClientRequestEntityImplCopyWith<$Res> {
  __$$ClientRequestEntityImplCopyWithImpl(_$ClientRequestEntityImpl _value,
      $Res Function(_$ClientRequestEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of ClientRequestEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? phone1 = freezed,
    Object? phone2 = freezed,
  }) {
    return _then(_$ClientRequestEntityImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      phone1: freezed == phone1
          ? _value.phone1
          : phone1 // ignore: cast_nullable_to_non_nullable
              as int?,
      phone2: freezed == phone2
          ? _value.phone2
          : phone2 // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$ClientRequestEntityImpl implements _ClientRequestEntity {
  const _$ClientRequestEntityImpl(
      {required this.id, this.name, this.phone1, this.phone2});

  @override
  final int? id;
  @override
  final String? name;
  @override
  final int? phone1;
  @override
  final int? phone2;

  @override
  String toString() {
    return 'ClientRequestEntity(id: $id, name: $name, phone1: $phone1, phone2: $phone2)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClientRequestEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone1, phone1) || other.phone1 == phone1) &&
            (identical(other.phone2, phone2) || other.phone2 == phone2));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, phone1, phone2);

  /// Create a copy of ClientRequestEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClientRequestEntityImplCopyWith<_$ClientRequestEntityImpl> get copyWith =>
      __$$ClientRequestEntityImplCopyWithImpl<_$ClientRequestEntityImpl>(
          this, _$identity);
}

abstract class _ClientRequestEntity implements ClientRequestEntity {
  const factory _ClientRequestEntity(
      {required final int? id,
      final String? name,
      final int? phone1,
      final int? phone2}) = _$ClientRequestEntityImpl;

  @override
  int? get id;
  @override
  String? get name;
  @override
  int? get phone1;
  @override
  int? get phone2;

  /// Create a copy of ClientRequestEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClientRequestEntityImplCopyWith<_$ClientRequestEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
