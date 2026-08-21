// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_attributes_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductAttributesEntity {

 String? get pollutionExpiryDate; String? get insuranceExpiryDate; String? get fitnessExpiryDate; String? get permitDate; String? get registrationNumber;
/// Create a copy of ProductAttributesEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductAttributesEntityCopyWith<ProductAttributesEntity> get copyWith => _$ProductAttributesEntityCopyWithImpl<ProductAttributesEntity>(this as ProductAttributesEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductAttributesEntity&&(identical(other.pollutionExpiryDate, pollutionExpiryDate) || other.pollutionExpiryDate == pollutionExpiryDate)&&(identical(other.insuranceExpiryDate, insuranceExpiryDate) || other.insuranceExpiryDate == insuranceExpiryDate)&&(identical(other.fitnessExpiryDate, fitnessExpiryDate) || other.fitnessExpiryDate == fitnessExpiryDate)&&(identical(other.permitDate, permitDate) || other.permitDate == permitDate)&&(identical(other.registrationNumber, registrationNumber) || other.registrationNumber == registrationNumber));
}


@override
int get hashCode => Object.hash(runtimeType,pollutionExpiryDate,insuranceExpiryDate,fitnessExpiryDate,permitDate,registrationNumber);

@override
String toString() {
  return 'ProductAttributesEntity(pollutionExpiryDate: $pollutionExpiryDate, insuranceExpiryDate: $insuranceExpiryDate, fitnessExpiryDate: $fitnessExpiryDate, permitDate: $permitDate, registrationNumber: $registrationNumber)';
}


}

/// @nodoc
abstract mixin class $ProductAttributesEntityCopyWith<$Res>  {
  factory $ProductAttributesEntityCopyWith(ProductAttributesEntity value, $Res Function(ProductAttributesEntity) _then) = _$ProductAttributesEntityCopyWithImpl;
@useResult
$Res call({
 String? pollutionExpiryDate, String? insuranceExpiryDate, String? fitnessExpiryDate, String? permitDate, String? registrationNumber
});




}
/// @nodoc
class _$ProductAttributesEntityCopyWithImpl<$Res>
    implements $ProductAttributesEntityCopyWith<$Res> {
  _$ProductAttributesEntityCopyWithImpl(this._self, this._then);

  final ProductAttributesEntity _self;
  final $Res Function(ProductAttributesEntity) _then;

/// Create a copy of ProductAttributesEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pollutionExpiryDate = freezed,Object? insuranceExpiryDate = freezed,Object? fitnessExpiryDate = freezed,Object? permitDate = freezed,Object? registrationNumber = freezed,}) {
  return _then(_self.copyWith(
pollutionExpiryDate: freezed == pollutionExpiryDate ? _self.pollutionExpiryDate : pollutionExpiryDate // ignore: cast_nullable_to_non_nullable
as String?,insuranceExpiryDate: freezed == insuranceExpiryDate ? _self.insuranceExpiryDate : insuranceExpiryDate // ignore: cast_nullable_to_non_nullable
as String?,fitnessExpiryDate: freezed == fitnessExpiryDate ? _self.fitnessExpiryDate : fitnessExpiryDate // ignore: cast_nullable_to_non_nullable
as String?,permitDate: freezed == permitDate ? _self.permitDate : permitDate // ignore: cast_nullable_to_non_nullable
as String?,registrationNumber: freezed == registrationNumber ? _self.registrationNumber : registrationNumber // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductAttributesEntity].
extension ProductAttributesEntityPatterns on ProductAttributesEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductAttributesEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductAttributesEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductAttributesEntity value)  $default,){
final _that = this;
switch (_that) {
case _ProductAttributesEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductAttributesEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ProductAttributesEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? pollutionExpiryDate,  String? insuranceExpiryDate,  String? fitnessExpiryDate,  String? permitDate,  String? registrationNumber)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductAttributesEntity() when $default != null:
return $default(_that.pollutionExpiryDate,_that.insuranceExpiryDate,_that.fitnessExpiryDate,_that.permitDate,_that.registrationNumber);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? pollutionExpiryDate,  String? insuranceExpiryDate,  String? fitnessExpiryDate,  String? permitDate,  String? registrationNumber)  $default,) {final _that = this;
switch (_that) {
case _ProductAttributesEntity():
return $default(_that.pollutionExpiryDate,_that.insuranceExpiryDate,_that.fitnessExpiryDate,_that.permitDate,_that.registrationNumber);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? pollutionExpiryDate,  String? insuranceExpiryDate,  String? fitnessExpiryDate,  String? permitDate,  String? registrationNumber)?  $default,) {final _that = this;
switch (_that) {
case _ProductAttributesEntity() when $default != null:
return $default(_that.pollutionExpiryDate,_that.insuranceExpiryDate,_that.fitnessExpiryDate,_that.permitDate,_that.registrationNumber);case _:
  return null;

}
}

}

