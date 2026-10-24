// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'desktop_dashboard_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DesktopDashboardEntity {

 List<BookingEntity> get upcoming; List<BookingEntity> get ongoingBookings; DesktopDashboardCarouselEntity get carouselData; String? get nextPageUrl; int get currentPage; int get totalPages;
/// Create a copy of DesktopDashboardEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DesktopDashboardEntityCopyWith<DesktopDashboardEntity> get copyWith => _$DesktopDashboardEntityCopyWithImpl<DesktopDashboardEntity>(this as DesktopDashboardEntity, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DesktopDashboardEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DesktopDashboardEntity&&const DeepCollectionEquality().equals(other.upcoming, _this.upcoming)&&const DeepCollectionEquality().equals(other.ongoingBookings, _this.ongoingBookings)&&(identical(other.carouselData, _this.carouselData) || other.carouselData == _this.carouselData)&&(identical(other.nextPageUrl, _this.nextPageUrl) || other.nextPageUrl == _this.nextPageUrl)&&(identical(other.currentPage, _this.currentPage) || other.currentPage == _this.currentPage)&&(identical(other.totalPages, _this.totalPages) || other.totalPages == _this.totalPages));
}


@override
int get hashCode {
  final _this = this as DesktopDashboardEntity;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.upcoming),const DeepCollectionEquality().hash(_this.ongoingBookings),_this.carouselData,_this.nextPageUrl,_this.currentPage,_this.totalPages);
}

@override
String toString() {
  final _this = this as DesktopDashboardEntity;
  return 'DesktopDashboardEntity(upcoming: ${_this.upcoming}, ongoingBookings: ${_this.ongoingBookings}, carouselData: ${_this.carouselData}, nextPageUrl: ${_this.nextPageUrl}, currentPage: ${_this.currentPage}, totalPages: ${_this.totalPages})';
}


}

/// @nodoc
abstract mixin class $DesktopDashboardEntityCopyWith<$Res>  {
  factory $DesktopDashboardEntityCopyWith(DesktopDashboardEntity value, $Res Function(DesktopDashboardEntity) _then) = _$DesktopDashboardEntityCopyWithImpl;
@useResult
$Res call({
 List<BookingEntity> upcoming, List<BookingEntity> ongoingBookings, DesktopDashboardCarouselEntity carouselData, String? nextPageUrl, int currentPage, int totalPages
});


$DesktopDashboardCarouselEntityCopyWith<$Res> get carouselData;

}
/// @nodoc
class _$DesktopDashboardEntityCopyWithImpl<$Res>
    implements $DesktopDashboardEntityCopyWith<$Res> {
  _$DesktopDashboardEntityCopyWithImpl(this._self, this._then);

  final DesktopDashboardEntity _self;
  final $Res Function(DesktopDashboardEntity) _then;

/// Create a copy of DesktopDashboardEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? upcoming = null,Object? ongoingBookings = null,Object? carouselData = null,Object? nextPageUrl = freezed,Object? currentPage = null,Object? totalPages = null,}) {
  return _then(DesktopDashboardEntity(
upcoming: null == upcoming ? _self.upcoming : upcoming // ignore: cast_nullable_to_non_nullable
as List<BookingEntity>,ongoingBookings: null == ongoingBookings ? _self.ongoingBookings : ongoingBookings // ignore: cast_nullable_to_non_nullable
as List<BookingEntity>,carouselData: null == carouselData ? _self.carouselData : carouselData // ignore: cast_nullable_to_non_nullable
as DesktopDashboardCarouselEntity,nextPageUrl: freezed == nextPageUrl ? _self.nextPageUrl : nextPageUrl // ignore: cast_nullable_to_non_nullable
as String?,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of DesktopDashboardEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DesktopDashboardCarouselEntityCopyWith<$Res> get carouselData {
  
  return $DesktopDashboardCarouselEntityCopyWith<$Res>(_self.carouselData, (value) {
    return _then(_self.copyWith(carouselData: value));
  });
}
}


/// Adds pattern-matching-related methods to [DesktopDashboardEntity].
extension DesktopDashboardEntityPatterns on DesktopDashboardEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DesktopDashboardEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DesktopDashboardEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DesktopDashboardEntity value)  $default,){
final _that = this;
switch (_that) {
case _DesktopDashboardEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DesktopDashboardEntity value)?  $default,){
final _that = this;
switch (_that) {
case _DesktopDashboardEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<BookingEntity> upcoming,  List<BookingEntity> ongoingBookings,  DesktopDashboardCarouselEntity carouselData,  String? nextPageUrl,  int currentPage,  int totalPages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DesktopDashboardEntity() when $default != null:
return $default(_that.upcoming,_that.ongoingBookings,_that.carouselData,_that.nextPageUrl,_that.currentPage,_that.totalPages);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<BookingEntity> upcoming,  List<BookingEntity> ongoingBookings,  DesktopDashboardCarouselEntity carouselData,  String? nextPageUrl,  int currentPage,  int totalPages)  $default,) {final _that = this;
switch (_that) {
case _DesktopDashboardEntity():
return $default(_that.upcoming,_that.ongoingBookings,_that.carouselData,_that.nextPageUrl,_that.currentPage,_that.totalPages);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<BookingEntity> upcoming,  List<BookingEntity> ongoingBookings,  DesktopDashboardCarouselEntity carouselData,  String? nextPageUrl,  int currentPage,  int totalPages)?  $default,) {final _that = this;
switch (_that) {
case _DesktopDashboardEntity() when $default != null:
return $default(_that.upcoming,_that.ongoingBookings,_that.carouselData,_that.nextPageUrl,_that.currentPage,_that.totalPages);case _:
  return null;

}
}

}

