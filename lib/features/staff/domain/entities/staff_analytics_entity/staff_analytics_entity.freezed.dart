// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'staff_analytics_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StaffAnalyticsEntity {

 int get staffId; String get staffName; int get year; Month get month; String get monthName; int get totalBookingsCount; int get totalSalesCount; int get totalPendingsCount; int get totalBookingsAmount; int get totalSalesAmount; int get totalPendingAmount; int get totalAmount; int get performancePercent;
/// Create a copy of StaffAnalyticsEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StaffAnalyticsEntityCopyWith<StaffAnalyticsEntity> get copyWith => _$StaffAnalyticsEntityCopyWithImpl<StaffAnalyticsEntity>(this as StaffAnalyticsEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StaffAnalyticsEntity&&(identical(other.staffId, staffId) || other.staffId == staffId)&&(identical(other.staffName, staffName) || other.staffName == staffName)&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.monthName, monthName) || other.monthName == monthName)&&(identical(other.totalBookingsCount, totalBookingsCount) || other.totalBookingsCount == totalBookingsCount)&&(identical(other.totalSalesCount, totalSalesCount) || other.totalSalesCount == totalSalesCount)&&(identical(other.totalPendingsCount, totalPendingsCount) || other.totalPendingsCount == totalPendingsCount)&&(identical(other.totalBookingsAmount, totalBookingsAmount) || other.totalBookingsAmount == totalBookingsAmount)&&(identical(other.totalSalesAmount, totalSalesAmount) || other.totalSalesAmount == totalSalesAmount)&&(identical(other.totalPendingAmount, totalPendingAmount) || other.totalPendingAmount == totalPendingAmount)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.performancePercent, performancePercent) || other.performancePercent == performancePercent));
}


@override
int get hashCode => Object.hash(runtimeType,staffId,staffName,year,month,monthName,totalBookingsCount,totalSalesCount,totalPendingsCount,totalBookingsAmount,totalSalesAmount,totalPendingAmount,totalAmount,performancePercent);

@override
String toString() {
  return 'StaffAnalyticsEntity(staffId: $staffId, staffName: $staffName, year: $year, month: $month, monthName: $monthName, totalBookingsCount: $totalBookingsCount, totalSalesCount: $totalSalesCount, totalPendingsCount: $totalPendingsCount, totalBookingsAmount: $totalBookingsAmount, totalSalesAmount: $totalSalesAmount, totalPendingAmount: $totalPendingAmount, totalAmount: $totalAmount, performancePercent: $performancePercent)';
}


}

