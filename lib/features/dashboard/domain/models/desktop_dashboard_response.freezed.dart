// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'desktop_dashboard_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DesktopDashboardResponse {

@JsonKey(name: 'upcoming') List<BookingsModel> get upcoming;@JsonKey(name: 'ongoing_bookings') List<BookingsModel> get ongoingBookings;@JsonKey(name: 'upcoming_count') int get upcomingCount;@JsonKey(name: 'alteration_booking_count') int get alterationBookingCount;@JsonKey(name: 'completed_count') int get completedCount;@JsonKey(name: 'expired_count') int get expiredCount;@JsonKey(name: 'pagination') DesktopDashboardPagination get pagination;
/// Create a copy of DesktopDashboardResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DesktopDashboardResponseCopyWith<DesktopDashboardResponse> get copyWith => _$DesktopDashboardResponseCopyWithImpl<DesktopDashboardResponse>(this as DesktopDashboardResponse, _$identity);

  /// Serializes this DesktopDashboardResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DesktopDashboardResponse&&const DeepCollectionEquality().equals(other.upcoming, upcoming)&&const DeepCollectionEquality().equals(other.ongoingBookings, ongoingBookings)&&(identical(other.upcomingCount, upcomingCount) || other.upcomingCount == upcomingCount)&&(identical(other.alterationBookingCount, alterationBookingCount) || other.alterationBookingCount == alterationBookingCount)&&(identical(other.completedCount, completedCount) || other.completedCount == completedCount)&&(identical(other.expiredCount, expiredCount) || other.expiredCount == expiredCount)&&(identical(other.pagination, pagination) || other.pagination == pagination));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(upcoming),const DeepCollectionEquality().hash(ongoingBookings),upcomingCount,alterationBookingCount,completedCount,expiredCount,pagination);

@override
String toString() {
  return 'DesktopDashboardResponse(upcoming: $upcoming, ongoingBookings: $ongoingBookings, upcomingCount: $upcomingCount, alterationBookingCount: $alterationBookingCount, completedCount: $completedCount, expiredCount: $expiredCount, pagination: $pagination)';
}


}

/// @nodoc
abstract mixin class $DesktopDashboardResponseCopyWith<$Res>  {
  factory $DesktopDashboardResponseCopyWith(DesktopDashboardResponse value, $Res Function(DesktopDashboardResponse) _then) = _$DesktopDashboardResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'upcoming') List<BookingsModel> upcoming,@JsonKey(name: 'ongoing_bookings') List<BookingsModel> ongoingBookings,@JsonKey(name: 'upcoming_count') int upcomingCount,@JsonKey(name: 'alteration_booking_count') int alterationBookingCount,@JsonKey(name: 'completed_count') int completedCount,@JsonKey(name: 'expired_count') int expiredCount,@JsonKey(name: 'pagination') DesktopDashboardPagination pagination
});


$DesktopDashboardPaginationCopyWith<$Res> get pagination;

}
/// @nodoc
class _$DesktopDashboardResponseCopyWithImpl<$Res>
    implements $DesktopDashboardResponseCopyWith<$Res> {
  _$DesktopDashboardResponseCopyWithImpl(this._self, this._then);

  final DesktopDashboardResponse _self;
  final $Res Function(DesktopDashboardResponse) _then;

/// Create a copy of DesktopDashboardResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? upcoming = null,Object? ongoingBookings = null,Object? upcomingCount = null,Object? alterationBookingCount = null,Object? completedCount = null,Object? expiredCount = null,Object? pagination = null,}) {
  return _then(_self.copyWith(
upcoming: null == upcoming ? _self.upcoming : upcoming // ignore: cast_nullable_to_non_nullable
as List<BookingsModel>,ongoingBookings: null == ongoingBookings ? _self.ongoingBookings : ongoingBookings // ignore: cast_nullable_to_non_nullable
as List<BookingsModel>,upcomingCount: null == upcomingCount ? _self.upcomingCount : upcomingCount // ignore: cast_nullable_to_non_nullable
as int,alterationBookingCount: null == alterationBookingCount ? _self.alterationBookingCount : alterationBookingCount // ignore: cast_nullable_to_non_nullable
as int,completedCount: null == completedCount ? _self.completedCount : completedCount // ignore: cast_nullable_to_non_nullable
as int,expiredCount: null == expiredCount ? _self.expiredCount : expiredCount // ignore: cast_nullable_to_non_nullable
as int,pagination: null == pagination ? _self.pagination : pagination // ignore: cast_nullable_to_non_nullable
as DesktopDashboardPagination,
  ));
}
/// Create a copy of DesktopDashboardResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DesktopDashboardPaginationCopyWith<$Res> get pagination {
  
  return $DesktopDashboardPaginationCopyWith<$Res>(_self.pagination, (value) {
    return _then(_self.copyWith(pagination: value));
  });
}
}


