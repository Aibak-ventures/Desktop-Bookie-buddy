// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DashboardEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DashboardEvent()';
}


}

/// @nodoc
class $DashboardEventCopyWith<$Res>  {
$DashboardEventCopyWith(DashboardEvent _, $Res Function(DashboardEvent) __);
}


/// Adds pattern-matching-related methods to [DashboardEvent].
extension DashboardEventPatterns on DashboardEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _LoadDashboardData value)?  loadDashboardData,TResult Function( _LoadDashboardNextPageData value)?  loadDashboardNextPageData,TResult Function( _UpdateData value)?  updateData,TResult Function( _LoadIfNot value)?  loadIfNot,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoadDashboardData() when loadDashboardData != null:
return loadDashboardData(_that);case _LoadDashboardNextPageData() when loadDashboardNextPageData != null:
return loadDashboardNextPageData(_that);case _UpdateData() when updateData != null:
return updateData(_that);case _LoadIfNot() when loadIfNot != null:
return loadIfNot(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _LoadDashboardData value)  loadDashboardData,required TResult Function( _LoadDashboardNextPageData value)  loadDashboardNextPageData,required TResult Function( _UpdateData value)  updateData,required TResult Function( _LoadIfNot value)  loadIfNot,}){
final _that = this;
switch (_that) {
case _LoadDashboardData():
return loadDashboardData(_that);case _LoadDashboardNextPageData():
return loadDashboardNextPageData(_that);case _UpdateData():
return updateData(_that);case _LoadIfNot():
return loadIfNot(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _LoadDashboardData value)?  loadDashboardData,TResult? Function( _LoadDashboardNextPageData value)?  loadDashboardNextPageData,TResult? Function( _UpdateData value)?  updateData,TResult? Function( _LoadIfNot value)?  loadIfNot,}){
final _that = this;
switch (_that) {
case _LoadDashboardData() when loadDashboardData != null:
return loadDashboardData(_that);case _LoadDashboardNextPageData() when loadDashboardNextPageData != null:
return loadDashboardNextPageData(_that);case _UpdateData() when updateData != null:
return updateData(_that);case _LoadIfNot() when loadIfNot != null:
return loadIfNot(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( UserEntity? activeShop,  bool useOldState)?  loadDashboardData,TResult Function()?  loadDashboardNextPageData,TResult Function( BookingEntity? updateBooking,  bool shouldRefresh,  bool isDeleted)?  updateData,TResult Function()?  loadIfNot,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoadDashboardData() when loadDashboardData != null:
return loadDashboardData(_that.activeShop,_that.useOldState);case _LoadDashboardNextPageData() when loadDashboardNextPageData != null:
return loadDashboardNextPageData();case _UpdateData() when updateData != null:
return updateData(_that.updateBooking,_that.shouldRefresh,_that.isDeleted);case _LoadIfNot() when loadIfNot != null:
return loadIfNot();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( UserEntity? activeShop,  bool useOldState)  loadDashboardData,required TResult Function()  loadDashboardNextPageData,required TResult Function( BookingEntity? updateBooking,  bool shouldRefresh,  bool isDeleted)  updateData,required TResult Function()  loadIfNot,}) {final _that = this;
switch (_that) {
case _LoadDashboardData():
return loadDashboardData(_that.activeShop,_that.useOldState);case _LoadDashboardNextPageData():
return loadDashboardNextPageData();case _UpdateData():
return updateData(_that.updateBooking,_that.shouldRefresh,_that.isDeleted);case _LoadIfNot():
return loadIfNot();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( UserEntity? activeShop,  bool useOldState)?  loadDashboardData,TResult? Function()?  loadDashboardNextPageData,TResult? Function( BookingEntity? updateBooking,  bool shouldRefresh,  bool isDeleted)?  updateData,TResult? Function()?  loadIfNot,}) {final _that = this;
switch (_that) {
case _LoadDashboardData() when loadDashboardData != null:
return loadDashboardData(_that.activeShop,_that.useOldState);case _LoadDashboardNextPageData() when loadDashboardNextPageData != null:
return loadDashboardNextPageData();case _UpdateData() when updateData != null:
return updateData(_that.updateBooking,_that.shouldRefresh,_that.isDeleted);case _LoadIfNot() when loadIfNot != null:
return loadIfNot();case _:
  return null;

}
}

}

