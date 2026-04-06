// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'client_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ClientEntity {

 int? get id; String get name; int get phone1; int? get phone2; String? get phone1E164; String? get phone2E164;
/// Create a copy of ClientEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClientEntityCopyWith<ClientEntity> get copyWith => _$ClientEntityCopyWithImpl<ClientEntity>(this as ClientEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClientEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone1, phone1) || other.phone1 == phone1)&&(identical(other.phone2, phone2) || other.phone2 == phone2)&&(identical(other.phone1E164, phone1E164) || other.phone1E164 == phone1E164)&&(identical(other.phone2E164, phone2E164) || other.phone2E164 == phone2E164));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,phone1,phone2,phone1E164,phone2E164);

@override
String toString() {
  return 'ClientEntity(id: $id, name: $name, phone1: $phone1, phone2: $phone2, phone1E164: $phone1E164, phone2E164: $phone2E164)';
}


}

/// @nodoc
abstract mixin class $ClientEntityCopyWith<$Res>  {
  factory $ClientEntityCopyWith(ClientEntity value, $Res Function(ClientEntity) _then) = _$ClientEntityCopyWithImpl;
@useResult
$Res call({
 int? id, String name, int phone1, int? phone2, String? phone1E164, String? phone2E164
});




}
/// @nodoc
class _$ClientEntityCopyWithImpl<$Res>
    implements $ClientEntityCopyWith<$Res> {
  _$ClientEntityCopyWithImpl(this._self, this._then);

  final ClientEntity _self;
  final $Res Function(ClientEntity) _then;

/// Create a copy of ClientEntity
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


/// Adds pattern-matching-related methods to [ClientEntity].
extension ClientEntityPatterns on ClientEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClientEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClientEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClientEntity value)  $default,){
final _that = this;
switch (_that) {
case _ClientEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClientEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ClientEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String name,  int phone1,  int? phone2,  String? phone1E164,  String? phone2E164)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClientEntity() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String name,  int phone1,  int? phone2,  String? phone1E164,  String? phone2E164)  $default,) {final _that = this;
switch (_that) {
case _ClientEntity():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String name,  int phone1,  int? phone2,  String? phone1E164,  String? phone2E164)?  $default,) {final _that = this;
switch (_that) {
case _ClientEntity() when $default != null:
return $default(_that.id,_that.name,_that.phone1,_that.phone2,_that.phone1E164,_that.phone2E164);case _:
  return null;

}
}

}

/// @nodoc


class _ClientEntity implements ClientEntity {
  const _ClientEntity({this.id, required this.name, required this.phone1, this.phone2, this.phone1E164, this.phone2E164});
  

@override final  int? id;
@override final  String name;
@override final  int phone1;
@override final  int? phone2;
@override final  String? phone1E164;
@override final  String? phone2E164;

/// Create a copy of ClientEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClientEntityCopyWith<_ClientEntity> get copyWith => __$ClientEntityCopyWithImpl<_ClientEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClientEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone1, phone1) || other.phone1 == phone1)&&(identical(other.phone2, phone2) || other.phone2 == phone2)&&(identical(other.phone1E164, phone1E164) || other.phone1E164 == phone1E164)&&(identical(other.phone2E164, phone2E164) || other.phone2E164 == phone2E164));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,phone1,phone2,phone1E164,phone2E164);

@override
String toString() {
  return 'ClientEntity(id: $id, name: $name, phone1: $phone1, phone2: $phone2, phone1E164: $phone1E164, phone2E164: $phone2E164)';
}


}

/// @nodoc
abstract mixin class _$ClientEntityCopyWith<$Res> implements $ClientEntityCopyWith<$Res> {
  factory _$ClientEntityCopyWith(_ClientEntity value, $Res Function(_ClientEntity) _then) = __$ClientEntityCopyWithImpl;
@override @useResult
$Res call({
 int? id, String name, int phone1, int? phone2, String? phone1E164, String? phone2E164
});




}
/// @nodoc
class __$ClientEntityCopyWithImpl<$Res>
    implements _$ClientEntityCopyWith<$Res> {
  __$ClientEntityCopyWithImpl(this._self, this._then);

  final _ClientEntity _self;
  final $Res Function(_ClientEntity) _then;

/// Create a copy of ClientEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = null,Object? phone1 = null,Object? phone2 = freezed,Object? phone1E164 = freezed,Object? phone2E164 = freezed,}) {
  return _then(_ClientEntity(
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
