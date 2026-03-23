// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'client_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ClientModel {

@JsonKey(name: 'id', includeToJson: false) int? get id;@JsonKey(name: 'name', readValue: _readName) String get name;@JsonKey(name: 'phone_1', readValue: _readPhone1) int get phone1;@JsonKey(name: 'phone_2', readValue: _readPhone2) int? get phone2;@JsonKey(name: 'phone_1_e164', readValue: _readPhone1E164) String? get phone1E164;@JsonKey(name: 'phone_2_e164', readValue: _readPhone2E164) String? get phone2E164;
/// Create a copy of ClientModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClientModelCopyWith<ClientModel> get copyWith => _$ClientModelCopyWithImpl<ClientModel>(this as ClientModel, _$identity);

  /// Serializes this ClientModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClientModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone1, phone1) || other.phone1 == phone1)&&(identical(other.phone2, phone2) || other.phone2 == phone2)&&(identical(other.phone1E164, phone1E164) || other.phone1E164 == phone1E164)&&(identical(other.phone2E164, phone2E164) || other.phone2E164 == phone2E164));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,phone1,phone2,phone1E164,phone2E164);

@override
String toString() {
  return 'ClientModel(id: $id, name: $name, phone1: $phone1, phone2: $phone2, phone1E164: $phone1E164, phone2E164: $phone2E164)';
}


}