/// Adds pattern-matching-related methods to [DesktopDashboardResponse].
extension DesktopDashboardResponsePatterns on DesktopDashboardResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DesktopDashboardResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DesktopDashboardResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DesktopDashboardResponse value)  $default,){
final _that = this;
switch (_that) {
case _DesktopDashboardResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DesktopDashboardResponse value)?  $default,){
final _that = this;
switch (_that) {
case _DesktopDashboardResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'upcoming')  List<BookingsModel> upcoming, @JsonKey(name: 'ongoing_bookings')  List<BookingsModel> ongoingBookings, @JsonKey(name: 'upcoming_count')  int upcomingCount, @JsonKey(name: 'alteration_booking_count')  int alterationBookingCount, @JsonKey(name: 'completed_count')  int completedCount, @JsonKey(name: 'expired_count')  int expiredCount, @JsonKey(name: 'pagination')  DesktopDashboardPagination pagination)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DesktopDashboardResponse() when $default != null:
return $default(_that.upcoming,_that.ongoingBookings,_that.upcomingCount,_that.alterationBookingCount,_that.completedCount,_that.expiredCount,_that.pagination);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'upcoming')  List<BookingsModel> upcoming, @JsonKey(name: 'ongoing_bookings')  List<BookingsModel> ongoingBookings, @JsonKey(name: 'upcoming_count')  int upcomingCount, @JsonKey(name: 'alteration_booking_count')  int alterationBookingCount, @JsonKey(name: 'completed_count')  int completedCount, @JsonKey(name: 'expired_count')  int expiredCount, @JsonKey(name: 'pagination')  DesktopDashboardPagination pagination)  $default,) {final _that = this;
switch (_that) {
case _DesktopDashboardResponse():
return $default(_that.upcoming,_that.ongoingBookings,_that.upcomingCount,_that.alterationBookingCount,_that.completedCount,_that.expiredCount,_that.pagination);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'upcoming')  List<BookingsModel> upcoming, @JsonKey(name: 'ongoing_bookings')  List<BookingsModel> ongoingBookings, @JsonKey(name: 'upcoming_count')  int upcomingCount, @JsonKey(name: 'alteration_booking_count')  int alterationBookingCount, @JsonKey(name: 'completed_count')  int completedCount, @JsonKey(name: 'expired_count')  int expiredCount, @JsonKey(name: 'pagination')  DesktopDashboardPagination pagination)?  $default,) {final _that = this;
switch (_that) {
case _DesktopDashboardResponse() when $default != null:
return $default(_that.upcoming,_that.ongoingBookings,_that.upcomingCount,_that.alterationBookingCount,_that.completedCount,_that.expiredCount,_that.pagination);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DesktopDashboardResponse implements DesktopDashboardResponse {
  const _DesktopDashboardResponse({@JsonKey(name: 'upcoming') required final  List<BookingsModel> upcoming, @JsonKey(name: 'ongoing_bookings') required final  List<BookingsModel> ongoingBookings, @JsonKey(name: 'upcoming_count') required this.upcomingCount, @JsonKey(name: 'alteration_booking_count') required this.alterationBookingCount, @JsonKey(name: 'completed_count') required this.completedCount, @JsonKey(name: 'expired_count') required this.expiredCount, @JsonKey(name: 'pagination') required this.pagination}): _upcoming = upcoming,_ongoingBookings = ongoingBookings;
  factory _DesktopDashboardResponse.fromJson(Map<String, dynamic> json) => _$DesktopDashboardResponseFromJson(json);

 final  List<BookingsModel> _upcoming;
@override@JsonKey(name: 'upcoming') List<BookingsModel> get upcoming {
  if (_upcoming is EqualUnmodifiableListView) return _upcoming;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_upcoming);
}

 final  List<BookingsModel> _ongoingBookings;
@override@JsonKey(name: 'ongoing_bookings') List<BookingsModel> get ongoingBookings {
  if (_ongoingBookings is EqualUnmodifiableListView) return _ongoingBookings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ongoingBookings);
}

@override@JsonKey(name: 'upcoming_count') final  int upcomingCount;
@override@JsonKey(name: 'alteration_booking_count') final  int alterationBookingCount;
@override@JsonKey(name: 'completed_count') final  int completedCount;
@override@JsonKey(name: 'expired_count') final  int expiredCount;
@override@JsonKey(name: 'pagination') final  DesktopDashboardPagination pagination;

/// Create a copy of DesktopDashboardResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DesktopDashboardResponseCopyWith<_DesktopDashboardResponse> get copyWith => __$DesktopDashboardResponseCopyWithImpl<_DesktopDashboardResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DesktopDashboardResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DesktopDashboardResponse&&const DeepCollectionEquality().equals(other._upcoming, _upcoming)&&const DeepCollectionEquality().equals(other._ongoingBookings, _ongoingBookings)&&(identical(other.upcomingCount, upcomingCount) || other.upcomingCount == upcomingCount)&&(identical(other.alterationBookingCount, alterationBookingCount) || other.alterationBookingCount == alterationBookingCount)&&(identical(other.completedCount, completedCount) || other.completedCount == completedCount)&&(identical(other.expiredCount, expiredCount) || other.expiredCount == expiredCount)&&(identical(other.pagination, pagination) || other.pagination == pagination));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_upcoming),const DeepCollectionEquality().hash(_ongoingBookings),upcomingCount,alterationBookingCount,completedCount,expiredCount,pagination);

@override
String toString() {
  return 'DesktopDashboardResponse(upcoming: $upcoming, ongoingBookings: $ongoingBookings, upcomingCount: $upcomingCount, alterationBookingCount: $alterationBookingCount, completedCount: $completedCount, expiredCount: $expiredCount, pagination: $pagination)';
}


}

