// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'staff_request_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StaffRequestEntity {

 int? get id; String? get name; String? get phoneNumber;
/// Create a copy of StaffRequestEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StaffRequestEntityCopyWith<StaffRequestEntity> get copyWith => _$StaffRequestEntityCopyWithImpl<StaffRequestEntity>(this as StaffRequestEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StaffRequestEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,phoneNumber);

@override
String toString() {
  return 'StaffRequestEntity(id: $id, name: $name, phoneNumber: $phoneNumber)';
}


}

/// @nodoc
abstract mixin class $StaffRequestEntityCopyWith<$Res>  {
  factory $StaffRequestEntityCopyWith(StaffRequestEntity value, $Res Function(StaffRequestEntity) _then) = _$StaffRequestEntityCopyWithImpl;
@useResult
$Res call({
 int? id, String? name, String? phoneNumber
});




}
/// @nodoc
class _$StaffRequestEntityCopyWithImpl<$Res>
    implements $StaffRequestEntityCopyWith<$Res> {
  _$StaffRequestEntityCopyWithImpl(this._self, this._then);

  final StaffRequestEntity _self;
  final $Res Function(StaffRequestEntity) _then;

/// Create a copy of StaffRequestEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = freezed,Object? phoneNumber = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [StaffRequestEntity].
extension StaffRequestEntityPatterns on StaffRequestEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StaffRequestEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StaffRequestEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StaffRequestEntity value)  $default,){
final _that = this;
switch (_that) {
case _StaffRequestEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StaffRequestEntity value)?  $default,){
final _that = this;
switch (_that) {
case _StaffRequestEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String? name,  String? phoneNumber)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StaffRequestEntity() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String? name,  String? phoneNumber)  $default,) {final _that = this;
switch (_that) {
case _StaffRequestEntity():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String? name,  String? phoneNumber)?  $default,) {final _that = this;
switch (_that) {
case _StaffRequestEntity() when $default != null:
return $default(_that.id,_that.name,_that.phoneNumber);case _:
  return null;

}
}

}

/// @nodoc


class _StaffRequestEntity implements StaffRequestEntity {
  const _StaffRequestEntity({this.id, this.name, this.phoneNumber});
  

@override final  int? id;
@override final  String? name;
@override final  String? phoneNumber;

/// Create a copy of StaffRequestEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StaffRequestEntityCopyWith<_StaffRequestEntity> get copyWith => __$StaffRequestEntityCopyWithImpl<_StaffRequestEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StaffRequestEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,phoneNumber);

@override
String toString() {
  return 'StaffRequestEntity(id: $id, name: $name, phoneNumber: $phoneNumber)';
}


}

/// @nodoc
abstract mixin class _$StaffRequestEntityCopyWith<$Res> implements $StaffRequestEntityCopyWith<$Res> {
  factory _$StaffRequestEntityCopyWith(_StaffRequestEntity value, $Res Function(_StaffRequestEntity) _then) = __$StaffRequestEntityCopyWithImpl;
@override @useResult
$Res call({
 int? id, String? name, String? phoneNumber
});




}
/// @nodoc
class __$StaffRequestEntityCopyWithImpl<$Res>
    implements _$StaffRequestEntityCopyWith<$Res> {
  __$StaffRequestEntityCopyWithImpl(this._self, this._then);

  final _StaffRequestEntity _self;
  final $Res Function(_StaffRequestEntity) _then;

/// Create a copy of StaffRequestEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = freezed,Object? phoneNumber = freezed,}) {
  return _then(_StaffRequestEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