/// @nodoc


class _LoadDashboardData implements DashboardEvent {
  const _LoadDashboardData({this.activeShop, this.useOldState = false});
  

 final  UserEntity? activeShop;
@JsonKey() final  bool useOldState;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadDashboardDataCopyWith<_LoadDashboardData> get copyWith => __$LoadDashboardDataCopyWithImpl<_LoadDashboardData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadDashboardData&&(identical(other.activeShop, activeShop) || other.activeShop == activeShop)&&(identical(other.useOldState, useOldState) || other.useOldState == useOldState));
}


@override
int get hashCode => Object.hash(runtimeType,activeShop,useOldState);

@override
String toString() {
  return 'DashboardEvent.loadDashboardData(activeShop: $activeShop, useOldState: $useOldState)';
}


}

/// @nodoc
abstract mixin class _$LoadDashboardDataCopyWith<$Res> implements $DashboardEventCopyWith<$Res> {
  factory _$LoadDashboardDataCopyWith(_LoadDashboardData value, $Res Function(_LoadDashboardData) _then) = __$LoadDashboardDataCopyWithImpl;
@useResult
$Res call({
 UserEntity? activeShop, bool useOldState
});


$UserEntityCopyWith<$Res>? get activeShop;

}
/// @nodoc
class __$LoadDashboardDataCopyWithImpl<$Res>
    implements _$LoadDashboardDataCopyWith<$Res> {
  __$LoadDashboardDataCopyWithImpl(this._self, this._then);

  final _LoadDashboardData _self;
  final $Res Function(_LoadDashboardData) _then;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? activeShop = freezed,Object? useOldState = null,}) {
  return _then(_LoadDashboardData(
activeShop: freezed == activeShop ? _self.activeShop : activeShop // ignore: cast_nullable_to_non_nullable
as UserEntity?,useOldState: null == useOldState ? _self.useOldState : useOldState // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserEntityCopyWith<$Res>? get activeShop {
    if (_self.activeShop == null) {
    return null;
  }

  return $UserEntityCopyWith<$Res>(_self.activeShop!, (value) {
    return _then(_self.copyWith(activeShop: value));
  });
}
}

/// @nodoc


class _LoadDashboardNextPageData implements DashboardEvent {
  const _LoadDashboardNextPageData();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadDashboardNextPageData);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DashboardEvent.loadDashboardNextPageData()';
}


}




/// @nodoc


class _UpdateData implements DashboardEvent {
  const _UpdateData(this.updateBooking, {this.shouldRefresh = false, this.isDeleted = false});
  

 final  BookingEntity? updateBooking;
@JsonKey() final  bool shouldRefresh;
@JsonKey() final  bool isDeleted;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateDataCopyWith<_UpdateData> get copyWith => __$UpdateDataCopyWithImpl<_UpdateData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateData&&(identical(other.updateBooking, updateBooking) || other.updateBooking == updateBooking)&&(identical(other.shouldRefresh, shouldRefresh) || other.shouldRefresh == shouldRefresh)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted));
}


@override
int get hashCode => Object.hash(runtimeType,updateBooking,shouldRefresh,isDeleted);

@override
String toString() {
  return 'DashboardEvent.updateData(updateBooking: $updateBooking, shouldRefresh: $shouldRefresh, isDeleted: $isDeleted)';
}


}