/// @nodoc
abstract mixin class $StaffAnalyticsEntityCopyWith<$Res>  {
  factory $StaffAnalyticsEntityCopyWith(StaffAnalyticsEntity value, $Res Function(StaffAnalyticsEntity) _then) = _$StaffAnalyticsEntityCopyWithImpl;
@useResult
$Res call({
 int staffId, String staffName, int year, Month month, String monthName, int totalBookingsCount, int totalSalesCount, int totalPendingsCount, int totalBookingsAmount, int totalSalesAmount, int totalPendingAmount, int totalAmount, int performancePercent
});




}
/// @nodoc
class _$StaffAnalyticsEntityCopyWithImpl<$Res>
    implements $StaffAnalyticsEntityCopyWith<$Res> {
  _$StaffAnalyticsEntityCopyWithImpl(this._self, this._then);

  final StaffAnalyticsEntity _self;
  final $Res Function(StaffAnalyticsEntity) _then;

/// Create a copy of StaffAnalyticsEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? staffId = null,Object? staffName = null,Object? year = null,Object? month = null,Object? monthName = null,Object? totalBookingsCount = null,Object? totalSalesCount = null,Object? totalPendingsCount = null,Object? totalBookingsAmount = null,Object? totalSalesAmount = null,Object? totalPendingAmount = null,Object? totalAmount = null,Object? performancePercent = null,}) {
  return _then(_self.copyWith(
staffId: null == staffId ? _self.staffId : staffId // ignore: cast_nullable_to_non_nullable
as int,staffName: null == staffName ? _self.staffName : staffName // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as Month,monthName: null == monthName ? _self.monthName : monthName // ignore: cast_nullable_to_non_nullable
as String,totalBookingsCount: null == totalBookingsCount ? _self.totalBookingsCount : totalBookingsCount // ignore: cast_nullable_to_non_nullable
as int,totalSalesCount: null == totalSalesCount ? _self.totalSalesCount : totalSalesCount // ignore: cast_nullable_to_non_nullable
as int,totalPendingsCount: null == totalPendingsCount ? _self.totalPendingsCount : totalPendingsCount // ignore: cast_nullable_to_non_nullable
as int,totalBookingsAmount: null == totalBookingsAmount ? _self.totalBookingsAmount : totalBookingsAmount // ignore: cast_nullable_to_non_nullable
as int,totalSalesAmount: null == totalSalesAmount ? _self.totalSalesAmount : totalSalesAmount // ignore: cast_nullable_to_non_nullable
as int,totalPendingAmount: null == totalPendingAmount ? _self.totalPendingAmount : totalPendingAmount // ignore: cast_nullable_to_non_nullable
as int,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as int,performancePercent: null == performancePercent ? _self.performancePercent : performancePercent // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [StaffAnalyticsEntity].
extension StaffAnalyticsEntityPatterns on StaffAnalyticsEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StaffAnalyticsEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StaffAnalyticsEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StaffAnalyticsEntity value)  $default,){
final _that = this;
switch (_that) {
case _StaffAnalyticsEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StaffAnalyticsEntity value)?  $default,){
final _that = this;
switch (_that) {
case _StaffAnalyticsEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int staffId,  String staffName,  int year,  Month month,  String monthName,  int totalBookingsCount,  int totalSalesCount,  int totalPendingsCount,  int totalBookingsAmount,  int totalSalesAmount,  int totalPendingAmount,  int totalAmount,  int performancePercent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StaffAnalyticsEntity() when $default != null:
return $default(_that.staffId,_that.staffName,_that.year,_that.month,_that.monthName,_that.totalBookingsCount,_that.totalSalesCount,_that.totalPendingsCount,_that.totalBookingsAmount,_that.totalSalesAmount,_that.totalPendingAmount,_that.totalAmount,_that.performancePercent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int staffId,  String staffName,  int year,  Month month,  String monthName,  int totalBookingsCount,  int totalSalesCount,  int totalPendingsCount,  int totalBookingsAmount,  int totalSalesAmount,  int totalPendingAmount,  int totalAmount,  int performancePercent)  $default,) {final _that = this;
switch (_that) {
case _StaffAnalyticsEntity():
return $default(_that.staffId,_that.staffName,_that.year,_that.month,_that.monthName,_that.totalBookingsCount,_that.totalSalesCount,_that.totalPendingsCount,_that.totalBookingsAmount,_that.totalSalesAmount,_that.totalPendingAmount,_that.totalAmount,_that.performancePercent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int staffId,  String staffName,  int year,  Month month,  String monthName,  int totalBookingsCount,  int totalSalesCount,  int totalPendingsCount,  int totalBookingsAmount,  int totalSalesAmount,  int totalPendingAmount,  int totalAmount,  int performancePercent)?  $default,) {final _that = this;
switch (_that) {
case _StaffAnalyticsEntity() when $default != null:
return $default(_that.staffId,_that.staffName,_that.year,_that.month,_that.monthName,_that.totalBookingsCount,_that.totalSalesCount,_that.totalPendingsCount,_that.totalBookingsAmount,_that.totalSalesAmount,_that.totalPendingAmount,_that.totalAmount,_that.performancePercent);case _:
  return null;

}
}

}

/// @nodoc


class _StaffAnalyticsEntity extends StaffAnalyticsEntity {
  const _StaffAnalyticsEntity({required this.staffId, required this.staffName, required this.year, required this.month, required this.monthName, required this.totalBookingsCount, required this.totalSalesCount, required this.totalPendingsCount, required this.totalBookingsAmount, required this.totalSalesAmount, required this.totalPendingAmount, required this.totalAmount, required this.performancePercent}): super._();
  

@override final  int staffId;
@override final  String staffName;
@override final  int year;
@override final  Month month;
@override final  String monthName;
@override final  int totalBookingsCount;
@override final  int totalSalesCount;
@override final  int totalPendingsCount;
@override final  int totalBookingsAmount;
@override final  int totalSalesAmount;
@override final  int totalPendingAmount;
@override final  int totalAmount;
@override final  int performancePercent;

/// Create a copy of StaffAnalyticsEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StaffAnalyticsEntityCopyWith<_StaffAnalyticsEntity> get copyWith => __$StaffAnalyticsEntityCopyWithImpl<_StaffAnalyticsEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StaffAnalyticsEntity&&(identical(other.staffId, staffId) || other.staffId == staffId)&&(identical(other.staffName, staffName) || other.staffName == staffName)&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.monthName, monthName) || other.monthName == monthName)&&(identical(other.totalBookingsCount, totalBookingsCount) || other.totalBookingsCount == totalBookingsCount)&&(identical(other.totalSalesCount, totalSalesCount) || other.totalSalesCount == totalSalesCount)&&(identical(other.totalPendingsCount, totalPendingsCount) || other.totalPendingsCount == totalPendingsCount)&&(identical(other.totalBookingsAmount, totalBookingsAmount) || other.totalBookingsAmount == totalBookingsAmount)&&(identical(other.totalSalesAmount, totalSalesAmount) || other.totalSalesAmount == totalSalesAmount)&&(identical(other.totalPendingAmount, totalPendingAmount) || other.totalPendingAmount == totalPendingAmount)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.performancePercent, performancePercent) || other.performancePercent == performancePercent));
}


@override
int get hashCode => Object.hash(runtimeType,staffId,staffName,year,month,monthName,totalBookingsCount,totalSalesCount,totalPendingsCount,totalBookingsAmount,totalSalesAmount,totalPendingAmount,totalAmount,performancePercent);

@override
String toString() {
  return 'StaffAnalyticsEntity(staffId: $staffId, staffName: $staffName, year: $year, month: $month, monthName: $monthName, totalBookingsCount: $totalBookingsCount, totalSalesCount: $totalSalesCount, totalPendingsCount: $totalPendingsCount, totalBookingsAmount: $totalBookingsAmount, totalSalesAmount: $totalSalesAmount, totalPendingAmount: $totalPendingAmount, totalAmount: $totalAmount, performancePercent: $performancePercent)';
}


}

/// @nodoc
abstract mixin class _$StaffAnalyticsEntityCopyWith<$Res> implements $StaffAnalyticsEntityCopyWith<$Res> {
  factory _$StaffAnalyticsEntityCopyWith(_StaffAnalyticsEntity value, $Res Function(_StaffAnalyticsEntity) _then) = __$StaffAnalyticsEntityCopyWithImpl;
@override @useResult
$Res call({
 int staffId, String staffName, int year, Month month, String monthName, int totalBookingsCount, int totalSalesCount, int totalPendingsCount, int totalBookingsAmount, int totalSalesAmount, int totalPendingAmount, int totalAmount, int performancePercent
});




}
/// @nodoc
class __$StaffAnalyticsEntityCopyWithImpl<$Res>
    implements _$StaffAnalyticsEntityCopyWith<$Res> {
  __$StaffAnalyticsEntityCopyWithImpl(this._self, this._then);

  final _StaffAnalyticsEntity _self;
  final $Res Function(_StaffAnalyticsEntity) _then;

/// Create a copy of StaffAnalyticsEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? staffId = null,Object? staffName = null,Object? year = null,Object? month = null,Object? monthName = null,Object? totalBookingsCount = null,Object? totalSalesCount = null,Object? totalPendingsCount = null,Object? totalBookingsAmount = null,Object? totalSalesAmount = null,Object? totalPendingAmount = null,Object? totalAmount = null,Object? performancePercent = null,}) {
  return _then(_StaffAnalyticsEntity(
staffId: null == staffId ? _self.staffId : staffId // ignore: cast_nullable_to_non_nullable
as int,staffName: null == staffName ? _self.staffName : staffName // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as Month,monthName: null == monthName ? _self.monthName : monthName // ignore: cast_nullable_to_non_nullable
as String,totalBookingsCount: null == totalBookingsCount ? _self.totalBookingsCount : totalBookingsCount // ignore: cast_nullable_to_non_nullable
as int,totalSalesCount: null == totalSalesCount ? _self.totalSalesCount : totalSalesCount // ignore: cast_nullable_to_non_nullable
as int,totalPendingsCount: null == totalPendingsCount ? _self.totalPendingsCount : totalPendingsCount // ignore: cast_nullable_to_non_nullable
as int,totalBookingsAmount: null == totalBookingsAmount ? _self.totalBookingsAmount : totalBookingsAmount // ignore: cast_nullable_to_non_nullable
as int,totalSalesAmount: null == totalSalesAmount ? _self.totalSalesAmount : totalSalesAmount // ignore: cast_nullable_to_non_nullable
as int,totalPendingAmount: null == totalPendingAmount ? _self.totalPendingAmount : totalPendingAmount // ignore: cast_nullable_to_non_nullable
as int,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as int,performancePercent: null == performancePercent ? _self.performancePercent : performancePercent // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
