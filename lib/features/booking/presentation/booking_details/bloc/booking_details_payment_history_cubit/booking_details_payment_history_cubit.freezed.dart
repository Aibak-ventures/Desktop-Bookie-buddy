// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_details_payment_history_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BookingDetailsPaymentHistoryState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingDetailsPaymentHistoryState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BookingDetailsPaymentHistoryState()';
}


}

/// @nodoc
class $BookingDetailsPaymentHistoryStateCopyWith<$Res>  {
$BookingDetailsPaymentHistoryStateCopyWith(BookingDetailsPaymentHistoryState _, $Res Function(BookingDetailsPaymentHistoryState) __);
}


/// Adds pattern-matching-related methods to [BookingDetailsPaymentHistoryState].
extension BookingDetailsPaymentHistoryStatePatterns on BookingDetailsPaymentHistoryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Collapsed value)?  collapsed,TResult Function( _Loading value)?  loading,TResult Function( _Error value)?  error,TResult Function( _Expanded value)?  expanded,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Collapsed() when collapsed != null:
return collapsed(_that);case _Loading() when loading != null:
return loading(_that);case _Error() when error != null:
return error(_that);case _Expanded() when expanded != null:
return expanded(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Collapsed value)  collapsed,required TResult Function( _Loading value)  loading,required TResult Function( _Error value)  error,required TResult Function( _Expanded value)  expanded,}){
final _that = this;
switch (_that) {
case _Collapsed():
return collapsed(_that);case _Loading():
return loading(_that);case _Error():
return error(_that);case _Expanded():
return expanded(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Collapsed value)?  collapsed,TResult? Function( _Loading value)?  loading,TResult? Function( _Error value)?  error,TResult? Function( _Expanded value)?  expanded,}){
final _that = this;
switch (_that) {
case _Collapsed() when collapsed != null:
return collapsed(_that);case _Loading() when loading != null:
return loading(_that);case _Error() when error != null:
return error(_that);case _Expanded() when expanded != null:
return expanded(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  collapsed,TResult Function()?  loading,TResult Function( String error)?  error,TResult Function( List<BookingPaymentHistoryEntity> paymentHistory)?  expanded,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Collapsed() when collapsed != null:
return collapsed();case _Loading() when loading != null:
return loading();case _Error() when error != null:
return error(_that.error);case _Expanded() when expanded != null:
return expanded(_that.paymentHistory);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  collapsed,required TResult Function()  loading,required TResult Function( String error)  error,required TResult Function( List<BookingPaymentHistoryEntity> paymentHistory)  expanded,}) {final _that = this;
switch (_that) {
case _Collapsed():
return collapsed();case _Loading():
return loading();case _Error():
return error(_that.error);case _Expanded():
return expanded(_that.paymentHistory);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  collapsed,TResult? Function()?  loading,TResult? Function( String error)?  error,TResult? Function( List<BookingPaymentHistoryEntity> paymentHistory)?  expanded,}) {final _that = this;
switch (_that) {
case _Collapsed() when collapsed != null:
return collapsed();case _Loading() when loading != null:
return loading();case _Error() when error != null:
return error(_that.error);case _Expanded() when expanded != null:
return expanded(_that.paymentHistory);case _:
  return null;

}
}

}

/// @nodoc


class _Collapsed implements BookingDetailsPaymentHistoryState {
  const _Collapsed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Collapsed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BookingDetailsPaymentHistoryState.collapsed()';
}


}




/// @nodoc


class _Loading implements BookingDetailsPaymentHistoryState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BookingDetailsPaymentHistoryState.loading()';
}


}




/// @nodoc


class _Error implements BookingDetailsPaymentHistoryState {
  const _Error(this.error);
  

 final  String error;

/// Create a copy of BookingDetailsPaymentHistoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'BookingDetailsPaymentHistoryState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $BookingDetailsPaymentHistoryStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of BookingDetailsPaymentHistoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(_Error(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _Expanded implements BookingDetailsPaymentHistoryState {
  const _Expanded(final  List<BookingPaymentHistoryEntity> paymentHistory): _paymentHistory = paymentHistory;
  

 final  List<BookingPaymentHistoryEntity> _paymentHistory;
 List<BookingPaymentHistoryEntity> get paymentHistory {
  if (_paymentHistory is EqualUnmodifiableListView) return _paymentHistory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_paymentHistory);
}


/// Create a copy of BookingDetailsPaymentHistoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExpandedCopyWith<_Expanded> get copyWith => __$ExpandedCopyWithImpl<_Expanded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Expanded&&const DeepCollectionEquality().equals(other._paymentHistory, _paymentHistory));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_paymentHistory));

@override
String toString() {
  return 'BookingDetailsPaymentHistoryState.expanded(paymentHistory: $paymentHistory)';
}


}

/// @nodoc
abstract mixin class _$ExpandedCopyWith<$Res> implements $BookingDetailsPaymentHistoryStateCopyWith<$Res> {
  factory _$ExpandedCopyWith(_Expanded value, $Res Function(_Expanded) _then) = __$ExpandedCopyWithImpl;
@useResult
$Res call({
 List<BookingPaymentHistoryEntity> paymentHistory
});




}
/// @nodoc
class __$ExpandedCopyWithImpl<$Res>
    implements _$ExpandedCopyWith<$Res> {
  __$ExpandedCopyWithImpl(this._self, this._then);

  final _Expanded _self;
  final $Res Function(_Expanded) _then;

/// Create a copy of BookingDetailsPaymentHistoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? paymentHistory = null,}) {
  return _then(_Expanded(
null == paymentHistory ? _self._paymentHistory : paymentHistory // ignore: cast_nullable_to_non_nullable
as List<BookingPaymentHistoryEntity>,
  ));
}


}

// dart format on
