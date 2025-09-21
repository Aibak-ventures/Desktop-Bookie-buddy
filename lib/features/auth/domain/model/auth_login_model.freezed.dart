// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_login_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AuthLoginModel _$AuthLoginModelFromJson(Map<String, dynamic> json) {
  return _AuthLoginModel.fromJson(json);
}

/// @nodoc
mixin _$AuthLoginModel {
  String get phone => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get deviceToken => throw _privateConstructorUsedError;
  String get platform => throw _privateConstructorUsedError;

  /// Serializes this AuthLoginModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AuthLoginModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthLoginModelCopyWith<AuthLoginModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthLoginModelCopyWith<$Res> {
  factory $AuthLoginModelCopyWith(
          AuthLoginModel value, $Res Function(AuthLoginModel) then) =
      _$AuthLoginModelCopyWithImpl<$Res, AuthLoginModel>;
  @useResult
  $Res call(
      {String phone, String password, String deviceToken, String platform});
}

/// @nodoc
class _$AuthLoginModelCopyWithImpl<$Res, $Val extends AuthLoginModel>
    implements $AuthLoginModelCopyWith<$Res> {
  _$AuthLoginModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthLoginModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phone = null,
    Object? password = null,
    Object? deviceToken = null,
    Object? platform = null,
  }) {
    return _then(_value.copyWith(
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      deviceToken: null == deviceToken
          ? _value.deviceToken
          : deviceToken // ignore: cast_nullable_to_non_nullable
              as String,
      platform: null == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AuthLoginModelImplCopyWith<$Res>
    implements $AuthLoginModelCopyWith<$Res> {
  factory _$$AuthLoginModelImplCopyWith(_$AuthLoginModelImpl value,
          $Res Function(_$AuthLoginModelImpl) then) =
      __$$AuthLoginModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String phone, String password, String deviceToken, String platform});
}

/// @nodoc
class __$$AuthLoginModelImplCopyWithImpl<$Res>
    extends _$AuthLoginModelCopyWithImpl<$Res, _$AuthLoginModelImpl>
    implements _$$AuthLoginModelImplCopyWith<$Res> {
  __$$AuthLoginModelImplCopyWithImpl(
      _$AuthLoginModelImpl _value, $Res Function(_$AuthLoginModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthLoginModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phone = null,
    Object? password = null,
    Object? deviceToken = null,
    Object? platform = null,
  }) {
    return _then(_$AuthLoginModelImpl(
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      deviceToken: null == deviceToken
          ? _value.deviceToken
          : deviceToken // ignore: cast_nullable_to_non_nullable
              as String,
      platform: null == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthLoginModelImpl implements _AuthLoginModel {
  const _$AuthLoginModelImpl(
      {required this.phone,
      required this.password,
      this.deviceToken = 'fcm_device_token_123456',
      this.platform = 'android'});

  factory _$AuthLoginModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthLoginModelImplFromJson(json);

  @override
  final String phone;
  @override
  final String password;
  @override
  @JsonKey()
  final String deviceToken;
  @override
  @JsonKey()
  final String platform;

  @override
  String toString() {
    return 'AuthLoginModel(phone: $phone, password: $password, deviceToken: $deviceToken, platform: $platform)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthLoginModelImpl &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.deviceToken, deviceToken) ||
                other.deviceToken == deviceToken) &&
            (identical(other.platform, platform) ||
                other.platform == platform));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, phone, password, deviceToken, platform);

  /// Create a copy of AuthLoginModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthLoginModelImplCopyWith<_$AuthLoginModelImpl> get copyWith =>
      __$$AuthLoginModelImplCopyWithImpl<_$AuthLoginModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthLoginModelImplToJson(
      this,
    );
  }
}

abstract class _AuthLoginModel implements AuthLoginModel {
  const factory _AuthLoginModel(
      {required final String phone,
      required final String password,
      final String deviceToken,
      final String platform}) = _$AuthLoginModelImpl;

  factory _AuthLoginModel.fromJson(Map<String, dynamic> json) =
      _$AuthLoginModelImpl.fromJson;

  @override
  String get phone;
  @override
  String get password;
  @override
  String get deviceToken;
  @override
  String get platform;

  /// Create a copy of AuthLoginModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthLoginModelImplCopyWith<_$AuthLoginModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
