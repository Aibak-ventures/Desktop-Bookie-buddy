// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'staff_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

StaffRequestModel _$StaffRequestModelFromJson(Map<String, dynamic> json) {
  return _StaffRequestModel.fromJson(json);
}

/// @nodoc
mixin _$StaffRequestModel {
  @JsonKey(includeToJson: false)
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'name', includeIfNull: false)
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'phone', includeIfNull: false)
  String? get phoneNumber => throw _privateConstructorUsedError;

  /// Serializes this StaffRequestModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StaffRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StaffRequestModelCopyWith<StaffRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StaffRequestModelCopyWith<$Res> {
  factory $StaffRequestModelCopyWith(
    StaffRequestModel value,
    $Res Function(StaffRequestModel) then,
  ) = _$StaffRequestModelCopyWithImpl<$Res, StaffRequestModel>;
  @useResult
  $Res call({
    @JsonKey(includeToJson: false) int? id,
    @JsonKey(name: 'name', includeIfNull: false) String? name,
    @JsonKey(name: 'phone', includeIfNull: false) String? phoneNumber,
  });
}

/// @nodoc
class _$StaffRequestModelCopyWithImpl<$Res, $Val extends StaffRequestModel>
    implements $StaffRequestModelCopyWith<$Res> {
  _$StaffRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StaffRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? phoneNumber = freezed,
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
            phoneNumber: freezed == phoneNumber
                ? _value.phoneNumber
                : phoneNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StaffRequestModelImplCopyWith<$Res>
    implements $StaffRequestModelCopyWith<$Res> {
  factory _$$StaffRequestModelImplCopyWith(
    _$StaffRequestModelImpl value,
    $Res Function(_$StaffRequestModelImpl) then,
  ) = __$$StaffRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(includeToJson: false) int? id,
    @JsonKey(name: 'name', includeIfNull: false) String? name,
    @JsonKey(name: 'phone', includeIfNull: false) String? phoneNumber,
  });
}

/// @nodoc
class __$$StaffRequestModelImplCopyWithImpl<$Res>
    extends _$StaffRequestModelCopyWithImpl<$Res, _$StaffRequestModelImpl>
    implements _$$StaffRequestModelImplCopyWith<$Res> {
  __$$StaffRequestModelImplCopyWithImpl(
    _$StaffRequestModelImpl _value,
    $Res Function(_$StaffRequestModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StaffRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? phoneNumber = freezed,
  }) {
    return _then(
      _$StaffRequestModelImpl(
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
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StaffRequestModelImpl implements _StaffRequestModel {
  const _$StaffRequestModelImpl({
    @JsonKey(includeToJson: false) this.id,
    @JsonKey(name: 'name', includeIfNull: false) this.name,
    @JsonKey(name: 'phone', includeIfNull: false) this.phoneNumber,
  });

  factory _$StaffRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$StaffRequestModelImplFromJson(json);

  @override
  @JsonKey(includeToJson: false)
  final int? id;
  @override
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  @override
  @JsonKey(name: 'phone', includeIfNull: false)
  final String? phoneNumber;

  @override
  String toString() {
    return 'StaffRequestModel(id: $id, name: $name, phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StaffRequestModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, phoneNumber);

  /// Create a copy of StaffRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StaffRequestModelImplCopyWith<_$StaffRequestModelImpl> get copyWith =>
      __$$StaffRequestModelImplCopyWithImpl<_$StaffRequestModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$StaffRequestModelImplToJson(this);
  }
}

abstract class _StaffRequestModel implements StaffRequestModel {
  const factory _StaffRequestModel({
    @JsonKey(includeToJson: false) final int? id,
    @JsonKey(name: 'name', includeIfNull: false) final String? name,
    @JsonKey(name: 'phone', includeIfNull: false) final String? phoneNumber,
  }) = _$StaffRequestModelImpl;

  factory _StaffRequestModel.fromJson(Map<String, dynamic> json) =
      _$StaffRequestModelImpl.fromJson;

  @override
  @JsonKey(includeToJson: false)
  int? get id;
  @override
  @JsonKey(name: 'name', includeIfNull: false)
  String? get name;
  @override
  @JsonKey(name: 'phone', includeIfNull: false)
  String? get phoneNumber;

  /// Create a copy of StaffRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StaffRequestModelImplCopyWith<_$StaffRequestModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
