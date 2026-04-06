// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'additional_charges_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AdditionalChargesEntity {

 int? get id; String? get name; int? get amount;
/// Create a copy of AdditionalChargesEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdditionalChargesEntityCopyWith<AdditionalChargesEntity> get copyWith => _$AdditionalChargesEntityCopyWithImpl<AdditionalChargesEntity>(this as AdditionalChargesEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdditionalChargesEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.amount, amount) || other.amount == amount));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,amount);

@override
String toString() {
  return 'AdditionalChargesEntity(id: $id, name: $name, amount: $amount)';
}


}

/// @nodoc
abstract mixin class $AdditionalChargesEntityCopyWith<$Res>  {
  factory $AdditionalChargesEntityCopyWith(AdditionalChargesEntity value, $Res Function(AdditionalChargesEntity) _then) = _$AdditionalChargesEntityCopyWithImpl;
@useResult
$Res call({
 int? id, String? name, int? amount
});




}
/// @nodoc
class _$AdditionalChargesEntityCopyWithImpl<$Res>
    implements $AdditionalChargesEntityCopyWith<$Res> {
  _$AdditionalChargesEntityCopyWithImpl(this._self, this._then);

  final AdditionalChargesEntity _self;
  final $Res Function(AdditionalChargesEntity) _then;

/// Create a copy of AdditionalChargesEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = freezed,Object? amount = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [AdditionalChargesEntity].
extension AdditionalChargesEntityPatterns on AdditionalChargesEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdditionalChargesEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdditionalChargesEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdditionalChargesEntity value)  $default,){
final _that = this;
switch (_that) {
case _AdditionalChargesEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdditionalChargesEntity value)?  $default,){
final _that = this;
switch (_that) {
case _AdditionalChargesEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String? name,  int? amount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdditionalChargesEntity() when $default != null:
return $default(_that.id,_that.name,_that.amount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String? name,  int? amount)  $default,) {final _that = this;
switch (_that) {
case _AdditionalChargesEntity():
return $default(_that.id,_that.name,_that.amount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String? name,  int? amount)?  $default,) {final _that = this;
switch (_that) {
case _AdditionalChargesEntity() when $default != null:
return $default(_that.id,_that.name,_that.amount);case _:
  return null;

}
}

}

/// @nodoc


class _AdditionalChargesEntity implements AdditionalChargesEntity {
  const _AdditionalChargesEntity({this.id, this.name, this.amount});
  

@override final  int? id;
@override final  String? name;
@override final  int? amount;

/// Create a copy of AdditionalChargesEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdditionalChargesEntityCopyWith<_AdditionalChargesEntity> get copyWith => __$AdditionalChargesEntityCopyWithImpl<_AdditionalChargesEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdditionalChargesEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.amount, amount) || other.amount == amount));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,amount);

@override
String toString() {
  return 'AdditionalChargesEntity(id: $id, name: $name, amount: $amount)';
}


}

/// @nodoc
abstract mixin class _$AdditionalChargesEntityCopyWith<$Res> implements $AdditionalChargesEntityCopyWith<$Res> {
  factory _$AdditionalChargesEntityCopyWith(_AdditionalChargesEntity value, $Res Function(_AdditionalChargesEntity) _then) = __$AdditionalChargesEntityCopyWithImpl;
@override @useResult
$Res call({
 int? id, String? name, int? amount
});




}
/// @nodoc
class __$AdditionalChargesEntityCopyWithImpl<$Res>
    implements _$AdditionalChargesEntityCopyWith<$Res> {
  __$AdditionalChargesEntityCopyWithImpl(this._self, this._then);

  final _AdditionalChargesEntity _self;
  final $Res Function(_AdditionalChargesEntity) _then;

/// Create a copy of AdditionalChargesEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = freezed,Object? amount = freezed,}) {
  return _then(_AdditionalChargesEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