/// @nodoc


class _ProductAttributesEntity implements ProductAttributesEntity {
  const _ProductAttributesEntity({this.pollutionExpiryDate, this.insuranceExpiryDate, this.fitnessExpiryDate, this.permitDate, this.registrationNumber});
  

@override final  String? pollutionExpiryDate;
@override final  String? insuranceExpiryDate;
@override final  String? fitnessExpiryDate;
@override final  String? permitDate;
@override final  String? registrationNumber;

/// Create a copy of ProductAttributesEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductAttributesEntityCopyWith<_ProductAttributesEntity> get copyWith => __$ProductAttributesEntityCopyWithImpl<_ProductAttributesEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductAttributesEntity&&(identical(other.pollutionExpiryDate, pollutionExpiryDate) || other.pollutionExpiryDate == pollutionExpiryDate)&&(identical(other.insuranceExpiryDate, insuranceExpiryDate) || other.insuranceExpiryDate == insuranceExpiryDate)&&(identical(other.fitnessExpiryDate, fitnessExpiryDate) || other.fitnessExpiryDate == fitnessExpiryDate)&&(identical(other.permitDate, permitDate) || other.permitDate == permitDate)&&(identical(other.registrationNumber, registrationNumber) || other.registrationNumber == registrationNumber));
}


@override
int get hashCode => Object.hash(runtimeType,pollutionExpiryDate,insuranceExpiryDate,fitnessExpiryDate,permitDate,registrationNumber);

@override
String toString() {
  return 'ProductAttributesEntity(pollutionExpiryDate: $pollutionExpiryDate, insuranceExpiryDate: $insuranceExpiryDate, fitnessExpiryDate: $fitnessExpiryDate, permitDate: $permitDate, registrationNumber: $registrationNumber)';
}


}

/// @nodoc
abstract mixin class _$ProductAttributesEntityCopyWith<$Res> implements $ProductAttributesEntityCopyWith<$Res> {
  factory _$ProductAttributesEntityCopyWith(_ProductAttributesEntity value, $Res Function(_ProductAttributesEntity) _then) = __$ProductAttributesEntityCopyWithImpl;
@override @useResult
$Res call({
 String? pollutionExpiryDate, String? insuranceExpiryDate, String? fitnessExpiryDate, String? permitDate, String? registrationNumber
});




}
/// @nodoc
class __$ProductAttributesEntityCopyWithImpl<$Res>
    implements _$ProductAttributesEntityCopyWith<$Res> {
  __$ProductAttributesEntityCopyWithImpl(this._self, this._then);

  final _ProductAttributesEntity _self;
  final $Res Function(_ProductAttributesEntity) _then;

/// Create a copy of ProductAttributesEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pollutionExpiryDate = freezed,Object? insuranceExpiryDate = freezed,Object? fitnessExpiryDate = freezed,Object? permitDate = freezed,Object? registrationNumber = freezed,}) {
  return _then(_ProductAttributesEntity(
pollutionExpiryDate: freezed == pollutionExpiryDate ? _self.pollutionExpiryDate : pollutionExpiryDate // ignore: cast_nullable_to_non_nullable
as String?,insuranceExpiryDate: freezed == insuranceExpiryDate ? _self.insuranceExpiryDate : insuranceExpiryDate // ignore: cast_nullable_to_non_nullable
as String?,fitnessExpiryDate: freezed == fitnessExpiryDate ? _self.fitnessExpiryDate : fitnessExpiryDate // ignore: cast_nullable_to_non_nullable
as String?,permitDate: freezed == permitDate ? _self.permitDate : permitDate // ignore: cast_nullable_to_non_nullable
as String?,registrationNumber: freezed == registrationNumber ? _self.registrationNumber : registrationNumber // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
