// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'applied_tax_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppliedTaxModel {

@JsonKey(name: 'is_tax_applied', defaultValue: false) bool get isTaxApplied;@JsonKey(name: 'tax_name', defaultValue: '') String get taxName;@JsonKey(name: 'tax_rate', defaultValue: 0.0) double get taxRate;@JsonKey(name: 'tax_calculation_type', fromJson: TaxCalculationType.fromJson, toJson: TaxCalculationType.toJson, defaultValue: TaxCalculationType.exclusive) TaxCalculationType get taxCalculationType;@JsonKey(name: 'taxable_components', fromJson: TaxableComponent.fromJsonList, toJson: TaxableComponent.toJsonList, defaultValue: <TaxableComponent>[]) List<TaxableComponent> get taxableComponents;@JsonKey(name: 'subtotal', defaultValue: 0.0) double get subtotal;@JsonKey(name: 'taxable_amount', defaultValue: 0.0) double get taxableAmount;@JsonKey(name: 'tax_amount', defaultValue: 0.0) double get taxAmount;
/// Create a copy of AppliedTaxModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppliedTaxModelCopyWith<AppliedTaxModel> get copyWith => _$AppliedTaxModelCopyWithImpl<AppliedTaxModel>(this as AppliedTaxModel, _$identity);

  /// Serializes this AppliedTaxModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppliedTaxModel&&(identical(other.isTaxApplied, isTaxApplied) || other.isTaxApplied == isTaxApplied)&&(identical(other.taxName, taxName) || other.taxName == taxName)&&(identical(other.taxRate, taxRate) || other.taxRate == taxRate)&&(identical(other.taxCalculationType, taxCalculationType) || other.taxCalculationType == taxCalculationType)&&const DeepCollectionEquality().equals(other.taxableComponents, taxableComponents)&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal)&&(identical(other.taxableAmount, taxableAmount) || other.taxableAmount == taxableAmount)&&(identical(other.taxAmount, taxAmount) || other.taxAmount == taxAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isTaxApplied,taxName,taxRate,taxCalculationType,const DeepCollectionEquality().hash(taxableComponents),subtotal,taxableAmount,taxAmount);

@override
String toString() {
  return 'AppliedTaxModel(isTaxApplied: $isTaxApplied, taxName: $taxName, taxRate: $taxRate, taxCalculationType: $taxCalculationType, taxableComponents: $taxableComponents, subtotal: $subtotal, taxableAmount: $taxableAmount, taxAmount: $taxAmount)';
}


}

