// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'custom_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CustomResponseModel {

@JsonKey(name: 'status', fromJson: CustomResponseStatus.fromString, toJson: CustomResponseStatus.toJson) CustomResponseStatus get status;@JsonKey(defaultValue: '') String? get message;@JsonKey(name: 'dev_message', defaultValue: '') dynamic get devMessage;@JsonKey(name: 'meta', includeIfNull: false) dynamic get meta; dynamic get data;
/// Create a copy of CustomResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomResponseModelCopyWith<CustomResponseModel> get copyWith => _$CustomResponseModelCopyWithImpl<CustomResponseModel>(this as CustomResponseModel, _$identity);

  /// Serializes this CustomResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomResponseModel&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.devMessage, devMessage)&&const DeepCollectionEquality().equals(other.meta, meta)&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,message,const DeepCollectionEquality().hash(devMessage),const DeepCollectionEquality().hash(meta),const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'CustomResponseModel(status: $status, message: $message, devMessage: $devMessage, meta: $meta, data: $data)';
}


}

/// @nodoc
abstract mixin class $CustomResponseModelCopyWith<$Res>  {
  factory $CustomResponseModelCopyWith(CustomResponseModel value, $Res Function(CustomResponseModel) _then) = _$CustomResponseModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'status', fromJson: CustomResponseStatus.fromString, toJson: CustomResponseStatus.toJson) CustomResponseStatus status,@JsonKey(defaultValue: '') String? message,@JsonKey(name: 'dev_message', defaultValue: '') dynamic devMessage,@JsonKey(name: 'meta', includeIfNull: false) dynamic meta, dynamic data
});




}
/// @nodoc
class _$CustomResponseModelCopyWithImpl<$Res>
    implements $CustomResponseModelCopyWith<$Res> {
  _$CustomResponseModelCopyWithImpl(this._self, this._then);

  final CustomResponseModel _self;
  final $Res Function(CustomResponseModel) _then;

/// Create a copy of CustomResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? message = freezed,Object? devMessage = freezed,Object? meta = freezed,Object? data = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CustomResponseStatus,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,devMessage: freezed == devMessage ? _self.devMessage : devMessage // ignore: cast_nullable_to_non_nullable
as dynamic,meta: freezed == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as dynamic,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

}


/// Adds pattern-matching-related methods to [CustomResponseModel].
extension CustomResponseModelPatterns on CustomResponseModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CustomResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CustomResponseModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CustomResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _CustomResponseModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CustomResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _CustomResponseModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'status', fromJson: CustomResponseStatus.fromString, toJson: CustomResponseStatus.toJson)  CustomResponseStatus status, @JsonKey(defaultValue: '')  String? message, @JsonKey(name: 'dev_message', defaultValue: '')  dynamic devMessage, @JsonKey(name: 'meta', includeIfNull: false)  dynamic meta,  dynamic data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CustomResponseModel() when $default != null:
return $default(_that.status,_that.message,_that.devMessage,_that.meta,_that.data);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'status', fromJson: CustomResponseStatus.fromString, toJson: CustomResponseStatus.toJson)  CustomResponseStatus status, @JsonKey(defaultValue: '')  String? message, @JsonKey(name: 'dev_message', defaultValue: '')  dynamic devMessage, @JsonKey(name: 'meta', includeIfNull: false)  dynamic meta,  dynamic data)  $default,) {final _that = this;
switch (_that) {
case _CustomResponseModel():
return $default(_that.status,_that.message,_that.devMessage,_that.meta,_that.data);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'status', fromJson: CustomResponseStatus.fromString, toJson: CustomResponseStatus.toJson)  CustomResponseStatus status, @JsonKey(defaultValue: '')  String? message, @JsonKey(name: 'dev_message', defaultValue: '')  dynamic devMessage, @JsonKey(name: 'meta', includeIfNull: false)  dynamic meta,  dynamic data)?  $default,) {final _that = this;
switch (_that) {
case _CustomResponseModel() when $default != null:
return $default(_that.status,_that.message,_that.devMessage,_that.meta,_that.data);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _CustomResponseModel implements CustomResponseModel {
  const _CustomResponseModel({@JsonKey(name: 'status', fromJson: CustomResponseStatus.fromString, toJson: CustomResponseStatus.toJson) required this.status, @JsonKey(defaultValue: '') this.message, @JsonKey(name: 'dev_message', defaultValue: '') required this.devMessage, @JsonKey(name: 'meta', includeIfNull: false) required this.meta, required this.data});
  factory _CustomResponseModel.fromJson(Map<String, dynamic> json) => _$CustomResponseModelFromJson(json);

@override@JsonKey(name: 'status', fromJson: CustomResponseStatus.fromString, toJson: CustomResponseStatus.toJson) final  CustomResponseStatus status;
@override@JsonKey(defaultValue: '') final  String? message;
@override@JsonKey(name: 'dev_message', defaultValue: '') final  dynamic devMessage;
@override@JsonKey(name: 'meta', includeIfNull: false) final  dynamic meta;
@override final  dynamic data;

/// Create a copy of CustomResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomResponseModelCopyWith<_CustomResponseModel> get copyWith => __$CustomResponseModelCopyWithImpl<_CustomResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CustomResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomResponseModel&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.devMessage, devMessage)&&const DeepCollectionEquality().equals(other.meta, meta)&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,message,const DeepCollectionEquality().hash(devMessage),const DeepCollectionEquality().hash(meta),const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'CustomResponseModel(status: $status, message: $message, devMessage: $devMessage, meta: $meta, data: $data)';
}


}

/// @nodoc
abstract mixin class _$CustomResponseModelCopyWith<$Res> implements $CustomResponseModelCopyWith<$Res> {
  factory _$CustomResponseModelCopyWith(_CustomResponseModel value, $Res Function(_CustomResponseModel) _then) = __$CustomResponseModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'status', fromJson: CustomResponseStatus.fromString, toJson: CustomResponseStatus.toJson) CustomResponseStatus status,@JsonKey(defaultValue: '') String? message,@JsonKey(name: 'dev_message', defaultValue: '') dynamic devMessage,@JsonKey(name: 'meta', includeIfNull: false) dynamic meta, dynamic data
});




}
/// @nodoc
class __$CustomResponseModelCopyWithImpl<$Res>
    implements _$CustomResponseModelCopyWith<$Res> {
  __$CustomResponseModelCopyWithImpl(this._self, this._then);

  final _CustomResponseModel _self;
  final $Res Function(_CustomResponseModel) _then;

/// Create a copy of CustomResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? message = freezed,Object? devMessage = freezed,Object? meta = freezed,Object? data = freezed,}) {
  return _then(_CustomResponseModel(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CustomResponseStatus,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,devMessage: freezed == devMessage ? _self.devMessage : devMessage // ignore: cast_nullable_to_non_nullable
as dynamic,meta: freezed == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as dynamic,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}

// dart format on
