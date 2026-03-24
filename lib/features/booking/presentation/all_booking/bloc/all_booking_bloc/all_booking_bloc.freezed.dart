// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'all_booking_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AllBookingEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AllBookingEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AllBookingEvent()';
}


}

/// @nodoc
class $AllBookingEventCopyWith<$Res>  {
$AllBookingEventCopyWith(AllBookingEvent _, $Res Function(AllBookingEvent) __);
}


/// Adds pattern-matching-related methods to [AllBookingEvent].
extension AllBookingEventPatterns on AllBookingEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _LoadBookings value)?  loadBookings,TResult Function( _LoadNextPageBookings value)?  loadNextPageBookings,TResult Function( _UpdateBooking value)?  updateBooking,TResult Function( _UpdateDeliveryStatus value)?  updateDeliveryStatus,TResult Function( _DeleteBooking value)?  deleteBooking,TResult Function( _MarkAsCompleted value)?  markAsCompleted,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoadBookings() when loadBookings != null:
return loadBookings(_that);case _LoadNextPageBookings() when loadNextPageBookings != null:
return loadNextPageBookings(_that);case _UpdateBooking() when updateBooking != null:
return updateBooking(_that);case _UpdateDeliveryStatus() when updateDeliveryStatus != null:
return updateDeliveryStatus(_that);case _DeleteBooking() when deleteBooking != null:
return deleteBooking(_that);case _MarkAsCompleted() when markAsCompleted != null:
return markAsCompleted(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _LoadBookings value)  loadBookings,required TResult Function( _LoadNextPageBookings value)  loadNextPageBookings,required TResult Function( _UpdateBooking value)  updateBooking,required TResult Function( _UpdateDeliveryStatus value)  updateDeliveryStatus,required TResult Function( _DeleteBooking value)  deleteBooking,required TResult Function( _MarkAsCompleted value)  markAsCompleted,}){
final _that = this;
switch (_that) {
case _LoadBookings():
return loadBookings(_that);case _LoadNextPageBookings():
return loadNextPageBookings(_that);case _UpdateBooking():
return updateBooking(_that);case _UpdateDeliveryStatus():
return updateDeliveryStatus(_that);case _DeleteBooking():
return deleteBooking(_that);case _MarkAsCompleted():
return markAsCompleted(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _LoadBookings value)?  loadBookings,TResult? Function( _LoadNextPageBookings value)?  loadNextPageBookings,TResult? Function( _UpdateBooking value)?  updateBooking,TResult? Function( _UpdateDeliveryStatus value)?  updateDeliveryStatus,TResult? Function( _DeleteBooking value)?  deleteBooking,TResult? Function( _MarkAsCompleted value)?  markAsCompleted,}){
final _that = this;
switch (_that) {
case _LoadBookings() when loadBookings != null:
return loadBookings(_that);case _LoadNextPageBookings() when loadNextPageBookings != null:
return loadNextPageBookings(_that);case _UpdateBooking() when updateBooking != null:
return updateBooking(_that);case _UpdateDeliveryStatus() when updateDeliveryStatus != null:
return updateDeliveryStatus(_that);case _DeleteBooking() when deleteBooking != null:
return deleteBooking(_that);case _MarkAsCompleted() when markAsCompleted != null:
return markAsCompleted(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String? status,  String? startDate,  String? endDate,  String? searchQuery)?  loadBookings,TResult Function()?  loadNextPageBookings,TResult Function( DesktopBookingItemEntity? booking,  bool shouldRefresh,  bool isDeleted)?  updateBooking,TResult Function( int bookingId,  DeliveryStatus deliveryStatus)?  updateDeliveryStatus,TResult Function( int bookingId)?  deleteBooking,TResult Function( int bookingId,  DeliveryStatus? currentStatus)?  markAsCompleted,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoadBookings() when loadBookings != null:
return loadBookings(_that.status,_that.startDate,_that.endDate,_that.searchQuery);case _LoadNextPageBookings() when loadNextPageBookings != null:
return loadNextPageBookings();case _UpdateBooking() when updateBooking != null:
return updateBooking(_that.booking,_that.shouldRefresh,_that.isDeleted);case _UpdateDeliveryStatus() when updateDeliveryStatus != null:
return updateDeliveryStatus(_that.bookingId,_that.deliveryStatus);case _DeleteBooking() when deleteBooking != null:
return deleteBooking(_that.bookingId);case _MarkAsCompleted() when markAsCompleted != null:
return markAsCompleted(_that.bookingId,_that.currentStatus);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String? status,  String? startDate,  String? endDate,  String? searchQuery)  loadBookings,required TResult Function()  loadNextPageBookings,required TResult Function( DesktopBookingItemEntity? booking,  bool shouldRefresh,  bool isDeleted)  updateBooking,required TResult Function( int bookingId,  DeliveryStatus deliveryStatus)  updateDeliveryStatus,required TResult Function( int bookingId)  deleteBooking,required TResult Function( int bookingId,  DeliveryStatus? currentStatus)  markAsCompleted,}) {final _that = this;
switch (_that) {
case _LoadBookings():
return loadBookings(_that.status,_that.startDate,_that.endDate,_that.searchQuery);case _LoadNextPageBookings():
return loadNextPageBookings();case _UpdateBooking():
return updateBooking(_that.booking,_that.shouldRefresh,_that.isDeleted);case _UpdateDeliveryStatus():
return updateDeliveryStatus(_that.bookingId,_that.deliveryStatus);case _DeleteBooking():
return deleteBooking(_that.bookingId);case _MarkAsCompleted():
return markAsCompleted(_that.bookingId,_that.currentStatus);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String? status,  String? startDate,  String? endDate,  String? searchQuery)?  loadBookings,TResult? Function()?  loadNextPageBookings,TResult? Function( DesktopBookingItemEntity? booking,  bool shouldRefresh,  bool isDeleted)?  updateBooking,TResult? Function( int bookingId,  DeliveryStatus deliveryStatus)?  updateDeliveryStatus,TResult? Function( int bookingId)?  deleteBooking,TResult? Function( int bookingId,  DeliveryStatus? currentStatus)?  markAsCompleted,}) {final _that = this;
switch (_that) {
case _LoadBookings() when loadBookings != null:
return loadBookings(_that.status,_that.startDate,_that.endDate,_that.searchQuery);case _LoadNextPageBookings() when loadNextPageBookings != null:
return loadNextPageBookings();case _UpdateBooking() when updateBooking != null:
return updateBooking(_that.booking,_that.shouldRefresh,_that.isDeleted);case _UpdateDeliveryStatus() when updateDeliveryStatus != null:
return updateDeliveryStatus(_that.bookingId,_that.deliveryStatus);case _DeleteBooking() when deleteBooking != null:
return deleteBooking(_that.bookingId);case _MarkAsCompleted() when markAsCompleted != null:
return markAsCompleted(_that.bookingId,_that.currentStatus);case _:
  return null;

}
}

}

