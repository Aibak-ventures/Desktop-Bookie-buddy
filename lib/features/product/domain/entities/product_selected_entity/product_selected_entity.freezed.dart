// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_selected_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductSelectedEntity {

 ProductInfoEntity get variant; int get amount; List<MeasurementValueEntity> get measurements; int get quantity; String? get runningKilometers;
/// Create a copy of ProductSelectedEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductSelectedEntityCopyWith<ProductSelectedEntity> get copyWith => _$ProductSelectedEntityCopyWithImpl<ProductSelectedEntity>(this as ProductSelectedEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductSelectedEntity&&(identical(other.variant, variant) || other.variant == variant)&&(identical(other.amount, amount) || other.amount == amount)&&const DeepCollectionEquality().equals(other.measurements, measurements)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.runningKilometers, runningKilometers) || other.runningKilometers == runningKilometers));
}


@override
int get hashCode => Object.hash(runtimeType,variant,amount,const DeepCollectionEquality().hash(measurements),quantity,runningKilometers);

@override
String toString() {
  return 'ProductSelectedEntity(variant: $variant, amount: $amount, measurements: $measurements, quantity: $quantity, runningKilometers: $runningKilometers)';
}


}

/// @nodoc
abstract mixin class $ProductSelectedEntityCopyWith<$Res>  {
  factory $ProductSelectedEntityCopyWith(ProductSelectedEntity value, $Res Function(ProductSelectedEntity) _then) = _$ProductSelectedEntityCopyWithImpl;
@useResult
$Res call({
 ProductInfoEntity variant, int amount, List<MeasurementValueEntity> measurements, int quantity, String? runningKilometers
});


$ProductInfoEntityCopyWith<$Res> get variant;

}
/// @nodoc
class _$ProductSelectedEntityCopyWithImpl<$Res>
    implements $ProductSelectedEntityCopyWith<$Res> {
  _$ProductSelectedEntityCopyWithImpl(this._self, this._then);

  final ProductSelectedEntity _self;
  final $Res Function(ProductSelectedEntity) _then;

/// Create a copy of ProductSelectedEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? variant = null,Object? amount = null,Object? measurements = null,Object? quantity = null,Object? runningKilometers = freezed,}) {
  return _then(_self.copyWith(
variant: null == variant ? _self.variant : variant // ignore: cast_nullable_to_non_nullable
as ProductInfoEntity,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,measurements: null == measurements ? _self.measurements : measurements // ignore: cast_nullable_to_non_nullable
as List<MeasurementValueEntity>,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,runningKilometers: freezed == runningKilometers ? _self.runningKilometers : runningKilometers // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ProductSelectedEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProductInfoEntityCopyWith<$Res> get variant {
  
  return $ProductInfoEntityCopyWith<$Res>(_self.variant, (value) {
    return _then(_self.copyWith(variant: value));
  });
}
}


/// Adds pattern-matching-related methods to [ProductSelectedEntity].
extension ProductSelectedEntityPatterns on ProductSelectedEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductSelectedEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductSelectedEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductSelectedEntity value)  $default,){
final _that = this;
switch (_that) {
case _ProductSelectedEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductSelectedEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ProductSelectedEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ProductInfoEntity variant,  int amount,  List<MeasurementValueEntity> measurements,  int quantity,  String? runningKilometers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductSelectedEntity() when $default != null:
return $default(_that.variant,_that.amount,_that.measurements,_that.quantity,_that.runningKilometers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ProductInfoEntity variant,  int amount,  List<MeasurementValueEntity> measurements,  int quantity,  String? runningKilometers)  $default,) {final _that = this;
switch (_that) {
case _ProductSelectedEntity():
return $default(_that.variant,_that.amount,_that.measurements,_that.quantity,_that.runningKilometers);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ProductInfoEntity variant,  int amount,  List<MeasurementValueEntity> measurements,  int quantity,  String? runningKilometers)?  $default,) {final _that = this;
switch (_that) {
case _ProductSelectedEntity() when $default != null:
return $default(_that.variant,_that.amount,_that.measurements,_that.quantity,_that.runningKilometers);case _:
  return null;

}
}

}

/// @nodoc


class _ProductSelectedEntity implements ProductSelectedEntity {
  const _ProductSelectedEntity({required this.variant, required this.amount, final  List<MeasurementValueEntity> measurements = const [], required this.quantity, this.runningKilometers}): _measurements = measurements;
  

@override final  ProductInfoEntity variant;
@override final  int amount;
 final  List<MeasurementValueEntity> _measurements;
@override@JsonKey() List<MeasurementValueEntity> get measurements {
  if (_measurements is EqualUnmodifiableListView) return _measurements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_measurements);
}

@override final  int quantity;
@override final  String? runningKilometers;

/// Create a copy of ProductSelectedEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductSelectedEntityCopyWith<_ProductSelectedEntity> get copyWith => __$ProductSelectedEntityCopyWithImpl<_ProductSelectedEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductSelectedEntity&&(identical(other.variant, variant) || other.variant == variant)&&(identical(other.amount, amount) || other.amount == amount)&&const DeepCollectionEquality().equals(other._measurements, _measurements)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.runningKilometers, runningKilometers) || other.runningKilometers == runningKilometers));
}


@override
int get hashCode => Object.hash(runtimeType,variant,amount,const DeepCollectionEquality().hash(_measurements),quantity,runningKilometers);

@override
String toString() {
  return 'ProductSelectedEntity(variant: $variant, amount: $amount, measurements: $measurements, quantity: $quantity, runningKilometers: $runningKilometers)';
}


}

/// @nodoc
abstract mixin class _$ProductSelectedEntityCopyWith<$Res> implements $ProductSelectedEntityCopyWith<$Res> {
  factory _$ProductSelectedEntityCopyWith(_ProductSelectedEntity value, $Res Function(_ProductSelectedEntity) _then) = __$ProductSelectedEntityCopyWithImpl;
@override @useResult
$Res call({
 ProductInfoEntity variant, int amount, List<MeasurementValueEntity> measurements, int quantity, String? runningKilometers
});


@override $ProductInfoEntityCopyWith<$Res> get variant;

}
/// @nodoc
class __$ProductSelectedEntityCopyWithImpl<$Res>
    implements _$ProductSelectedEntityCopyWith<$Res> {
  __$ProductSelectedEntityCopyWithImpl(this._self, this._then);

  final _ProductSelectedEntity _self;
  final $Res Function(_ProductSelectedEntity) _then;

/// Create a copy of ProductSelectedEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? variant = null,Object? amount = null,Object? measurements = null,Object? quantity = null,Object? runningKilometers = freezed,}) {
  return _then(_ProductSelectedEntity(
variant: null == variant ? _self.variant : variant // ignore: cast_nullable_to_non_nullable
as ProductInfoEntity,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,measurements: null == measurements ? _self._measurements : measurements // ignore: cast_nullable_to_non_nullable
as List<MeasurementValueEntity>,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,runningKilometers: freezed == runningKilometers ? _self.runningKilometers : runningKilometers // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ProductSelectedEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProductInfoEntityCopyWith<$Res> get variant {
  
  return $ProductInfoEntityCopyWith<$Res>(_self.variant, (value) {
    return _then(_self.copyWith(variant: value));
  });
}
}

// dart format on
