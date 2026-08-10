// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_shop_settings_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UpdateShopSettingsRequestModel {

@JsonKey(name: 'cooling_days') int? get coolingPeriodDuration;@JsonKey(name: 'cooling_period_mode', toJson: _coolingPeriodModeToJson) CoolingPeriodMode? get coolingPeriodMode;@JsonKey(name: 'default_action', toJson: _addButtonDefaultActionToJson) AddButtonDefaultAction? get addButtonDefaultAction;@JsonKey(name: 'search_client') bool? get searchClient;@JsonKey(name: 'print_output_preference', toJson: _printOutputPreferenceToJson) PrintOutputPreference? get printOutputPreference;
/// Create a copy of UpdateShopSettingsRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateShopSettingsRequestModelCopyWith<UpdateShopSettingsRequestModel> get copyWith => _$UpdateShopSettingsRequestModelCopyWithImpl<UpdateShopSettingsRequestModel>(this as UpdateShopSettingsRequestModel, _$identity);

  /// Serializes this UpdateShopSettingsRequestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateShopSettingsRequestModel&&(identical(other.coolingPeriodDuration, coolingPeriodDuration) || other.coolingPeriodDuration == coolingPeriodDuration)&&(identical(other.coolingPeriodMode, coolingPeriodMode) || other.coolingPeriodMode == coolingPeriodMode)&&(identical(other.addButtonDefaultAction, addButtonDefaultAction) || other.addButtonDefaultAction == addButtonDefaultAction)&&(identical(other.searchClient, searchClient) || other.searchClient == searchClient)&&(identical(other.printOutputPreference, printOutputPreference) || other.printOutputPreference == printOutputPreference));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,coolingPeriodDuration,coolingPeriodMode,addButtonDefaultAction,searchClient,printOutputPreference);

@override
String toString() {
  return 'UpdateShopSettingsRequestModel(coolingPeriodDuration: $coolingPeriodDuration, coolingPeriodMode: $coolingPeriodMode, addButtonDefaultAction: $addButtonDefaultAction, searchClient: $searchClient, printOutputPreference: $printOutputPreference)';
}


}

