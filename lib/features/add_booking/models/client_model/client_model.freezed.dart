// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'client_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ClientModel _$ClientModelFromJson(Map<String, dynamic> json) {
  return _ClientModel.fromJson(json);
}

/// @nodoc
mixin _$ClientModel {
  @JsonKey(name: 'id', includeToJson: false)
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'name', readValue: _readName)
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'phone_1', readValue: _readPhone1)
  int get phone1 => throw _privateConstructorUsedError;
  @JsonKey(name: 'phone_2', readValue: _readPhone2)
  int? get phone2 => throw _privateConstructorUsedError;

  /// Serializes this ClientModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClientModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClientModelCopyWith<ClientModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientModelCopyWith<$Res> {
  factory $ClientModelCopyWith(
    ClientModel value,
    $Res Function(ClientModel) then,
  ) = _$ClientModelCopyWithImpl<$Res, ClientModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'id', includeToJson: false) int? id,
    @JsonKey(name: 'name', readValue: _readName) String name,
    @JsonKey(name: 'phone_1', readValue: _readPhone1) int phone1,
    @JsonKey(name: 'phone_2', readValue: _readPhone2) int? phone2,
  });
}

/// @nodoc
class _$ClientModelCopyWithImpl<$Res, $Val extends ClientModel>
    implements $ClientModelCopyWith<$Res> {
  _$ClientModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClientModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? phone1 = null,
    Object? phone2 = freezed,
  }) {
    return _then(
      _value.copyWith(
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
      ) as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ClientModelImplCopyWith<$Res>
    implements $ClientModelCopyWith<$Res> {
  factory _$$ClientModelImplCopyWith(
    _$ClientModelImpl value,
    $Res Function(_$ClientModelImpl) then,
  ) = __$$ClientModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'id', includeToJson: false) int? id,
    @JsonKey(name: 'name', readValue: _readName) String name,
    @JsonKey(name: 'phone_1', readValue: _readPhone1) int phone1,
    @JsonKey(name: 'phone_2', readValue: _readPhone2) int? phone2,
  });
}

/// @nodoc
class __$$ClientModelImplCopyWithImpl<$Res>
    extends _$ClientModelCopyWithImpl<$Res, _$ClientModelImpl>
    implements _$$ClientModelImplCopyWith<$Res> {
  __$$ClientModelImplCopyWithImpl(
    _$ClientModelImpl _value,
    $Res Function(_$ClientModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClientModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? phone1 = null,
    Object? phone2 = freezed,
  }) {
    return _then(
      _$ClientModelImpl(
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
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ClientModelImpl implements _ClientModel {
  const _$ClientModelImpl({
    @JsonKey(name: 'id', includeToJson: false) this.id,
    @JsonKey(name: 'name', readValue: _readName) required this.name,
    @JsonKey(name: 'phone_1', readValue: _readPhone1) required this.phone1,
    @JsonKey(name: 'phone_2', readValue: _readPhone2) this.phone2,
  });

  factory _$ClientModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClientModelImplFromJson(json);

  @override
  @JsonKey(name: 'id', includeToJson: false)
  final int? id;
  @override
  @JsonKey(name: 'name', readValue: _readName)
  final String name;
  @override
  @JsonKey(name: 'phone_1', readValue: _readPhone1)
  final int phone1;
  @override
  @JsonKey(name: 'phone_2', readValue: _readPhone2)
  final int? phone2;

  @override
  String toString() {
    return 'ClientModel(id: $id, name: $name, phone1: $phone1, phone2: $phone2)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClientModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone1, phone1) || other.phone1 == phone1) &&
            (identical(other.phone2, phone2) || other.phone2 == phone2));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, phone1, phone2);

  /// Create a copy of ClientModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClientModelImplCopyWith<_$ClientModelImpl> get copyWith =>
      __$$ClientModelImplCopyWithImpl<_$ClientModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClientModelImplToJson(this);
  }
}

abstract class _ClientModel implements ClientModel {
  const factory _ClientModel({
    @JsonKey(name: 'id', includeToJson: false) final int? id,
    @JsonKey(name: 'name', readValue: _readName) required final String name,
    @JsonKey(name: 'phone_1', readValue: _readPhone1) required final int phone1,
    @JsonKey(name: 'phone_2', readValue: _readPhone2) final int? phone2,
  }) = _$ClientModelImpl;

  factory _ClientModel.fromJson(Map<String, dynamic> json) =
      _$ClientModelImpl.fromJson;

  @override
  @JsonKey(name: 'id', includeToJson: false)
  int? get id;
  @override
  @JsonKey(name: 'name', readValue: _readName)
  String get name;
  @override
  @JsonKey(name: 'phone_1', readValue: _readPhone1)
  int get phone1;
  @override
  @JsonKey(name: 'phone_2', readValue: _readPhone2)
  int? get phone2;

  /// Create a copy of ClientModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClientModelImplCopyWith<_$ClientModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
