// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'client_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ClientRequestModel _$ClientRequestModelFromJson(Map<String, dynamic> json) {
  return _ClientRequestModel.fromJson(json);
}

/// @nodoc
mixin _$ClientRequestModel {
  @JsonKey(name: 'id', includeToJson: false, includeIfNull: false)
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'name', includeIfNull: false)
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'phone_1', includeIfNull: false)
  int? get phone1 => throw _privateConstructorUsedError;
  @JsonKey(name: 'phone_2', includeIfNull: false)
  int? get phone2 => throw _privateConstructorUsedError;

  /// Serializes this ClientRequestModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClientRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClientRequestModelCopyWith<ClientRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientRequestModelCopyWith<$Res> {
  factory $ClientRequestModelCopyWith(
    ClientRequestModel value,
    $Res Function(ClientRequestModel) then,
  ) = _$ClientRequestModelCopyWithImpl<$Res, ClientRequestModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'id', includeToJson: false, includeIfNull: false) int? id,
    @JsonKey(name: 'name', includeIfNull: false) String? name,
    @JsonKey(name: 'phone_1', includeIfNull: false) int? phone1,
    @JsonKey(name: 'phone_2', includeIfNull: false) int? phone2,
  });
}

/// @nodoc
class _$ClientRequestModelCopyWithImpl<$Res, $Val extends ClientRequestModel>
    implements $ClientRequestModelCopyWith<$Res> {
  _$ClientRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClientRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? phone1 = freezed,
    Object? phone2 = freezed,
  }) {
    return _then(
      _value.copyWith(
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ClientRequestModelImplCopyWith<$Res>
    implements $ClientRequestModelCopyWith<$Res> {
  factory _$$ClientRequestModelImplCopyWith(
    _$ClientRequestModelImpl value,
    $Res Function(_$ClientRequestModelImpl) then,
  ) = __$$ClientRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'id', includeToJson: false, includeIfNull: false) int? id,
    @JsonKey(name: 'name', includeIfNull: false) String? name,
    @JsonKey(name: 'phone_1', includeIfNull: false) int? phone1,
    @JsonKey(name: 'phone_2', includeIfNull: false) int? phone2,
  });
}

/// @nodoc
class __$$ClientRequestModelImplCopyWithImpl<$Res>
    extends _$ClientRequestModelCopyWithImpl<$Res, _$ClientRequestModelImpl>
    implements _$$ClientRequestModelImplCopyWith<$Res> {
  __$$ClientRequestModelImplCopyWithImpl(
    _$ClientRequestModelImpl _value,
    $Res Function(_$ClientRequestModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClientRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? phone1 = freezed,
    Object? phone2 = freezed,
  }) {
    return _then(
      _$ClientRequestModelImpl(
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
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ClientRequestModelImpl implements _ClientRequestModel {
  const _$ClientRequestModelImpl({
    @JsonKey(name: 'id', includeToJson: false, includeIfNull: false)
    required this.id,
    @JsonKey(name: 'name', includeIfNull: false) this.name,
    @JsonKey(name: 'phone_1', includeIfNull: false) this.phone1,
    @JsonKey(name: 'phone_2', includeIfNull: false) this.phone2,
  });

  factory _$ClientRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClientRequestModelImplFromJson(json);

  @override
  @JsonKey(name: 'id', includeToJson: false, includeIfNull: false)
  final int? id;
  @override
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  @override
  @JsonKey(name: 'phone_1', includeIfNull: false)
  final int? phone1;
  @override
  @JsonKey(name: 'phone_2', includeIfNull: false)
  final int? phone2;

  @override
  String toString() {
    return 'ClientRequestModel(id: $id, name: $name, phone1: $phone1, phone2: $phone2)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClientRequestModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone1, phone1) || other.phone1 == phone1) &&
            (identical(other.phone2, phone2) || other.phone2 == phone2));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, phone1, phone2);

  /// Create a copy of ClientRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClientRequestModelImplCopyWith<_$ClientRequestModelImpl> get copyWith =>
      __$$ClientRequestModelImplCopyWithImpl<_$ClientRequestModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ClientRequestModelImplToJson(this);
  }
}

abstract class _ClientRequestModel implements ClientRequestModel {
  const factory _ClientRequestModel({
    @JsonKey(name: 'id', includeToJson: false, includeIfNull: false)
    required final int? id,
    @JsonKey(name: 'name', includeIfNull: false) final String? name,
    @JsonKey(name: 'phone_1', includeIfNull: false) final int? phone1,
    @JsonKey(name: 'phone_2', includeIfNull: false) final int? phone2,
  }) = _$ClientRequestModelImpl;

  factory _ClientRequestModel.fromJson(Map<String, dynamic> json) =
      _$ClientRequestModelImpl.fromJson;

  @override
  @JsonKey(name: 'id', includeToJson: false, includeIfNull: false)
  int? get id;
  @override
  @JsonKey(name: 'name', includeIfNull: false)
  String? get name;
  @override
  @JsonKey(name: 'phone_1', includeIfNull: false)
  int? get phone1;
  @override
  @JsonKey(name: 'phone_2', includeIfNull: false)
  int? get phone2;

  /// Create a copy of ClientRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClientRequestModelImplCopyWith<_$ClientRequestModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
