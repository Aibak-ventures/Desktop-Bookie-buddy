// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_other_details_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BookingOtherDetailsEntity {

 String? get locationStart; String? get locationFrom; String? get locationTo; String? get end;
/// Create a copy of BookingOtherDetailsEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingOtherDetailsEntityCopyWith<BookingOtherDetailsEntity> get copyWith => _$BookingOtherDetailsEntityCopyWithImpl<BookingOtherDetailsEntity>(this as BookingOtherDetailsEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingOtherDetailsEntity&&(identical(other.locationStart, locationStart) || other.locationStart == locationStart)&&(identical(other.locationFrom, locationFrom) || other.locationFrom == locationFrom)&&(identical(other.locationTo, locationTo) || other.locationTo == locationTo)&&(identical(other.end, end) || other.end == end));
}


@override
int get hashCode => Object.hash(runtimeType,locationStart,locationFrom,locationTo,end);

@override
String toString() {
  return 'BookingOtherDetailsEntity(locationStart: $locationStart, locationFrom: $locationFrom, locationTo: $locationTo, end: $end)';
}


}

/// @nodoc
abstract mixin class $BookingOtherDetailsEntityCopyWith<$Res>  {
  factory $BookingOtherDetailsEntityCopyWith(BookingOtherDetailsEntity value, $Res Function(BookingOtherDetailsEntity) _then) = _$BookingOtherDetailsEntityCopyWithImpl;
@useResult
$Res call({
 String? locationStart, String? locationFrom, String? locationTo, String? end
});




}
/// @nodoc
class _$BookingOtherDetailsEntityCopyWithImpl<$Res>
    implements $BookingOtherDetailsEntityCopyWith<$Res> {
  _$BookingOtherDetailsEntityCopyWithImpl(this._self, this._then);

  final BookingOtherDetailsEntity _self;
  final $Res Function(BookingOtherDetailsEntity) _then;

/// Create a copy of BookingOtherDetailsEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? locationStart = freezed,Object? locationFrom = freezed,Object? locationTo = freezed,Object? end = freezed,}) {
  return _then(_self.copyWith(
locationStart: freezed == locationStart ? _self.locationStart : locationStart // ignore: cast_nullable_to_non_nullable
as String?,locationFrom: freezed == locationFrom ? _self.locationFrom : locationFrom // ignore: cast_nullable_to_non_nullable
as String?,locationTo: freezed == locationTo ? _self.locationTo : locationTo // ignore: cast_nullable_to_non_nullable
as String?,end: freezed == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BookingOtherDetailsEntity].
extension BookingOtherDetailsEntityPatterns on BookingOtherDetailsEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingOtherDetailsEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingOtherDetailsEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingOtherDetailsEntity value)  $default,){
final _that = this;
switch (_that) {
case _BookingOtherDetailsEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingOtherDetailsEntity value)?  $default,){
final _that = this;
switch (_that) {
case _BookingOtherDetailsEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? locationStart,  String? locationFrom,  String? locationTo,  String? end)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingOtherDetailsEntity() when $default != null:
return $default(_that.locationStart,_that.locationFrom,_that.locationTo,_that.end);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? locationStart,  String? locationFrom,  String? locationTo,  String? end)  $default,) {final _that = this;
switch (_that) {
case _BookingOtherDetailsEntity():
return $default(_that.locationStart,_that.locationFrom,_that.locationTo,_that.end);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? locationStart,  String? locationFrom,  String? locationTo,  String? end)?  $default,) {final _that = this;
switch (_that) {
case _BookingOtherDetailsEntity() when $default != null:
return $default(_that.locationStart,_that.locationFrom,_that.locationTo,_that.end);case _:
  return null;

}
}

}

/// @nodoc


class _BookingOtherDetailsEntity implements BookingOtherDetailsEntity {
  const _BookingOtherDetailsEntity({this.locationStart, this.locationFrom, this.locationTo, this.end});
  

@override final  String? locationStart;
@override final  String? locationFrom;
@override final  String? locationTo;
@override final  String? end;

/// Create a copy of BookingOtherDetailsEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingOtherDetailsEntityCopyWith<_BookingOtherDetailsEntity> get copyWith => __$BookingOtherDetailsEntityCopyWithImpl<_BookingOtherDetailsEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingOtherDetailsEntity&&(identical(other.locationStart, locationStart) || other.locationStart == locationStart)&&(identical(other.locationFrom, locationFrom) || other.locationFrom == locationFrom)&&(identical(other.locationTo, locationTo) || other.locationTo == locationTo)&&(identical(other.end, end) || other.end == end));
}


@override
int get hashCode => Object.hash(runtimeType,locationStart,locationFrom,locationTo,end);

@override
String toString() {
  return 'BookingOtherDetailsEntity(locationStart: $locationStart, locationFrom: $locationFrom, locationTo: $locationTo, end: $end)';
}


}

/// @nodoc
abstract mixin class _$BookingOtherDetailsEntityCopyWith<$Res> implements $BookingOtherDetailsEntityCopyWith<$Res> {
  factory _$BookingOtherDetailsEntityCopyWith(_BookingOtherDetailsEntity value, $Res Function(_BookingOtherDetailsEntity) _then) = __$BookingOtherDetailsEntityCopyWithImpl;
@override @useResult
$Res call({
 String? locationStart, String? locationFrom, String? locationTo, String? end
});




}
/// @nodoc
class __$BookingOtherDetailsEntityCopyWithImpl<$Res>
    implements _$BookingOtherDetailsEntityCopyWith<$Res> {
  __$BookingOtherDetailsEntityCopyWithImpl(this._self, this._then);

  final _BookingOtherDetailsEntity _self;
  final $Res Function(_BookingOtherDetailsEntity) _then;

/// Create a copy of BookingOtherDetailsEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? locationStart = freezed,Object? locationFrom = freezed,Object? locationTo = freezed,Object? end = freezed,}) {
  return _then(_BookingOtherDetailsEntity(
locationStart: freezed == locationStart ? _self.locationStart : locationStart // ignore: cast_nullable_to_non_nullable
as String?,locationFrom: freezed == locationFrom ? _self.locationFrom : locationFrom // ignore: cast_nullable_to_non_nullable
as String?,locationTo: freezed == locationTo ? _self.locationTo : locationTo // ignore: cast_nullable_to_non_nullable
as String?,end: freezed == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
