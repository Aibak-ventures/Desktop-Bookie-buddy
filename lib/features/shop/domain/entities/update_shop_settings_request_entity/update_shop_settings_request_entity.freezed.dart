// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_shop_settings_request_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UpdateShopSettingsRequestEntity {

 int? get coolingPeriodDuration; CoolingPeriodMode? get coolingPeriodMode; AddButtonDefaultAction? get addButtonDefaultAction; bool? get searchClient; PrintOutputPreference? get printOutputPreference;
/// Create a copy of UpdateShopSettingsRequestEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateShopSettingsRequestEntityCopyWith<UpdateShopSettingsRequestEntity> get copyWith => _$UpdateShopSettingsRequestEntityCopyWithImpl<UpdateShopSettingsRequestEntity>(this as UpdateShopSettingsRequestEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateShopSettingsRequestEntity&&(identical(other.coolingPeriodDuration, coolingPeriodDuration) || other.coolingPeriodDuration == coolingPeriodDuration)&&(identical(other.coolingPeriodMode, coolingPeriodMode) || other.coolingPeriodMode == coolingPeriodMode)&&(identical(other.addButtonDefaultAction, addButtonDefaultAction) || other.addButtonDefaultAction == addButtonDefaultAction)&&(identical(other.searchClient, searchClient) || other.searchClient == searchClient)&&(identical(other.printOutputPreference, printOutputPreference) || other.printOutputPreference == printOutputPreference));
}


@override
int get hashCode => Object.hash(runtimeType,coolingPeriodDuration,coolingPeriodMode,addButtonDefaultAction,searchClient,printOutputPreference);

@override
String toString() {
  return 'UpdateShopSettingsRequestEntity(coolingPeriodDuration: $coolingPeriodDuration, coolingPeriodMode: $coolingPeriodMode, addButtonDefaultAction: $addButtonDefaultAction, searchClient: $searchClient, printOutputPreference: $printOutputPreference)';
}


}

/// @nodoc
abstract mixin class $UpdateShopSettingsRequestEntityCopyWith<$Res>  {
  factory $UpdateShopSettingsRequestEntityCopyWith(UpdateShopSettingsRequestEntity value, $Res Function(UpdateShopSettingsRequestEntity) _then) = _$UpdateShopSettingsRequestEntityCopyWithImpl;
@useResult
$Res call({
 int? coolingPeriodDuration, CoolingPeriodMode? coolingPeriodMode, AddButtonDefaultAction? addButtonDefaultAction, bool? searchClient, PrintOutputPreference? printOutputPreference
});




}
/// @nodoc
class _$UpdateShopSettingsRequestEntityCopyWithImpl<$Res>
    implements $UpdateShopSettingsRequestEntityCopyWith<$Res> {
  _$UpdateShopSettingsRequestEntityCopyWithImpl(this._self, this._then);

  final UpdateShopSettingsRequestEntity _self;
  final $Res Function(UpdateShopSettingsRequestEntity) _then;

/// Create a copy of UpdateShopSettingsRequestEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? coolingPeriodDuration = freezed,Object? coolingPeriodMode = freezed,Object? addButtonDefaultAction = freezed,Object? searchClient = freezed,Object? printOutputPreference = freezed,}) {
  return _then(_self.copyWith(
coolingPeriodDuration: freezed == coolingPeriodDuration ? _self.coolingPeriodDuration : coolingPeriodDuration // ignore: cast_nullable_to_non_nullable
as int?,coolingPeriodMode: freezed == coolingPeriodMode ? _self.coolingPeriodMode : coolingPeriodMode // ignore: cast_nullable_to_non_nullable
as CoolingPeriodMode?,addButtonDefaultAction: freezed == addButtonDefaultAction ? _self.addButtonDefaultAction : addButtonDefaultAction // ignore: cast_nullable_to_non_nullable
as AddButtonDefaultAction?,searchClient: freezed == searchClient ? _self.searchClient : searchClient // ignore: cast_nullable_to_non_nullable
as bool?,printOutputPreference: freezed == printOutputPreference ? _self.printOutputPreference : printOutputPreference // ignore: cast_nullable_to_non_nullable
as PrintOutputPreference?,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateShopSettingsRequestEntity].
extension UpdateShopSettingsRequestEntityPatterns on UpdateShopSettingsRequestEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateShopSettingsRequestEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateShopSettingsRequestEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateShopSettingsRequestEntity value)  $default,){
final _that = this;
switch (_that) {
case _UpdateShopSettingsRequestEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateShopSettingsRequestEntity value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateShopSettingsRequestEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? coolingPeriodDuration,  CoolingPeriodMode? coolingPeriodMode,  AddButtonDefaultAction? addButtonDefaultAction,  bool? searchClient,  PrintOutputPreference? printOutputPreference)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateShopSettingsRequestEntity() when $default != null:
return $default(_that.coolingPeriodDuration,_that.coolingPeriodMode,_that.addButtonDefaultAction,_that.searchClient,_that.printOutputPreference);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? coolingPeriodDuration,  CoolingPeriodMode? coolingPeriodMode,  AddButtonDefaultAction? addButtonDefaultAction,  bool? searchClient,  PrintOutputPreference? printOutputPreference)  $default,) {final _that = this;
switch (_that) {
case _UpdateShopSettingsRequestEntity():
return $default(_that.coolingPeriodDuration,_that.coolingPeriodMode,_that.addButtonDefaultAction,_that.searchClient,_that.printOutputPreference);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? coolingPeriodDuration,  CoolingPeriodMode? coolingPeriodMode,  AddButtonDefaultAction? addButtonDefaultAction,  bool? searchClient,  PrintOutputPreference? printOutputPreference)?  $default,) {final _that = this;
switch (_that) {
case _UpdateShopSettingsRequestEntity() when $default != null:
return $default(_that.coolingPeriodDuration,_that.coolingPeriodMode,_that.addButtonDefaultAction,_that.searchClient,_that.printOutputPreference);case _:
  return null;

}
}

}