/// @nodoc
abstract mixin class $ClientModelCopyWith<$Res>  {
  factory $ClientModelCopyWith(ClientModel value, $Res Function(ClientModel) _then) = _$ClientModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id', includeToJson: false) int? id,@JsonKey(name: 'name', readValue: _readName) String name,@JsonKey(name: 'phone_1', readValue: _readPhone1) int phone1,@JsonKey(name: 'phone_2', readValue: _readPhone2) int? phone2,@JsonKey(name: 'phone_1_e164', readValue: _readPhone1E164) String? phone1E164,@JsonKey(name: 'phone_2_e164', readValue: _readPhone2E164) String? phone2E164
});




}
/// @nodoc
class _$ClientModelCopyWithImpl<$Res>
    implements $ClientModelCopyWith<$Res> {
  _$ClientModelCopyWithImpl(this._self, this._then);

  final ClientModel _self;
  final $Res Function(ClientModel) _then;

/// Create a copy of ClientModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = null,Object? phone1 = null,Object? phone2 = freezed,Object? phone1E164 = freezed,Object? phone2E164 = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phone1: null == phone1 ? _self.phone1 : phone1 // ignore: cast_nullable_to_non_nullable
as int,phone2: freezed == phone2 ? _self.phone2 : phone2 // ignore: cast_nullable_to_non_nullable
as int?,phone1E164: freezed == phone1E164 ? _self.phone1E164 : phone1E164 // ignore: cast_nullable_to_non_nullable
as String?,phone2E164: freezed == phone2E164 ? _self.phone2E164 : phone2E164 // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ClientModel].
extension ClientModelPatterns on ClientModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClientModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClientModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClientModel value)  $default,){
final _that = this;
switch (_that) {
case _ClientModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClientModel value)?  $default,){
final _that = this;
switch (_that) {
case _ClientModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id', includeToJson: false)  int? id, @JsonKey(name: 'name', readValue: _readName)  String name, @JsonKey(name: 'phone_1', readValue: _readPhone1)  int phone1, @JsonKey(name: 'phone_2', readValue: _readPhone2)  int? phone2, @JsonKey(name: 'phone_1_e164', readValue: _readPhone1E164)  String? phone1E164, @JsonKey(name: 'phone_2_e164', readValue: _readPhone2E164)  String? phone2E164)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClientModel() when $default != null:
return $default(_that.id,_that.name,_that.phone1,_that.phone2,_that.phone1E164,_that.phone2E164);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id', includeToJson: false)  int? id, @JsonKey(name: 'name', readValue: _readName)  String name, @JsonKey(name: 'phone_1', readValue: _readPhone1)  int phone1, @JsonKey(name: 'phone_2', readValue: _readPhone2)  int? phone2, @JsonKey(name: 'phone_1_e164', readValue: _readPhone1E164)  String? phone1E164, @JsonKey(name: 'phone_2_e164', readValue: _readPhone2E164)  String? phone2E164)  $default,) {final _that = this;
switch (_that) {
case _ClientModel():
return $default(_that.id,_that.name,_that.phone1,_that.phone2,_that.phone1E164,_that.phone2E164);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id', includeToJson: false)  int? id, @JsonKey(name: 'name', readValue: _readName)  String name, @JsonKey(name: 'phone_1', readValue: _readPhone1)  int phone1, @JsonKey(name: 'phone_2', readValue: _readPhone2)  int? phone2, @JsonKey(name: 'phone_1_e164', readValue: _readPhone1E164)  String? phone1E164, @JsonKey(name: 'phone_2_e164', readValue: _readPhone2E164)  String? phone2E164)?  $default,) {final _that = this;
switch (_that) {
case _ClientModel() when $default != null:
return $default(_that.id,_that.name,_that.phone1,_that.phone2,_that.phone1E164,_that.phone2E164);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClientModel implements ClientModel {
  const _ClientModel({@JsonKey(name: 'id', includeToJson: false) this.id, @JsonKey(name: 'name', readValue: _readName) required this.name, @JsonKey(name: 'phone_1', readValue: _readPhone1) required this.phone1, @JsonKey(name: 'phone_2', readValue: _readPhone2) this.phone2, @JsonKey(name: 'phone_1_e164', readValue: _readPhone1E164) this.phone1E164, @JsonKey(name: 'phone_2_e164', readValue: _readPhone2E164) this.phone2E164});
  factory _ClientModel.fromJson(Map<String, dynamic> json) => _$ClientModelFromJson(json);

@override@JsonKey(name: 'id', includeToJson: false) final  int? id;
@override@JsonKey(name: 'name', readValue: _readName) final  String name;
@override@JsonKey(name: 'phone_1', readValue: _readPhone1) final  int phone1;
@override@JsonKey(name: 'phone_2', readValue: _readPhone2) final  int? phone2;
@override@JsonKey(name: 'phone_1_e164', readValue: _readPhone1E164) final  String? phone1E164;
@override@JsonKey(name: 'phone_2_e164', readValue: _readPhone2E164) final  String? phone2E164;

/// Create a copy of ClientModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClientModelCopyWith<_ClientModel> get copyWith => __$ClientModelCopyWithImpl<_ClientModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClientModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClientModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone1, phone1) || other.phone1 == phone1)&&(identical(other.phone2, phone2) || other.phone2 == phone2)&&(identical(other.phone1E164, phone1E164) || other.phone1E164 == phone1E164)&&(identical(other.phone2E164, phone2E164) || other.phone2E164 == phone2E164));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,phone1,phone2,phone1E164,phone2E164);

@override
String toString() {
  return 'ClientModel(id: $id, name: $name, phone1: $phone1, phone2: $phone2, phone1E164: $phone1E164, phone2E164: $phone2E164)';
}


}

/// @nodoc
abstract mixin class _$ClientModelCopyWith<$Res> implements $ClientModelCopyWith<$Res> {
  factory _$ClientModelCopyWith(_ClientModel value, $Res Function(_ClientModel) _then) = __$ClientModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id', includeToJson: false) int? id,@JsonKey(name: 'name', readValue: _readName) String name,@JsonKey(name: 'phone_1', readValue: _readPhone1) int phone1,@JsonKey(name: 'phone_2', readValue: _readPhone2) int? phone2,@JsonKey(name: 'phone_1_e164', readValue: _readPhone1E164) String? phone1E164,@JsonKey(name: 'phone_2_e164', readValue: _readPhone2E164) String? phone2E164
});




}
/// @nodoc
class __$ClientModelCopyWithImpl<$Res>
    implements _$ClientModelCopyWith<$Res> {
  __$ClientModelCopyWithImpl(this._self, this._then);

  final _ClientModel _self;
  final $Res Function(_ClientModel) _then;

/// Create a copy of ClientModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = null,Object? phone1 = null,Object? phone2 = freezed,Object? phone1E164 = freezed,Object? phone2E164 = freezed,}) {
  return _then(_ClientModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phone1: null == phone1 ? _self.phone1 : phone1 // ignore: cast_nullable_to_non_nullable
as int,phone2: freezed == phone2 ? _self.phone2 : phone2 // ignore: cast_nullable_to_non_nullable
as int?,phone1E164: freezed == phone1E164 ? _self.phone1E164 : phone1E164 // ignore: cast_nullable_to_non_nullable
as String?,phone2E164: freezed == phone2E164 ? _self.phone2E164 : phone2E164 // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