/// @nodoc
abstract mixin class _$DesktopDashboardResponseCopyWith<$Res> implements $DesktopDashboardResponseCopyWith<$Res> {
  factory _$DesktopDashboardResponseCopyWith(_DesktopDashboardResponse value, $Res Function(_DesktopDashboardResponse) _then) = __$DesktopDashboardResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'upcoming') List<BookingsModel> upcoming,@JsonKey(name: 'ongoing_bookings') List<BookingsModel> ongoingBookings,@JsonKey(name: 'upcoming_count') int upcomingCount,@JsonKey(name: 'alteration_booking_count') int alterationBookingCount,@JsonKey(name: 'completed_count') int completedCount,@JsonKey(name: 'expired_count') int expiredCount,@JsonKey(name: 'pagination') DesktopDashboardPagination pagination
});


@override $DesktopDashboardPaginationCopyWith<$Res> get pagination;

}
/// @nodoc
class __$DesktopDashboardResponseCopyWithImpl<$Res>
    implements _$DesktopDashboardResponseCopyWith<$Res> {
  __$DesktopDashboardResponseCopyWithImpl(this._self, this._then);

  final _DesktopDashboardResponse _self;
  final $Res Function(_DesktopDashboardResponse) _then;

/// Create a copy of DesktopDashboardResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? upcoming = null,Object? ongoingBookings = null,Object? upcomingCount = null,Object? alterationBookingCount = null,Object? completedCount = null,Object? expiredCount = null,Object? pagination = null,}) {
  return _then(_DesktopDashboardResponse(
upcoming: null == upcoming ? _self._upcoming : upcoming // ignore: cast_nullable_to_non_nullable
as List<BookingsModel>,ongoingBookings: null == ongoingBookings ? _self._ongoingBookings : ongoingBookings // ignore: cast_nullable_to_non_nullable
as List<BookingsModel>,upcomingCount: null == upcomingCount ? _self.upcomingCount : upcomingCount // ignore: cast_nullable_to_non_nullable
as int,alterationBookingCount: null == alterationBookingCount ? _self.alterationBookingCount : alterationBookingCount // ignore: cast_nullable_to_non_nullable
as int,completedCount: null == completedCount ? _self.completedCount : completedCount // ignore: cast_nullable_to_non_nullable
as int,expiredCount: null == expiredCount ? _self.expiredCount : expiredCount // ignore: cast_nullable_to_non_nullable
as int,pagination: null == pagination ? _self.pagination : pagination // ignore: cast_nullable_to_non_nullable
as DesktopDashboardPagination,
  ));
}