/// @nodoc


class _UpdateShopSettingsRequestEntity implements UpdateShopSettingsRequestEntity {
  const _UpdateShopSettingsRequestEntity({this.coolingPeriodDuration, this.coolingPeriodMode, this.addButtonDefaultAction, this.searchClient, this.printOutputPreference});
  

@override final  int? coolingPeriodDuration;
@override final  CoolingPeriodMode? coolingPeriodMode;
@override final  AddButtonDefaultAction? addButtonDefaultAction;
@override final  bool? searchClient;
@override final  PrintOutputPreference? printOutputPreference;

/// Create a copy of UpdateShopSettingsRequestEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateShopSettingsRequestEntityCopyWith<_UpdateShopSettingsRequestEntity> get copyWith => __$UpdateShopSettingsRequestEntityCopyWithImpl<_UpdateShopSettingsRequestEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateShopSettingsRequestEntity&&(identical(other.coolingPeriodDuration, coolingPeriodDuration) || other.coolingPeriodDuration == coolingPeriodDuration)&&(identical(other.coolingPeriodMode, coolingPeriodMode) || other.coolingPeriodMode == coolingPeriodMode)&&(identical(other.addButtonDefaultAction, addButtonDefaultAction) || other.addButtonDefaultAction == addButtonDefaultAction)&&(identical(other.searchClient, searchClient) || other.searchClient == searchClient)&&(identical(other.printOutputPreference, printOutputPreference) || other.printOutputPreference == printOutputPreference));
}


@override
int get hashCode => Object.hash(runtimeType,coolingPeriodDuration,coolingPeriodMode,addButtonDefaultAction,searchClient,printOutputPreference);

@override
String toString() {
  return 'UpdateShopSettingsRequestEntity(coolingPeriodDuration: $coolingPeriodDuration, coolingPeriodMode: $coolingPeriodMode, addButtonDefaultAction: $addButtonDefaultAction, searchClient: $searchClient, printOutputPreference: $printOutputPreference)';
}


}

/// @nodoc
abstract mixin class _$UpdateShopSettingsRequestEntityCopyWith<$Res> implements $UpdateShopSettingsRequestEntityCopyWith<$Res> {
  factory _$UpdateShopSettingsRequestEntityCopyWith(_UpdateShopSettingsRequestEntity value, $Res Function(_UpdateShopSettingsRequestEntity) _then) = __$UpdateShopSettingsRequestEntityCopyWithImpl;
@override @useResult
$Res call({
 int? coolingPeriodDuration, CoolingPeriodMode? coolingPeriodMode, AddButtonDefaultAction? addButtonDefaultAction, bool? searchClient, PrintOutputPreference? printOutputPreference
});




}
/// @nodoc
class __$UpdateShopSettingsRequestEntityCopyWithImpl<$Res>
    implements _$UpdateShopSettingsRequestEntityCopyWith<$Res> {
  __$UpdateShopSettingsRequestEntityCopyWithImpl(this._self, this._then);

  final _UpdateShopSettingsRequestEntity _self;
  final $Res Function(_UpdateShopSettingsRequestEntity) _then;

/// Create a copy of UpdateShopSettingsRequestEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? coolingPeriodDuration = freezed,Object? coolingPeriodMode = freezed,Object? addButtonDefaultAction = freezed,Object? searchClient = freezed,Object? printOutputPreference = freezed,}) {
  return _then(_UpdateShopSettingsRequestEntity(
coolingPeriodDuration: freezed == coolingPeriodDuration ? _self.coolingPeriodDuration : coolingPeriodDuration // ignore: cast_nullable_to_non_nullable
as int?,coolingPeriodMode: freezed == coolingPeriodMode ? _self.coolingPeriodMode : coolingPeriodMode // ignore: cast_nullable_to_non_nullable
as CoolingPeriodMode?,addButtonDefaultAction: freezed == addButtonDefaultAction ? _self.addButtonDefaultAction : addButtonDefaultAction // ignore: cast_nullable_to_non_nullable
as AddButtonDefaultAction?,searchClient: freezed == searchClient ? _self.searchClient : searchClient // ignore: cast_nullable_to_non_nullable
as bool?,printOutputPreference: freezed == printOutputPreference ? _self.printOutputPreference : printOutputPreference // ignore: cast_nullable_to_non_nullable
as PrintOutputPreference?,
  ));
}


}

// dart format on
