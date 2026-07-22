// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tax_configuration_request_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TaxConfigurationRequestEntity {

 String? get taxName; double? get taxRate; bool? get isEnabled; List<TaxableComponent>? get taxableComponents; TaxCalculationType? get taxCalculationType;
/// Create a copy of TaxConfigurationRequestEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaxConfigurationRequestEntityCopyWith<TaxConfigurationRequestEntity> get copyWith => _$TaxConfigurationRequestEntityCopyWithImpl<TaxConfigurationRequestEntity>(this as TaxConfigurationRequestEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaxConfigurationRequestEntity&&(identical(other.taxName, taxName) || other.taxName == taxName)&&(identical(other.taxRate, taxRate) || other.taxRate == taxRate)&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled)&&const DeepCollectionEquality().equals(other.taxableComponents, taxableComponents)&&(identical(other.taxCalculationType, taxCalculationType) || other.taxCalculationType == taxCalculationType));
}


@override
int get hashCode => Object.hash(runtimeType,taxName,taxRate,isEnabled,const DeepCollectionEquality().hash(taxableComponents),taxCalculationType);

@override
String toString() {
  return 'TaxConfigurationRequestEntity(taxName: $taxName, taxRate: $taxRate, isEnabled: $isEnabled, taxableComponents: $taxableComponents, taxCalculationType: $taxCalculationType)';
}


}

/// @nodoc
abstract mixin class $TaxConfigurationRequestEntityCopyWith<$Res>  {
  factory $TaxConfigurationRequestEntityCopyWith(TaxConfigurationRequestEntity value, $Res Function(TaxConfigurationRequestEntity) _then) = _$TaxConfigurationRequestEntityCopyWithImpl;
@useResult
$Res call({
 String? taxName, double? taxRate, bool? isEnabled, List<TaxableComponent>? taxableComponents, TaxCalculationType? taxCalculationType
});




}
/// @nodoc
class _$TaxConfigurationRequestEntityCopyWithImpl<$Res>
    implements $TaxConfigurationRequestEntityCopyWith<$Res> {
  _$TaxConfigurationRequestEntityCopyWithImpl(this._self, this._then);

  final TaxConfigurationRequestEntity _self;
  final $Res Function(TaxConfigurationRequestEntity) _then;

/// Create a copy of TaxConfigurationRequestEntity
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


/// Adds pattern-matching-related methods to [TaxConfigurationRequestEntity].
extension TaxConfigurationRequestEntityPatterns on TaxConfigurationRequestEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaxConfigurationRequestEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaxConfigurationRequestEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaxConfigurationRequestEntity value)  $default,){
final _that = this;
switch (_that) {
case _TaxConfigurationRequestEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaxConfigurationRequestEntity value)?  $default,){
final _that = this;
switch (_that) {
case _TaxConfigurationRequestEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? taxName,  double? taxRate,  bool? isEnabled,  List<TaxableComponent>? taxableComponents,  TaxCalculationType? taxCalculationType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaxConfigurationRequestEntity() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? taxName,  double? taxRate,  bool? isEnabled,  List<TaxableComponent>? taxableComponents,  TaxCalculationType? taxCalculationType)  $default,) {final _that = this;
switch (_that) {
case _TaxConfigurationRequestEntity():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? taxName,  double? taxRate,  bool? isEnabled,  List<TaxableComponent>? taxableComponents,  TaxCalculationType? taxCalculationType)?  $default,) {final _that = this;
switch (_that) {
case _TaxConfigurationRequestEntity() when $default != null:
return $default(_that.taxName,_that.taxRate,_that.isEnabled,_that.taxableComponents,_that.taxCalculationType);case _:
  return null;

}
}

}

/// @nodoc


class _TaxConfigurationRequestEntity implements TaxConfigurationRequestEntity {
  const _TaxConfigurationRequestEntity({this.taxName, this.taxRate, this.isEnabled, final  List<TaxableComponent>? taxableComponents, this.taxCalculationType}): _taxableComponents = taxableComponents;
  

@override final  String? taxName;
@override final  double? taxRate;
@override final  bool? isEnabled;
 final  List<TaxableComponent>? _taxableComponents;
@override List<TaxableComponent>? get taxableComponents {
  final value = _taxableComponents;
  if (value == null) return null;
  if (_taxableComponents is EqualUnmodifiableListView) return _taxableComponents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  TaxCalculationType? taxCalculationType;

/// Create a copy of TaxConfigurationRequestEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaxConfigurationRequestEntityCopyWith<_TaxConfigurationRequestEntity> get copyWith => __$TaxConfigurationRequestEntityCopyWithImpl<_TaxConfigurationRequestEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaxConfigurationRequestEntity&&(identical(other.taxName, taxName) || other.taxName == taxName)&&(identical(other.taxRate, taxRate) || other.taxRate == taxRate)&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled)&&const DeepCollectionEquality().equals(other._taxableComponents, _taxableComponents)&&(identical(other.taxCalculationType, taxCalculationType) || other.taxCalculationType == taxCalculationType));
}


@override
int get hashCode => Object.hash(runtimeType,taxName,taxRate,isEnabled,const DeepCollectionEquality().hash(_taxableComponents),taxCalculationType);

@override
String toString() {
  return 'TaxConfigurationRequestEntity(taxName: $taxName, taxRate: $taxRate, isEnabled: $isEnabled, taxableComponents: $taxableComponents, taxCalculationType: $taxCalculationType)';
}


}

/// @nodoc
abstract mixin class _$TaxConfigurationRequestEntityCopyWith<$Res> implements $TaxConfigurationRequestEntityCopyWith<$Res> {
  factory _$TaxConfigurationRequestEntityCopyWith(_TaxConfigurationRequestEntity value, $Res Function(_TaxConfigurationRequestEntity) _then) = __$TaxConfigurationRequestEntityCopyWithImpl;
@override @useResult
$Res call({
 String? taxName, double? taxRate, bool? isEnabled, List<TaxableComponent>? taxableComponents, TaxCalculationType? taxCalculationType
});




}
/// @nodoc
class __$TaxConfigurationRequestEntityCopyWithImpl<$Res>
    implements _$TaxConfigurationRequestEntityCopyWith<$Res> {
  __$TaxConfigurationRequestEntityCopyWithImpl(this._self, this._then);

  final _TaxConfigurationRequestEntity _self;
  final $Res Function(_TaxConfigurationRequestEntity) _then;

/// Create a copy of TaxConfigurationRequestEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? taxName = freezed,Object? taxRate = freezed,Object? isEnabled = freezed,Object? taxableComponents = freezed,Object? taxCalculationType = freezed,}) {
  return _then(_TaxConfigurationRequestEntity(
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
