// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tax_configuration_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TaxConfigurationRequestModel {

@JsonKey(name: 'tax_name', includeIfNull: false) String? get taxName;@JsonKey(name: 'tax_rate', includeIfNull: false) double? get taxRate;@JsonKey(name: 'is_enabled', includeIfNull: false) bool? get isEnabled;@JsonKey(name: 'taxable_components', fromJson: TaxableComponent.tryFromJsonList, toJson: TaxableComponent.tryToJsonList, includeIfNull: false) List<TaxableComponent>? get taxableComponents;@JsonKey(name: 'tax_calculation_type', fromJson: TaxCalculationType.tryFromJson, toJson: TaxCalculationType.tryToJson, includeIfNull: false) TaxCalculationType? get taxCalculationType;
/// Create a copy of TaxConfigurationRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaxConfigurationRequestModelCopyWith<TaxConfigurationRequestModel> get copyWith => _$TaxConfigurationRequestModelCopyWithImpl<TaxConfigurationRequestModel>(this as TaxConfigurationRequestModel, _$identity);

  /// Serializes this TaxConfigurationRequestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaxConfigurationRequestModel&&(identical(other.taxName, taxName) || other.taxName == taxName)&&(identical(other.taxRate, taxRate) || other.taxRate == taxRate)&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled)&&const DeepCollectionEquality().equals(other.taxableComponents, taxableComponents)&&(identical(other.taxCalculationType, taxCalculationType) || other.taxCalculationType == taxCalculationType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,taxName,taxRate,isEnabled,const DeepCollectionEquality().hash(taxableComponents),taxCalculationType);

@override
String toString() {
  return 'TaxConfigurationRequestModel(taxName: $taxName, taxRate: $taxRate, isEnabled: $isEnabled, taxableComponents: $taxableComponents, taxCalculationType: $taxCalculationType)';
}


}

/// @nodoc
abstract mixin class $TaxConfigurationRequestModelCopyWith<$Res>  {
  factory $TaxConfigurationRequestModelCopyWith(TaxConfigurationRequestModel value, $Res Function(TaxConfigurationRequestModel) _then) = _$TaxConfigurationRequestModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'tax_name', includeIfNull: false) String? taxName,@JsonKey(name: 'tax_rate', includeIfNull: false) double? taxRate,@JsonKey(name: 'is_enabled', includeIfNull: false) bool? isEnabled,@JsonKey(name: 'taxable_components', fromJson: TaxableComponent.tryFromJsonList, toJson: TaxableComponent.tryToJsonList, includeIfNull: false) List<TaxableComponent>? taxableComponents,@JsonKey(name: 'tax_calculation_type', fromJson: TaxCalculationType.tryFromJson, toJson: TaxCalculationType.tryToJson, includeIfNull: false) TaxCalculationType? taxCalculationType
});




}
/// @nodoc
class _$TaxConfigurationRequestModelCopyWithImpl<$Res>
    implements $TaxConfigurationRequestModelCopyWith<$Res> {
  _$TaxConfigurationRequestModelCopyWithImpl(this._self, this._then);

  final TaxConfigurationRequestModel _self;
  final $Res Function(TaxConfigurationRequestModel) _then;

/// Create a copy of TaxConfigurationRequestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? taxName = freezed,Object? taxRate = freezed,Object? isEnabled = freezed,Object? taxableComponents = freezed,Object? taxCalculationType = freezed,}) {
  return _then(_self.copyWith(
taxName: freezed == taxName ? _self.taxName : taxName // ignore: cast_nullable_to_non_nullable
as String?,taxRate: freezed == taxRate ? _self.taxRate : taxRate // ignore: cast_nullable_to_non_nullable
as double?,isEnabled: freezed == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool?,taxableComponents: freezed == taxableComponents ? _self.taxableComponents : taxableComponents // ignore: cast_nullable_to_non_nullable
as List<TaxableComponent>?,taxCalculationType: freezed == taxCalculationType ? _self.taxCalculationType : taxCalculationType // ignore: cast_nullable_to_non_nullable
as TaxCalculationType?,
  ));
}

}


