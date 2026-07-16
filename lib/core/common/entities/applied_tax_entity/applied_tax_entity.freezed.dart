// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'applied_tax_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppliedTaxEntity {

 bool get isTaxApplied; String get taxName; double get taxRate; TaxCalculationType get taxCalculationType; List<TaxableComponent> get taxableComponents; double get subtotal; double get taxableAmount; double get taxAmount;
/// Create a copy of AppliedTaxEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppliedTaxEntityCopyWith<AppliedTaxEntity> get copyWith => _$AppliedTaxEntityCopyWithImpl<AppliedTaxEntity>(this as AppliedTaxEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppliedTaxEntity&&(identical(other.isTaxApplied, isTaxApplied) || other.isTaxApplied == isTaxApplied)&&(identical(other.taxName, taxName) || other.taxName == taxName)&&(identical(other.taxRate, taxRate) || other.taxRate == taxRate)&&(identical(other.taxCalculationType, taxCalculationType) || other.taxCalculationType == taxCalculationType)&&const DeepCollectionEquality().equals(other.taxableComponents, taxableComponents)&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal)&&(identical(other.taxableAmount, taxableAmount) || other.taxableAmount == taxableAmount)&&(identical(other.taxAmount, taxAmount) || other.taxAmount == taxAmount));
}


@override
int get hashCode => Object.hash(runtimeType,isTaxApplied,taxName,taxRate,taxCalculationType,const DeepCollectionEquality().hash(taxableComponents),subtotal,taxableAmount,taxAmount);

@override
String toString() {
  return 'AppliedTaxEntity(isTaxApplied: $isTaxApplied, taxName: $taxName, taxRate: $taxRate, taxCalculationType: $taxCalculationType, taxableComponents: $taxableComponents, subtotal: $subtotal, taxableAmount: $taxableAmount, taxAmount: $taxAmount)';
}


}

/// @nodoc
abstract mixin class $AppliedTaxEntityCopyWith<$Res>  {
  factory $AppliedTaxEntityCopyWith(AppliedTaxEntity value, $Res Function(AppliedTaxEntity) _then) = _$AppliedTaxEntityCopyWithImpl;
@useResult
$Res call({
 bool isTaxApplied, String taxName, double taxRate, TaxCalculationType taxCalculationType, List<TaxableComponent> taxableComponents, double subtotal, double taxableAmount, double taxAmount
});




}
/// @nodoc
class _$AppliedTaxEntityCopyWithImpl<$Res>
    implements $AppliedTaxEntityCopyWith<$Res> {
  _$AppliedTaxEntityCopyWithImpl(this._self, this._then);

  final AppliedTaxEntity _self;
  final $Res Function(AppliedTaxEntity) _then;

/// Create a copy of AppliedTaxEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isTaxApplied = null,Object? taxName = null,Object? taxRate = null,Object? taxCalculationType = null,Object? taxableComponents = null,Object? subtotal = null,Object? taxableAmount = null,Object? taxAmount = null,}) {
  return _then(_self.copyWith(
isTaxApplied: null == isTaxApplied ? _self.isTaxApplied : isTaxApplied // ignore: cast_nullable_to_non_nullable
as bool,taxName: null == taxName ? _self.taxName : taxName // ignore: cast_nullable_to_non_nullable
as String,taxRate: null == taxRate ? _self.taxRate : taxRate // ignore: cast_nullable_to_non_nullable
as double,taxCalculationType: null == taxCalculationType ? _self.taxCalculationType : taxCalculationType // ignore: cast_nullable_to_non_nullable
as TaxCalculationType,taxableComponents: null == taxableComponents ? _self.taxableComponents : taxableComponents // ignore: cast_nullable_to_non_nullable
as List<TaxableComponent>,subtotal: null == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as double,taxableAmount: null == taxableAmount ? _self.taxableAmount : taxableAmount // ignore: cast_nullable_to_non_nullable
as double,taxAmount: null == taxAmount ? _self.taxAmount : taxAmount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [AppliedTaxEntity].
extension AppliedTaxEntityPatterns on AppliedTaxEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppliedTaxEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppliedTaxEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppliedTaxEntity value)  $default,){
final _that = this;
switch (_that) {
case _AppliedTaxEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppliedTaxEntity value)?  $default,){
final _that = this;
switch (_that) {
case _AppliedTaxEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isTaxApplied,  String taxName,  double taxRate,  TaxCalculationType taxCalculationType,  List<TaxableComponent> taxableComponents,  double subtotal,  double taxableAmount,  double taxAmount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppliedTaxEntity() when $default != null:
return $default(_that.isTaxApplied,_that.taxName,_that.taxRate,_that.taxCalculationType,_that.taxableComponents,_that.subtotal,_that.taxableAmount,_that.taxAmount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isTaxApplied,  String taxName,  double taxRate,  TaxCalculationType taxCalculationType,  List<TaxableComponent> taxableComponents,  double subtotal,  double taxableAmount,  double taxAmount)  $default,) {final _that = this;
switch (_that) {
case _AppliedTaxEntity():
return $default(_that.isTaxApplied,_that.taxName,_that.taxRate,_that.taxCalculationType,_that.taxableComponents,_that.subtotal,_that.taxableAmount,_that.taxAmount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isTaxApplied,  String taxName,  double taxRate,  TaxCalculationType taxCalculationType,  List<TaxableComponent> taxableComponents,  double subtotal,  double taxableAmount,  double taxAmount)?  $default,) {final _that = this;
switch (_that) {
case _AppliedTaxEntity() when $default != null:
return $default(_that.isTaxApplied,_that.taxName,_that.taxRate,_that.taxCalculationType,_that.taxableComponents,_that.subtotal,_that.taxableAmount,_that.taxAmount);case _:
  return null;

}
}

}

/// @nodoc


class _AppliedTaxEntity implements AppliedTaxEntity {
  const _AppliedTaxEntity({required this.isTaxApplied, required this.taxName, required this.taxRate, required this.taxCalculationType, required final  List<TaxableComponent> taxableComponents, required this.subtotal, required this.taxableAmount, required this.taxAmount}): _taxableComponents = taxableComponents;
  

@override final  bool isTaxApplied;
@override final  String taxName;
@override final  double taxRate;
@override final  TaxCalculationType taxCalculationType;
 final  List<TaxableComponent> _taxableComponents;
@override List<TaxableComponent> get taxableComponents {
  if (_taxableComponents is EqualUnmodifiableListView) return _taxableComponents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_taxableComponents);
}

@override final  double subtotal;
@override final  double taxableAmount;
@override final  double taxAmount;

/// Create a copy of AppliedTaxEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppliedTaxEntityCopyWith<_AppliedTaxEntity> get copyWith => __$AppliedTaxEntityCopyWithImpl<_AppliedTaxEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppliedTaxEntity&&(identical(other.isTaxApplied, isTaxApplied) || other.isTaxApplied == isTaxApplied)&&(identical(other.taxName, taxName) || other.taxName == taxName)&&(identical(other.taxRate, taxRate) || other.taxRate == taxRate)&&(identical(other.taxCalculationType, taxCalculationType) || other.taxCalculationType == taxCalculationType)&&const DeepCollectionEquality().equals(other._taxableComponents, _taxableComponents)&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal)&&(identical(other.taxableAmount, taxableAmount) || other.taxableAmount == taxableAmount)&&(identical(other.taxAmount, taxAmount) || other.taxAmount == taxAmount));
}


@override
int get hashCode => Object.hash(runtimeType,isTaxApplied,taxName,taxRate,taxCalculationType,const DeepCollectionEquality().hash(_taxableComponents),subtotal,taxableAmount,taxAmount);

@override
String toString() {
  return 'AppliedTaxEntity(isTaxApplied: $isTaxApplied, taxName: $taxName, taxRate: $taxRate, taxCalculationType: $taxCalculationType, taxableComponents: $taxableComponents, subtotal: $subtotal, taxableAmount: $taxableAmount, taxAmount: $taxAmount)';
}


}

