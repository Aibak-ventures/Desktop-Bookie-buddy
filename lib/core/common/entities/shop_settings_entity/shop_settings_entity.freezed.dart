// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shop_settings_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ShopSettingsEntity {

 int get coolingPeriodDuration; CoolingPeriodMode get coolingPeriodMode; AddButtonDefaultAction get addButtonDefaultAction; bool get searchClient;
/// Create a copy of ShopSettingsEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShopSettingsEntityCopyWith<ShopSettingsEntity> get copyWith => _$ShopSettingsEntityCopyWithImpl<ShopSettingsEntity>(this as ShopSettingsEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShopSettingsEntity&&(identical(other.coolingPeriodDuration, coolingPeriodDuration) || other.coolingPeriodDuration == coolingPeriodDuration)&&(identical(other.coolingPeriodMode, coolingPeriodMode) || other.coolingPeriodMode == coolingPeriodMode)&&(identical(other.addButtonDefaultAction, addButtonDefaultAction) || other.addButtonDefaultAction == addButtonDefaultAction)&&(identical(other.searchClient, searchClient) || other.searchClient == searchClient));
}


@override
int get hashCode => Object.hash(runtimeType,coolingPeriodDuration,coolingPeriodMode,addButtonDefaultAction,searchClient);

@override
String toString() {
  return 'ShopSettingsEntity(coolingPeriodDuration: $coolingPeriodDuration, coolingPeriodMode: $coolingPeriodMode, addButtonDefaultAction: $addButtonDefaultAction, searchClient: $searchClient)';
}


}

/// @nodoc
abstract mixin class $ShopSettingsEntityCopyWith<$Res>  {
  factory $ShopSettingsEntityCopyWith(ShopSettingsEntity value, $Res Function(ShopSettingsEntity) _then) = _$ShopSettingsEntityCopyWithImpl;
@useResult
$Res call({
 int coolingPeriodDuration, CoolingPeriodMode coolingPeriodMode, AddButtonDefaultAction addButtonDefaultAction, bool searchClient
});




}
/// @nodoc
class _$ShopSettingsEntityCopyWithImpl<$Res>
    implements $ShopSettingsEntityCopyWith<$Res> {
  _$ShopSettingsEntityCopyWithImpl(this._self, this._then);

  final ShopSettingsEntity _self;
  final $Res Function(ShopSettingsEntity) _then;

/// Create a copy of ShopSettingsEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? coolingPeriodDuration = null,Object? coolingPeriodMode = null,Object? addButtonDefaultAction = null,Object? searchClient = null,}) {
  return _then(_self.copyWith(
coolingPeriodDuration: null == coolingPeriodDuration ? _self.coolingPeriodDuration : coolingPeriodDuration // ignore: cast_nullable_to_non_nullable
as int,coolingPeriodMode: null == coolingPeriodMode ? _self.coolingPeriodMode : coolingPeriodMode // ignore: cast_nullable_to_non_nullable
as CoolingPeriodMode,addButtonDefaultAction: null == addButtonDefaultAction ? _self.addButtonDefaultAction : addButtonDefaultAction // ignore: cast_nullable_to_non_nullable
as AddButtonDefaultAction,searchClient: null == searchClient ? _self.searchClient : searchClient // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ShopSettingsEntity].
extension ShopSettingsEntityPatterns on ShopSettingsEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShopSettingsEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShopSettingsEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShopSettingsEntity value)  $default,){
final _that = this;
switch (_that) {
case _ShopSettingsEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShopSettingsEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ShopSettingsEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int coolingPeriodDuration,  CoolingPeriodMode coolingPeriodMode,  AddButtonDefaultAction addButtonDefaultAction,  bool searchClient)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShopSettingsEntity() when $default != null:
return $default(_that.coolingPeriodDuration,_that.coolingPeriodMode,_that.addButtonDefaultAction,_that.searchClient);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int coolingPeriodDuration,  CoolingPeriodMode coolingPeriodMode,  AddButtonDefaultAction addButtonDefaultAction,  bool searchClient)  $default,) {final _that = this;
switch (_that) {
case _ShopSettingsEntity():
return $default(_that.coolingPeriodDuration,_that.coolingPeriodMode,_that.addButtonDefaultAction,_that.searchClient);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int coolingPeriodDuration,  CoolingPeriodMode coolingPeriodMode,  AddButtonDefaultAction addButtonDefaultAction,  bool searchClient)?  $default,) {final _that = this;
switch (_that) {
case _ShopSettingsEntity() when $default != null:
return $default(_that.coolingPeriodDuration,_that.coolingPeriodMode,_that.addButtonDefaultAction,_that.searchClient);case _:
  return null;

}
}

}