/// @nodoc
abstract mixin class _$UpdateDataCopyWith<$Res> implements $DashboardEventCopyWith<$Res> {
  factory _$UpdateDataCopyWith(_UpdateData value, $Res Function(_UpdateData) _then) = __$UpdateDataCopyWithImpl;
@useResult
$Res call({
 BookingEntity? updateBooking, bool shouldRefresh, bool isDeleted
});


$BookingEntityCopyWith<$Res>? get updateBooking;

}
/// @nodoc
class __$UpdateDataCopyWithImpl<$Res>
    implements _$UpdateDataCopyWith<$Res> {
  __$UpdateDataCopyWithImpl(this._self, this._then);

  final _UpdateData _self;
  final $Res Function(_UpdateData) _then;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? updateBooking = freezed,Object? shouldRefresh = null,Object? isDeleted = null,}) {
  return _then(_UpdateData(
freezed == updateBooking ? _self.updateBooking : updateBooking // ignore: cast_nullable_to_non_nullable
as BookingEntity?,shouldRefresh: null == shouldRefresh ? _self.shouldRefresh : shouldRefresh // ignore: cast_nullable_to_non_nullable
as bool,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookingEntityCopyWith<$Res>? get updateBooking {
    if (_self.updateBooking == null) {
    return null;
  }

  return $BookingEntityCopyWith<$Res>(_self.updateBooking!, (value) {
    return _then(_self.copyWith(updateBooking: value));
  });
}
}

/// @nodoc


class _LoadIfNot implements DashboardEvent {
  const _LoadIfNot();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadIfNot);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DashboardEvent.loadIfNot()';
}


}




/// @nodoc
mixin _$DashboardState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DashboardState()';
}


}

/// @nodoc
class $DashboardStateCopyWith<$Res>  {
$DashboardStateCopyWith(DashboardState _, $Res Function(DashboardState) __);
}


/// Adds pattern-matching-related methods to [DashboardState].
extension DashboardStatePatterns on DashboardState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Loading value)?  loading,TResult Function( _Loaded value)?  loaded,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Loading() when loading != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Loading value)  loading,required TResult Function( _Loaded value)  loaded,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Loading():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Loading value)?  loading,TResult? Function( _Loaded value)?  loaded,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Loading() when loading != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( Map<String, List<BookingEntity>> upcomingGrouped,  Map<String, List<BookingEntity>> returnsGrouped,  DesktopDashboardCarouselEntity carouselData,  String? nextPageUrl,  int currentPage,  int totalPages,  bool isPaginating)?  loaded,TResult Function( String error)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.upcomingGrouped,_that.returnsGrouped,_that.carouselData,_that.nextPageUrl,_that.currentPage,_that.totalPages,_that.isPaginating);case _Error() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( Map<String, List<BookingEntity>> upcomingGrouped,  Map<String, List<BookingEntity>> returnsGrouped,  DesktopDashboardCarouselEntity carouselData,  String? nextPageUrl,  int currentPage,  int totalPages,  bool isPaginating)  loaded,required TResult Function( String error)  error,}) {final _that = this;
switch (_that) {
case _Loading():
return loading();case _Loaded():
return loaded(_that.upcomingGrouped,_that.returnsGrouped,_that.carouselData,_that.nextPageUrl,_that.currentPage,_that.totalPages,_that.isPaginating);case _Error():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( Map<String, List<BookingEntity>> upcomingGrouped,  Map<String, List<BookingEntity>> returnsGrouped,  DesktopDashboardCarouselEntity carouselData,  String? nextPageUrl,  int currentPage,  int totalPages,  bool isPaginating)?  loaded,TResult? Function( String error)?  error,}) {final _that = this;
switch (_that) {
case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.upcomingGrouped,_that.returnsGrouped,_that.carouselData,_that.nextPageUrl,_that.currentPage,_that.totalPages,_that.isPaginating);case _Error() when error != null:
return error(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _Loading implements DashboardState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DashboardState.loading()';
}


}




/// @nodoc