/// @nodoc
abstract mixin class $AppliedTaxModelCopyWith<$Res>  {
  factory $AppliedTaxModelCopyWith(AppliedTaxModel value, $Res Function(AppliedTaxModel) _then) = _$AppliedTaxModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'is_tax_applied', defaultValue: false) bool isTaxApplied,@JsonKey(name: 'tax_name', defaultValue: '') String taxName,@JsonKey(name: 'tax_rate', defaultValue: 0.0) double taxRate,@JsonKey(name: 'tax_calculation_type', fromJson: TaxCalculationType.fromJson, toJson: TaxCalculationType.toJson, defaultValue: TaxCalculationType.exclusive) TaxCalculationType taxCalculationType,@JsonKey(name: 'taxable_components', fromJson: TaxableComponent.fromJsonList, toJson: TaxableComponent.toJsonList, defaultValue: <TaxableComponent>[]) List<TaxableComponent> taxableComponents,@JsonKey(name: 'subtotal', defaultValue: 0.0) double subtotal,@JsonKey(name: 'taxable_amount', defaultValue: 0.0) double taxableAmount,@JsonKey(name: 'tax_amount', defaultValue: 0.0) double taxAmount
});




}
/// @nodoc
class _$AppliedTaxModelCopyWithImpl<$Res>
    implements $AppliedTaxModelCopyWith<$Res> {
  _$AppliedTaxModelCopyWithImpl(this._self, this._then);

  final AppliedTaxModel _self;
  final $Res Function(AppliedTaxModel) _then;

/// Create a copy of AppliedTaxModel
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


/// Adds pattern-matching-related methods to [AppliedTaxModel].
extension AppliedTaxModelPatterns on AppliedTaxModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppliedTaxModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppliedTaxModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppliedTaxModel value)  $default,){
final _that = this;
switch (_that) {
case _AppliedTaxModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppliedTaxModel value)?  $default,){
final _that = this;
switch (_that) {
case _AppliedTaxModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'is_tax_applied', defaultValue: false)  bool isTaxApplied, @JsonKey(name: 'tax_name', defaultValue: '')  String taxName, @JsonKey(name: 'tax_rate', defaultValue: 0.0)  double taxRate, @JsonKey(name: 'tax_calculation_type', fromJson: TaxCalculationType.fromJson, toJson: TaxCalculationType.toJson, defaultValue: TaxCalculationType.exclusive)  TaxCalculationType taxCalculationType, @JsonKey(name: 'taxable_components', fromJson: TaxableComponent.fromJsonList, toJson: TaxableComponent.toJsonList, defaultValue: <TaxableComponent>[])  List<TaxableComponent> taxableComponents, @JsonKey(name: 'subtotal', defaultValue: 0.0)  double subtotal, @JsonKey(name: 'taxable_amount', defaultValue: 0.0)  double taxableAmount, @JsonKey(name: 'tax_amount', defaultValue: 0.0)  double taxAmount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppliedTaxModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'is_tax_applied', defaultValue: false)  bool isTaxApplied, @JsonKey(name: 'tax_name', defaultValue: '')  String taxName, @JsonKey(name: 'tax_rate', defaultValue: 0.0)  double taxRate, @JsonKey(name: 'tax_calculation_type', fromJson: TaxCalculationType.fromJson, toJson: TaxCalculationType.toJson, defaultValue: TaxCalculationType.exclusive)  TaxCalculationType taxCalculationType, @JsonKey(name: 'taxable_components', fromJson: TaxableComponent.fromJsonList, toJson: TaxableComponent.toJsonList, defaultValue: <TaxableComponent>[])  List<TaxableComponent> taxableComponents, @JsonKey(name: 'subtotal', defaultValue: 0.0)  double subtotal, @JsonKey(name: 'taxable_amount', defaultValue: 0.0)  double taxableAmount, @JsonKey(name: 'tax_amount', defaultValue: 0.0)  double taxAmount)  $default,) {final _that = this;
switch (_that) {
case _AppliedTaxModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'is_tax_applied', defaultValue: false)  bool isTaxApplied, @JsonKey(name: 'tax_name', defaultValue: '')  String taxName, @JsonKey(name: 'tax_rate', defaultValue: 0.0)  double taxRate, @JsonKey(name: 'tax_calculation_type', fromJson: TaxCalculationType.fromJson, toJson: TaxCalculationType.toJson, defaultValue: TaxCalculationType.exclusive)  TaxCalculationType taxCalculationType, @JsonKey(name: 'taxable_components', fromJson: TaxableComponent.fromJsonList, toJson: TaxableComponent.toJsonList, defaultValue: <TaxableComponent>[])  List<TaxableComponent> taxableComponents, @JsonKey(name: 'subtotal', defaultValue: 0.0)  double subtotal, @JsonKey(name: 'taxable_amount', defaultValue: 0.0)  double taxableAmount, @JsonKey(name: 'tax_amount', defaultValue: 0.0)  double taxAmount)?  $default,) {final _that = this;
switch (_that) {
case _AppliedTaxModel() when $default != null:
return $default(_that.isTaxApplied,_that.taxName,_that.taxRate,_that.taxCalculationType,_that.taxableComponents,_that.subtotal,_that.taxableAmount,_that.taxAmount);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _AppliedTaxModel implements AppliedTaxModel {
  const _AppliedTaxModel({@JsonKey(name: 'is_tax_applied', defaultValue: false) required this.isTaxApplied, @JsonKey(name: 'tax_name', defaultValue: '') required this.taxName, @JsonKey(name: 'tax_rate', defaultValue: 0.0) required this.taxRate, @JsonKey(name: 'tax_calculation_type', fromJson: TaxCalculationType.fromJson, toJson: TaxCalculationType.toJson, defaultValue: TaxCalculationType.exclusive) required this.taxCalculationType, @JsonKey(name: 'taxable_components', fromJson: TaxableComponent.fromJsonList, toJson: TaxableComponent.toJsonList, defaultValue: <TaxableComponent>[]) required final  List<TaxableComponent> taxableComponents, @JsonKey(name: 'subtotal', defaultValue: 0.0) required this.subtotal, @JsonKey(name: 'taxable_amount', defaultValue: 0.0) required this.taxableAmount, @JsonKey(name: 'tax_amount', defaultValue: 0.0) required this.taxAmount}): _taxableComponents = taxableComponents;
  factory _AppliedTaxModel.fromJson(Map<String, dynamic> json) => _$AppliedTaxModelFromJson(json);

@override@JsonKey(name: 'is_tax_applied', defaultValue: false) final  bool isTaxApplied;
@override@JsonKey(name: 'tax_name', defaultValue: '') final  String taxName;
@override@JsonKey(name: 'tax_rate', defaultValue: 0.0) final  double taxRate;
@override@JsonKey(name: 'tax_calculation_type', fromJson: TaxCalculationType.fromJson, toJson: TaxCalculationType.toJson, defaultValue: TaxCalculationType.exclusive) final  TaxCalculationType taxCalculationType;
 final  List<TaxableComponent> _taxableComponents;
@override@JsonKey(name: 'taxable_components', fromJson: TaxableComponent.fromJsonList, toJson: TaxableComponent.toJsonList, defaultValue: <TaxableComponent>[]) List<TaxableComponent> get taxableComponents {
  if (_taxableComponents is EqualUnmodifiableListView) return _taxableComponents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_taxableComponents);
}

@override@JsonKey(name: 'subtotal', defaultValue: 0.0) final  double subtotal;
@override@JsonKey(name: 'taxable_amount', defaultValue: 0.0) final  double taxableAmount;
@override@JsonKey(name: 'tax_amount', defaultValue: 0.0) final  double taxAmount;

/// Create a copy of AppliedTaxModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppliedTaxModelCopyWith<_AppliedTaxModel> get copyWith => __$AppliedTaxModelCopyWithImpl<_AppliedTaxModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppliedTaxModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppliedTaxModel&&(identical(other.isTaxApplied, isTaxApplied) || other.isTaxApplied == isTaxApplied)&&(identical(other.taxName, taxName) || other.taxName == taxName)&&(identical(other.taxRate, taxRate) || other.taxRate == taxRate)&&(identical(other.taxCalculationType, taxCalculationType) || other.taxCalculationType == taxCalculationType)&&const DeepCollectionEquality().equals(other._taxableComponents, _taxableComponents)&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal)&&(identical(other.taxableAmount, taxableAmount) || other.taxableAmount == taxableAmount)&&(identical(other.taxAmount, taxAmount) || other.taxAmount == taxAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isTaxApplied,taxName,taxRate,taxCalculationType,const DeepCollectionEquality().hash(_taxableComponents),subtotal,taxableAmount,taxAmount);

@override
String toString() {
  return 'AppliedTaxModel(isTaxApplied: $isTaxApplied, taxName: $taxName, taxRate: $taxRate, taxCalculationType: $taxCalculationType, taxableComponents: $taxableComponents, subtotal: $subtotal, taxableAmount: $taxableAmount, taxAmount: $taxAmount)';
}


}

/// @nodoc
abstract mixin class _$AppliedTaxModelCopyWith<$Res> implements $AppliedTaxModelCopyWith<$Res> {
  factory _$AppliedTaxModelCopyWith(_AppliedTaxModel value, $Res Function(_AppliedTaxModel) _then) = __$AppliedTaxModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'is_tax_applied', defaultValue: false) bool isTaxApplied,@JsonKey(name: 'tax_name', defaultValue: '') String taxName,@JsonKey(name: 'tax_rate', defaultValue: 0.0) double taxRate,@JsonKey(name: 'tax_calculation_type', fromJson: TaxCalculationType.fromJson, toJson: TaxCalculationType.toJson, defaultValue: TaxCalculationType.exclusive) TaxCalculationType taxCalculationType,@JsonKey(name: 'taxable_components', fromJson: TaxableComponent.fromJsonList, toJson: TaxableComponent.toJsonList, defaultValue: <TaxableComponent>[]) List<TaxableComponent> taxableComponents,@JsonKey(name: 'subtotal', defaultValue: 0.0) double subtotal,@JsonKey(name: 'taxable_amount', defaultValue: 0.0) double taxableAmount,@JsonKey(name: 'tax_amount', defaultValue: 0.0) double taxAmount
});




}
/// @nodoc
class __$AppliedTaxModelCopyWithImpl<$Res>
    implements _$AppliedTaxModelCopyWith<$Res> {
  __$AppliedTaxModelCopyWithImpl(this._self, this._then);

  final _AppliedTaxModel _self;
  final $Res Function(_AppliedTaxModel) _then;

/// Create a copy of AppliedTaxModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isTaxApplied = null,Object? taxName = null,Object? taxRate = null,Object? taxCalculationType = null,Object? taxableComponents = null,Object? subtotal = null,Object? taxableAmount = null,Object? taxAmount = null,}) {
  return _then(_AppliedTaxModel(
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
