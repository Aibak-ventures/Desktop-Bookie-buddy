// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_feature_details_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserFeatureDetailsEntity {

 String get displayName; AppPremiumFeatures get feature; FeatureSubscriptionStatus get status;
/// Create a copy of UserFeatureDetailsEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserFeatureDetailsEntityCopyWith<UserFeatureDetailsEntity> get copyWith => _$UserFeatureDetailsEntityCopyWithImpl<UserFeatureDetailsEntity>(this as UserFeatureDetailsEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserFeatureDetailsEntity&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.feature, feature) || other.feature == feature)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,displayName,feature,status);

@override
String toString() {
  return 'UserFeatureDetailsEntity(displayName: $displayName, feature: $feature, status: $status)';
}


}

/// @nodoc
abstract mixin class $UserFeatureDetailsEntityCopyWith<$Res>  {
  factory $UserFeatureDetailsEntityCopyWith(UserFeatureDetailsEntity value, $Res Function(UserFeatureDetailsEntity) _then) = _$UserFeatureDetailsEntityCopyWithImpl;
@useResult
$Res call({
 String displayName, AppPremiumFeatures feature, FeatureSubscriptionStatus status
});




}
/// @nodoc
class _$UserFeatureDetailsEntityCopyWithImpl<$Res>
    implements $UserFeatureDetailsEntityCopyWith<$Res> {
  _$UserFeatureDetailsEntityCopyWithImpl(this._self, this._then);

  final UserFeatureDetailsEntity _self;
  final $Res Function(UserFeatureDetailsEntity) _then;

/// Create a copy of UserFeatureDetailsEntity
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


/// Adds pattern-matching-related methods to [UserFeatureDetailsEntity].
extension UserFeatureDetailsEntityPatterns on UserFeatureDetailsEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserFeatureDetailsEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserFeatureDetailsEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserFeatureDetailsEntity value)  $default,){
final _that = this;
switch (_that) {
case _UserFeatureDetailsEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserFeatureDetailsEntity value)?  $default,){
final _that = this;
switch (_that) {
case _UserFeatureDetailsEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String displayName,  AppPremiumFeatures feature,  FeatureSubscriptionStatus status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserFeatureDetailsEntity() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String displayName,  AppPremiumFeatures feature,  FeatureSubscriptionStatus status)  $default,) {final _that = this;
switch (_that) {
case _UserFeatureDetailsEntity():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String displayName,  AppPremiumFeatures feature,  FeatureSubscriptionStatus status)?  $default,) {final _that = this;
switch (_that) {
case _UserFeatureDetailsEntity() when $default != null:
return $default(_that.displayName,_that.feature,_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _UserFeatureDetailsEntity implements UserFeatureDetailsEntity {
  const _UserFeatureDetailsEntity({required this.displayName, required this.feature, required this.status});
  

@override final  String displayName;
@override final  AppPremiumFeatures feature;
@override final  FeatureSubscriptionStatus status;

/// Create a copy of UserFeatureDetailsEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserFeatureDetailsEntityCopyWith<_UserFeatureDetailsEntity> get copyWith => __$UserFeatureDetailsEntityCopyWithImpl<_UserFeatureDetailsEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserFeatureDetailsEntity&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.feature, feature) || other.feature == feature)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,displayName,feature,status);

@override
String toString() {
  return 'UserFeatureDetailsEntity(displayName: $displayName, feature: $feature, status: $status)';
}


}

/// @nodoc
abstract mixin class _$UserFeatureDetailsEntityCopyWith<$Res> implements $UserFeatureDetailsEntityCopyWith<$Res> {
  factory _$UserFeatureDetailsEntityCopyWith(_UserFeatureDetailsEntity value, $Res Function(_UserFeatureDetailsEntity) _then) = __$UserFeatureDetailsEntityCopyWithImpl;
@override @useResult
$Res call({
 String displayName, AppPremiumFeatures feature, FeatureSubscriptionStatus status
});




}
/// @nodoc
class __$UserFeatureDetailsEntityCopyWithImpl<$Res>
    implements _$UserFeatureDetailsEntityCopyWith<$Res> {
  __$UserFeatureDetailsEntityCopyWithImpl(this._self, this._then);

  final _UserFeatureDetailsEntity _self;
  final $Res Function(_UserFeatureDetailsEntity) _then;

/// Create a copy of UserFeatureDetailsEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? displayName = null,Object? feature = null,Object? status = null,}) {
  return _then(_UserFeatureDetailsEntity(
displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,feature: null == feature ? _self.feature : feature // ignore: cast_nullable_to_non_nullable
as AppPremiumFeatures,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FeatureSubscriptionStatus,
  ));
}


}

// dart format on
