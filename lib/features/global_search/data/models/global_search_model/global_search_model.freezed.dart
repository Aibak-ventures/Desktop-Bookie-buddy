// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'global_search_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GlobalSearchModel {

 DesktopBookingItemModel? get booking;
/// Create a copy of GlobalSearchModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GlobalSearchModelCopyWith<GlobalSearchModel> get copyWith => _$GlobalSearchModelCopyWithImpl<GlobalSearchModel>(this as GlobalSearchModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GlobalSearchModel&&(identical(other.booking, booking) || other.booking == booking));
}


@override
int get hashCode => Object.hash(runtimeType,booking);

@override
String toString() {
  return 'GlobalSearchModel(booking: $booking)';
}


}

/// @nodoc
abstract mixin class $GlobalSearchModelCopyWith<$Res>  {
  factory $GlobalSearchModelCopyWith(GlobalSearchModel value, $Res Function(GlobalSearchModel) _then) = _$GlobalSearchModelCopyWithImpl;
@useResult
$Res call({
 DesktopBookingItemModel? booking
});


$DesktopBookingItemModelCopyWith<$Res>? get booking;

}
/// @nodoc
class _$GlobalSearchModelCopyWithImpl<$Res>
    implements $GlobalSearchModelCopyWith<$Res> {
  _$GlobalSearchModelCopyWithImpl(this._self, this._then);

  final GlobalSearchModel _self;
  final $Res Function(GlobalSearchModel) _then;

/// Create a copy of GlobalSearchModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? booking = freezed,}) {
  return _then(_self.copyWith(
booking: freezed == booking ? _self.booking : booking // ignore: cast_nullable_to_non_nullable
as DesktopBookingItemModel?,
  ));
}
/// Create a copy of GlobalSearchModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DesktopBookingItemModelCopyWith<$Res>? get booking {
    if (_self.booking == null) {
    return null;
  }

  return $DesktopBookingItemModelCopyWith<$Res>(_self.booking!, (value) {
    return _then(_self.copyWith(booking: value));
  });
}
}


/// Adds pattern-matching-related methods to [GlobalSearchModel].
extension GlobalSearchModelPatterns on GlobalSearchModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GlobalSearchModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GlobalSearchModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GlobalSearchModel value)  $default,){
final _that = this;
switch (_that) {
case _GlobalSearchModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GlobalSearchModel value)?  $default,){
final _that = this;
switch (_that) {
case _GlobalSearchModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DesktopBookingItemModel? booking)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GlobalSearchModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DesktopBookingItemModel? booking)  $default,) {final _that = this;
switch (_that) {
case _GlobalSearchModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DesktopBookingItemModel? booking)?  $default,) {final _that = this;
switch (_that) {
case _GlobalSearchModel() when $default != null:
return $default(_that.booking);case _:
  return null;

}
}

}

/// @nodoc


class _GlobalSearchModel implements GlobalSearchModel {
  const _GlobalSearchModel({this.booking});
  

@override final  DesktopBookingItemModel? booking;

/// Create a copy of GlobalSearchModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GlobalSearchModelCopyWith<_GlobalSearchModel> get copyWith => __$GlobalSearchModelCopyWithImpl<_GlobalSearchModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GlobalSearchModel&&(identical(other.booking, booking) || other.booking == booking));
}


@override
int get hashCode => Object.hash(runtimeType,booking);

@override
String toString() {
  return 'GlobalSearchModel(booking: $booking)';
}


}

/// @nodoc
abstract mixin class _$GlobalSearchModelCopyWith<$Res> implements $GlobalSearchModelCopyWith<$Res> {
  factory _$GlobalSearchModelCopyWith(_GlobalSearchModel value, $Res Function(_GlobalSearchModel) _then) = __$GlobalSearchModelCopyWithImpl;
@override @useResult
$Res call({
 DesktopBookingItemModel? booking
});


@override $DesktopBookingItemModelCopyWith<$Res>? get booking;

}
/// @nodoc
class __$GlobalSearchModelCopyWithImpl<$Res>
    implements _$GlobalSearchModelCopyWith<$Res> {
  __$GlobalSearchModelCopyWithImpl(this._self, this._then);

  final _GlobalSearchModel _self;
  final $Res Function(_GlobalSearchModel) _then;

/// Create a copy of GlobalSearchModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? booking = freezed,}) {
  return _then(_GlobalSearchModel(
booking: freezed == booking ? _self.booking : booking // ignore: cast_nullable_to_non_nullable
as DesktopBookingItemModel?,
  ));
}

/// Create a copy of GlobalSearchModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DesktopBookingItemModelCopyWith<$Res>? get booking {
    if (_self.booking == null) {
    return null;
  }

  return $DesktopBookingItemModelCopyWith<$Res>(_self.booking!, (value) {
    return _then(_self.copyWith(booking: value));
  });
}
}

// dart format on