/// @nodoc


class _DesktopDashboardEntity implements DesktopDashboardEntity {
  const _DesktopDashboardEntity({required  List<BookingEntity> upcoming, required  List<BookingEntity> ongoingBookings, required this.carouselData, required this.nextPageUrl, required this.currentPage, required this.totalPages}): _upcoming = upcoming,_ongoingBookings = ongoingBookings;
  

 final  List<BookingEntity> _upcoming;
@override List<BookingEntity> get upcoming {
  if (_upcoming is EqualUnmodifiableListView) return _upcoming;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_upcoming);
}

 final  List<BookingEntity> _ongoingBookings;
@override List<BookingEntity> get ongoingBookings {
  if (_ongoingBookings is EqualUnmodifiableListView) return _ongoingBookings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ongoingBookings);
}

@override final  DesktopDashboardCarouselEntity carouselData;
@override final  String? nextPageUrl;
@override final  int currentPage;
@override final  int totalPages;

/// Create a copy of DesktopDashboardEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DesktopDashboardEntityCopyWith<_DesktopDashboardEntity> get copyWith => __$DesktopDashboardEntityCopyWithImpl<_DesktopDashboardEntity>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DesktopDashboardEntity&&const DeepCollectionEquality().equals(other.upcoming, _upcoming)&&const DeepCollectionEquality().equals(other.ongoingBookings, _ongoingBookings)&&(identical(other.carouselData, carouselData) || other.carouselData == carouselData)&&(identical(other.nextPageUrl, nextPageUrl) || other.nextPageUrl == nextPageUrl)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_upcoming),const DeepCollectionEquality().hash(_ongoingBookings),carouselData,nextPageUrl,currentPage,totalPages);
}

@override
String toString() {
    return 'DesktopDashboardEntity(upcoming: $upcoming, ongoingBookings: $ongoingBookings, carouselData: $carouselData, nextPageUrl: $nextPageUrl, currentPage: $currentPage, totalPages: $totalPages)';
}


}

/// @nodoc
abstract mixin class _$DesktopDashboardEntityCopyWith<$Res> implements $DesktopDashboardEntityCopyWith<$Res> {
  factory _$DesktopDashboardEntityCopyWith(_DesktopDashboardEntity value, $Res Function(_DesktopDashboardEntity) _then) = __$DesktopDashboardEntityCopyWithImpl;
@override @useResult
$Res call({
 List<BookingEntity> upcoming, List<BookingEntity> ongoingBookings, DesktopDashboardCarouselEntity carouselData, String? nextPageUrl, int currentPage, int totalPages
});


@override $DesktopDashboardCarouselEntityCopyWith<$Res> get carouselData;

}
/// @nodoc
class __$DesktopDashboardEntityCopyWithImpl<$Res>
    implements _$DesktopDashboardEntityCopyWith<$Res> {
  __$DesktopDashboardEntityCopyWithImpl(this._self, this._then);

  final _DesktopDashboardEntity _self;
  final $Res Function(_DesktopDashboardEntity) _then;

/// Create a copy of DesktopDashboardEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? upcoming = null,Object? ongoingBookings = null,Object? carouselData = null,Object? nextPageUrl = freezed,Object? currentPage = null,Object? totalPages = null,}) {
  return _then(_DesktopDashboardEntity(
upcoming: null == upcoming ? _self._upcoming : upcoming // ignore: cast_nullable_to_non_nullable
as List<BookingEntity>,ongoingBookings: null == ongoingBookings ? _self._ongoingBookings : ongoingBookings // ignore: cast_nullable_to_non_nullable
as List<BookingEntity>,carouselData: null == carouselData ? _self.carouselData : carouselData // ignore: cast_nullable_to_non_nullable
as DesktopDashboardCarouselEntity,nextPageUrl: freezed == nextPageUrl ? _self.nextPageUrl : nextPageUrl // ignore: cast_nullable_to_non_nullable
as String?,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of DesktopDashboardEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DesktopDashboardCarouselEntityCopyWith<$Res> get carouselData {
  
  return $DesktopDashboardCarouselEntityCopyWith<$Res>(_self.carouselData, (value) {
    return _then(_self.copyWith(carouselData: value));
  });
}
}

// dart format on
