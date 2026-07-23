// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tax_configuration_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TaxConfigurationModel {

 int get id;@JsonKey(name: 'tax_name') String get taxName;@JsonKey(name: 'tax_rate', fromJson: StringX.toDoubleFromString) double get taxRate;@JsonKey(name: 'is_enabled') bool get isEnabled;@JsonKey(name: 'taxable_components', fromJson: TaxableComponent.fromJsonList, toJson: TaxableComponent.toJsonList) List<TaxableComponent> get taxableComponents;@JsonKey(name: 'tax_calculation_type', fromJson: TaxCalculationType.fromJson, toJson: TaxCalculationType.toJson, defaultValue: TaxCalculationType.exclusive) TaxCalculationType get taxCalculationType;@JsonKey(name: 'created_at') String? get createdAt;@JsonKey(name: 'updated_at') String? get updatedAt;
/// Create a copy of TaxConfigurationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaxConfigurationModelCopyWith<TaxConfigurationModel> get copyWith => _$TaxConfigurationModelCopyWithImpl<TaxConfigurationModel>(this as TaxConfigurationModel, _$identity);

  /// Serializes this TaxConfigurationModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaxConfigurationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.taxName, taxName) || other.taxName == taxName)&&(identical(other.taxRate, taxRate) || other.taxRate == taxRate)&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled)&&const DeepCollectionEquality().equals(other.taxableComponents, taxableComponents)&&(identical(other.taxCalculationType, taxCalculationType) || other.taxCalculationType == taxCalculationType)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,taxName,taxRate,isEnabled,const DeepCollectionEquality().hash(taxableComponents),taxCalculationType,createdAt,updatedAt);

