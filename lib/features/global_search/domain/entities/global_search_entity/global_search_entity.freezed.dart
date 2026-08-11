// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'global_search_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GlobalSearchEntity {

 DesktopBookingItemEntity? get booking;
/// Create a copy of GlobalSearchEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GlobalSearchEntityCopyWith<GlobalSearchEntity> get copyWith => _$GlobalSearchEntityCopyWithImpl<GlobalSearchEntity>(this as GlobalSearchEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GlobalSearchEntity&&(identical(other.booking, booking) || other.booking == booking));
}


@override
int get hashCode => Object.hash(runtimeType,booking);

@override
String toString() {
  return 'GlobalSearchEntity(booking: $booking)';
}


}

/// @nodoc
abstract mixin class $GlobalSearchEntityCopyWith<$Res>  {
  factory $GlobalSearchEntityCopyWith(GlobalSearchEntity value, $Res Function(GlobalSearchEntity) _then) = _$GlobalSearchEntityCopyWithImpl;
@useResult
$Res call({
 DesktopBookingItemEntity? booking
});


$DesktopBookingItemEntityCopyWith<$Res>? get booking;

}
/// @nodoc
class _$GlobalSearchEntityCopyWithImpl<$Res>
    implements $GlobalSearchEntityCopyWith<$Res> {
  _$GlobalSearchEntityCopyWithImpl(this._self, this._then);

  final GlobalSearchEntity _self;
  final $Res Function(GlobalSearchEntity) _then;

/// Create a copy of GlobalSearchEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? booking = freezed,}) {
  return _then(_self.copyWith(
booking: freezed == booking ? _self.booking : booking // ignore: cast_nullable_to_non_nullable
as DesktopBookingItemEntity?,
  ));
}
/// Create a copy of GlobalSearchEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DesktopBookingItemEntityCopyWith<$Res>? get booking {
    if (_self.booking == null) {
    return null;
  }

  return $DesktopBookingItemEntityCopyWith<$Res>(_self.booking!, (value) {
    return _then(_self.copyWith(booking: value));
  });
}
}


/// Adds pattern-matching-related methods to [GlobalSearchEntity].
extension GlobalSearchEntityPatterns on GlobalSearchEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GlobalSearchEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GlobalSearchEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GlobalSearchEntity value)  $default,){
final _that = this;
switch (_that) {
case _GlobalSearchEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GlobalSearchEntity value)?  $default,){
final _that = this;
switch (_that) {
case _GlobalSearchEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DesktopBookingItemEntity? booking)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GlobalSearchEntity() when $default != null:
return $default(_that.booking);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DesktopBookingItemEntity? booking)  $default,) {final _that = this;
switch (_that) {
case _GlobalSearchEntity():
return $default(_that.booking);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DesktopBookingItemEntity? booking)?  $default,) {final _that = this;
switch (_that) {
case _GlobalSearchEntity() when $default != null:
return $default(_that.booking);case _:
  return null;

}
}

}

/// @nodoc


class _GlobalSearchEntity implements GlobalSearchEntity {
  const _GlobalSearchEntity({this.booking});
  

@override final  DesktopBookingItemEntity? booking;

/// Create a copy of GlobalSearchEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GlobalSearchEntityCopyWith<_GlobalSearchEntity> get copyWith => __$GlobalSearchEntityCopyWithImpl<_GlobalSearchEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GlobalSearchEntity&&(identical(other.booking, booking) || other.booking == booking));
}


@override
int get hashCode => Object.hash(runtimeType,booking);

@override
String toString() {
  return 'GlobalSearchEntity(booking: $booking)';
}


}

/// @nodoc
abstract mixin class _$GlobalSearchEntityCopyWith<$Res> implements $GlobalSearchEntityCopyWith<$Res> {
  factory _$GlobalSearchEntityCopyWith(_GlobalSearchEntity value, $Res Function(_GlobalSearchEntity) _then) = __$GlobalSearchEntityCopyWithImpl;
@override @useResult
$Res call({
 DesktopBookingItemEntity? booking
});


@override $DesktopBookingItemEntityCopyWith<$Res>? get booking;

}
/// @nodoc
class __$GlobalSearchEntityCopyWithImpl<$Res>
    implements _$GlobalSearchEntityCopyWith<$Res> {
  __$GlobalSearchEntityCopyWithImpl(this._self, this._then);

  final _GlobalSearchEntity _self;
  final $Res Function(_GlobalSearchEntity) _then;

/// Create a copy of GlobalSearchEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? booking = freezed,}) {
  return _then(_GlobalSearchEntity(
booking: freezed == booking ? _self.booking : booking // ignore: cast_nullable_to_non_nullable
as DesktopBookingItemEntity?,
  ));
}

/// Create a copy of GlobalSearchEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DesktopBookingItemEntityCopyWith<$Res>? get booking {
    if (_self.booking == null) {
    return null;
  }

  return $DesktopBookingItemEntityCopyWith<$Res>(_self.booking!, (value) {
    return _then(_self.copyWith(booking: value));
  });
}
}

// dart format on
