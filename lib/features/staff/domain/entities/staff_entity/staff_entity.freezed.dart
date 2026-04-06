// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'staff_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StaffEntity {

 int get id; String get name; String get phoneNumber;
/// Create a copy of StaffEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StaffEntityCopyWith<StaffEntity> get copyWith => _$StaffEntityCopyWithImpl<StaffEntity>(this as StaffEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StaffEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,phoneNumber);

@override
String toString() {
  return 'StaffEntity(id: $id, name: $name, phoneNumber: $phoneNumber)';
}


}

/// @nodoc
abstract mixin class $StaffEntityCopyWith<$Res>  {
  factory $StaffEntityCopyWith(StaffEntity value, $Res Function(StaffEntity) _then) = _$StaffEntityCopyWithImpl;
@useResult
$Res call({
 int id, String name, String phoneNumber
});




}
/// @nodoc
class _$StaffEntityCopyWithImpl<$Res>
    implements $StaffEntityCopyWith<$Res> {
  _$StaffEntityCopyWithImpl(this._self, this._then);

  final StaffEntity _self;
  final $Res Function(StaffEntity) _then;

/// Create a copy of StaffEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? phoneNumber = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [StaffEntity].
extension StaffEntityPatterns on StaffEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StaffEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StaffEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StaffEntity value)  $default,){
final _that = this;
switch (_that) {
case _StaffEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StaffEntity value)?  $default,){
final _that = this;
switch (_that) {
case _StaffEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String phoneNumber)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StaffEntity() when $default != null:
return $default(_that.id,_that.name,_that.phoneNumber);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String phoneNumber)  $default,) {final _that = this;
switch (_that) {
case _StaffEntity():
return $default(_that.id,_that.name,_that.phoneNumber);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String phoneNumber)?  $default,) {final _that = this;
switch (_that) {
case _StaffEntity() when $default != null:
return $default(_that.id,_that.name,_that.phoneNumber);case _:
  return null;

}
}

}

/// @nodoc


class _StaffEntity implements StaffEntity {
  const _StaffEntity({required this.id, required this.name, required this.phoneNumber});
  

@override final  int id;
@override final  String name;
@override final  String phoneNumber;

/// Create a copy of StaffEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StaffEntityCopyWith<_StaffEntity> get copyWith => __$StaffEntityCopyWithImpl<_StaffEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StaffEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,phoneNumber);

@override
String toString() {
  return 'StaffEntity(id: $id, name: $name, phoneNumber: $phoneNumber)';
}


}

/// @nodoc
abstract mixin class _$StaffEntityCopyWith<$Res> implements $StaffEntityCopyWith<$Res> {
  factory _$StaffEntityCopyWith(_StaffEntity value, $Res Function(_StaffEntity) _then) = __$StaffEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String phoneNumber
});




}
/// @nodoc
class __$StaffEntityCopyWithImpl<$Res>
    implements _$StaffEntityCopyWith<$Res> {
  __$StaffEntityCopyWithImpl(this._self, this._then);

  final _StaffEntity _self;
  final $Res Function(_StaffEntity) _then;

/// Create a copy of StaffEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? phoneNumber = null,}) {
  return _then(_StaffEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