/// Create a copy of DesktopDashboardResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DesktopDashboardPaginationCopyWith<$Res> get pagination {
  
  return $DesktopDashboardPaginationCopyWith<$Res>(_self.pagination, (value) {
    return _then(_self.copyWith(pagination: value));
  });
}
}


/// @nodoc
mixin _$DesktopDashboardCarouselData {

 int get upcomingCount; int get alterationBookingCount; int get completedCount; int get expiredCount;
/// Create a copy of DesktopDashboardCarouselData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DesktopDashboardCarouselDataCopyWith<DesktopDashboardCarouselData> get copyWith => _$DesktopDashboardCarouselDataCopyWithImpl<DesktopDashboardCarouselData>(this as DesktopDashboardCarouselData, _$identity);

  /// Serializes this DesktopDashboardCarouselData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DesktopDashboardCarouselData&&(identical(other.upcomingCount, upcomingCount) || other.upcomingCount == upcomingCount)&&(identical(other.alterationBookingCount, alterationBookingCount) || other.alterationBookingCount == alterationBookingCount)&&(identical(other.completedCount, completedCount) || other.completedCount == completedCount)&&(identical(other.expiredCount, expiredCount) || other.expiredCount == expiredCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,upcomingCount,alterationBookingCount,completedCount,expiredCount);

@override
String toString() {
  return 'DesktopDashboardCarouselData(upcomingCount: $upcomingCount, alterationBookingCount: $alterationBookingCount, completedCount: $completedCount, expiredCount: $expiredCount)';
}


}

