// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'custom_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CustomResponseModel _$CustomResponseModelFromJson(Map<String, dynamic> json) {
  return _CustomResponseModel.fromJson(json);
}

/// @nodoc
mixin _$CustomResponseModel {
  @JsonKey(
      name: 'status',
      fromJson: CustomResponseStatus.fromString,
      toJson: CustomResponseStatus.toJson)
  CustomResponseStatus get status => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: '')
  String? get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'dev_message', defaultValue: '')
  dynamic get devMessage => throw _privateConstructorUsedError;
  @JsonKey(name: 'meta', includeIfNull: false)
  dynamic get meta => throw _privateConstructorUsedError;
  dynamic get data => throw _privateConstructorUsedError;

  /// Serializes this CustomResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CustomResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CustomResponseModelCopyWith<CustomResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomResponseModelCopyWith<$Res> {
  factory $CustomResponseModelCopyWith(
          CustomResponseModel value, $Res Function(CustomResponseModel) then) =
      _$CustomResponseModelCopyWithImpl<$Res, CustomResponseModel>;
  @useResult
  $Res call(
      {@JsonKey(
          name: 'status',
          fromJson: CustomResponseStatus.fromString,
          toJson: CustomResponseStatus.toJson)
      CustomResponseStatus status,
      @JsonKey(defaultValue: '') String? message,
      @JsonKey(name: 'dev_message', defaultValue: '') dynamic devMessage,
      @JsonKey(name: 'meta', includeIfNull: false) dynamic meta,
      dynamic data});
}

/// @nodoc
class _$CustomResponseModelCopyWithImpl<$Res, $Val extends CustomResponseModel>
    implements $CustomResponseModelCopyWith<$Res> {
  _$CustomResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CustomResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = freezed,
    Object? devMessage = freezed,
    Object? meta = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CustomResponseStatus,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      devMessage: freezed == devMessage
          ? _value.devMessage
          : devMessage // ignore: cast_nullable_to_non_nullable
              as dynamic,
      meta: freezed == meta
          ? _value.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as dynamic,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CustomResponseModelImplCopyWith<$Res>
    implements $CustomResponseModelCopyWith<$Res> {
  factory _$$CustomResponseModelImplCopyWith(_$CustomResponseModelImpl value,
          $Res Function(_$CustomResponseModelImpl) then) =
      __$$CustomResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(
          name: 'status',
          fromJson: CustomResponseStatus.fromString,
          toJson: CustomResponseStatus.toJson)
      CustomResponseStatus status,
      @JsonKey(defaultValue: '') String? message,
      @JsonKey(name: 'dev_message', defaultValue: '') dynamic devMessage,
      @JsonKey(name: 'meta', includeIfNull: false) dynamic meta,
      dynamic data});
}

/// @nodoc
class __$$CustomResponseModelImplCopyWithImpl<$Res>
    extends _$CustomResponseModelCopyWithImpl<$Res, _$CustomResponseModelImpl>
    implements _$$CustomResponseModelImplCopyWith<$Res> {
  __$$CustomResponseModelImplCopyWithImpl(_$CustomResponseModelImpl _value,
      $Res Function(_$CustomResponseModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of CustomResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = freezed,
    Object? devMessage = freezed,
    Object? meta = freezed,
    Object? data = freezed,
  }) {
    return _then(_$CustomResponseModelImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CustomResponseStatus,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      devMessage: freezed == devMessage
          ? _value.devMessage
          : devMessage // ignore: cast_nullable_to_non_nullable
              as dynamic,
      meta: freezed == meta
          ? _value.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as dynamic,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$CustomResponseModelImpl implements _CustomResponseModel {
  const _$CustomResponseModelImpl(
      {@JsonKey(
          name: 'status',
          fromJson: CustomResponseStatus.fromString,
          toJson: CustomResponseStatus.toJson)
      required this.status,
      @JsonKey(defaultValue: '') this.message,
      @JsonKey(name: 'dev_message', defaultValue: '') required this.devMessage,
      @JsonKey(name: 'meta', includeIfNull: false) required this.meta,
      required this.data});

  factory _$CustomResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomResponseModelImplFromJson(json);

  @override
  @JsonKey(
      name: 'status',
      fromJson: CustomResponseStatus.fromString,
      toJson: CustomResponseStatus.toJson)
  final CustomResponseStatus status;
  @override
  @JsonKey(defaultValue: '')
  final String? message;
  @override
  @JsonKey(name: 'dev_message', defaultValue: '')
  final dynamic devMessage;
  @override
  @JsonKey(name: 'meta', includeIfNull: false)
  final dynamic meta;
  @override
  final dynamic data;

  @override
  String toString() {
    return 'CustomResponseModel(status: $status, message: $message, devMessage: $devMessage, meta: $meta, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomResponseModelImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality()
                .equals(other.devMessage, devMessage) &&
            const DeepCollectionEquality().equals(other.meta, meta) &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      message,
      const DeepCollectionEquality().hash(devMessage),
      const DeepCollectionEquality().hash(meta),
      const DeepCollectionEquality().hash(data));

  /// Create a copy of CustomResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomResponseModelImplCopyWith<_$CustomResponseModelImpl> get copyWith =>
      __$$CustomResponseModelImplCopyWithImpl<_$CustomResponseModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomResponseModelImplToJson(
      this,
    );
  }
}

abstract class _CustomResponseModel implements CustomResponseModel {
  const factory _CustomResponseModel(
      {@JsonKey(
          name: 'status',
          fromJson: CustomResponseStatus.fromString,
          toJson: CustomResponseStatus.toJson)
      required final CustomResponseStatus status,
      @JsonKey(defaultValue: '') final String? message,
      @JsonKey(name: 'dev_message', defaultValue: '')
      required final dynamic devMessage,
      @JsonKey(name: 'meta', includeIfNull: false) required final dynamic meta,
      required final dynamic data}) = _$CustomResponseModelImpl;

  factory _CustomResponseModel.fromJson(Map<String, dynamic> json) =
      _$CustomResponseModelImpl.fromJson;

  @override
  @JsonKey(
      name: 'status',
      fromJson: CustomResponseStatus.fromString,
      toJson: CustomResponseStatus.toJson)
  CustomResponseStatus get status;
  @override
  @JsonKey(defaultValue: '')
  String? get message;
  @override
  @JsonKey(name: 'dev_message', defaultValue: '')
  dynamic get devMessage;
  @override
  @JsonKey(name: 'meta', includeIfNull: false)
  dynamic get meta;
  @override
  dynamic get data;

  /// Create a copy of CustomResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomResponseModelImplCopyWith<_$CustomResponseModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
