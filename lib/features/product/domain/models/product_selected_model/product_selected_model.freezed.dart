// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_selected_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProductSelectedModel {

 ProductInfoModel get variant; int get amount; List<MeasurementValueModel> get measurements; int get quantity; String? get runningKilometers;
/// Create a copy of ProductSelectedModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductSelectedModelCopyWith<ProductSelectedModel> get copyWith => _$ProductSelectedModelCopyWithImpl<ProductSelectedModel>(this as ProductSelectedModel, _$identity);

  /// Serializes this ProductSelectedModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductSelectedModel&&(identical(other.variant, variant) || other.variant == variant)&&(identical(other.amount, amount) || other.amount == amount)&&const DeepCollectionEquality().equals(other.measurements, measurements)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.runningKilometers, runningKilometers) || other.runningKilometers == runningKilometers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,variant,amount,const DeepCollectionEquality().hash(measurements),quantity,runningKilometers);

@override
String toString() {
  return 'ProductSelectedModel(variant: $variant, amount: $amount, measurements: $measurements, quantity: $quantity, runningKilometers: $runningKilometers)';
}


}

/// @nodoc
abstract mixin class $ProductSelectedModelCopyWith<$Res>  {
  factory $ProductSelectedModelCopyWith(ProductSelectedModel value, $Res Function(ProductSelectedModel) _then) = _$ProductSelectedModelCopyWithImpl;
@useResult
$Res call({
 ProductInfoModel variant, int amount, List<MeasurementValueModel> measurements, int quantity, String? runningKilometers
});


$ProductInfoModelCopyWith<$Res> get variant;

}
/// @nodoc
class _$ProductSelectedModelCopyWithImpl<$Res>
    implements $ProductSelectedModelCopyWith<$Res> {
  _$ProductSelectedModelCopyWithImpl(this._self, this._then);

  final ProductSelectedModel _self;
  final $Res Function(ProductSelectedModel) _then;

/// Create a copy of ProductSelectedModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? variant = null,Object? amount = null,Object? measurements = null,Object? quantity = null,Object? runningKilometers = freezed,}) {
  return _then(_self.copyWith(
variant: null == variant ? _self.variant : variant // ignore: cast_nullable_to_non_nullable
as ProductInfoModel,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,measurements: null == measurements ? _self.measurements : measurements // ignore: cast_nullable_to_non_nullable
as List<MeasurementValueModel>,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,runningKilometers: freezed == runningKilometers ? _self.runningKilometers : runningKilometers // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ProductSelectedModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProductInfoModelCopyWith<$Res> get variant {
  
  return $ProductInfoModelCopyWith<$Res>(_self.variant, (value) {
    return _then(_self.copyWith(variant: value));
  });
}
}


/// Adds pattern-matching-related methods to [ProductSelectedModel].
extension ProductSelectedModelPatterns on ProductSelectedModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductSelectedModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductSelectedModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductSelectedModel value)  $default,){
final _that = this;
switch (_that) {
case _ProductSelectedModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductSelectedModel value)?  $default,){
final _that = this;
switch (_that) {
case _ProductSelectedModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ProductInfoModel variant,  int amount,  List<MeasurementValueModel> measurements,  int quantity,  String? runningKilometers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductSelectedModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ProductInfoModel variant,  int amount,  List<MeasurementValueModel> measurements,  int quantity,  String? runningKilometers)  $default,) {final _that = this;
switch (_that) {
case _ProductSelectedModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ProductInfoModel variant,  int amount,  List<MeasurementValueModel> measurements,  int quantity,  String? runningKilometers)?  $default,) {final _that = this;
switch (_that) {
case _ProductSelectedModel() when $default != null:
return $default(_that.variant,_that.amount,_that.measurements,_that.quantity,_that.runningKilometers);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductSelectedModel implements ProductSelectedModel {
  const _ProductSelectedModel({required this.variant, required this.amount, final  List<MeasurementValueModel> measurements = const [], required this.quantity, this.runningKilometers}): _measurements = measurements;
  factory _ProductSelectedModel.fromJson(Map<String, dynamic> json) => _$ProductSelectedModelFromJson(json);

@override final  ProductInfoModel variant;
@override final  int amount;
 final  List<MeasurementValueModel> _measurements;
@override@JsonKey() List<MeasurementValueModel> get measurements {
  if (_measurements is EqualUnmodifiableListView) return _measurements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_measurements);
}

@override final  int quantity;
@override final  String? runningKilometers;

/// Create a copy of ProductSelectedModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductSelectedModelCopyWith<_ProductSelectedModel> get copyWith => __$ProductSelectedModelCopyWithImpl<_ProductSelectedModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductSelectedModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductSelectedModel&&(identical(other.variant, variant) || other.variant == variant)&&(identical(other.amount, amount) || other.amount == amount)&&const DeepCollectionEquality().equals(other._measurements, _measurements)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.runningKilometers, runningKilometers) || other.runningKilometers == runningKilometers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,variant,amount,const DeepCollectionEquality().hash(_measurements),quantity,runningKilometers);

@override
String toString() {
  return 'ProductSelectedModel(variant: $variant, amount: $amount, measurements: $measurements, quantity: $quantity, runningKilometers: $runningKilometers)';
}


}

/// @nodoc
abstract mixin class _$ProductSelectedModelCopyWith<$Res> implements $ProductSelectedModelCopyWith<$Res> {
  factory _$ProductSelectedModelCopyWith(_ProductSelectedModel value, $Res Function(_ProductSelectedModel) _then) = __$ProductSelectedModelCopyWithImpl;
@override @useResult
$Res call({
 ProductInfoModel variant, int amount, List<MeasurementValueModel> measurements, int quantity, String? runningKilometers
});


@override $ProductInfoModelCopyWith<$Res> get variant;

}
/// @nodoc
class __$ProductSelectedModelCopyWithImpl<$Res>
    implements _$ProductSelectedModelCopyWith<$Res> {
  __$ProductSelectedModelCopyWithImpl(this._self, this._then);

  final _ProductSelectedModel _self;
  final $Res Function(_ProductSelectedModel) _then;

/// Create a copy of ProductSelectedModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? variant = null,Object? amount = null,Object? measurements = null,Object? quantity = null,Object? runningKilometers = freezed,}) {
  return _then(_ProductSelectedModel(
variant: null == variant ? _self.variant : variant // ignore: cast_nullable_to_non_nullable
as ProductInfoModel,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,measurements: null == measurements ? _self._measurements : measurements // ignore: cast_nullable_to_non_nullable
as List<MeasurementValueModel>,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,runningKilometers: freezed == runningKilometers ? _self.runningKilometers : runningKilometers // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ProductSelectedModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProductInfoModelCopyWith<$Res> get variant {
  
  return $ProductInfoModelCopyWith<$Res>(_self.variant, (value) {
    return _then(_self.copyWith(variant: value));
  });
}
}

// dart format on
