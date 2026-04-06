// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shop_settings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ShopSettingsModel {

@JsonKey(name: 'cooling_days', defaultValue: 0) int get coolingPeriodDuration;@JsonKey(name: 'cooling_period_mode', fromJson: CoolingPeriodMode.fromJson, defaultValue: CoolingPeriodMode.after) CoolingPeriodMode get coolingPeriodMode;@JsonKey(name: 'default_action', fromJson: AddButtonDefaultAction.fromString, defaultValue: AddButtonDefaultAction.booking) AddButtonDefaultAction get addButtonDefaultAction;@JsonKey(name: 'search_client', defaultValue: false) bool get searchClient;
/// Create a copy of ShopSettingsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShopSettingsModelCopyWith<ShopSettingsModel> get copyWith => _$ShopSettingsModelCopyWithImpl<ShopSettingsModel>(this as ShopSettingsModel, _$identity);

  /// Serializes this ShopSettingsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShopSettingsModel&&(identical(other.coolingPeriodDuration, coolingPeriodDuration) || other.coolingPeriodDuration == coolingPeriodDuration)&&(identical(other.coolingPeriodMode, coolingPeriodMode) || other.coolingPeriodMode == coolingPeriodMode)&&(identical(other.addButtonDefaultAction, addButtonDefaultAction) || other.addButtonDefaultAction == addButtonDefaultAction)&&(identical(other.searchClient, searchClient) || other.searchClient == searchClient));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,coolingPeriodDuration,coolingPeriodMode,addButtonDefaultAction,searchClient);

@override
String toString() {
  return 'ShopSettingsModel(coolingPeriodDuration: $coolingPeriodDuration, coolingPeriodMode: $coolingPeriodMode, addButtonDefaultAction: $addButtonDefaultAction, searchClient: $searchClient)';
}


}

