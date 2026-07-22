// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tax_configuration_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TaxConfigurationEntity {

 int get id; String get taxName; double get taxRate; bool get isEnabled; List<TaxableComponent> get taxableComponents; TaxCalculationType get taxCalculationType; String? get createdAt; String? get updatedAt;
/// Create a copy of TaxConfigurationEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaxConfigurationEntityCopyWith<TaxConfigurationEntity> get copyWith => _$TaxConfigurationEntityCopyWithImpl<TaxConfigurationEntity>(this as TaxConfigurationEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaxConfigurationEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.taxName, taxName) || other.taxName == taxName)&&(identical(other.taxRate, taxRate) || other.taxRate == taxRate)&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled)&&const DeepCollectionEquality().equals(other.taxableComponents, taxableComponents)&&(identical(other.taxCalculationType, taxCalculationType) || other.taxCalculationType == taxCalculationType)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,taxName,taxRate,isEnabled,const DeepCollectionEquality().hash(taxableComponents),taxCalculationType,createdAt,updatedAt);

@override
String toString() {
  return 'TaxConfigurationEntity(id: $id, taxName: $taxName, taxRate: $taxRate, isEnabled: $isEnabled, taxableComponents: $taxableComponents, taxCalculationType: $taxCalculationType, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $TaxConfigurationEntityCopyWith<$Res>  {
  factory $TaxConfigurationEntityCopyWith(TaxConfigurationEntity value, $Res Function(TaxConfigurationEntity) _then) = _$TaxConfigurationEntityCopyWithImpl;
@useResult
$Res call({
 int id, String taxName, double taxRate, bool isEnabled, List<TaxableComponent> taxableComponents, TaxCalculationType taxCalculationType, String? createdAt, String? updatedAt
});




}
/// @nodoc
class _$TaxConfigurationEntityCopyWithImpl<$Res>
    implements $TaxConfigurationEntityCopyWith<$Res> {
  _$TaxConfigurationEntityCopyWithImpl(this._self, this._then);

  final TaxConfigurationEntity _self;
  final $Res Function(TaxConfigurationEntity) _then;

/// Create a copy of TaxConfigurationEntity
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


/// Adds pattern-matching-related methods to [TaxConfigurationEntity].
extension TaxConfigurationEntityPatterns on TaxConfigurationEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaxConfigurationEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaxConfigurationEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaxConfigurationEntity value)  $default,){
final _that = this;
switch (_that) {
case _TaxConfigurationEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaxConfigurationEntity value)?  $default,){
final _that = this;
switch (_that) {
case _TaxConfigurationEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String taxName,  double taxRate,  bool isEnabled,  List<TaxableComponent> taxableComponents,  TaxCalculationType taxCalculationType,  String? createdAt,  String? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaxConfigurationEntity() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String taxName,  double taxRate,  bool isEnabled,  List<TaxableComponent> taxableComponents,  TaxCalculationType taxCalculationType,  String? createdAt,  String? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _TaxConfigurationEntity():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String taxName,  double taxRate,  bool isEnabled,  List<TaxableComponent> taxableComponents,  TaxCalculationType taxCalculationType,  String? createdAt,  String? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _TaxConfigurationEntity() when $default != null:
return $default(_that.id,_that.taxName,_that.taxRate,_that.isEnabled,_that.taxableComponents,_that.taxCalculationType,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _TaxConfigurationEntity implements TaxConfigurationEntity {
  const _TaxConfigurationEntity({required this.id, required this.taxName, required this.taxRate, required this.isEnabled, required final  List<TaxableComponent> taxableComponents, required this.taxCalculationType, this.createdAt, this.updatedAt}): _taxableComponents = taxableComponents;
  

@override final  int id;
@override final  String taxName;
@override final  double taxRate;
@override final  bool isEnabled;
 final  List<TaxableComponent> _taxableComponents;
@override List<TaxableComponent> get taxableComponents {
  if (_taxableComponents is EqualUnmodifiableListView) return _taxableComponents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_taxableComponents);
}

@override final  TaxCalculationType taxCalculationType;
@override final  String? createdAt;
@override final  String? updatedAt;

/// Create a copy of TaxConfigurationEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaxConfigurationEntityCopyWith<_TaxConfigurationEntity> get copyWith => __$TaxConfigurationEntityCopyWithImpl<_TaxConfigurationEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaxConfigurationEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.taxName, taxName) || other.taxName == taxName)&&(identical(other.taxRate, taxRate) || other.taxRate == taxRate)&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled)&&const DeepCollectionEquality().equals(other._taxableComponents, _taxableComponents)&&(identical(other.taxCalculationType, taxCalculationType) || other.taxCalculationType == taxCalculationType)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,taxName,taxRate,isEnabled,const DeepCollectionEquality().hash(_taxableComponents),taxCalculationType,createdAt,updatedAt);

@override
String toString() {
  return 'TaxConfigurationEntity(id: $id, taxName: $taxName, taxRate: $taxRate, isEnabled: $isEnabled, taxableComponents: $taxableComponents, taxCalculationType: $taxCalculationType, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$TaxConfigurationEntityCopyWith<$Res> implements $TaxConfigurationEntityCopyWith<$Res> {
  factory _$TaxConfigurationEntityCopyWith(_TaxConfigurationEntity value, $Res Function(_TaxConfigurationEntity) _then) = __$TaxConfigurationEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, String taxName, double taxRate, bool isEnabled, List<TaxableComponent> taxableComponents, TaxCalculationType taxCalculationType, String? createdAt, String? updatedAt
});




}
/// @nodoc
class __$TaxConfigurationEntityCopyWithImpl<$Res>
    implements _$TaxConfigurationEntityCopyWith<$Res> {
  __$TaxConfigurationEntityCopyWithImpl(this._self, this._then);

  final _TaxConfigurationEntity _self;
  final $Res Function(_TaxConfigurationEntity) _then;

/// Create a copy of TaxConfigurationEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? taxName = null,Object? taxRate = null,Object? isEnabled = null,Object? taxableComponents = null,Object? taxCalculationType = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_TaxConfigurationEntity(
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