/// Adds pattern-matching-related methods to [TaxConfigurationRequestModel].
extension TaxConfigurationRequestModelPatterns on TaxConfigurationRequestModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaxConfigurationRequestModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaxConfigurationRequestModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaxConfigurationRequestModel value)  $default,){
final _that = this;
switch (_that) {
case _TaxConfigurationRequestModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaxConfigurationRequestModel value)?  $default,){
final _that = this;
switch (_that) {
case _TaxConfigurationRequestModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'tax_name', includeIfNull: false)  String? taxName, @JsonKey(name: 'tax_rate', includeIfNull: false)  double? taxRate, @JsonKey(name: 'is_enabled', includeIfNull: false)  bool? isEnabled, @JsonKey(name: 'taxable_components', fromJson: TaxableComponent.tryFromJsonList, toJson: TaxableComponent.tryToJsonList, includeIfNull: false)  List<TaxableComponent>? taxableComponents, @JsonKey(name: 'tax_calculation_type', fromJson: TaxCalculationType.tryFromJson, toJson: TaxCalculationType.tryToJson, includeIfNull: false)  TaxCalculationType? taxCalculationType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaxConfigurationRequestModel() when $default != null:
return $default(_that.taxName,_that.taxRate,_that.isEnabled,_that.taxableComponents,_that.taxCalculationType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'tax_name', includeIfNull: false)  String? taxName, @JsonKey(name: 'tax_rate', includeIfNull: false)  double? taxRate, @JsonKey(name: 'is_enabled', includeIfNull: false)  bool? isEnabled, @JsonKey(name: 'taxable_components', fromJson: TaxableComponent.tryFromJsonList, toJson: TaxableComponent.tryToJsonList, includeIfNull: false)  List<TaxableComponent>? taxableComponents, @JsonKey(name: 'tax_calculation_type', fromJson: TaxCalculationType.tryFromJson, toJson: TaxCalculationType.tryToJson, includeIfNull: false)  TaxCalculationType? taxCalculationType)  $default,) {final _that = this;
switch (_that) {
case _TaxConfigurationRequestModel():
return $default(_that.taxName,_that.taxRate,_that.isEnabled,_that.taxableComponents,_that.taxCalculationType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'tax_name', includeIfNull: false)  String? taxName, @JsonKey(name: 'tax_rate', includeIfNull: false)  double? taxRate, @JsonKey(name: 'is_enabled', includeIfNull: false)  bool? isEnabled, @JsonKey(name: 'taxable_components', fromJson: TaxableComponent.tryFromJsonList, toJson: TaxableComponent.tryToJsonList, includeIfNull: false)  List<TaxableComponent>? taxableComponents, @JsonKey(name: 'tax_calculation_type', fromJson: TaxCalculationType.tryFromJson, toJson: TaxCalculationType.tryToJson, includeIfNull: false)  TaxCalculationType? taxCalculationType)?  $default,) {final _that = this;
switch (_that) {
case _TaxConfigurationRequestModel() when $default != null:
return $default(_that.taxName,_that.taxRate,_that.isEnabled,_that.taxableComponents,_that.taxCalculationType);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TaxConfigurationRequestModel implements TaxConfigurationRequestModel {
  const _TaxConfigurationRequestModel({@JsonKey(name: 'tax_name', includeIfNull: false) this.taxName, @JsonKey(name: 'tax_rate', includeIfNull: false) this.taxRate, @JsonKey(name: 'is_enabled', includeIfNull: false) this.isEnabled, @JsonKey(name: 'taxable_components', fromJson: TaxableComponent.tryFromJsonList, toJson: TaxableComponent.tryToJsonList, includeIfNull: false) final  List<TaxableComponent>? taxableComponents, @JsonKey(name: 'tax_calculation_type', fromJson: TaxCalculationType.tryFromJson, toJson: TaxCalculationType.tryToJson, includeIfNull: false) this.taxCalculationType}): _taxableComponents = taxableComponents;
  factory _TaxConfigurationRequestModel.fromJson(Map<String, dynamic> json) => _$TaxConfigurationRequestModelFromJson(json);

@override@JsonKey(name: 'tax_name', includeIfNull: false) final  String? taxName;
@override@JsonKey(name: 'tax_rate', includeIfNull: false) final  double? taxRate;
@override@JsonKey(name: 'is_enabled', includeIfNull: false) final  bool? isEnabled;
 final  List<TaxableComponent>? _taxableComponents;
@override@JsonKey(name: 'taxable_components', fromJson: TaxableComponent.tryFromJsonList, toJson: TaxableComponent.tryToJsonList, includeIfNull: false) List<TaxableComponent>? get taxableComponents {
  final value = _taxableComponents;
  if (value == null) return null;
  if (_taxableComponents is EqualUnmodifiableListView) return _taxableComponents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: 'tax_calculation_type', fromJson: TaxCalculationType.tryFromJson, toJson: TaxCalculationType.tryToJson, includeIfNull: false) final  TaxCalculationType? taxCalculationType;

/// Create a copy of TaxConfigurationRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaxConfigurationRequestModelCopyWith<_TaxConfigurationRequestModel> get copyWith => __$TaxConfigurationRequestModelCopyWithImpl<_TaxConfigurationRequestModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaxConfigurationRequestModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaxConfigurationRequestModel&&(identical(other.taxName, taxName) || other.taxName == taxName)&&(identical(other.taxRate, taxRate) || other.taxRate == taxRate)&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled)&&const DeepCollectionEquality().equals(other._taxableComponents, _taxableComponents)&&(identical(other.taxCalculationType, taxCalculationType) || other.taxCalculationType == taxCalculationType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,taxName,taxRate,isEnabled,const DeepCollectionEquality().hash(_taxableComponents),taxCalculationType);

@override
String toString() {
  return 'TaxConfigurationRequestModel(taxName: $taxName, taxRate: $taxRate, isEnabled: $isEnabled, taxableComponents: $taxableComponents, taxCalculationType: $taxCalculationType)';
}


}

/// @nodoc
abstract mixin class _$TaxConfigurationRequestModelCopyWith<$Res> implements $TaxConfigurationRequestModelCopyWith<$Res> {
  factory _$TaxConfigurationRequestModelCopyWith(_TaxConfigurationRequestModel value, $Res Function(_TaxConfigurationRequestModel) _then) = __$TaxConfigurationRequestModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'tax_name', includeIfNull: false) String? taxName,@JsonKey(name: 'tax_rate', includeIfNull: false) double? taxRate,@JsonKey(name: 'is_enabled', includeIfNull: false) bool? isEnabled,@JsonKey(name: 'taxable_components', fromJson: TaxableComponent.tryFromJsonList, toJson: TaxableComponent.tryToJsonList, includeIfNull: false) List<TaxableComponent>? taxableComponents,@JsonKey(name: 'tax_calculation_type', fromJson: TaxCalculationType.tryFromJson, toJson: TaxCalculationType.tryToJson, includeIfNull: false) TaxCalculationType? taxCalculationType
});




}
/// @nodoc
class __$TaxConfigurationRequestModelCopyWithImpl<$Res>
    implements _$TaxConfigurationRequestModelCopyWith<$Res> {
  __$TaxConfigurationRequestModelCopyWithImpl(this._self, this._then);

  final _TaxConfigurationRequestModel _self;
  final $Res Function(_TaxConfigurationRequestModel) _then;

/// Create a copy of TaxConfigurationRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? taxName = freezed,Object? taxRate = freezed,Object? isEnabled = freezed,Object? taxableComponents = freezed,Object? taxCalculationType = freezed,}) {
  return _then(_TaxConfigurationRequestModel(
taxName: freezed == taxName ? _self.taxName : taxName // ignore: cast_nullable_to_non_nullable
as String?,taxRate: freezed == taxRate ? _self.taxRate : taxRate // ignore: cast_nullable_to_non_nullable
as double?,isEnabled: freezed == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool?,taxableComponents: freezed == taxableComponents ? _self._taxableComponents : taxableComponents // ignore: cast_nullable_to_non_nullable
as List<TaxableComponent>?,taxCalculationType: freezed == taxCalculationType ? _self.taxCalculationType : taxCalculationType // ignore: cast_nullable_to_non_nullable
as TaxCalculationType?,
  ));
}


}

// dart format on