/// @nodoc
abstract mixin class $ShopSettingsModelCopyWith<$Res>  {
  factory $ShopSettingsModelCopyWith(ShopSettingsModel value, $Res Function(ShopSettingsModel) _then) = _$ShopSettingsModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'cooling_days', defaultValue: 0) int coolingPeriodDuration,@JsonKey(name: 'cooling_period_mode', fromJson: CoolingPeriodMode.fromJson, defaultValue: CoolingPeriodMode.after) CoolingPeriodMode coolingPeriodMode,@JsonKey(name: 'default_action', fromJson: AddButtonDefaultAction.fromString, defaultValue: AddButtonDefaultAction.booking) AddButtonDefaultAction addButtonDefaultAction,@JsonKey(name: 'search_client', defaultValue: false) bool searchClient
});




}
/// @nodoc
class _$ShopSettingsModelCopyWithImpl<$Res>
    implements $ShopSettingsModelCopyWith<$Res> {
  _$ShopSettingsModelCopyWithImpl(this._self, this._then);

  final ShopSettingsModel _self;
  final $Res Function(ShopSettingsModel) _then;

/// Create a copy of ShopSettingsModel
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


/// Adds pattern-matching-related methods to [ShopSettingsModel].
extension ShopSettingsModelPatterns on ShopSettingsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShopSettingsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShopSettingsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShopSettingsModel value)  $default,){
final _that = this;
switch (_that) {
case _ShopSettingsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShopSettingsModel value)?  $default,){
final _that = this;
switch (_that) {
case _ShopSettingsModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'cooling_days', defaultValue: 0)  int coolingPeriodDuration, @JsonKey(name: 'cooling_period_mode', fromJson: CoolingPeriodMode.fromJson, defaultValue: CoolingPeriodMode.after)  CoolingPeriodMode coolingPeriodMode, @JsonKey(name: 'default_action', fromJson: AddButtonDefaultAction.fromString, defaultValue: AddButtonDefaultAction.booking)  AddButtonDefaultAction addButtonDefaultAction, @JsonKey(name: 'search_client', defaultValue: false)  bool searchClient)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShopSettingsModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'cooling_days', defaultValue: 0)  int coolingPeriodDuration, @JsonKey(name: 'cooling_period_mode', fromJson: CoolingPeriodMode.fromJson, defaultValue: CoolingPeriodMode.after)  CoolingPeriodMode coolingPeriodMode, @JsonKey(name: 'default_action', fromJson: AddButtonDefaultAction.fromString, defaultValue: AddButtonDefaultAction.booking)  AddButtonDefaultAction addButtonDefaultAction, @JsonKey(name: 'search_client', defaultValue: false)  bool searchClient)  $default,) {final _that = this;
switch (_that) {
case _ShopSettingsModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'cooling_days', defaultValue: 0)  int coolingPeriodDuration, @JsonKey(name: 'cooling_period_mode', fromJson: CoolingPeriodMode.fromJson, defaultValue: CoolingPeriodMode.after)  CoolingPeriodMode coolingPeriodMode, @JsonKey(name: 'default_action', fromJson: AddButtonDefaultAction.fromString, defaultValue: AddButtonDefaultAction.booking)  AddButtonDefaultAction addButtonDefaultAction, @JsonKey(name: 'search_client', defaultValue: false)  bool searchClient)?  $default,) {final _that = this;
switch (_that) {
case _ShopSettingsModel() when $default != null:
return $default(_that.coolingPeriodDuration,_that.coolingPeriodMode,_that.addButtonDefaultAction,_that.searchClient);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShopSettingsModel implements ShopSettingsModel {
  const _ShopSettingsModel({@JsonKey(name: 'cooling_days', defaultValue: 0) required this.coolingPeriodDuration, @JsonKey(name: 'cooling_period_mode', fromJson: CoolingPeriodMode.fromJson, defaultValue: CoolingPeriodMode.after) required this.coolingPeriodMode, @JsonKey(name: 'default_action', fromJson: AddButtonDefaultAction.fromString, defaultValue: AddButtonDefaultAction.booking) required this.addButtonDefaultAction, @JsonKey(name: 'search_client', defaultValue: false) required this.searchClient});
  factory _ShopSettingsModel.fromJson(Map<String, dynamic> json) => _$ShopSettingsModelFromJson(json);

@override@JsonKey(name: 'cooling_days', defaultValue: 0) final  int coolingPeriodDuration;
@override@JsonKey(name: 'cooling_period_mode', fromJson: CoolingPeriodMode.fromJson, defaultValue: CoolingPeriodMode.after) final  CoolingPeriodMode coolingPeriodMode;
@override@JsonKey(name: 'default_action', fromJson: AddButtonDefaultAction.fromString, defaultValue: AddButtonDefaultAction.booking) final  AddButtonDefaultAction addButtonDefaultAction;
@override@JsonKey(name: 'search_client', defaultValue: false) final  bool searchClient;

/// Create a copy of ShopSettingsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShopSettingsModelCopyWith<_ShopSettingsModel> get copyWith => __$ShopSettingsModelCopyWithImpl<_ShopSettingsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShopSettingsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShopSettingsModel&&(identical(other.coolingPeriodDuration, coolingPeriodDuration) || other.coolingPeriodDuration == coolingPeriodDuration)&&(identical(other.coolingPeriodMode, coolingPeriodMode) || other.coolingPeriodMode == coolingPeriodMode)&&(identical(other.addButtonDefaultAction, addButtonDefaultAction) || other.addButtonDefaultAction == addButtonDefaultAction)&&(identical(other.searchClient, searchClient) || other.searchClient == searchClient));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,coolingPeriodDuration,coolingPeriodMode,addButtonDefaultAction,searchClient);

@override
String toString() {
  return 'ShopSettingsModel(coolingPeriodDuration: $coolingPeriodDuration, coolingPeriodMode: $coolingPeriodMode, addButtonDefaultAction: $addButtonDefaultAction, searchClient: $searchClient)';
}


}

/// @nodoc
abstract mixin class _$ShopSettingsModelCopyWith<$Res> implements $ShopSettingsModelCopyWith<$Res> {
  factory _$ShopSettingsModelCopyWith(_ShopSettingsModel value, $Res Function(_ShopSettingsModel) _then) = __$ShopSettingsModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'cooling_days', defaultValue: 0) int coolingPeriodDuration,@JsonKey(name: 'cooling_period_mode', fromJson: CoolingPeriodMode.fromJson, defaultValue: CoolingPeriodMode.after) CoolingPeriodMode coolingPeriodMode,@JsonKey(name: 'default_action', fromJson: AddButtonDefaultAction.fromString, defaultValue: AddButtonDefaultAction.booking) AddButtonDefaultAction addButtonDefaultAction,@JsonKey(name: 'search_client', defaultValue: false) bool searchClient
});




}
/// @nodoc
class __$ShopSettingsModelCopyWithImpl<$Res>
    implements _$ShopSettingsModelCopyWith<$Res> {
  __$ShopSettingsModelCopyWithImpl(this._self, this._then);

  final _ShopSettingsModel _self;
  final $Res Function(_ShopSettingsModel) _then;

/// Create a copy of ShopSettingsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? coolingPeriodDuration = null,Object? coolingPeriodMode = null,Object? addButtonDefaultAction = null,Object? searchClient = null,}) {
  return _then(_ShopSettingsModel(
coolingPeriodDuration: null == coolingPeriodDuration ? _self.coolingPeriodDuration : coolingPeriodDuration // ignore: cast_nullable_to_non_nullable
as int,coolingPeriodMode: null == coolingPeriodMode ? _self.coolingPeriodMode : coolingPeriodMode // ignore: cast_nullable_to_non_nullable
as CoolingPeriodMode,addButtonDefaultAction: null == addButtonDefaultAction ? _self.addButtonDefaultAction : addButtonDefaultAction // ignore: cast_nullable_to_non_nullable
as AddButtonDefaultAction,searchClient: null == searchClient ? _self.searchClient : searchClient // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