/// @nodoc
abstract mixin class $DesktopDashboardCarouselDataCopyWith<$Res>  {
  factory $DesktopDashboardCarouselDataCopyWith(DesktopDashboardCarouselData value, $Res Function(DesktopDashboardCarouselData) _then) = _$DesktopDashboardCarouselDataCopyWithImpl;
@useResult
$Res call({
 int upcomingCount, int alterationBookingCount, int completedCount, int expiredCount
});




}
/// @nodoc
class _$DesktopDashboardCarouselDataCopyWithImpl<$Res>
    implements $DesktopDashboardCarouselDataCopyWith<$Res> {
  _$DesktopDashboardCarouselDataCopyWithImpl(this._self, this._then);

  final DesktopDashboardCarouselData _self;
  final $Res Function(DesktopDashboardCarouselData) _then;

/// Create a copy of DesktopDashboardCarouselData
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


/// Adds pattern-matching-related methods to [DesktopDashboardCarouselData].
extension DesktopDashboardCarouselDataPatterns on DesktopDashboardCarouselData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DesktopDashboardCarouselData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DesktopDashboardCarouselData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DesktopDashboardCarouselData value)  $default,){
final _that = this;
switch (_that) {
case _DesktopDashboardCarouselData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DesktopDashboardCarouselData value)?  $default,){
final _that = this;
switch (_that) {
case _DesktopDashboardCarouselData() when $default != null:
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
case _DesktopDashboardCarouselData() when $default != null:
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
case _DesktopDashboardCarouselData():
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
case _DesktopDashboardCarouselData() when $default != null:
return $default(_that.upcomingCount,_that.alterationBookingCount,_that.completedCount,_that.expiredCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DesktopDashboardCarouselData implements DesktopDashboardCarouselData {
  const _DesktopDashboardCarouselData({required this.upcomingCount, required this.alterationBookingCount, required this.completedCount, required this.expiredCount});
  factory _DesktopDashboardCarouselData.fromJson(Map<String, dynamic> json) => _$DesktopDashboardCarouselDataFromJson(json);

@override final  int upcomingCount;
@override final  int alterationBookingCount;
@override final  int completedCount;
@override final  int expiredCount;

/// Create a copy of DesktopDashboardCarouselData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DesktopDashboardCarouselDataCopyWith<_DesktopDashboardCarouselData> get copyWith => __$DesktopDashboardCarouselDataCopyWithImpl<_DesktopDashboardCarouselData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DesktopDashboardCarouselDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DesktopDashboardCarouselData&&(identical(other.upcomingCount, upcomingCount) || other.upcomingCount == upcomingCount)&&(identical(other.alterationBookingCount, alterationBookingCount) || other.alterationBookingCount == alterationBookingCount)&&(identical(other.completedCount, completedCount) || other.completedCount == completedCount)&&(identical(other.expiredCount, expiredCount) || other.expiredCount == expiredCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,upcomingCount,alterationBookingCount,completedCount,expiredCount);

@override
String toString() {
  return 'DesktopDashboardCarouselData(upcomingCount: $upcomingCount, alterationBookingCount: $alterationBookingCount, completedCount: $completedCount, expiredCount: $expiredCount)';
}


}

/// @nodoc
abstract mixin class _$DesktopDashboardCarouselDataCopyWith<$Res> implements $DesktopDashboardCarouselDataCopyWith<$Res> {
  factory _$DesktopDashboardCarouselDataCopyWith(_DesktopDashboardCarouselData value, $Res Function(_DesktopDashboardCarouselData) _then) = __$DesktopDashboardCarouselDataCopyWithImpl;
@override @useResult
$Res call({
 int upcomingCount, int alterationBookingCount, int completedCount, int expiredCount
});




}
/// @nodoc
class __$DesktopDashboardCarouselDataCopyWithImpl<$Res>
    implements _$DesktopDashboardCarouselDataCopyWith<$Res> {
  __$DesktopDashboardCarouselDataCopyWithImpl(this._self, this._then);

  final _DesktopDashboardCarouselData _self;
  final $Res Function(_DesktopDashboardCarouselData) _then;

/// Create a copy of DesktopDashboardCarouselData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? upcomingCount = null,Object? alterationBookingCount = null,Object? completedCount = null,Object? expiredCount = null,}) {
  return _then(_DesktopDashboardCarouselData(
upcomingCount: null == upcomingCount ? _self.upcomingCount : upcomingCount // ignore: cast_nullable_to_non_nullable
as int,alterationBookingCount: null == alterationBookingCount ? _self.alterationBookingCount : alterationBookingCount // ignore: cast_nullable_to_non_nullable
as int,completedCount: null == completedCount ? _self.completedCount : completedCount // ignore: cast_nullable_to_non_nullable
as int,expiredCount: null == expiredCount ? _self.expiredCount : expiredCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$DesktopDashboardPagination {

@JsonKey(name: 'upcoming') PaginationInfo get upcoming;@JsonKey(name: 'ongoing') PaginationInfo get ongoing;
/// Create a copy of DesktopDashboardPagination
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DesktopDashboardPaginationCopyWith<DesktopDashboardPagination> get copyWith => _$DesktopDashboardPaginationCopyWithImpl<DesktopDashboardPagination>(this as DesktopDashboardPagination, _$identity);

  /// Serializes this DesktopDashboardPagination to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DesktopDashboardPagination&&(identical(other.upcoming, upcoming) || other.upcoming == upcoming)&&(identical(other.ongoing, ongoing) || other.ongoing == ongoing));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,upcoming,ongoing);

@override
String toString() {
  return 'DesktopDashboardPagination(upcoming: $upcoming, ongoing: $ongoing)';
}


}

/// @nodoc
abstract mixin class $DesktopDashboardPaginationCopyWith<$Res>  {
  factory $DesktopDashboardPaginationCopyWith(DesktopDashboardPagination value, $Res Function(DesktopDashboardPagination) _then) = _$DesktopDashboardPaginationCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'upcoming') PaginationInfo upcoming,@JsonKey(name: 'ongoing') PaginationInfo ongoing
});


$PaginationInfoCopyWith<$Res> get upcoming;$PaginationInfoCopyWith<$Res> get ongoing;

}
/// @nodoc
class _$DesktopDashboardPaginationCopyWithImpl<$Res>
    implements $DesktopDashboardPaginationCopyWith<$Res> {
  _$DesktopDashboardPaginationCopyWithImpl(this._self, this._then);

  final DesktopDashboardPagination _self;
  final $Res Function(DesktopDashboardPagination) _then;

/// Create a copy of DesktopDashboardPagination
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? upcoming = null,Object? ongoing = null,}) {
  return _then(_self.copyWith(
upcoming: null == upcoming ? _self.upcoming : upcoming // ignore: cast_nullable_to_non_nullable
as PaginationInfo,ongoing: null == ongoing ? _self.ongoing : ongoing // ignore: cast_nullable_to_non_nullable
as PaginationInfo,
  ));
}
/// Create a copy of DesktopDashboardPagination
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaginationInfoCopyWith<$Res> get upcoming {
  
  return $PaginationInfoCopyWith<$Res>(_self.upcoming, (value) {
    return _then(_self.copyWith(upcoming: value));
  });
}/// Create a copy of DesktopDashboardPagination
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaginationInfoCopyWith<$Res> get ongoing {
  
  return $PaginationInfoCopyWith<$Res>(_self.ongoing, (value) {
    return _then(_self.copyWith(ongoing: value));
  });
}
}


/// Adds pattern-matching-related methods to [DesktopDashboardPagination].
extension DesktopDashboardPaginationPatterns on DesktopDashboardPagination {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DesktopDashboardPagination value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DesktopDashboardPagination() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DesktopDashboardPagination value)  $default,){
final _that = this;
switch (_that) {
case _DesktopDashboardPagination():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DesktopDashboardPagination value)?  $default,){
final _that = this;
switch (_that) {
case _DesktopDashboardPagination() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'upcoming')  PaginationInfo upcoming, @JsonKey(name: 'ongoing')  PaginationInfo ongoing)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DesktopDashboardPagination() when $default != null:
return $default(_that.upcoming,_that.ongoing);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'upcoming')  PaginationInfo upcoming, @JsonKey(name: 'ongoing')  PaginationInfo ongoing)  $default,) {final _that = this;
switch (_that) {
case _DesktopDashboardPagination():
return $default(_that.upcoming,_that.ongoing);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'upcoming')  PaginationInfo upcoming, @JsonKey(name: 'ongoing')  PaginationInfo ongoing)?  $default,) {final _that = this;
switch (_that) {
case _DesktopDashboardPagination() when $default != null:
return $default(_that.upcoming,_that.ongoing);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DesktopDashboardPagination implements DesktopDashboardPagination {
  const _DesktopDashboardPagination({@JsonKey(name: 'upcoming') required this.upcoming, @JsonKey(name: 'ongoing') required this.ongoing});
  factory _DesktopDashboardPagination.fromJson(Map<String, dynamic> json) => _$DesktopDashboardPaginationFromJson(json);

@override@JsonKey(name: 'upcoming') final  PaginationInfo upcoming;
@override@JsonKey(name: 'ongoing') final  PaginationInfo ongoing;

/// Create a copy of DesktopDashboardPagination
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DesktopDashboardPaginationCopyWith<_DesktopDashboardPagination> get copyWith => __$DesktopDashboardPaginationCopyWithImpl<_DesktopDashboardPagination>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DesktopDashboardPaginationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DesktopDashboardPagination&&(identical(other.upcoming, upcoming) || other.upcoming == upcoming)&&(identical(other.ongoing, ongoing) || other.ongoing == ongoing));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,upcoming,ongoing);

@override
String toString() {
  return 'DesktopDashboardPagination(upcoming: $upcoming, ongoing: $ongoing)';
}


}

