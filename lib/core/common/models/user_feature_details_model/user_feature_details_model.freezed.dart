// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_feature_details_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserFeatureDetailsModel {

@JsonKey(name: 'name', defaultValue: '') String get displayName;@JsonKey(name: 'code', fromJson: AppPremiumFeatures.fromJson, toJson: AppPremiumFeatures.toJson) AppPremiumFeatures get feature;@JsonKey(name: 'status', fromJson: FeatureSubscriptionStatus.fromJson, toJson: FeatureSubscriptionStatus.toJson) FeatureSubscriptionStatus get status;
/// Create a copy of UserFeatureDetailsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserFeatureDetailsModelCopyWith<UserFeatureDetailsModel> get copyWith => _$UserFeatureDetailsModelCopyWithImpl<UserFeatureDetailsModel>(this as UserFeatureDetailsModel, _$identity);

  /// Serializes this UserFeatureDetailsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserFeatureDetailsModel&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.feature, feature) || other.feature == feature)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,displayName,feature,status);

@override
String toString() {
  return 'UserFeatureDetailsModel(displayName: $displayName, feature: $feature, status: $status)';
}


}

/// @nodoc
abstract mixin class $UserFeatureDetailsModelCopyWith<$Res>  {
  factory $UserFeatureDetailsModelCopyWith(UserFeatureDetailsModel value, $Res Function(UserFeatureDetailsModel) _then) = _$UserFeatureDetailsModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'name', defaultValue: '') String displayName,@JsonKey(name: 'code', fromJson: AppPremiumFeatures.fromJson, toJson: AppPremiumFeatures.toJson) AppPremiumFeatures feature,@JsonKey(name: 'status', fromJson: FeatureSubscriptionStatus.fromJson, toJson: FeatureSubscriptionStatus.toJson) FeatureSubscriptionStatus status
});




}
/// @nodoc
class _$UserFeatureDetailsModelCopyWithImpl<$Res>
    implements $UserFeatureDetailsModelCopyWith<$Res> {
  _$UserFeatureDetailsModelCopyWithImpl(this._self, this._then);

  final UserFeatureDetailsModel _self;
  final $Res Function(UserFeatureDetailsModel) _then;

/// Create a copy of UserFeatureDetailsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? displayName = null,Object? feature = null,Object? status = null,}) {
  return _then(_self.copyWith(
displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,feature: null == feature ? _self.feature : feature // ignore: cast_nullable_to_non_nullable
as AppPremiumFeatures,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FeatureSubscriptionStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [UserFeatureDetailsModel].
extension UserFeatureDetailsModelPatterns on UserFeatureDetailsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserFeatureDetailsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserFeatureDetailsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserFeatureDetailsModel value)  $default,){
final _that = this;
switch (_that) {
case _UserFeatureDetailsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserFeatureDetailsModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserFeatureDetailsModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'name', defaultValue: '')  String displayName, @JsonKey(name: 'code', fromJson: AppPremiumFeatures.fromJson, toJson: AppPremiumFeatures.toJson)  AppPremiumFeatures feature, @JsonKey(name: 'status', fromJson: FeatureSubscriptionStatus.fromJson, toJson: FeatureSubscriptionStatus.toJson)  FeatureSubscriptionStatus status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserFeatureDetailsModel() when $default != null:
return $default(_that.displayName,_that.feature,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'name', defaultValue: '')  String displayName, @JsonKey(name: 'code', fromJson: AppPremiumFeatures.fromJson, toJson: AppPremiumFeatures.toJson)  AppPremiumFeatures feature, @JsonKey(name: 'status', fromJson: FeatureSubscriptionStatus.fromJson, toJson: FeatureSubscriptionStatus.toJson)  FeatureSubscriptionStatus status)  $default,) {final _that = this;
switch (_that) {
case _UserFeatureDetailsModel():
return $default(_that.displayName,_that.feature,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'name', defaultValue: '')  String displayName, @JsonKey(name: 'code', fromJson: AppPremiumFeatures.fromJson, toJson: AppPremiumFeatures.toJson)  AppPremiumFeatures feature, @JsonKey(name: 'status', fromJson: FeatureSubscriptionStatus.fromJson, toJson: FeatureSubscriptionStatus.toJson)  FeatureSubscriptionStatus status)?  $default,) {final _that = this;
switch (_that) {
case _UserFeatureDetailsModel() when $default != null:
return $default(_that.displayName,_that.feature,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserFeatureDetailsModel implements UserFeatureDetailsModel {
  const _UserFeatureDetailsModel({@JsonKey(name: 'name', defaultValue: '') required this.displayName, @JsonKey(name: 'code', fromJson: AppPremiumFeatures.fromJson, toJson: AppPremiumFeatures.toJson) required this.feature, @JsonKey(name: 'status', fromJson: FeatureSubscriptionStatus.fromJson, toJson: FeatureSubscriptionStatus.toJson) required this.status});
  factory _UserFeatureDetailsModel.fromJson(Map<String, dynamic> json) => _$UserFeatureDetailsModelFromJson(json);

@override@JsonKey(name: 'name', defaultValue: '') final  String displayName;
@override@JsonKey(name: 'code', fromJson: AppPremiumFeatures.fromJson, toJson: AppPremiumFeatures.toJson) final  AppPremiumFeatures feature;
@override@JsonKey(name: 'status', fromJson: FeatureSubscriptionStatus.fromJson, toJson: FeatureSubscriptionStatus.toJson) final  FeatureSubscriptionStatus status;

/// Create a copy of UserFeatureDetailsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserFeatureDetailsModelCopyWith<_UserFeatureDetailsModel> get copyWith => __$UserFeatureDetailsModelCopyWithImpl<_UserFeatureDetailsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserFeatureDetailsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserFeatureDetailsModel&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.feature, feature) || other.feature == feature)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,displayName,feature,status);

@override
String toString() {
  return 'UserFeatureDetailsModel(displayName: $displayName, feature: $feature, status: $status)';
}


}

/// @nodoc
abstract mixin class _$UserFeatureDetailsModelCopyWith<$Res> implements $UserFeatureDetailsModelCopyWith<$Res> {
  factory _$UserFeatureDetailsModelCopyWith(_UserFeatureDetailsModel value, $Res Function(_UserFeatureDetailsModel) _then) = __$UserFeatureDetailsModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'name', defaultValue: '') String displayName,@JsonKey(name: 'code', fromJson: AppPremiumFeatures.fromJson, toJson: AppPremiumFeatures.toJson) AppPremiumFeatures feature,@JsonKey(name: 'status', fromJson: FeatureSubscriptionStatus.fromJson, toJson: FeatureSubscriptionStatus.toJson) FeatureSubscriptionStatus status
});




}
/// @nodoc
class __$UserFeatureDetailsModelCopyWithImpl<$Res>
    implements _$UserFeatureDetailsModelCopyWith<$Res> {
  __$UserFeatureDetailsModelCopyWithImpl(this._self, this._then);

  final _UserFeatureDetailsModel _self;
  final $Res Function(_UserFeatureDetailsModel) _then;

/// Create a copy of UserFeatureDetailsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? displayName = null,Object? feature = null,Object? status = null,}) {
  return _then(_UserFeatureDetailsModel(
displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,feature: null == feature ? _self.feature : feature // ignore: cast_nullable_to_non_nullable
as AppPremiumFeatures,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FeatureSubscriptionStatus,
  ));
}


}

// dart format on
