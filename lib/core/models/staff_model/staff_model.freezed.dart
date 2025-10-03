// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'staff_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

StaffModel _$StaffModelFromJson(Map<String, dynamic> json) {
  return _StaffModel.fromJson(json);
}

/// @nodoc
mixin _$StaffModel {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'phone')
  String get phoneNumber => throw _privateConstructorUsedError;

  /// Serializes this StaffModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StaffModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StaffModelCopyWith<StaffModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StaffModelCopyWith<$Res> {
  factory $StaffModelCopyWith(
    StaffModel value,
    $Res Function(StaffModel) then,
  ) = _$StaffModelCopyWithImpl<$Res, StaffModel>;
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'name') String name,
    @JsonKey(name: 'phone') String phoneNumber,
  });
}

/// @nodoc
class _$StaffModelCopyWithImpl<$Res, $Val extends StaffModel>
    implements $StaffModelCopyWith<$Res> {
  _$StaffModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StaffModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phoneNumber = null,
  }) {
    return _then(
      _value.copyWith(
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StaffModelImplCopyWith<$Res>
    implements $StaffModelCopyWith<$Res> {
  factory _$$StaffModelImplCopyWith(
    _$StaffModelImpl value,
    $Res Function(_$StaffModelImpl) then,
  ) = __$$StaffModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'name') String name,
    @JsonKey(name: 'phone') String phoneNumber,
  });
}

/// @nodoc
class __$$StaffModelImplCopyWithImpl<$Res>
    extends _$StaffModelCopyWithImpl<$Res, _$StaffModelImpl>
    implements _$$StaffModelImplCopyWith<$Res> {
  __$$StaffModelImplCopyWithImpl(
    _$StaffModelImpl _value,
    $Res Function(_$StaffModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StaffModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phoneNumber = null,
  }) {
    return _then(
      _$StaffModelImpl(
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
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StaffModelImpl implements _StaffModel {
  const _$StaffModelImpl({
    required this.id,
    @JsonKey(name: 'name') required this.name,
    @JsonKey(name: 'phone') required this.phoneNumber,
  });

  factory _$StaffModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$StaffModelImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'name')
  final String name;
  @override
  @JsonKey(name: 'phone')
  final String phoneNumber;

  @override
  String toString() {
    return 'StaffModel(id: $id, name: $name, phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StaffModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, phoneNumber);

  /// Create a copy of StaffModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StaffModelImplCopyWith<_$StaffModelImpl> get copyWith =>
      __$$StaffModelImplCopyWithImpl<_$StaffModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StaffModelImplToJson(this);
  }
}

abstract class _StaffModel implements StaffModel {
  const factory _StaffModel({
    required final int id,
    @JsonKey(name: 'name') required final String name,
    @JsonKey(name: 'phone') required final String phoneNumber,
  }) = _$StaffModelImpl;

  factory _StaffModel.fromJson(Map<String, dynamic> json) =
      _$StaffModelImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'name')
  String get name;
  @override
  @JsonKey(name: 'phone')
  String get phoneNumber;

  /// Create a copy of StaffModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StaffModelImplCopyWith<_$StaffModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
