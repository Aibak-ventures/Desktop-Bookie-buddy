// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'measurement_value_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MeasurementValueModel _$MeasurementValueModelFromJson(
  Map<String, dynamic> json,
) {
  return _MeasurementValueModel.fromJson(json);
}

/// @nodoc
mixin _$MeasurementValueModel {
  String get name => throw _privateConstructorUsedError;
  String get key => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;
  GenderType? get gender => throw _privateConstructorUsedError;

  /// Serializes this MeasurementValueModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MeasurementValueModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MeasurementValueModelCopyWith<MeasurementValueModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MeasurementValueModelCopyWith<$Res> {
  factory $MeasurementValueModelCopyWith(
    MeasurementValueModel value,
    $Res Function(MeasurementValueModel) then,
  ) = _$MeasurementValueModelCopyWithImpl<$Res, MeasurementValueModel>;
  @useResult
  $Res call({String name, String key, String value, GenderType? gender});
}

/// @nodoc
class _$MeasurementValueModelCopyWithImpl<$Res,
        $Val extends MeasurementValueModel>
    implements $MeasurementValueModelCopyWith<$Res> {
  _$MeasurementValueModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MeasurementValueModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? key = null,
    Object? value = null,
    Object? gender = freezed,
  }) {
    return _then(
      _value.copyWith(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                as String,
        key: null == key
            ? _value.key
            : key // ignore: cast_nullable_to_non_nullable
                as String,
        value: null == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                as String,
        gender: freezed == gender
            ? _value.gender
            : gender // ignore: cast_nullable_to_non_nullable
                as GenderType?,
      ) as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MeasurementValueModelImplCopyWith<$Res>
    implements $MeasurementValueModelCopyWith<$Res> {
  factory _$$MeasurementValueModelImplCopyWith(
    _$MeasurementValueModelImpl value,
    $Res Function(_$MeasurementValueModelImpl) then,
  ) = __$$MeasurementValueModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String key, String value, GenderType? gender});
}

/// @nodoc
class __$$MeasurementValueModelImplCopyWithImpl<$Res>
    extends _$MeasurementValueModelCopyWithImpl<$Res,
        _$MeasurementValueModelImpl>
    implements _$$MeasurementValueModelImplCopyWith<$Res> {
  __$$MeasurementValueModelImplCopyWithImpl(
    _$MeasurementValueModelImpl _value,
    $Res Function(_$MeasurementValueModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MeasurementValueModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? key = null,
    Object? value = null,
    Object? gender = freezed,
  }) {
    return _then(
      _$MeasurementValueModelImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                as String,
        key: null == key
            ? _value.key
            : key // ignore: cast_nullable_to_non_nullable
                as String,
        value: null == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                as String,
        gender: freezed == gender
            ? _value.gender
            : gender // ignore: cast_nullable_to_non_nullable
                as GenderType?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MeasurementValueModelImpl implements _MeasurementValueModel {
  const _$MeasurementValueModelImpl({
    required this.name,
    required this.key,
    required this.value,
    this.gender,
  });

  factory _$MeasurementValueModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MeasurementValueModelImplFromJson(json);

  @override
  final String name;
  @override
  final String key;
  @override
  final String value;
  @override
  final GenderType? gender;

  @override
  String toString() {
    return 'MeasurementValueModel(name: $name, key: $key, value: $value, gender: $gender)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MeasurementValueModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.gender, gender) || other.gender == gender));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, key, value, gender);

  /// Create a copy of MeasurementValueModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MeasurementValueModelImplCopyWith<_$MeasurementValueModelImpl>
      get copyWith => __$$MeasurementValueModelImplCopyWithImpl<
              _$MeasurementValueModelImpl>(
            this,
            _$identity,
          );

  @override
  Map<String, dynamic> toJson() {
    return _$$MeasurementValueModelImplToJson(this);
  }
}

abstract class _MeasurementValueModel implements MeasurementValueModel {
  const factory _MeasurementValueModel({
    required final String name,
    required final String key,
    required final String value,
    final GenderType? gender,
  }) = _$MeasurementValueModelImpl;

  factory _MeasurementValueModel.fromJson(Map<String, dynamic> json) =
      _$MeasurementValueModelImpl.fromJson;

  @override
  String get name;
  @override
  String get key;
  @override
  String get value;
  @override
  GenderType? get gender;

  /// Create a copy of MeasurementValueModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MeasurementValueModelImplCopyWith<_$MeasurementValueModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
