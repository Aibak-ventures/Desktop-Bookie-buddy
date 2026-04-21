// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'client_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ClientRequestModel {

@JsonKey(name: 'id', includeToJson: false, includeIfNull: false) int? get id;@JsonKey(name: 'name', includeIfNull: false) String? get name;@JsonKey(name: 'phone_1_e164', includeIfNull: false) String? get phone1E164;@JsonKey(name: 'phone_2_e164', includeIfNull: false) String? get phone2E164;
/// Create a copy of ClientRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClientRequestModelCopyWith<ClientRequestModel> get copyWith => _$ClientRequestModelCopyWithImpl<ClientRequestModel>(this as ClientRequestModel, _$identity);

  /// Serializes this ClientRequestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClientRequestModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone1E164, phone1E164) || other.phone1E164 == phone1E164)&&(identical(other.phone2E164, phone2E164) || other.phone2E164 == phone2E164));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,phone1E164,phone2E164);

@override
String toString() {
  return 'ClientRequestModel(id: $id, name: $name, phone1E164: $phone1E164, phone2E164: $phone2E164)';
}


}

/// @nodoc
abstract mixin class $ClientRequestModelCopyWith<$Res>  {
  factory $ClientRequestModelCopyWith(ClientRequestModel value, $Res Function(ClientRequestModel) _then) = _$ClientRequestModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id', includeToJson: false, includeIfNull: false) int? id,@JsonKey(name: 'name', includeIfNull: false) String? name,@JsonKey(name: 'phone_1_e164', includeIfNull: false) String? phone1E164,@JsonKey(name: 'phone_2_e164', includeIfNull: false) String? phone2E164
});




}
/// @nodoc
class _$ClientRequestModelCopyWithImpl<$Res>
    implements $ClientRequestModelCopyWith<$Res> {
  _$ClientRequestModelCopyWithImpl(this._self, this._then);

  final ClientRequestModel _self;
  final $Res Function(ClientRequestModel) _then;

/// Create a copy of ClientRequestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = freezed,Object? phone1E164 = freezed,Object? phone2E164 = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,phone1E164: freezed == phone1E164 ? _self.phone1E164 : phone1E164 // ignore: cast_nullable_to_non_nullable
as String?,phone2E164: freezed == phone2E164 ? _self.phone2E164 : phone2E164 // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ClientRequestModel].
extension ClientRequestModelPatterns on ClientRequestModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClientRequestModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClientRequestModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClientRequestModel value)  $default,){
final _that = this;
switch (_that) {
case _ClientRequestModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClientRequestModel value)?  $default,){
final _that = this;
switch (_that) {
case _ClientRequestModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id', includeToJson: false, includeIfNull: false)  int? id, @JsonKey(name: 'name', includeIfNull: false)  String? name, @JsonKey(name: 'phone_1_e164', includeIfNull: false)  String? phone1E164, @JsonKey(name: 'phone_2_e164', includeIfNull: false)  String? phone2E164)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClientRequestModel() when $default != null:
return $default(_that.id,_that.name,_that.phone1E164,_that.phone2E164);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id', includeToJson: false, includeIfNull: false)  int? id, @JsonKey(name: 'name', includeIfNull: false)  String? name, @JsonKey(name: 'phone_1_e164', includeIfNull: false)  String? phone1E164, @JsonKey(name: 'phone_2_e164', includeIfNull: false)  String? phone2E164)  $default,) {final _that = this;
switch (_that) {
case _ClientRequestModel():
return $default(_that.id,_that.name,_that.phone1E164,_that.phone2E164);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id', includeToJson: false, includeIfNull: false)  int? id, @JsonKey(name: 'name', includeIfNull: false)  String? name, @JsonKey(name: 'phone_1_e164', includeIfNull: false)  String? phone1E164, @JsonKey(name: 'phone_2_e164', includeIfNull: false)  String? phone2E164)?  $default,) {final _that = this;
switch (_that) {
case _ClientRequestModel() when $default != null:
return $default(_that.id,_that.name,_that.phone1E164,_that.phone2E164);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClientRequestModel implements ClientRequestModel {
  const _ClientRequestModel({@JsonKey(name: 'id', includeToJson: false, includeIfNull: false) required this.id, @JsonKey(name: 'name', includeIfNull: false) this.name, @JsonKey(name: 'phone_1_e164', includeIfNull: false) this.phone1E164, @JsonKey(name: 'phone_2_e164', includeIfNull: false) this.phone2E164});
  factory _ClientRequestModel.fromJson(Map<String, dynamic> json) => _$ClientRequestModelFromJson(json);

@override@JsonKey(name: 'id', includeToJson: false, includeIfNull: false) final  int? id;
@override@JsonKey(name: 'name', includeIfNull: false) final  String? name;
@override@JsonKey(name: 'phone_1_e164', includeIfNull: false) final  String? phone1E164;
@override@JsonKey(name: 'phone_2_e164', includeIfNull: false) final  String? phone2E164;

/// Create a copy of ClientRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClientRequestModelCopyWith<_ClientRequestModel> get copyWith => __$ClientRequestModelCopyWithImpl<_ClientRequestModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClientRequestModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClientRequestModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone1E164, phone1E164) || other.phone1E164 == phone1E164)&&(identical(other.phone2E164, phone2E164) || other.phone2E164 == phone2E164));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,phone1E164,phone2E164);

@override
String toString() {
  return 'ClientRequestModel(id: $id, name: $name, phone1E164: $phone1E164, phone2E164: $phone2E164)';
}


}

/// @nodoc
abstract mixin class _$ClientRequestModelCopyWith<$Res> implements $ClientRequestModelCopyWith<$Res> {
  factory _$ClientRequestModelCopyWith(_ClientRequestModel value, $Res Function(_ClientRequestModel) _then) = __$ClientRequestModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id', includeToJson: false, includeIfNull: false) int? id,@JsonKey(name: 'name', includeIfNull: false) String? name,@JsonKey(name: 'phone_1_e164', includeIfNull: false) String? phone1E164,@JsonKey(name: 'phone_2_e164', includeIfNull: false) String? phone2E164
});




}
/// @nodoc
class __$ClientRequestModelCopyWithImpl<$Res>
    implements _$ClientRequestModelCopyWith<$Res> {
  __$ClientRequestModelCopyWithImpl(this._self, this._then);

  final _ClientRequestModel _self;
  final $Res Function(_ClientRequestModel) _then;

/// Create a copy of ClientRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = freezed,Object? phone1E164 = freezed,Object? phone2E164 = freezed,}) {
  return _then(_ClientRequestModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,phone1E164: freezed == phone1E164 ? _self.phone1E164 : phone1E164 // ignore: cast_nullable_to_non_nullable
as String?,phone2E164: freezed == phone2E164 ? _self.phone2E164 : phone2E164 // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