/// @nodoc


class _LoadBookings implements AllBookingEvent {
  const _LoadBookings({this.status, this.startDate, this.endDate, this.searchQuery});
  

 final  String? status;
 final  String? startDate;
 final  String? endDate;
 final  String? searchQuery;

/// Create a copy of AllBookingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadBookingsCopyWith<_LoadBookings> get copyWith => __$LoadBookingsCopyWithImpl<_LoadBookings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadBookings&&(identical(other.status, status) || other.status == status)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery));
}


@override
int get hashCode => Object.hash(runtimeType,status,startDate,endDate,searchQuery);

@override
String toString() {
  return 'AllBookingEvent.loadBookings(status: $status, startDate: $startDate, endDate: $endDate, searchQuery: $searchQuery)';
}


}

/// @nodoc
abstract mixin class _$LoadBookingsCopyWith<$Res> implements $AllBookingEventCopyWith<$Res> {
  factory _$LoadBookingsCopyWith(_LoadBookings value, $Res Function(_LoadBookings) _then) = __$LoadBookingsCopyWithImpl;
@useResult
$Res call({
 String? status, String? startDate, String? endDate, String? searchQuery
});




}
/// @nodoc
class __$LoadBookingsCopyWithImpl<$Res>
    implements _$LoadBookingsCopyWith<$Res> {
  __$LoadBookingsCopyWithImpl(this._self, this._then);

  final _LoadBookings _self;
  final $Res Function(_LoadBookings) _then;

/// Create a copy of AllBookingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? status = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? searchQuery = freezed,}) {
  return _then(_LoadBookings(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String?,searchQuery: freezed == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _LoadNextPageBookings implements AllBookingEvent {
  const _LoadNextPageBookings();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadNextPageBookings);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AllBookingEvent.loadNextPageBookings()';
}


}




/// @nodoc


class _UpdateBooking implements AllBookingEvent {
  const _UpdateBooking(this.booking, {this.shouldRefresh = false, this.isDeleted = false});
  

 final  DesktopBookingItemEntity? booking;
@JsonKey() final  bool shouldRefresh;
@JsonKey() final  bool isDeleted;

/// Create a copy of AllBookingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateBookingCopyWith<_UpdateBooking> get copyWith => __$UpdateBookingCopyWithImpl<_UpdateBooking>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateBooking&&(identical(other.booking, booking) || other.booking == booking)&&(identical(other.shouldRefresh, shouldRefresh) || other.shouldRefresh == shouldRefresh)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted));
}


@override
int get hashCode => Object.hash(runtimeType,booking,shouldRefresh,isDeleted);

@override
String toString() {
  return 'AllBookingEvent.updateBooking(booking: $booking, shouldRefresh: $shouldRefresh, isDeleted: $isDeleted)';
}


}