/// @nodoc
abstract mixin class _$AppliedTaxEntityCopyWith<$Res> implements $AppliedTaxEntityCopyWith<$Res> {
  factory _$AppliedTaxEntityCopyWith(_AppliedTaxEntity value, $Res Function(_AppliedTaxEntity) _then) = __$AppliedTaxEntityCopyWithImpl;
@override @useResult
$Res call({
 bool isTaxApplied, String taxName, double taxRate, TaxCalculationType taxCalculationType, List<TaxableComponent> taxableComponents, double subtotal, double taxableAmount, double taxAmount
});




}
/// @nodoc
class __$AppliedTaxEntityCopyWithImpl<$Res>
    implements _$AppliedTaxEntityCopyWith<$Res> {
  __$AppliedTaxEntityCopyWithImpl(this._self, this._then);

  final _AppliedTaxEntity _self;
  final $Res Function(_AppliedTaxEntity) _then;

/// Create a copy of AppliedTaxEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isTaxApplied = null,Object? taxName = null,Object? taxRate = null,Object? taxCalculationType = null,Object? taxableComponents = null,Object? subtotal = null,Object? taxableAmount = null,Object? taxAmount = null,}) {
  return _then(_AppliedTaxEntity(
isTaxApplied: null == isTaxApplied ? _self.isTaxApplied : isTaxApplied // ignore: cast_nullable_to_non_nullable
as bool,taxName: null == taxName ? _self.taxName : taxName // ignore: cast_nullable_to_non_nullable
as String,taxRate: null == taxRate ? _self.taxRate : taxRate // ignore: cast_nullable_to_non_nullable
as double,taxCalculationType: null == taxCalculationType ? _self.taxCalculationType : taxCalculationType // ignore: cast_nullable_to_non_nullable
as TaxCalculationType,taxableComponents: null == taxableComponents ? _self._taxableComponents : taxableComponents // ignore: cast_nullable_to_non_nullable
as List<TaxableComponent>,subtotal: null == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as double,taxableAmount: null == taxableAmount ? _self.taxableAmount : taxableAmount // ignore: cast_nullable_to_non_nullable
as double,taxAmount: null == taxAmount ? _self.taxAmount : taxAmount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