/// @nodoc


class _ShopSettingsEntity implements ShopSettingsEntity {
  const _ShopSettingsEntity({required this.coolingPeriodDuration, required this.coolingPeriodMode, required this.addButtonDefaultAction, required this.searchClient});
  

@override final  int coolingPeriodDuration;
@override final  CoolingPeriodMode coolingPeriodMode;
@override final  AddButtonDefaultAction addButtonDefaultAction;
@override final  bool searchClient;

/// Create a copy of ShopSettingsEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShopSettingsEntityCopyWith<_ShopSettingsEntity> get copyWith => __$ShopSettingsEntityCopyWithImpl<_ShopSettingsEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShopSettingsEntity&&(identical(other.coolingPeriodDuration, coolingPeriodDuration) || other.coolingPeriodDuration == coolingPeriodDuration)&&(identical(other.coolingPeriodMode, coolingPeriodMode) || other.coolingPeriodMode == coolingPeriodMode)&&(identical(other.addButtonDefaultAction, addButtonDefaultAction) || other.addButtonDefaultAction == addButtonDefaultAction)&&(identical(other.searchClient, searchClient) || other.searchClient == searchClient));
}


@override
int get hashCode => Object.hash(runtimeType,coolingPeriodDuration,coolingPeriodMode,addButtonDefaultAction,searchClient);

@override
String toString() {
  return 'ShopSettingsEntity(coolingPeriodDuration: $coolingPeriodDuration, coolingPeriodMode: $coolingPeriodMode, addButtonDefaultAction: $addButtonDefaultAction, searchClient: $searchClient)';
}


}

/// @nodoc
abstract mixin class _$ShopSettingsEntityCopyWith<$Res> implements $ShopSettingsEntityCopyWith<$Res> {
  factory _$ShopSettingsEntityCopyWith(_ShopSettingsEntity value, $Res Function(_ShopSettingsEntity) _then) = __$ShopSettingsEntityCopyWithImpl;
@override @useResult
$Res call({
 int coolingPeriodDuration, CoolingPeriodMode coolingPeriodMode, AddButtonDefaultAction addButtonDefaultAction, bool searchClient
});




}
/// @nodoc
class __$ShopSettingsEntityCopyWithImpl<$Res>
    implements _$ShopSettingsEntityCopyWith<$Res> {
  __$ShopSettingsEntityCopyWithImpl(this._self, this._then);

  final _ShopSettingsEntity _self;
  final $Res Function(_ShopSettingsEntity) _then;

/// Create a copy of ShopSettingsEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? coolingPeriodDuration = null,Object? coolingPeriodMode = null,Object? addButtonDefaultAction = null,Object? searchClient = null,}) {
  return _then(_ShopSettingsEntity(
coolingPeriodDuration: null == coolingPeriodDuration ? _self.coolingPeriodDuration : coolingPeriodDuration // ignore: cast_nullable_to_non_nullable
as int,coolingPeriodMode: null == coolingPeriodMode ? _self.coolingPeriodMode : coolingPeriodMode // ignore: cast_nullable_to_non_nullable
as CoolingPeriodMode,addButtonDefaultAction: null == addButtonDefaultAction ? _self.addButtonDefaultAction : addButtonDefaultAction // ignore: cast_nullable_to_non_nullable
as AddButtonDefaultAction,searchClient: null == searchClient ? _self.searchClient : searchClient // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
