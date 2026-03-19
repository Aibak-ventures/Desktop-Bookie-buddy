// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ServiceEntity {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String? get icon => throw _privateConstructorUsedError;
  String get mainServiceName => throw _privateConstructorUsedError;

  /// Create a copy of ServiceEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ServiceEntityCopyWith<ServiceEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceEntityCopyWith<$Res> {
  factory $ServiceEntityCopyWith(
          ServiceEntity value, $Res Function(ServiceEntity) then) =
      _$ServiceEntityCopyWithImpl<$Res, ServiceEntity>;
  @useResult
  $Res call(
      {int id,
      String name,
      String description,
      String? icon,
      String mainServiceName});
}

/// @nodoc
class _$ServiceEntityCopyWithImpl<$Res, $Val extends ServiceEntity>
    implements $ServiceEntityCopyWith<$Res> {
  _$ServiceEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ServiceEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? icon = freezed,
    Object? mainServiceName = null,
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
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      mainServiceName: null == mainServiceName
          ? _value.mainServiceName
          : mainServiceName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ServiceEntityImplCopyWith<$Res>
    implements $ServiceEntityCopyWith<$Res> {
  factory _$$ServiceEntityImplCopyWith(
          _$ServiceEntityImpl value, $Res Function(_$ServiceEntityImpl) then) =
      __$$ServiceEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String description,
      String? icon,
      String mainServiceName});
}

/// @nodoc
class __$$ServiceEntityImplCopyWithImpl<$Res>
    extends _$ServiceEntityCopyWithImpl<$Res, _$ServiceEntityImpl>
    implements _$$ServiceEntityImplCopyWith<$Res> {
  __$$ServiceEntityImplCopyWithImpl(
      _$ServiceEntityImpl _value, $Res Function(_$ServiceEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of ServiceEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? icon = freezed,
    Object? mainServiceName = null,
  }) {
    return _then(_$ServiceEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      mainServiceName: null == mainServiceName
          ? _value.mainServiceName
          : mainServiceName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ServiceEntityImpl implements _ServiceEntity {
  const _$ServiceEntityImpl(
      {required this.id,
      required this.name,
      required this.description,
      this.icon,
      required this.mainServiceName});

  @override
  final int id;
  @override
  final String name;
  @override
  final String description;
  @override
  final String? icon;
  @override
  final String mainServiceName;

  @override
  String toString() {
    return 'ServiceEntity(id: $id, name: $name, description: $description, icon: $icon, mainServiceName: $mainServiceName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.mainServiceName, mainServiceName) ||
                other.mainServiceName == mainServiceName));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, description, icon, mainServiceName);

  /// Create a copy of ServiceEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServiceEntityImplCopyWith<_$ServiceEntityImpl> get copyWith =>
      __$$ServiceEntityImplCopyWithImpl<_$ServiceEntityImpl>(this, _$identity);
}

abstract class _ServiceEntity implements ServiceEntity {
  const factory _ServiceEntity(
      {required final int id,
      required final String name,
      required final String description,
      final String? icon,
      required final String mainServiceName}) = _$ServiceEntityImpl;

  @override
  int get id;
  @override
  String get name;
  @override
  String get description;
  @override
  String? get icon;
  @override
  String get mainServiceName;

  /// Create a copy of ServiceEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServiceEntityImplCopyWith<_$ServiceEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
