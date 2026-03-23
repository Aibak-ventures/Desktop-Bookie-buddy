// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'staff_details_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StaffDetailsEntity {

 int get id; String get name; String get phoneNumber; String get createdAt;
/// Create a copy of StaffDetailsEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StaffDetailsEntityCopyWith<StaffDetailsEntity> get copyWith => _$StaffDetailsEntityCopyWithImpl<StaffDetailsEntity>(this as StaffDetailsEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StaffDetailsEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,phoneNumber,createdAt);

@override
String toString() {
  return 'StaffDetailsEntity(id: $id, name: $name, phoneNumber: $phoneNumber, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $StaffDetailsEntityCopyWith<$Res>  {
  factory $StaffDetailsEntityCopyWith(StaffDetailsEntity value, $Res Function(StaffDetailsEntity) _then) = _$StaffDetailsEntityCopyWithImpl;
@useResult
$Res call({
 int id, String name, String phoneNumber, String createdAt
});




}
/// @nodoc
class _$StaffDetailsEntityCopyWithImpl<$Res>
    implements $StaffDetailsEntityCopyWith<$Res> {
  _$StaffDetailsEntityCopyWithImpl(this._self, this._then);

  final StaffDetailsEntity _self;
  final $Res Function(StaffDetailsEntity) _then;

/// Create a copy of StaffDetailsEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? phoneNumber = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [StaffDetailsEntity].
extension StaffDetailsEntityPatterns on StaffDetailsEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StaffDetailsEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StaffDetailsEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StaffDetailsEntity value)  $default,){
final _that = this;
switch (_that) {
case _StaffDetailsEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StaffDetailsEntity value)?  $default,){
final _that = this;
switch (_that) {
case _StaffDetailsEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String phoneNumber,  String createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StaffDetailsEntity() when $default != null:
return $default(_that.id,_that.name,_that.phoneNumber,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String phoneNumber,  String createdAt)  $default,) {final _that = this;
switch (_that) {
case _StaffDetailsEntity():
return $default(_that.id,_that.name,_that.phoneNumber,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String phoneNumber,  String createdAt)?  $default,) {final _that = this;
switch (_that) {
case _StaffDetailsEntity() when $default != null:
return $default(_that.id,_that.name,_that.phoneNumber,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _StaffDetailsEntity implements StaffDetailsEntity {
  const _StaffDetailsEntity({required this.id, required this.name, required this.phoneNumber, required this.createdAt});
  

@override final  int id;
@override final  String name;
@override final  String phoneNumber;
@override final  String createdAt;

/// Create a copy of StaffDetailsEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StaffDetailsEntityCopyWith<_StaffDetailsEntity> get copyWith => __$StaffDetailsEntityCopyWithImpl<_StaffDetailsEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StaffDetailsEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,phoneNumber,createdAt);

@override
String toString() {
  return 'StaffDetailsEntity(id: $id, name: $name, phoneNumber: $phoneNumber, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$StaffDetailsEntityCopyWith<$Res> implements $StaffDetailsEntityCopyWith<$Res> {
  factory _$StaffDetailsEntityCopyWith(_StaffDetailsEntity value, $Res Function(_StaffDetailsEntity) _then) = __$StaffDetailsEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String phoneNumber, String createdAt
});




}
/// @nodoc
class __$StaffDetailsEntityCopyWithImpl<$Res>
    implements _$StaffDetailsEntityCopyWith<$Res> {
  __$StaffDetailsEntityCopyWithImpl(this._self, this._then);

  final _StaffDetailsEntity _self;
  final $Res Function(_StaffDetailsEntity) _then;

/// Create a copy of StaffDetailsEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? phoneNumber = null,Object? createdAt = null,}) {
  return _then(_StaffDetailsEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
