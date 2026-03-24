// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'measurement_value_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MeasurementValueEntity {

 String get name; String get key; String get value; GenderType? get gender;
/// Create a copy of MeasurementValueEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MeasurementValueEntityCopyWith<MeasurementValueEntity> get copyWith => _$MeasurementValueEntityCopyWithImpl<MeasurementValueEntity>(this as MeasurementValueEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MeasurementValueEntity&&(identical(other.name, name) || other.name == name)&&(identical(other.key, key) || other.key == key)&&(identical(other.value, value) || other.value == value)&&(identical(other.gender, gender) || other.gender == gender));
}


@override
int get hashCode => Object.hash(runtimeType,name,key,value,gender);

@override
String toString() {
  return 'MeasurementValueEntity(name: $name, key: $key, value: $value, gender: $gender)';
}


}

/// @nodoc
abstract mixin class $MeasurementValueEntityCopyWith<$Res>  {
  factory $MeasurementValueEntityCopyWith(MeasurementValueEntity value, $Res Function(MeasurementValueEntity) _then) = _$MeasurementValueEntityCopyWithImpl;
@useResult
$Res call({
 String name, String key, String value, GenderType? gender
});




}
/// @nodoc
class _$MeasurementValueEntityCopyWithImpl<$Res>
    implements $MeasurementValueEntityCopyWith<$Res> {
  _$MeasurementValueEntityCopyWithImpl(this._self, this._then);

  final MeasurementValueEntity _self;
  final $Res Function(MeasurementValueEntity) _then;

/// Create a copy of MeasurementValueEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? key = null,Object? value = null,Object? gender = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as GenderType?,
  ));
}

}


/// Adds pattern-matching-related methods to [MeasurementValueEntity].
extension MeasurementValueEntityPatterns on MeasurementValueEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MeasurementValueEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MeasurementValueEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MeasurementValueEntity value)  $default,){
final _that = this;
switch (_that) {
case _MeasurementValueEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MeasurementValueEntity value)?  $default,){
final _that = this;
switch (_that) {
case _MeasurementValueEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String key,  String value,  GenderType? gender)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MeasurementValueEntity() when $default != null:
return $default(_that.name,_that.key,_that.value,_that.gender);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String key,  String value,  GenderType? gender)  $default,) {final _that = this;
switch (_that) {
case _MeasurementValueEntity():
return $default(_that.name,_that.key,_that.value,_that.gender);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String key,  String value,  GenderType? gender)?  $default,) {final _that = this;
switch (_that) {
case _MeasurementValueEntity() when $default != null:
return $default(_that.name,_that.key,_that.value,_that.gender);case _:
  return null;

}
}

}

/// @nodoc


class _MeasurementValueEntity implements MeasurementValueEntity {
  const _MeasurementValueEntity({required this.name, required this.key, required this.value, this.gender});
  

@override final  String name;
@override final  String key;
@override final  String value;
@override final  GenderType? gender;

/// Create a copy of MeasurementValueEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MeasurementValueEntityCopyWith<_MeasurementValueEntity> get copyWith => __$MeasurementValueEntityCopyWithImpl<_MeasurementValueEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MeasurementValueEntity&&(identical(other.name, name) || other.name == name)&&(identical(other.key, key) || other.key == key)&&(identical(other.value, value) || other.value == value)&&(identical(other.gender, gender) || other.gender == gender));
}


@override
int get hashCode => Object.hash(runtimeType,name,key,value,gender);

@override
String toString() {
  return 'MeasurementValueEntity(name: $name, key: $key, value: $value, gender: $gender)';
}


}

/// @nodoc
abstract mixin class _$MeasurementValueEntityCopyWith<$Res> implements $MeasurementValueEntityCopyWith<$Res> {
  factory _$MeasurementValueEntityCopyWith(_MeasurementValueEntity value, $Res Function(_MeasurementValueEntity) _then) = __$MeasurementValueEntityCopyWithImpl;
@override @useResult
$Res call({
 String name, String key, String value, GenderType? gender
});




}
/// @nodoc
class __$MeasurementValueEntityCopyWithImpl<$Res>
    implements _$MeasurementValueEntityCopyWith<$Res> {
  __$MeasurementValueEntityCopyWithImpl(this._self, this._then);

  final _MeasurementValueEntity _self;
  final $Res Function(_MeasurementValueEntity) _then;

/// Create a copy of MeasurementValueEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? key = null,Object? value = null,Object? gender = freezed,}) {
  return _then(_MeasurementValueEntity(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as GenderType?,
  ));
}


}

// dart format on
