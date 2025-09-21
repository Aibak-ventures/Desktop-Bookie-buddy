// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_login_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AuthLoginResponse _$AuthLoginResponseFromJson(Map<String, dynamic> json) {
  return _AuthLoginResponse.fromJson(json);
}

/// @nodoc
mixin _$AuthLoginResponse {
  String get status => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  AuthLoginData get data => throw _privateConstructorUsedError;
  String get devMessage => throw _privateConstructorUsedError;

  /// Serializes this AuthLoginResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AuthLoginResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthLoginResponseCopyWith<AuthLoginResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthLoginResponseCopyWith<$Res> {
  factory $AuthLoginResponseCopyWith(
          AuthLoginResponse value, $Res Function(AuthLoginResponse) then) =
      _$AuthLoginResponseCopyWithImpl<$Res, AuthLoginResponse>;
  @useResult
  $Res call(
      {String status, String message, AuthLoginData data, String devMessage});

  $AuthLoginDataCopyWith<$Res> get data;
}

/// @nodoc
class _$AuthLoginResponseCopyWithImpl<$Res, $Val extends AuthLoginResponse>
    implements $AuthLoginResponseCopyWith<$Res> {
  _$AuthLoginResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthLoginResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? data = null,
    Object? devMessage = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as AuthLoginData,
      devMessage: null == devMessage
          ? _value.devMessage
          : devMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  /// Create a copy of AuthLoginResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AuthLoginDataCopyWith<$Res> get data {
    return $AuthLoginDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AuthLoginResponseImplCopyWith<$Res>
    implements $AuthLoginResponseCopyWith<$Res> {
  factory _$$AuthLoginResponseImplCopyWith(_$AuthLoginResponseImpl value,
          $Res Function(_$AuthLoginResponseImpl) then) =
      __$$AuthLoginResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String status, String message, AuthLoginData data, String devMessage});

  @override
  $AuthLoginDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$AuthLoginResponseImplCopyWithImpl<$Res>
    extends _$AuthLoginResponseCopyWithImpl<$Res, _$AuthLoginResponseImpl>
    implements _$$AuthLoginResponseImplCopyWith<$Res> {
  __$$AuthLoginResponseImplCopyWithImpl(_$AuthLoginResponseImpl _value,
      $Res Function(_$AuthLoginResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthLoginResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? data = null,
    Object? devMessage = null,
  }) {
    return _then(_$AuthLoginResponseImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as AuthLoginData,
      devMessage: null == devMessage
          ? _value.devMessage
          : devMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthLoginResponseImpl implements _AuthLoginResponse {
  const _$AuthLoginResponseImpl(
      {required this.status,
      required this.message,
      required this.data,
      this.devMessage = ''});

  factory _$AuthLoginResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthLoginResponseImplFromJson(json);

  @override
  final String status;
  @override
  final String message;
  @override
  final AuthLoginData data;
  @override
  @JsonKey()
  final String devMessage;

  @override
  String toString() {
    return 'AuthLoginResponse(status: $status, message: $message, data: $data, devMessage: $devMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthLoginResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.devMessage, devMessage) ||
                other.devMessage == devMessage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, status, message, data, devMessage);

  /// Create a copy of AuthLoginResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthLoginResponseImplCopyWith<_$AuthLoginResponseImpl> get copyWith =>
      __$$AuthLoginResponseImplCopyWithImpl<_$AuthLoginResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthLoginResponseImplToJson(
      this,
    );
  }
}

abstract class _AuthLoginResponse implements AuthLoginResponse {
  const factory _AuthLoginResponse(
      {required final String status,
      required final String message,
      required final AuthLoginData data,
      final String devMessage}) = _$AuthLoginResponseImpl;

  factory _AuthLoginResponse.fromJson(Map<String, dynamic> json) =
      _$AuthLoginResponseImpl.fromJson;

  @override
  String get status;
  @override
  String get message;
  @override
  AuthLoginData get data;
  @override
  String get devMessage;

  /// Create a copy of AuthLoginResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthLoginResponseImplCopyWith<_$AuthLoginResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AuthLoginData _$AuthLoginDataFromJson(Map<String, dynamic> json) {
  return _AuthLoginData.fromJson(json);
}

/// @nodoc
mixin _$AuthLoginData {
  String get refresh => throw _privateConstructorUsedError;
  String get access => throw _privateConstructorUsedError;

  /// Serializes this AuthLoginData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AuthLoginData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthLoginDataCopyWith<AuthLoginData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthLoginDataCopyWith<$Res> {
  factory $AuthLoginDataCopyWith(
          AuthLoginData value, $Res Function(AuthLoginData) then) =
      _$AuthLoginDataCopyWithImpl<$Res, AuthLoginData>;
  @useResult
  $Res call({String refresh, String access});
}

/// @nodoc
class _$AuthLoginDataCopyWithImpl<$Res, $Val extends AuthLoginData>
    implements $AuthLoginDataCopyWith<$Res> {
  _$AuthLoginDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthLoginData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? refresh = null,
    Object? access = null,
  }) {
    return _then(_value.copyWith(
      refresh: null == refresh
          ? _value.refresh
          : refresh // ignore: cast_nullable_to_non_nullable
              as String,
      access: null == access
          ? _value.access
          : access // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AuthLoginDataImplCopyWith<$Res>
    implements $AuthLoginDataCopyWith<$Res> {
  factory _$$AuthLoginDataImplCopyWith(
          _$AuthLoginDataImpl value, $Res Function(_$AuthLoginDataImpl) then) =
      __$$AuthLoginDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String refresh, String access});
}

/// @nodoc
class __$$AuthLoginDataImplCopyWithImpl<$Res>
    extends _$AuthLoginDataCopyWithImpl<$Res, _$AuthLoginDataImpl>
    implements _$$AuthLoginDataImplCopyWith<$Res> {
  __$$AuthLoginDataImplCopyWithImpl(
      _$AuthLoginDataImpl _value, $Res Function(_$AuthLoginDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthLoginData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? refresh = null,
    Object? access = null,
  }) {
    return _then(_$AuthLoginDataImpl(
      refresh: null == refresh
          ? _value.refresh
          : refresh // ignore: cast_nullable_to_non_nullable
              as String,
      access: null == access
          ? _value.access
          : access // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthLoginDataImpl implements _AuthLoginData {
  const _$AuthLoginDataImpl({required this.refresh, required this.access});

  factory _$AuthLoginDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthLoginDataImplFromJson(json);

  @override
  final String refresh;
  @override
  final String access;

  @override
  String toString() {
    return 'AuthLoginData(refresh: $refresh, access: $access)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthLoginDataImpl &&
            (identical(other.refresh, refresh) || other.refresh == refresh) &&
            (identical(other.access, access) || other.access == access));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, refresh, access);

  /// Create a copy of AuthLoginData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthLoginDataImplCopyWith<_$AuthLoginDataImpl> get copyWith =>
      __$$AuthLoginDataImplCopyWithImpl<_$AuthLoginDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthLoginDataImplToJson(
      this,
    );
  }
}

abstract class _AuthLoginData implements AuthLoginData {
  const factory _AuthLoginData(
      {required final String refresh,
      required final String access}) = _$AuthLoginDataImpl;

  factory _AuthLoginData.fromJson(Map<String, dynamic> json) =
      _$AuthLoginDataImpl.fromJson;

  @override
  String get refresh;
  @override
  String get access;

  /// Create a copy of AuthLoginData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthLoginDataImplCopyWith<_$AuthLoginDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
