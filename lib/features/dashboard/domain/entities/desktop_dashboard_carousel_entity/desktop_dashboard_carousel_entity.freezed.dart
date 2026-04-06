// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'desktop_dashboard_carousel_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DesktopDashboardCarouselEntity {

 int get upcomingCount; int get alterationBookingCount; int get completedCount; int get expiredCount;
/// Create a copy of DesktopDashboardCarouselEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DesktopDashboardCarouselEntityCopyWith<DesktopDashboardCarouselEntity> get copyWith => _$DesktopDashboardCarouselEntityCopyWithImpl<DesktopDashboardCarouselEntity>(this as DesktopDashboardCarouselEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DesktopDashboardCarouselEntity&&(identical(other.upcomingCount, upcomingCount) || other.upcomingCount == upcomingCount)&&(identical(other.alterationBookingCount, alterationBookingCount) || other.alterationBookingCount == alterationBookingCount)&&(identical(other.completedCount, completedCount) || other.completedCount == completedCount)&&(identical(other.expiredCount, expiredCount) || other.expiredCount == expiredCount));
}


@override
int get hashCode => Object.hash(runtimeType,upcomingCount,alterationBookingCount,completedCount,expiredCount);

@override
String toString() {
  return 'DesktopDashboardCarouselEntity(upcomingCount: $upcomingCount, alterationBookingCount: $alterationBookingCount, completedCount: $completedCount, expiredCount: $expiredCount)';
}


}

/// @nodoc
abstract mixin class $DesktopDashboardCarouselEntityCopyWith<$Res>  {
  factory $DesktopDashboardCarouselEntityCopyWith(DesktopDashboardCarouselEntity value, $Res Function(DesktopDashboardCarouselEntity) _then) = _$DesktopDashboardCarouselEntityCopyWithImpl;
@useResult
$Res call({
 int upcomingCount, int alterationBookingCount, int completedCount, int expiredCount
});




}
/// @nodoc
class _$DesktopDashboardCarouselEntityCopyWithImpl<$Res>
    implements $DesktopDashboardCarouselEntityCopyWith<$Res> {
  _$DesktopDashboardCarouselEntityCopyWithImpl(this._self, this._then);

  final DesktopDashboardCarouselEntity _self;
  final $Res Function(DesktopDashboardCarouselEntity) _then;

/// Create a copy of DesktopDashboardCarouselEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? upcomingCount = null,Object? alterationBookingCount = null,Object? completedCount = null,Object? expiredCount = null,}) {
  return _then(_self.copyWith(
upcomingCount: null == upcomingCount ? _self.upcomingCount : upcomingCount // ignore: cast_nullable_to_non_nullable
as int,alterationBookingCount: null == alterationBookingCount ? _self.alterationBookingCount : alterationBookingCount // ignore: cast_nullable_to_non_nullable
as int,completedCount: null == completedCount ? _self.completedCount : completedCount // ignore: cast_nullable_to_non_nullable
as int,expiredCount: null == expiredCount ? _self.expiredCount : expiredCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DesktopDashboardCarouselEntity].
extension DesktopDashboardCarouselEntityPatterns on DesktopDashboardCarouselEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DesktopDashboardCarouselEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DesktopDashboardCarouselEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DesktopDashboardCarouselEntity value)  $default,){
final _that = this;
switch (_that) {
case _DesktopDashboardCarouselEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DesktopDashboardCarouselEntity value)?  $default,){
final _that = this;
switch (_that) {
case _DesktopDashboardCarouselEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int upcomingCount,  int alterationBookingCount,  int completedCount,  int expiredCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DesktopDashboardCarouselEntity() when $default != null:
return $default(_that.upcomingCount,_that.alterationBookingCount,_that.completedCount,_that.expiredCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int upcomingCount,  int alterationBookingCount,  int completedCount,  int expiredCount)  $default,) {final _that = this;
switch (_that) {
case _DesktopDashboardCarouselEntity():
return $default(_that.upcomingCount,_that.alterationBookingCount,_that.completedCount,_that.expiredCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int upcomingCount,  int alterationBookingCount,  int completedCount,  int expiredCount)?  $default,) {final _that = this;
switch (_that) {
case _DesktopDashboardCarouselEntity() when $default != null:
return $default(_that.upcomingCount,_that.alterationBookingCount,_that.completedCount,_that.expiredCount);case _:
  return null;

}
}

}

/// @nodoc


class _DesktopDashboardCarouselEntity implements DesktopDashboardCarouselEntity {
  const _DesktopDashboardCarouselEntity({required this.upcomingCount, required this.alterationBookingCount, required this.completedCount, required this.expiredCount});
  

@override final  int upcomingCount;
@override final  int alterationBookingCount;
@override final  int completedCount;
@override final  int expiredCount;

/// Create a copy of DesktopDashboardCarouselEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DesktopDashboardCarouselEntityCopyWith<_DesktopDashboardCarouselEntity> get copyWith => __$DesktopDashboardCarouselEntityCopyWithImpl<_DesktopDashboardCarouselEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DesktopDashboardCarouselEntity&&(identical(other.upcomingCount, upcomingCount) || other.upcomingCount == upcomingCount)&&(identical(other.alterationBookingCount, alterationBookingCount) || other.alterationBookingCount == alterationBookingCount)&&(identical(other.completedCount, completedCount) || other.completedCount == completedCount)&&(identical(other.expiredCount, expiredCount) || other.expiredCount == expiredCount));
}


@override
int get hashCode => Object.hash(runtimeType,upcomingCount,alterationBookingCount,completedCount,expiredCount);

@override
String toString() {
  return 'DesktopDashboardCarouselEntity(upcomingCount: $upcomingCount, alterationBookingCount: $alterationBookingCount, completedCount: $completedCount, expiredCount: $expiredCount)';
}


}

/// @nodoc
abstract mixin class _$DesktopDashboardCarouselEntityCopyWith<$Res> implements $DesktopDashboardCarouselEntityCopyWith<$Res> {
  factory _$DesktopDashboardCarouselEntityCopyWith(_DesktopDashboardCarouselEntity value, $Res Function(_DesktopDashboardCarouselEntity) _then) = __$DesktopDashboardCarouselEntityCopyWithImpl;
@override @useResult
$Res call({
 int upcomingCount, int alterationBookingCount, int completedCount, int expiredCount
});




}
/// @nodoc
class __$DesktopDashboardCarouselEntityCopyWithImpl<$Res>
    implements _$DesktopDashboardCarouselEntityCopyWith<$Res> {
  __$DesktopDashboardCarouselEntityCopyWithImpl(this._self, this._then);

  final _DesktopDashboardCarouselEntity _self;
  final $Res Function(_DesktopDashboardCarouselEntity) _then;

/// Create a copy of DesktopDashboardCarouselEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? upcomingCount = null,Object? alterationBookingCount = null,Object? completedCount = null,Object? expiredCount = null,}) {
  return _then(_DesktopDashboardCarouselEntity(
upcomingCount: null == upcomingCount ? _self.upcomingCount : upcomingCount // ignore: cast_nullable_to_non_nullable
as int,alterationBookingCount: null == alterationBookingCount ? _self.alterationBookingCount : alterationBookingCount // ignore: cast_nullable_to_non_nullable
as int,completedCount: null == completedCount ? _self.completedCount : completedCount // ignore: cast_nullable_to_non_nullable
as int,expiredCount: null == expiredCount ? _self.expiredCount : expiredCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