@override
String toString() {
  return 'TaxConfigurationModel(id: $id, taxName: $taxName, taxRate: $taxRate, isEnabled: $isEnabled, taxableComponents: $taxableComponents, taxCalculationType: $taxCalculationType, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $TaxConfigurationModelCopyWith<$Res>  {
  factory $TaxConfigurationModelCopyWith(TaxConfigurationModel value, $Res Function(TaxConfigurationModel) _then) = _$TaxConfigurationModelCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'tax_name') String taxName,@JsonKey(name: 'tax_rate', fromJson: StringX.toDoubleFromString) double taxRate,@JsonKey(name: 'is_enabled') bool isEnabled,@JsonKey(name: 'taxable_components', fromJson: TaxableComponent.fromJsonList, toJson: TaxableComponent.toJsonList) List<TaxableComponent> taxableComponents,@JsonKey(name: 'tax_calculation_type', fromJson: TaxCalculationType.fromJson, toJson: TaxCalculationType.toJson, defaultValue: TaxCalculationType.exclusive) TaxCalculationType taxCalculationType,@JsonKey(name: 'created_at') String? createdAt,@JsonKey(name: 'updated_at') String? updatedAt
});




}
/// @nodoc
class _$TaxConfigurationModelCopyWithImpl<$Res>
    implements $TaxConfigurationModelCopyWith<$Res> {
  _$TaxConfigurationModelCopyWithImpl(this._self, this._then);

  final TaxConfigurationModel _self;
  final $Res Function(TaxConfigurationModel) _then;

/// Create a copy of TaxConfigurationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? taxName = null,Object? taxRate = null,Object? isEnabled = null,Object? taxableComponents = null,Object? taxCalculationType = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,taxName: null == taxName ? _self.taxName : taxName // ignore: cast_nullable_to_non_nullable
as String,taxRate: null == taxRate ? _self.taxRate : taxRate // ignore: cast_nullable_to_non_nullable
as double,isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,taxableComponents: null == taxableComponents ? _self.taxableComponents : taxableComponents // ignore: cast_nullable_to_non_nullable
as List<TaxableComponent>,taxCalculationType: null == taxCalculationType ? _self.taxCalculationType : taxCalculationType // ignore: cast_nullable_to_non_nullable
as TaxCalculationType,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TaxConfigurationModel].
extension TaxConfigurationModelPatterns on TaxConfigurationModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaxConfigurationModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaxConfigurationModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaxConfigurationModel value)  $default,){
final _that = this;
switch (_that) {
case _TaxConfigurationModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaxConfigurationModel value)?  $default,){
final _that = this;
switch (_that) {
case _TaxConfigurationModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'tax_name')  String taxName, @JsonKey(name: 'tax_rate', fromJson: StringX.toDoubleFromString)  double taxRate, @JsonKey(name: 'is_enabled')  bool isEnabled, @JsonKey(name: 'taxable_components', fromJson: TaxableComponent.fromJsonList, toJson: TaxableComponent.toJsonList)  List<TaxableComponent> taxableComponents, @JsonKey(name: 'tax_calculation_type', fromJson: TaxCalculationType.fromJson, toJson: TaxCalculationType.toJson, defaultValue: TaxCalculationType.exclusive)  TaxCalculationType taxCalculationType, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'updated_at')  String? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaxConfigurationModel() when $default != null:
return $default(_that.id,_that.taxName,_that.taxRate,_that.isEnabled,_that.taxableComponents,_that.taxCalculationType,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'tax_name')  String taxName, @JsonKey(name: 'tax_rate', fromJson: StringX.toDoubleFromString)  double taxRate, @JsonKey(name: 'is_enabled')  bool isEnabled, @JsonKey(name: 'taxable_components', fromJson: TaxableComponent.fromJsonList, toJson: TaxableComponent.toJsonList)  List<TaxableComponent> taxableComponents, @JsonKey(name: 'tax_calculation_type', fromJson: TaxCalculationType.fromJson, toJson: TaxCalculationType.toJson, defaultValue: TaxCalculationType.exclusive)  TaxCalculationType taxCalculationType, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'updated_at')  String? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _TaxConfigurationModel():
return $default(_that.id,_that.taxName,_that.taxRate,_that.isEnabled,_that.taxableComponents,_that.taxCalculationType,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'tax_name')  String taxName, @JsonKey(name: 'tax_rate', fromJson: StringX.toDoubleFromString)  double taxRate, @JsonKey(name: 'is_enabled')  bool isEnabled, @JsonKey(name: 'taxable_components', fromJson: TaxableComponent.fromJsonList, toJson: TaxableComponent.toJsonList)  List<TaxableComponent> taxableComponents, @JsonKey(name: 'tax_calculation_type', fromJson: TaxCalculationType.fromJson, toJson: TaxCalculationType.toJson, defaultValue: TaxCalculationType.exclusive)  TaxCalculationType taxCalculationType, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'updated_at')  String? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _TaxConfigurationModel() when $default != null:
return $default(_that.id,_that.taxName,_that.taxRate,_that.isEnabled,_that.taxableComponents,_that.taxCalculationType,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TaxConfigurationModel implements TaxConfigurationModel {
  const _TaxConfigurationModel({required this.id, @JsonKey(name: 'tax_name') required this.taxName, @JsonKey(name: 'tax_rate', fromJson: StringX.toDoubleFromString) required this.taxRate, @JsonKey(name: 'is_enabled') required this.isEnabled, @JsonKey(name: 'taxable_components', fromJson: TaxableComponent.fromJsonList, toJson: TaxableComponent.toJsonList) required final  List<TaxableComponent> taxableComponents, @JsonKey(name: 'tax_calculation_type', fromJson: TaxCalculationType.fromJson, toJson: TaxCalculationType.toJson, defaultValue: TaxCalculationType.exclusive) required this.taxCalculationType, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt}): _taxableComponents = taxableComponents;
  factory _TaxConfigurationModel.fromJson(Map<String, dynamic> json) => _$TaxConfigurationModelFromJson(json);

@override final  int id;
@override@JsonKey(name: 'tax_name') final  String taxName;
@override@JsonKey(name: 'tax_rate', fromJson: StringX.toDoubleFromString) final  double taxRate;
@override@JsonKey(name: 'is_enabled') final  bool isEnabled;
 final  List<TaxableComponent> _taxableComponents;
@override@JsonKey(name: 'taxable_components', fromJson: TaxableComponent.fromJsonList, toJson: TaxableComponent.toJsonList) List<TaxableComponent> get taxableComponents {
  if (_taxableComponents is EqualUnmodifiableListView) return _taxableComponents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_taxableComponents);
}

@override@JsonKey(name: 'tax_calculation_type', fromJson: TaxCalculationType.fromJson, toJson: TaxCalculationType.toJson, defaultValue: TaxCalculationType.exclusive) final  TaxCalculationType taxCalculationType;
@override@JsonKey(name: 'created_at') final  String? createdAt;
@override@JsonKey(name: 'updated_at') final  String? updatedAt;

/// Create a copy of TaxConfigurationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaxConfigurationModelCopyWith<_TaxConfigurationModel> get copyWith => __$TaxConfigurationModelCopyWithImpl<_TaxConfigurationModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaxConfigurationModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaxConfigurationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.taxName, taxName) || other.taxName == taxName)&&(identical(other.taxRate, taxRate) || other.taxRate == taxRate)&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled)&&const DeepCollectionEquality().equals(other._taxableComponents, _taxableComponents)&&(identical(other.taxCalculationType, taxCalculationType) || other.taxCalculationType == taxCalculationType)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,taxName,taxRate,isEnabled,const DeepCollectionEquality().hash(_taxableComponents),taxCalculationType,createdAt,updatedAt);

@override
String toString() {
  return 'TaxConfigurationModel(id: $id, taxName: $taxName, taxRate: $taxRate, isEnabled: $isEnabled, taxableComponents: $taxableComponents, taxCalculationType: $taxCalculationType, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$TaxConfigurationModelCopyWith<$Res> implements $TaxConfigurationModelCopyWith<$Res> {
  factory _$TaxConfigurationModelCopyWith(_TaxConfigurationModel value, $Res Function(_TaxConfigurationModel) _then) = __$TaxConfigurationModelCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'tax_name') String taxName,@JsonKey(name: 'tax_rate', fromJson: StringX.toDoubleFromString) double taxRate,@JsonKey(name: 'is_enabled') bool isEnabled,@JsonKey(name: 'taxable_components', fromJson: TaxableComponent.fromJsonList, toJson: TaxableComponent.toJsonList) List<TaxableComponent> taxableComponents,@JsonKey(name: 'tax_calculation_type', fromJson: TaxCalculationType.fromJson, toJson: TaxCalculationType.toJson, defaultValue: TaxCalculationType.exclusive) TaxCalculationType taxCalculationType,@JsonKey(name: 'created_at') String? createdAt,@JsonKey(name: 'updated_at') String? updatedAt
});




}
/// @nodoc
class __$TaxConfigurationModelCopyWithImpl<$Res>
    implements _$TaxConfigurationModelCopyWith<$Res> {
  __$TaxConfigurationModelCopyWithImpl(this._self, this._then);

  final _TaxConfigurationModel _self;
  final $Res Function(_TaxConfigurationModel) _then;

/// Create a copy of TaxConfigurationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? taxName = null,Object? taxRate = null,Object? isEnabled = null,Object? taxableComponents = null,Object? taxCalculationType = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_TaxConfigurationModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,taxName: null == taxName ? _self.taxName : taxName // ignore: cast_nullable_to_non_nullable
as String,taxRate: null == taxRate ? _self.taxRate : taxRate // ignore: cast_nullable_to_non_nullable
as double,isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,taxableComponents: null == taxableComponents ? _self._taxableComponents : taxableComponents // ignore: cast_nullable_to_non_nullable
as List<TaxableComponent>,taxCalculationType: null == taxCalculationType ? _self.taxCalculationType : taxCalculationType // ignore: cast_nullable_to_non_nullable
as TaxCalculationType,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