/// @nodoc
abstract mixin class $UpdateShopSettingsRequestModelCopyWith<$Res>  {
  factory $UpdateShopSettingsRequestModelCopyWith(UpdateShopSettingsRequestModel value, $Res Function(UpdateShopSettingsRequestModel) _then) = _$UpdateShopSettingsRequestModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'cooling_days') int? coolingPeriodDuration,@JsonKey(name: 'cooling_period_mode', toJson: _coolingPeriodModeToJson) CoolingPeriodMode? coolingPeriodMode,@JsonKey(name: 'default_action', toJson: _addButtonDefaultActionToJson) AddButtonDefaultAction? addButtonDefaultAction,@JsonKey(name: 'search_client') bool? searchClient,@JsonKey(name: 'print_output_preference', toJson: _printOutputPreferenceToJson) PrintOutputPreference? printOutputPreference
});




}
/// @nodoc
class _$UpdateShopSettingsRequestModelCopyWithImpl<$Res>
    implements $UpdateShopSettingsRequestModelCopyWith<$Res> {
  _$UpdateShopSettingsRequestModelCopyWithImpl(this._self, this._then);

  final UpdateShopSettingsRequestModel _self;
  final $Res Function(UpdateShopSettingsRequestModel) _then;

/// Create a copy of UpdateShopSettingsRequestModel
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


/// Adds pattern-matching-related methods to [UpdateShopSettingsRequestModel].
extension UpdateShopSettingsRequestModelPatterns on UpdateShopSettingsRequestModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateShopSettingsRequestModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateShopSettingsRequestModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateShopSettingsRequestModel value)  $default,){
final _that = this;
switch (_that) {
case _UpdateShopSettingsRequestModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateShopSettingsRequestModel value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateShopSettingsRequestModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'cooling_days')  int? coolingPeriodDuration, @JsonKey(name: 'cooling_period_mode', toJson: _coolingPeriodModeToJson)  CoolingPeriodMode? coolingPeriodMode, @JsonKey(name: 'default_action', toJson: _addButtonDefaultActionToJson)  AddButtonDefaultAction? addButtonDefaultAction, @JsonKey(name: 'search_client')  bool? searchClient, @JsonKey(name: 'print_output_preference', toJson: _printOutputPreferenceToJson)  PrintOutputPreference? printOutputPreference)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateShopSettingsRequestModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'cooling_days')  int? coolingPeriodDuration, @JsonKey(name: 'cooling_period_mode', toJson: _coolingPeriodModeToJson)  CoolingPeriodMode? coolingPeriodMode, @JsonKey(name: 'default_action', toJson: _addButtonDefaultActionToJson)  AddButtonDefaultAction? addButtonDefaultAction, @JsonKey(name: 'search_client')  bool? searchClient, @JsonKey(name: 'print_output_preference', toJson: _printOutputPreferenceToJson)  PrintOutputPreference? printOutputPreference)  $default,) {final _that = this;
switch (_that) {
case _UpdateShopSettingsRequestModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'cooling_days')  int? coolingPeriodDuration, @JsonKey(name: 'cooling_period_mode', toJson: _coolingPeriodModeToJson)  CoolingPeriodMode? coolingPeriodMode, @JsonKey(name: 'default_action', toJson: _addButtonDefaultActionToJson)  AddButtonDefaultAction? addButtonDefaultAction, @JsonKey(name: 'search_client')  bool? searchClient, @JsonKey(name: 'print_output_preference', toJson: _printOutputPreferenceToJson)  PrintOutputPreference? printOutputPreference)?  $default,) {final _that = this;
switch (_that) {
case _UpdateShopSettingsRequestModel() when $default != null:
return $default(_that.coolingPeriodDuration,_that.coolingPeriodMode,_that.addButtonDefaultAction,_that.searchClient,_that.printOutputPreference);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _UpdateShopSettingsRequestModel implements UpdateShopSettingsRequestModel {
  const _UpdateShopSettingsRequestModel({@JsonKey(name: 'cooling_days') this.coolingPeriodDuration, @JsonKey(name: 'cooling_period_mode', toJson: _coolingPeriodModeToJson) this.coolingPeriodMode, @JsonKey(name: 'default_action', toJson: _addButtonDefaultActionToJson) this.addButtonDefaultAction, @JsonKey(name: 'search_client') this.searchClient, @JsonKey(name: 'print_output_preference', toJson: _printOutputPreferenceToJson) this.printOutputPreference});
  factory _UpdateShopSettingsRequestModel.fromJson(Map<String, dynamic> json) => _$UpdateShopSettingsRequestModelFromJson(json);

@override@JsonKey(name: 'cooling_days') final  int? coolingPeriodDuration;
@override@JsonKey(name: 'cooling_period_mode', toJson: _coolingPeriodModeToJson) final  CoolingPeriodMode? coolingPeriodMode;
@override@JsonKey(name: 'default_action', toJson: _addButtonDefaultActionToJson) final  AddButtonDefaultAction? addButtonDefaultAction;
@override@JsonKey(name: 'search_client') final  bool? searchClient;
@override@JsonKey(name: 'print_output_preference', toJson: _printOutputPreferenceToJson) final  PrintOutputPreference? printOutputPreference;

/// Create a copy of UpdateShopSettingsRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateShopSettingsRequestModelCopyWith<_UpdateShopSettingsRequestModel> get copyWith => __$UpdateShopSettingsRequestModelCopyWithImpl<_UpdateShopSettingsRequestModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdateShopSettingsRequestModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateShopSettingsRequestModel&&(identical(other.coolingPeriodDuration, coolingPeriodDuration) || other.coolingPeriodDuration == coolingPeriodDuration)&&(identical(other.coolingPeriodMode, coolingPeriodMode) || other.coolingPeriodMode == coolingPeriodMode)&&(identical(other.addButtonDefaultAction, addButtonDefaultAction) || other.addButtonDefaultAction == addButtonDefaultAction)&&(identical(other.searchClient, searchClient) || other.searchClient == searchClient)&&(identical(other.printOutputPreference, printOutputPreference) || other.printOutputPreference == printOutputPreference));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,coolingPeriodDuration,coolingPeriodMode,addButtonDefaultAction,searchClient,printOutputPreference);

@override
String toString() {
  return 'UpdateShopSettingsRequestModel(coolingPeriodDuration: $coolingPeriodDuration, coolingPeriodMode: $coolingPeriodMode, addButtonDefaultAction: $addButtonDefaultAction, searchClient: $searchClient, printOutputPreference: $printOutputPreference)';
}


}

/// @nodoc
abstract mixin class _$UpdateShopSettingsRequestModelCopyWith<$Res> implements $UpdateShopSettingsRequestModelCopyWith<$Res> {
  factory _$UpdateShopSettingsRequestModelCopyWith(_UpdateShopSettingsRequestModel value, $Res Function(_UpdateShopSettingsRequestModel) _then) = __$UpdateShopSettingsRequestModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'cooling_days') int? coolingPeriodDuration,@JsonKey(name: 'cooling_period_mode', toJson: _coolingPeriodModeToJson) CoolingPeriodMode? coolingPeriodMode,@JsonKey(name: 'default_action', toJson: _addButtonDefaultActionToJson) AddButtonDefaultAction? addButtonDefaultAction,@JsonKey(name: 'search_client') bool? searchClient,@JsonKey(name: 'print_output_preference', toJson: _printOutputPreferenceToJson) PrintOutputPreference? printOutputPreference
});




}
/// @nodoc
class __$UpdateShopSettingsRequestModelCopyWithImpl<$Res>
    implements _$UpdateShopSettingsRequestModelCopyWith<$Res> {
  __$UpdateShopSettingsRequestModelCopyWithImpl(this._self, this._then);

  final _UpdateShopSettingsRequestModel _self;
  final $Res Function(_UpdateShopSettingsRequestModel) _then;

/// Create a copy of UpdateShopSettingsRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? coolingPeriodDuration = freezed,Object? coolingPeriodMode = freezed,Object? addButtonDefaultAction = freezed,Object? searchClient = freezed,Object? printOutputPreference = freezed,}) {
  return _then(_UpdateShopSettingsRequestModel(
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