/// @nodoc
abstract mixin class _$DesktopDashboardPaginationCopyWith<$Res> implements $DesktopDashboardPaginationCopyWith<$Res> {
  factory _$DesktopDashboardPaginationCopyWith(_DesktopDashboardPagination value, $Res Function(_DesktopDashboardPagination) _then) = __$DesktopDashboardPaginationCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'upcoming') PaginationInfo upcoming,@JsonKey(name: 'ongoing') PaginationInfo ongoing
});


@override $PaginationInfoCopyWith<$Res> get upcoming;@override $PaginationInfoCopyWith<$Res> get ongoing;

}
/// @nodoc
class __$DesktopDashboardPaginationCopyWithImpl<$Res>
    implements _$DesktopDashboardPaginationCopyWith<$Res> {
  __$DesktopDashboardPaginationCopyWithImpl(this._self, this._then);

  final _DesktopDashboardPagination _self;
  final $Res Function(_DesktopDashboardPagination) _then;

/// Create a copy of DesktopDashboardPagination
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? upcoming = null,Object? ongoing = null,}) {
  return _then(_DesktopDashboardPagination(
upcoming: null == upcoming ? _self.upcoming : upcoming // ignore: cast_nullable_to_non_nullable
as PaginationInfo,ongoing: null == ongoing ? _self.ongoing : ongoing // ignore: cast_nullable_to_non_nullable
as PaginationInfo,
  ));
}