/// @nodoc
abstract mixin class _$UpdateBookingCopyWith<$Res> implements $AllBookingEventCopyWith<$Res> {
  factory _$UpdateBookingCopyWith(_UpdateBooking value, $Res Function(_UpdateBooking) _then) = __$UpdateBookingCopyWithImpl;
@useResult
$Res call({
 DesktopBookingItemEntity? booking, bool shouldRefresh, bool isDeleted
});


$DesktopBookingItemEntityCopyWith<$Res>? get booking;

}
/// @nodoc
class __$UpdateBookingCopyWithImpl<$Res>
    implements _$UpdateBookingCopyWith<$Res> {
  __$UpdateBookingCopyWithImpl(this._self, this._then);

  final _UpdateBooking _self;
  final $Res Function(_UpdateBooking) _then;

/// Create a copy of AllBookingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? booking = freezed,Object? shouldRefresh = null,Object? isDeleted = null,}) {
  return _then(_UpdateBooking(
freezed == booking ? _self.booking : booking // ignore: cast_nullable_to_non_nullable
as DesktopBookingItemEntity?,shouldRefresh: null == shouldRefresh ? _self.shouldRefresh : shouldRefresh // ignore: cast_nullable_to_non_nullable
as bool,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of AllBookingEvent
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

/// @nodoc


class _UpdateDeliveryStatus implements AllBookingEvent {
  const _UpdateDeliveryStatus({required this.bookingId, required this.deliveryStatus});
  

 final  int bookingId;
 final  DeliveryStatus deliveryStatus;

/// Create a copy of AllBookingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateDeliveryStatusCopyWith<_UpdateDeliveryStatus> get copyWith => __$UpdateDeliveryStatusCopyWithImpl<_UpdateDeliveryStatus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateDeliveryStatus&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId)&&(identical(other.deliveryStatus, deliveryStatus) || other.deliveryStatus == deliveryStatus));
}


@override
int get hashCode => Object.hash(runtimeType,bookingId,deliveryStatus);

@override
String toString() {
  return 'AllBookingEvent.updateDeliveryStatus(bookingId: $bookingId, deliveryStatus: $deliveryStatus)';
}


}

/// @nodoc
abstract mixin class _$UpdateDeliveryStatusCopyWith<$Res> implements $AllBookingEventCopyWith<$Res> {
  factory _$UpdateDeliveryStatusCopyWith(_UpdateDeliveryStatus value, $Res Function(_UpdateDeliveryStatus) _then) = __$UpdateDeliveryStatusCopyWithImpl;
@useResult
$Res call({
 int bookingId, DeliveryStatus deliveryStatus
});




}
/// @nodoc
class __$UpdateDeliveryStatusCopyWithImpl<$Res>
    implements _$UpdateDeliveryStatusCopyWith<$Res> {
  __$UpdateDeliveryStatusCopyWithImpl(this._self, this._then);

  final _UpdateDeliveryStatus _self;
  final $Res Function(_UpdateDeliveryStatus) _then;

/// Create a copy of AllBookingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? bookingId = null,Object? deliveryStatus = null,}) {
  return _then(_UpdateDeliveryStatus(
bookingId: null == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as int,deliveryStatus: null == deliveryStatus ? _self.deliveryStatus : deliveryStatus // ignore: cast_nullable_to_non_nullable
as DeliveryStatus,
  ));
}


}

/// @nodoc


class _DeleteBooking implements AllBookingEvent {
  const _DeleteBooking({required this.bookingId});
  

 final  int bookingId;

/// Create a copy of AllBookingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeleteBookingCopyWith<_DeleteBooking> get copyWith => __$DeleteBookingCopyWithImpl<_DeleteBooking>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeleteBooking&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId));
}


@override
int get hashCode => Object.hash(runtimeType,bookingId);

@override
String toString() {
  return 'AllBookingEvent.deleteBooking(bookingId: $bookingId)';
}


}