class _Loaded implements DashboardState {
  const _Loaded({required final  Map<String, List<BookingEntity>> upcomingGrouped, required final  Map<String, List<BookingEntity>> returnsGrouped, required this.carouselData, required this.nextPageUrl, required this.currentPage, required this.totalPages, this.isPaginating = false}): _upcomingGrouped = upcomingGrouped,_returnsGrouped = returnsGrouped;
  

 final  Map<String, List<BookingEntity>> _upcomingGrouped;
 Map<String, List<BookingEntity>> get upcomingGrouped {
  if (_upcomingGrouped is EqualUnmodifiableMapView) return _upcomingGrouped;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_upcomingGrouped);
}

 final  Map<String, List<BookingEntity>> _returnsGrouped;
 Map<String, List<BookingEntity>> get returnsGrouped {
  if (_returnsGrouped is EqualUnmodifiableMapView) return _returnsGrouped;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_returnsGrouped);
}

 final  DesktopDashboardCarouselEntity carouselData;
 final  String? nextPageUrl;
 final  int currentPage;
 final  int totalPages;
@JsonKey() final  bool isPaginating;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&const DeepCollectionEquality().equals(other._upcomingGrouped, _upcomingGrouped)&&const DeepCollectionEquality().equals(other._returnsGrouped, _returnsGrouped)&&(identical(other.carouselData, carouselData) || other.carouselData == carouselData)&&(identical(other.nextPageUrl, nextPageUrl) || other.nextPageUrl == nextPageUrl)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.isPaginating, isPaginating) || other.isPaginating == isPaginating));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_upcomingGrouped),const DeepCollectionEquality().hash(_returnsGrouped),carouselData,nextPageUrl,currentPage,totalPages,isPaginating);

@override
String toString() {
  return 'DashboardState.loaded(upcomingGrouped: $upcomingGrouped, returnsGrouped: $returnsGrouped, carouselData: $carouselData, nextPageUrl: $nextPageUrl, currentPage: $currentPage, totalPages: $totalPages, isPaginating: $isPaginating)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $DashboardStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 Map<String, List<BookingEntity>> upcomingGrouped, Map<String, List<BookingEntity>> returnsGrouped, DesktopDashboardCarouselEntity carouselData, String? nextPageUrl, int currentPage, int totalPages, bool isPaginating
});


$DesktopDashboardCarouselEntityCopyWith<$Res> get carouselData;

}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? upcomingGrouped = null,Object? returnsGrouped = null,Object? carouselData = null,Object? nextPageUrl = freezed,Object? currentPage = null,Object? totalPages = null,Object? isPaginating = null,}) {
  return _then(_Loaded(
upcomingGrouped: null == upcomingGrouped ? _self._upcomingGrouped : upcomingGrouped // ignore: cast_nullable_to_non_nullable
as Map<String, List<BookingEntity>>,returnsGrouped: null == returnsGrouped ? _self._returnsGrouped : returnsGrouped // ignore: cast_nullable_to_non_nullable
as Map<String, List<BookingEntity>>,carouselData: null == carouselData ? _self.carouselData : carouselData // ignore: cast_nullable_to_non_nullable
as DesktopDashboardCarouselEntity,nextPageUrl: freezed == nextPageUrl ? _self.nextPageUrl : nextPageUrl // ignore: cast_nullable_to_non_nullable
as String?,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,isPaginating: null == isPaginating ? _self.isPaginating : isPaginating // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DesktopDashboardCarouselEntityCopyWith<$Res> get carouselData {
  
  return $DesktopDashboardCarouselEntityCopyWith<$Res>(_self.carouselData, (value) {
    return _then(_self.copyWith(carouselData: value));
  });
}
}

/// @nodoc


class _Error implements DashboardState {
  const _Error(this.error);
  

 final  String error;

/// Create a copy of DashboardState
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
  return 'DashboardState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $DashboardStateCopyWith<$Res> {
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

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(_Error(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
