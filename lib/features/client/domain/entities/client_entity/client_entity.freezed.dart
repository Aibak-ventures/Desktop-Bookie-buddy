// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'client_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ClientEntity {
  int? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get phone1 => throw _privateConstructorUsedError;
  int? get phone2 => throw _privateConstructorUsedError;

  /// Create a copy of ClientEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClientEntityCopyWith<ClientEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientEntityCopyWith<$Res> {
  factory $ClientEntityCopyWith(
          ClientEntity value, $Res Function(ClientEntity) then) =
      _$ClientEntityCopyWithImpl<$Res, ClientEntity>;
  @useResult
  $Res call({int? id, String name, int phone1, int? phone2});
}

/// @nodoc
class _$ClientEntityCopyWithImpl<$Res, $Val extends ClientEntity>
    implements $ClientEntityCopyWith<$Res> {
  _$ClientEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClientEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? phone1 = null,
    Object? phone2 = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phone1: null == phone1
          ? _value.phone1
          : phone1 // ignore: cast_nullable_to_non_nullable
              as int,
      phone2: freezed == phone2
          ? _value.phone2
          : phone2 // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClientEntityImplCopyWith<$Res>
    implements $ClientEntityCopyWith<$Res> {
  factory _$$ClientEntityImplCopyWith(
          _$ClientEntityImpl value, $Res Function(_$ClientEntityImpl) then) =
      __$$ClientEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String name, int phone1, int? phone2});
}

/// @nodoc
class __$$ClientEntityImplCopyWithImpl<$Res>
    extends _$ClientEntityCopyWithImpl<$Res, _$ClientEntityImpl>
    implements _$$ClientEntityImplCopyWith<$Res> {
  __$$ClientEntityImplCopyWithImpl(
      _$ClientEntityImpl _value, $Res Function(_$ClientEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of ClientEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? phone1 = null,
    Object? phone2 = freezed,
  }) {
    return _then(_$ClientEntityImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phone1: null == phone1
          ? _value.phone1
          : phone1 // ignore: cast_nullable_to_non_nullable
              as int,
      phone2: freezed == phone2
          ? _value.phone2
          : phone2 // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$ClientEntityImpl implements _ClientEntity {
  const _$ClientEntityImpl(
      {this.id, required this.name, required this.phone1, this.phone2});

  @override
  final int? id;
  @override
  final String name;
  @override
  final int phone1;
  @override
  final int? phone2;

  @override
  String toString() {
    return 'ClientEntity(id: $id, name: $name, phone1: $phone1, phone2: $phone2)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClientEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone1, phone1) || other.phone1 == phone1) &&
            (identical(other.phone2, phone2) || other.phone2 == phone2));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, phone1, phone2);

  /// Create a copy of ClientEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClientEntityImplCopyWith<_$ClientEntityImpl> get copyWith =>
      __$$ClientEntityImplCopyWithImpl<_$ClientEntityImpl>(this, _$identity);
}

abstract class _ClientEntity implements ClientEntity {
  const factory _ClientEntity(
      {final int? id,
      required final String name,
      required final int phone1,
      final int? phone2}) = _$ClientEntityImpl;

  @override
  int? get id;
  @override
  String get name;
  @override
  int get phone1;
  @override
  int? get phone2;

  /// Create a copy of ClientEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClientEntityImplCopyWith<_$ClientEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
