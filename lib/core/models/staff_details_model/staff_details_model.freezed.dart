// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'staff_details_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StaffDetailsModel _$StaffDetailsModelFromJson(Map<String, dynamic> json) {
  return _StaffDetailsModel.fromJson(json);
}

/// @nodoc
mixin _$StaffDetailsModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'phone')
  String get phoneNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at', defaultValue: '')
  String get createdAt => throw _privateConstructorUsedError;

  /// Serializes this StaffDetailsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StaffDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StaffDetailsModelCopyWith<StaffDetailsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StaffDetailsModelCopyWith<$Res> {
  factory $StaffDetailsModelCopyWith(
          StaffDetailsModel value, $Res Function(StaffDetailsModel) then) =
      _$StaffDetailsModelCopyWithImpl<$Res, StaffDetailsModel>;
  @useResult
  $Res call(
      {int id,
      String name,
      @JsonKey(name: 'phone') String phoneNumber,
      @JsonKey(name: 'created_at', defaultValue: '') String createdAt});
}

/// @nodoc
class _$StaffDetailsModelCopyWithImpl<$Res, $Val extends StaffDetailsModel>
    implements $StaffDetailsModelCopyWith<$Res> {
  _$StaffDetailsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StaffDetailsModel
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
abstract class _$$StaffDetailsModelImplCopyWith<$Res>
    implements $StaffDetailsModelCopyWith<$Res> {
  factory _$$StaffDetailsModelImplCopyWith(_$StaffDetailsModelImpl value,
          $Res Function(_$StaffDetailsModelImpl) then) =
      __$$StaffDetailsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      @JsonKey(name: 'phone') String phoneNumber,
      @JsonKey(name: 'created_at', defaultValue: '') String createdAt});
}

/// @nodoc
class __$$StaffDetailsModelImplCopyWithImpl<$Res>
    extends _$StaffDetailsModelCopyWithImpl<$Res, _$StaffDetailsModelImpl>
    implements _$$StaffDetailsModelImplCopyWith<$Res> {
  __$$StaffDetailsModelImplCopyWithImpl(_$StaffDetailsModelImpl _value,
      $Res Function(_$StaffDetailsModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of StaffDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phoneNumber = null,
    Object? createdAt = null,
  }) {
    return _then(_$StaffDetailsModelImpl(
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
@JsonSerializable()
class _$StaffDetailsModelImpl implements _StaffDetailsModel {
  const _$StaffDetailsModelImpl(
      {required this.id,
      required this.name,
      @JsonKey(name: 'phone') required this.phoneNumber,
      @JsonKey(name: 'created_at', defaultValue: '') required this.createdAt});

  factory _$StaffDetailsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$StaffDetailsModelImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  @JsonKey(name: 'phone')
  final String phoneNumber;
  @override
  @JsonKey(name: 'created_at', defaultValue: '')
  final String createdAt;

  @override
  String toString() {
    return 'StaffDetailsModel(id: $id, name: $name, phoneNumber: $phoneNumber, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StaffDetailsModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, phoneNumber, createdAt);

  /// Create a copy of StaffDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StaffDetailsModelImplCopyWith<_$StaffDetailsModelImpl> get copyWith =>
      __$$StaffDetailsModelImplCopyWithImpl<_$StaffDetailsModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StaffDetailsModelImplToJson(
      this,
    );
  }
}

abstract class _StaffDetailsModel implements StaffDetailsModel {
  const factory _StaffDetailsModel(
      {required final int id,
      required final String name,
      @JsonKey(name: 'phone') required final String phoneNumber,
      @JsonKey(name: 'created_at', defaultValue: '')
      required final String createdAt}) = _$StaffDetailsModelImpl;

  factory _StaffDetailsModel.fromJson(Map<String, dynamic> json) =
      _$StaffDetailsModelImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  @JsonKey(name: 'phone')
  String get phoneNumber;
  @override
  @JsonKey(name: 'created_at', defaultValue: '')
  String get createdAt;

  /// Create a copy of StaffDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StaffDetailsModelImplCopyWith<_$StaffDetailsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