/// @nodoc
abstract mixin class _$DeleteBookingCopyWith<$Res> implements $AllBookingEventCopyWith<$Res> {
  factory _$DeleteBookingCopyWith(_DeleteBooking value, $Res Function(_DeleteBooking) _then) = __$DeleteBookingCopyWithImpl;
@useResult
$Res call({
 int bookingId
});




}
/// @nodoc
class __$DeleteBookingCopyWithImpl<$Res>
    implements _$DeleteBookingCopyWith<$Res> {
  __$DeleteBookingCopyWithImpl(this._self, this._then);

  final _DeleteBooking _self;
  final $Res Function(_DeleteBooking) _then;

/// Create a copy of AllBookingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? bookingId = null,}) {
  return _then(_DeleteBooking(
bookingId: null == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _MarkAsCompleted implements AllBookingEvent {
  const _MarkAsCompleted({required this.bookingId, required this.currentStatus});
  

 final  int bookingId;
 final  DeliveryStatus? currentStatus;

/// Create a copy of AllBookingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MarkAsCompletedCopyWith<_MarkAsCompleted> get copyWith => __$MarkAsCompletedCopyWithImpl<_MarkAsCompleted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MarkAsCompleted&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId)&&(identical(other.currentStatus, currentStatus) || other.currentStatus == currentStatus));
}


@override
int get hashCode => Object.hash(runtimeType,bookingId,currentStatus);

@override
String toString() {
  return 'AllBookingEvent.markAsCompleted(bookingId: $bookingId, currentStatus: $currentStatus)';
}


}

/// @nodoc
abstract mixin class _$MarkAsCompletedCopyWith<$Res> implements $AllBookingEventCopyWith<$Res> {
  factory _$MarkAsCompletedCopyWith(_MarkAsCompleted value, $Res Function(_MarkAsCompleted) _then) = __$MarkAsCompletedCopyWithImpl;
@useResult
$Res call({
 int bookingId, DeliveryStatus? currentStatus
});




}
/// @nodoc
class __$MarkAsCompletedCopyWithImpl<$Res>
    implements _$MarkAsCompletedCopyWith<$Res> {
  __$MarkAsCompletedCopyWithImpl(this._self, this._then);

  final _MarkAsCompleted _self;
  final $Res Function(_MarkAsCompleted) _then;

/// Create a copy of AllBookingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? bookingId = null,Object? currentStatus = freezed,}) {
  return _then(_MarkAsCompleted(
bookingId: null == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as int,currentStatus: freezed == currentStatus ? _self.currentStatus : currentStatus // ignore: cast_nullable_to_non_nullable
as DeliveryStatus?,
  ));
}


}

/// @nodoc
mixin _$AllBookingState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AllBookingState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AllBookingState()';
}


}

/// @nodoc
class $AllBookingStateCopyWith<$Res>  {
$AllBookingStateCopyWith(AllBookingState _, $Res Function(AllBookingState) __);
}


/// Adds pattern-matching-related methods to [AllBookingState].
extension AllBookingStatePatterns on AllBookingState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Loaded value)?  loaded,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Loaded value)  loaded,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Loaded():
return loaded(_that);case _Error():
return error(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Loaded value)?  loaded,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<DesktopBookingItemEntity> bookings,  String? nextPageUrl,  bool isPaginating,  String? startDate,  String? endDate,  String? searchQuery,  String? status,  StatusCountsEntity? statusCounts,  String? actionError)?  loaded,TResult Function( String error)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.bookings,_that.nextPageUrl,_that.isPaginating,_that.startDate,_that.endDate,_that.searchQuery,_that.status,_that.statusCounts,_that.actionError);case _Error() when error != null:
return error(_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<DesktopBookingItemEntity> bookings,  String? nextPageUrl,  bool isPaginating,  String? startDate,  String? endDate,  String? searchQuery,  String? status,  StatusCountsEntity? statusCounts,  String? actionError)  loaded,required TResult Function( String error)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Loaded():
return loaded(_that.bookings,_that.nextPageUrl,_that.isPaginating,_that.startDate,_that.endDate,_that.searchQuery,_that.status,_that.statusCounts,_that.actionError);case _Error():
return error(_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<DesktopBookingItemEntity> bookings,  String? nextPageUrl,  bool isPaginating,  String? startDate,  String? endDate,  String? searchQuery,  String? status,  StatusCountsEntity? statusCounts,  String? actionError)?  loaded,TResult? Function( String error)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.bookings,_that.nextPageUrl,_that.isPaginating,_that.startDate,_that.endDate,_that.searchQuery,_that.status,_that.statusCounts,_that.actionError);case _Error() when error != null:
return error(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements AllBookingState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AllBookingState.initial()';
}


}