/// Create a copy of DesktopDashboardPagination
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaginationInfoCopyWith<$Res> get upcoming {
  
  return $PaginationInfoCopyWith<$Res>(_self.upcoming, (value) {
    return _then(_self.copyWith(upcoming: value));
  });
}/// Create a copy of DesktopDashboardPagination
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaginationInfoCopyWith<$Res> get ongoing {
  
  return $PaginationInfoCopyWith<$Res>(_self.ongoing, (value) {
    return _then(_self.copyWith(ongoing: value));
  });
}
}


/// @nodoc
mixin _$PaginationInfo {

 String? get next; String? get previous; int get count;@JsonKey(name: 'page_size') int get pageSize;@JsonKey(name: 'current_page') int get currentPage;@JsonKey(name: 'total_pages') int get totalPages;@JsonKey(name: 'start_index') int get startIndex;@JsonKey(name: 'end_index') int get endIndex;
/// Create a copy of PaginationInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaginationInfoCopyWith<PaginationInfo> get copyWith => _$PaginationInfoCopyWithImpl<PaginationInfo>(this as PaginationInfo, _$identity);

  /// Serializes this PaginationInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaginationInfo&&(identical(other.next, next) || other.next == next)&&(identical(other.previous, previous) || other.previous == previous)&&(identical(other.count, count) || other.count == count)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.startIndex, startIndex) || other.startIndex == startIndex)&&(identical(other.endIndex, endIndex) || other.endIndex == endIndex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,next,previous,count,pageSize,currentPage,totalPages,startIndex,endIndex);

@override
String toString() {
  return 'PaginationInfo(next: $next, previous: $previous, count: $count, pageSize: $pageSize, currentPage: $currentPage, totalPages: $totalPages, startIndex: $startIndex, endIndex: $endIndex)';
}


}

