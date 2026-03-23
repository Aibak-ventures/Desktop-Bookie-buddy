// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_details_drawer_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BookingDetailsDrawerState {

 bool get isOpen; int? get selectedBookingId;
/// Create a copy of BookingDetailsDrawerState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingDetailsDrawerStateCopyWith<BookingDetailsDrawerState> get copyWith => _$BookingDetailsDrawerStateCopyWithImpl<BookingDetailsDrawerState>(this as BookingDetailsDrawerState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingDetailsDrawerState&&(identical(other.isOpen, isOpen) || other.isOpen == isOpen)&&(identical(other.selectedBookingId, selectedBookingId) || other.selectedBookingId == selectedBookingId));
}


@override
int get hashCode => Object.hash(runtimeType,isOpen,selectedBookingId);

@override
String toString() {
  return 'BookingDetailsDrawerState(isOpen: $isOpen, selectedBookingId: $selectedBookingId)';
}


}

/// @nodoc
abstract mixin class $BookingDetailsDrawerStateCopyWith<$Res>  {
  factory $BookingDetailsDrawerStateCopyWith(BookingDetailsDrawerState value, $Res Function(BookingDetailsDrawerState) _then) = _$BookingDetailsDrawerStateCopyWithImpl;
@useResult
$Res call({
 bool isOpen, int? selectedBookingId
});




}
/// @nodoc
class _$BookingDetailsDrawerStateCopyWithImpl<$Res>
    implements $BookingDetailsDrawerStateCopyWith<$Res> {
  _$BookingDetailsDrawerStateCopyWithImpl(this._self, this._then);

  final BookingDetailsDrawerState _self;
  final $Res Function(BookingDetailsDrawerState) _then;

/// Create a copy of BookingDetailsDrawerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isOpen = null,Object? selectedBookingId = freezed,}) {
  return _then(_self.copyWith(
isOpen: null == isOpen ? _self.isOpen : isOpen // ignore: cast_nullable_to_non_nullable
as bool,selectedBookingId: freezed == selectedBookingId ? _self.selectedBookingId : selectedBookingId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [BookingDetailsDrawerState].
extension BookingDetailsDrawerStatePatterns on BookingDetailsDrawerState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingDetailsDrawerState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingDetailsDrawerState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingDetailsDrawerState value)  $default,){
final _that = this;
switch (_that) {
case _BookingDetailsDrawerState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingDetailsDrawerState value)?  $default,){
final _that = this;
switch (_that) {
case _BookingDetailsDrawerState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isOpen,  int? selectedBookingId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingDetailsDrawerState() when $default != null:
return $default(_that.isOpen,_that.selectedBookingId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isOpen,  int? selectedBookingId)  $default,) {final _that = this;
switch (_that) {
case _BookingDetailsDrawerState():
return $default(_that.isOpen,_that.selectedBookingId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isOpen,  int? selectedBookingId)?  $default,) {final _that = this;
switch (_that) {
case _BookingDetailsDrawerState() when $default != null:
return $default(_that.isOpen,_that.selectedBookingId);case _:
  return null;

}
}

}

/// @nodoc


class _BookingDetailsDrawerState implements BookingDetailsDrawerState {
  const _BookingDetailsDrawerState({this.isOpen = false, this.selectedBookingId});
  

@override@JsonKey() final  bool isOpen;
@override final  int? selectedBookingId;

/// Create a copy of BookingDetailsDrawerState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingDetailsDrawerStateCopyWith<_BookingDetailsDrawerState> get copyWith => __$BookingDetailsDrawerStateCopyWithImpl<_BookingDetailsDrawerState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingDetailsDrawerState&&(identical(other.isOpen, isOpen) || other.isOpen == isOpen)&&(identical(other.selectedBookingId, selectedBookingId) || other.selectedBookingId == selectedBookingId));
}


@override
int get hashCode => Object.hash(runtimeType,isOpen,selectedBookingId);

@override
String toString() {
  return 'BookingDetailsDrawerState(isOpen: $isOpen, selectedBookingId: $selectedBookingId)';
}


}

/// @nodoc
abstract mixin class _$BookingDetailsDrawerStateCopyWith<$Res> implements $BookingDetailsDrawerStateCopyWith<$Res> {
  factory _$BookingDetailsDrawerStateCopyWith(_BookingDetailsDrawerState value, $Res Function(_BookingDetailsDrawerState) _then) = __$BookingDetailsDrawerStateCopyWithImpl;
@override @useResult
$Res call({
 bool isOpen, int? selectedBookingId
});




}
/// @nodoc
class __$BookingDetailsDrawerStateCopyWithImpl<$Res>
    implements _$BookingDetailsDrawerStateCopyWith<$Res> {
  __$BookingDetailsDrawerStateCopyWithImpl(this._self, this._then);

  final _BookingDetailsDrawerState _self;
  final $Res Function(_BookingDetailsDrawerState) _then;

/// Create a copy of BookingDetailsDrawerState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isOpen = null,Object? selectedBookingId = freezed,}) {
  return _then(_BookingDetailsDrawerState(
isOpen: null == isOpen ? _self.isOpen : isOpen // ignore: cast_nullable_to_non_nullable
as bool,selectedBookingId: freezed == selectedBookingId ? _self.selectedBookingId : selectedBookingId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