/// @nodoc


class _Loading implements AllBookingState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AllBookingState.loading()';
}


}




/// @nodoc


class _Loaded implements AllBookingState {
  const _Loaded({required final  List<DesktopBookingItemEntity> bookings, this.nextPageUrl, this.isPaginating = false, this.startDate, this.endDate, this.searchQuery, this.status, this.statusCounts, this.actionError}): _bookings = bookings;
  

 final  List<DesktopBookingItemEntity> _bookings;
 List<DesktopBookingItemEntity> get bookings {
  if (_bookings is EqualUnmodifiableListView) return _bookings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bookings);
}

 final  String? nextPageUrl;
@JsonKey() final  bool isPaginating;
 final  String? startDate;
 final  String? endDate;
 final  String? searchQuery;
 final  String? status;
 final  StatusCountsEntity? statusCounts;
 final  String? actionError;

/// Create a copy of AllBookingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&const DeepCollectionEquality().equals(other._bookings, _bookings)&&(identical(other.nextPageUrl, nextPageUrl) || other.nextPageUrl == nextPageUrl)&&(identical(other.isPaginating, isPaginating) || other.isPaginating == isPaginating)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.status, status) || other.status == status)&&(identical(other.statusCounts, statusCounts) || other.statusCounts == statusCounts)&&(identical(other.actionError, actionError) || other.actionError == actionError));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_bookings),nextPageUrl,isPaginating,startDate,endDate,searchQuery,status,statusCounts,actionError);

@override
String toString() {
  return 'AllBookingState.loaded(bookings: $bookings, nextPageUrl: $nextPageUrl, isPaginating: $isPaginating, startDate: $startDate, endDate: $endDate, searchQuery: $searchQuery, status: $status, statusCounts: $statusCounts, actionError: $actionError)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $AllBookingStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 List<DesktopBookingItemEntity> bookings, String? nextPageUrl, bool isPaginating, String? startDate, String? endDate, String? searchQuery, String? status, StatusCountsEntity? statusCounts, String? actionError
});


$StatusCountsEntityCopyWith<$Res>? get statusCounts;

}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of AllBookingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? bookings = null,Object? nextPageUrl = freezed,Object? isPaginating = null,Object? startDate = freezed,Object? endDate = freezed,Object? searchQuery = freezed,Object? status = freezed,Object? statusCounts = freezed,Object? actionError = freezed,}) {
  return _then(_Loaded(
bookings: null == bookings ? _self._bookings : bookings // ignore: cast_nullable_to_non_nullable
as List<DesktopBookingItemEntity>,nextPageUrl: freezed == nextPageUrl ? _self.nextPageUrl : nextPageUrl // ignore: cast_nullable_to_non_nullable
as String?,isPaginating: null == isPaginating ? _self.isPaginating : isPaginating // ignore: cast_nullable_to_non_nullable
as bool,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String?,searchQuery: freezed == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,statusCounts: freezed == statusCounts ? _self.statusCounts : statusCounts // ignore: cast_nullable_to_non_nullable
as StatusCountsEntity?,actionError: freezed == actionError ? _self.actionError : actionError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of AllBookingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatusCountsEntityCopyWith<$Res>? get statusCounts {
    if (_self.statusCounts == null) {
    return null;
  }

  return $StatusCountsEntityCopyWith<$Res>(_self.statusCounts!, (value) {
    return _then(_self.copyWith(statusCounts: value));
  });
}
}

/// @nodoc


class _Error implements AllBookingState {
  const _Error(this.error);
  

 final  String error;

/// Create a copy of AllBookingState
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
  return 'AllBookingState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $AllBookingStateCopyWith<$Res> {
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

/// Create a copy of AllBookingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(_Error(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