/// @nodoc
abstract mixin class $PaginationInfoCopyWith<$Res>  {
  factory $PaginationInfoCopyWith(PaginationInfo value, $Res Function(PaginationInfo) _then) = _$PaginationInfoCopyWithImpl;
@useResult
$Res call({
 String? next, String? previous, int count,@JsonKey(name: 'page_size') int pageSize,@JsonKey(name: 'current_page') int currentPage,@JsonKey(name: 'total_pages') int totalPages,@JsonKey(name: 'start_index') int startIndex,@JsonKey(name: 'end_index') int endIndex
});




}
/// @nodoc
class _$PaginationInfoCopyWithImpl<$Res>
    implements $PaginationInfoCopyWith<$Res> {
  _$PaginationInfoCopyWithImpl(this._self, this._then);

  final PaginationInfo _self;
  final $Res Function(PaginationInfo) _then;

/// Create a copy of PaginationInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? next = freezed,Object? previous = freezed,Object? count = null,Object? pageSize = null,Object? currentPage = null,Object? totalPages = null,Object? startIndex = null,Object? endIndex = null,}) {
  return _then(_self.copyWith(
next: freezed == next ? _self.next : next // ignore: cast_nullable_to_non_nullable
as String?,previous: freezed == previous ? _self.previous : previous // ignore: cast_nullable_to_non_nullable
as String?,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,startIndex: null == startIndex ? _self.startIndex : startIndex // ignore: cast_nullable_to_non_nullable
as int,endIndex: null == endIndex ? _self.endIndex : endIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PaginationInfo].
extension PaginationInfoPatterns on PaginationInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaginationInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaginationInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaginationInfo value)  $default,){
final _that = this;
switch (_that) {
case _PaginationInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaginationInfo value)?  $default,){
final _that = this;
switch (_that) {
case _PaginationInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? next,  String? previous,  int count, @JsonKey(name: 'page_size')  int pageSize, @JsonKey(name: 'current_page')  int currentPage, @JsonKey(name: 'total_pages')  int totalPages, @JsonKey(name: 'start_index')  int startIndex, @JsonKey(name: 'end_index')  int endIndex)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaginationInfo() when $default != null:
return $default(_that.next,_that.previous,_that.count,_that.pageSize,_that.currentPage,_that.totalPages,_that.startIndex,_that.endIndex);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? next,  String? previous,  int count, @JsonKey(name: 'page_size')  int pageSize, @JsonKey(name: 'current_page')  int currentPage, @JsonKey(name: 'total_pages')  int totalPages, @JsonKey(name: 'start_index')  int startIndex, @JsonKey(name: 'end_index')  int endIndex)  $default,) {final _that = this;
switch (_that) {
case _PaginationInfo():
return $default(_that.next,_that.previous,_that.count,_that.pageSize,_that.currentPage,_that.totalPages,_that.startIndex,_that.endIndex);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? next,  String? previous,  int count, @JsonKey(name: 'page_size')  int pageSize, @JsonKey(name: 'current_page')  int currentPage, @JsonKey(name: 'total_pages')  int totalPages, @JsonKey(name: 'start_index')  int startIndex, @JsonKey(name: 'end_index')  int endIndex)?  $default,) {final _that = this;
switch (_that) {
case _PaginationInfo() when $default != null:
return $default(_that.next,_that.previous,_that.count,_that.pageSize,_that.currentPage,_that.totalPages,_that.startIndex,_that.endIndex);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaginationInfo implements PaginationInfo {
  const _PaginationInfo({this.next, this.previous, required this.count, @JsonKey(name: 'page_size') required this.pageSize, @JsonKey(name: 'current_page') required this.currentPage, @JsonKey(name: 'total_pages') required this.totalPages, @JsonKey(name: 'start_index') required this.startIndex, @JsonKey(name: 'end_index') required this.endIndex});
  factory _PaginationInfo.fromJson(Map<String, dynamic> json) => _$PaginationInfoFromJson(json);

@override final  String? next;
@override final  String? previous;
@override final  int count;
@override@JsonKey(name: 'page_size') final  int pageSize;
@override@JsonKey(name: 'current_page') final  int currentPage;
@override@JsonKey(name: 'total_pages') final  int totalPages;
@override@JsonKey(name: 'start_index') final  int startIndex;
@override@JsonKey(name: 'end_index') final  int endIndex;

/// Create a copy of PaginationInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaginationInfoCopyWith<_PaginationInfo> get copyWith => __$PaginationInfoCopyWithImpl<_PaginationInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaginationInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaginationInfo&&(identical(other.next, next) || other.next == next)&&(identical(other.previous, previous) || other.previous == previous)&&(identical(other.count, count) || other.count == count)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.startIndex, startIndex) || other.startIndex == startIndex)&&(identical(other.endIndex, endIndex) || other.endIndex == endIndex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,next,previous,count,pageSize,currentPage,totalPages,startIndex,endIndex);

@override
String toString() {
  return 'PaginationInfo(next: $next, previous: $previous, count: $count, pageSize: $pageSize, currentPage: $currentPage, totalPages: $totalPages, startIndex: $startIndex, endIndex: $endIndex)';
}


}

/// @nodoc
abstract mixin class _$PaginationInfoCopyWith<$Res> implements $PaginationInfoCopyWith<$Res> {
  factory _$PaginationInfoCopyWith(_PaginationInfo value, $Res Function(_PaginationInfo) _then) = __$PaginationInfoCopyWithImpl;
@override @useResult
$Res call({
 String? next, String? previous, int count,@JsonKey(name: 'page_size') int pageSize,@JsonKey(name: 'current_page') int currentPage,@JsonKey(name: 'total_pages') int totalPages,@JsonKey(name: 'start_index') int startIndex,@JsonKey(name: 'end_index') int endIndex
});




}
/// @nodoc
class __$PaginationInfoCopyWithImpl<$Res>
    implements _$PaginationInfoCopyWith<$Res> {
  __$PaginationInfoCopyWithImpl(this._self, this._then);

  final _PaginationInfo _self;
  final $Res Function(_PaginationInfo) _then;

/// Create a copy of PaginationInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? next = freezed,Object? previous = freezed,Object? count = null,Object? pageSize = null,Object? currentPage = null,Object? totalPages = null,Object? startIndex = null,Object? endIndex = null,}) {
  return _then(_PaginationInfo(
next: freezed == next ? _self.next : next // ignore: cast_nullable_to_non_nullable
as String?,previous: freezed == previous ? _self.previous : previous // ignore: cast_nullable_to_non_nullable
as String?,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,startIndex: null == startIndex ? _self.startIndex : startIndex // ignore: cast_nullable_to_non_nullable
as int,endIndex: null == endIndex ? _self.endIndex : endIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
