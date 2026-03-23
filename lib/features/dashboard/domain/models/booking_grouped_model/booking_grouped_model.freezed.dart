// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_grouped_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BookingGroupedModel {

 String get date; List<BookingsModel> get bookings;
/// Create a copy of BookingGroupedModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingGroupedModelCopyWith<BookingGroupedModel> get copyWith => _$BookingGroupedModelCopyWithImpl<BookingGroupedModel>(this as BookingGroupedModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingGroupedModel&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other.bookings, bookings));
}


@override
int get hashCode => Object.hash(runtimeType,date,const DeepCollectionEquality().hash(bookings));

@override
String toString() {
  return 'BookingGroupedModel(date: $date, bookings: $bookings)';
}


}

/// @nodoc
abstract mixin class $BookingGroupedModelCopyWith<$Res>  {
  factory $BookingGroupedModelCopyWith(BookingGroupedModel value, $Res Function(BookingGroupedModel) _then) = _$BookingGroupedModelCopyWithImpl;
@useResult
$Res call({
 String date, List<BookingsModel> bookings
});




}
/// @nodoc
class _$BookingGroupedModelCopyWithImpl<$Res>
    implements $BookingGroupedModelCopyWith<$Res> {
  _$BookingGroupedModelCopyWithImpl(this._self, this._then);

  final BookingGroupedModel _self;
  final $Res Function(BookingGroupedModel) _then;

/// Create a copy of BookingGroupedModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? bookings = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,bookings: null == bookings ? _self.bookings : bookings // ignore: cast_nullable_to_non_nullable
as List<BookingsModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [BookingGroupedModel].
extension BookingGroupedModelPatterns on BookingGroupedModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingGroupedModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingGroupedModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingGroupedModel value)  $default,){
final _that = this;
switch (_that) {
case _BookingGroupedModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingGroupedModel value)?  $default,){
final _that = this;
switch (_that) {
case _BookingGroupedModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  List<BookingsModel> bookings)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingGroupedModel() when $default != null:
return $default(_that.date,_that.bookings);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  List<BookingsModel> bookings)  $default,) {final _that = this;
switch (_that) {
case _BookingGroupedModel():
return $default(_that.date,_that.bookings);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  List<BookingsModel> bookings)?  $default,) {final _that = this;
switch (_that) {
case _BookingGroupedModel() when $default != null:
return $default(_that.date,_that.bookings);case _:
  return null;

}
}

}

/// @nodoc


class _BookingGroupedModel implements BookingGroupedModel {
  const _BookingGroupedModel({required this.date, required final  List<BookingsModel> bookings}): _bookings = bookings;
  

@override final  String date;
 final  List<BookingsModel> _bookings;
@override List<BookingsModel> get bookings {
  if (_bookings is EqualUnmodifiableListView) return _bookings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bookings);
}


/// Create a copy of BookingGroupedModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingGroupedModelCopyWith<_BookingGroupedModel> get copyWith => __$BookingGroupedModelCopyWithImpl<_BookingGroupedModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingGroupedModel&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other._bookings, _bookings));
}


@override
int get hashCode => Object.hash(runtimeType,date,const DeepCollectionEquality().hash(_bookings));

@override
String toString() {
  return 'BookingGroupedModel(date: $date, bookings: $bookings)';
}


}

/// @nodoc
abstract mixin class _$BookingGroupedModelCopyWith<$Res> implements $BookingGroupedModelCopyWith<$Res> {
  factory _$BookingGroupedModelCopyWith(_BookingGroupedModel value, $Res Function(_BookingGroupedModel) _then) = __$BookingGroupedModelCopyWithImpl;
@override @useResult
$Res call({
 String date, List<BookingsModel> bookings
});




}
/// @nodoc
class __$BookingGroupedModelCopyWithImpl<$Res>
    implements _$BookingGroupedModelCopyWith<$Res> {
  __$BookingGroupedModelCopyWithImpl(this._self, this._then);

  final _BookingGroupedModel _self;
  final $Res Function(_BookingGroupedModel) _then;

/// Create a copy of BookingGroupedModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? bookings = null,}) {
  return _then(_BookingGroupedModel(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,bookings: null == bookings ? _self._bookings : bookings // ignore: cast_nullable_to_non_nullable
as List<BookingsModel>,
  ));
}


}

// dart format on
