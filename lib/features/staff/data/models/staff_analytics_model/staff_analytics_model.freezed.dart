// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'staff_analytics_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StaffAnalyticsModel {

 int get staffId; String get staffName; int get year;@JsonKey(fromJson: Month.fromInt, includeToJson: false) Month get month; String get monthName;@JsonKey(name: 'total_bookings_count', defaultValue: 0) int get totalBookingsCount;@JsonKey(name: 'total_sales_count', defaultValue: 0) int get totalSalesCount;@JsonKey(name: 'total_bookings_pending_count', defaultValue: 0) int get totalPendingsCount;@JsonKey(name: 'total_bookings_earned_amount', defaultValue: 0) int get totalBookingsAmount;@JsonKey(name: 'total_sales_earning', defaultValue: 0) int get totalSalesAmount;@JsonKey(name: 'total_bookings_pending_amount', defaultValue: 0) int get totalPendingAmount;@JsonKey(name: 'total_earning', defaultValue: 0) int get totalAmount;@JsonKey(name: 'performance_percent', defaultValue: 0) int get performancePercent;
/// Create a copy of StaffAnalyticsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StaffAnalyticsModelCopyWith<StaffAnalyticsModel> get copyWith => _$StaffAnalyticsModelCopyWithImpl<StaffAnalyticsModel>(this as StaffAnalyticsModel, _$identity);

  /// Serializes this StaffAnalyticsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StaffAnalyticsModel&&(identical(other.staffId, staffId) || other.staffId == staffId)&&(identical(other.staffName, staffName) || other.staffName == staffName)&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.monthName, monthName) || other.monthName == monthName)&&(identical(other.totalBookingsCount, totalBookingsCount) || other.totalBookingsCount == totalBookingsCount)&&(identical(other.totalSalesCount, totalSalesCount) || other.totalSalesCount == totalSalesCount)&&(identical(other.totalPendingsCount, totalPendingsCount) || other.totalPendingsCount == totalPendingsCount)&&(identical(other.totalBookingsAmount, totalBookingsAmount) || other.totalBookingsAmount == totalBookingsAmount)&&(identical(other.totalSalesAmount, totalSalesAmount) || other.totalSalesAmount == totalSalesAmount)&&(identical(other.totalPendingAmount, totalPendingAmount) || other.totalPendingAmount == totalPendingAmount)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.performancePercent, performancePercent) || other.performancePercent == performancePercent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,staffId,staffName,year,month,monthName,totalBookingsCount,totalSalesCount,totalPendingsCount,totalBookingsAmount,totalSalesAmount,totalPendingAmount,totalAmount,performancePercent);

@override
String toString() {
  return 'StaffAnalyticsModel(staffId: $staffId, staffName: $staffName, year: $year, month: $month, monthName: $monthName, totalBookingsCount: $totalBookingsCount, totalSalesCount: $totalSalesCount, totalPendingsCount: $totalPendingsCount, totalBookingsAmount: $totalBookingsAmount, totalSalesAmount: $totalSalesAmount, totalPendingAmount: $totalPendingAmount, totalAmount: $totalAmount, performancePercent: $performancePercent)';
}


}

/// @nodoc
abstract mixin class $StaffAnalyticsModelCopyWith<$Res>  {
  factory $StaffAnalyticsModelCopyWith(StaffAnalyticsModel value, $Res Function(StaffAnalyticsModel) _then) = _$StaffAnalyticsModelCopyWithImpl;
@useResult
$Res call({
 int staffId, String staffName, int year,@JsonKey(fromJson: Month.fromInt, includeToJson: false) Month month, String monthName,@JsonKey(name: 'total_bookings_count', defaultValue: 0) int totalBookingsCount,@JsonKey(name: 'total_sales_count', defaultValue: 0) int totalSalesCount,@JsonKey(name: 'total_bookings_pending_count', defaultValue: 0) int totalPendingsCount,@JsonKey(name: 'total_bookings_earned_amount', defaultValue: 0) int totalBookingsAmount,@JsonKey(name: 'total_sales_earning', defaultValue: 0) int totalSalesAmount,@JsonKey(name: 'total_bookings_pending_amount', defaultValue: 0) int totalPendingAmount,@JsonKey(name: 'total_earning', defaultValue: 0) int totalAmount,@JsonKey(name: 'performance_percent', defaultValue: 0) int performancePercent
});




}
/// @nodoc
class _$StaffAnalyticsModelCopyWithImpl<$Res>
    implements $StaffAnalyticsModelCopyWith<$Res> {
  _$StaffAnalyticsModelCopyWithImpl(this._self, this._then);

  final StaffAnalyticsModel _self;
  final $Res Function(StaffAnalyticsModel) _then;

/// Create a copy of StaffAnalyticsModel
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


/// Adds pattern-matching-related methods to [StaffAnalyticsModel].
extension StaffAnalyticsModelPatterns on StaffAnalyticsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StaffAnalyticsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StaffAnalyticsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StaffAnalyticsModel value)  $default,){
final _that = this;
switch (_that) {
case _StaffAnalyticsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StaffAnalyticsModel value)?  $default,){
final _that = this;
switch (_that) {
case _StaffAnalyticsModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int staffId,  String staffName,  int year, @JsonKey(fromJson: Month.fromInt, includeToJson: false)  Month month,  String monthName, @JsonKey(name: 'total_bookings_count', defaultValue: 0)  int totalBookingsCount, @JsonKey(name: 'total_sales_count', defaultValue: 0)  int totalSalesCount, @JsonKey(name: 'total_bookings_pending_count', defaultValue: 0)  int totalPendingsCount, @JsonKey(name: 'total_bookings_earned_amount', defaultValue: 0)  int totalBookingsAmount, @JsonKey(name: 'total_sales_earning', defaultValue: 0)  int totalSalesAmount, @JsonKey(name: 'total_bookings_pending_amount', defaultValue: 0)  int totalPendingAmount, @JsonKey(name: 'total_earning', defaultValue: 0)  int totalAmount, @JsonKey(name: 'performance_percent', defaultValue: 0)  int performancePercent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StaffAnalyticsModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int staffId,  String staffName,  int year, @JsonKey(fromJson: Month.fromInt, includeToJson: false)  Month month,  String monthName, @JsonKey(name: 'total_bookings_count', defaultValue: 0)  int totalBookingsCount, @JsonKey(name: 'total_sales_count', defaultValue: 0)  int totalSalesCount, @JsonKey(name: 'total_bookings_pending_count', defaultValue: 0)  int totalPendingsCount, @JsonKey(name: 'total_bookings_earned_amount', defaultValue: 0)  int totalBookingsAmount, @JsonKey(name: 'total_sales_earning', defaultValue: 0)  int totalSalesAmount, @JsonKey(name: 'total_bookings_pending_amount', defaultValue: 0)  int totalPendingAmount, @JsonKey(name: 'total_earning', defaultValue: 0)  int totalAmount, @JsonKey(name: 'performance_percent', defaultValue: 0)  int performancePercent)  $default,) {final _that = this;
switch (_that) {
case _StaffAnalyticsModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int staffId,  String staffName,  int year, @JsonKey(fromJson: Month.fromInt, includeToJson: false)  Month month,  String monthName, @JsonKey(name: 'total_bookings_count', defaultValue: 0)  int totalBookingsCount, @JsonKey(name: 'total_sales_count', defaultValue: 0)  int totalSalesCount, @JsonKey(name: 'total_bookings_pending_count', defaultValue: 0)  int totalPendingsCount, @JsonKey(name: 'total_bookings_earned_amount', defaultValue: 0)  int totalBookingsAmount, @JsonKey(name: 'total_sales_earning', defaultValue: 0)  int totalSalesAmount, @JsonKey(name: 'total_bookings_pending_amount', defaultValue: 0)  int totalPendingAmount, @JsonKey(name: 'total_earning', defaultValue: 0)  int totalAmount, @JsonKey(name: 'performance_percent', defaultValue: 0)  int performancePercent)?  $default,) {final _that = this;
switch (_that) {
case _StaffAnalyticsModel() when $default != null:
return $default(_that.staffId,_that.staffName,_that.year,_that.month,_that.monthName,_that.totalBookingsCount,_that.totalSalesCount,_that.totalPendingsCount,_that.totalBookingsAmount,_that.totalSalesAmount,_that.totalPendingAmount,_that.totalAmount,_that.performancePercent);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _StaffAnalyticsModel implements StaffAnalyticsModel {
  const _StaffAnalyticsModel({required this.staffId, required this.staffName, required this.year, @JsonKey(fromJson: Month.fromInt, includeToJson: false) required this.month, required this.monthName, @JsonKey(name: 'total_bookings_count', defaultValue: 0) required this.totalBookingsCount, @JsonKey(name: 'total_sales_count', defaultValue: 0) required this.totalSalesCount, @JsonKey(name: 'total_bookings_pending_count', defaultValue: 0) required this.totalPendingsCount, @JsonKey(name: 'total_bookings_earned_amount', defaultValue: 0) required this.totalBookingsAmount, @JsonKey(name: 'total_sales_earning', defaultValue: 0) required this.totalSalesAmount, @JsonKey(name: 'total_bookings_pending_amount', defaultValue: 0) required this.totalPendingAmount, @JsonKey(name: 'total_earning', defaultValue: 0) required this.totalAmount, @JsonKey(name: 'performance_percent', defaultValue: 0) required this.performancePercent});
  factory _StaffAnalyticsModel.fromJson(Map<String, dynamic> json) => _$StaffAnalyticsModelFromJson(json);

@override final  int staffId;
@override final  String staffName;
@override final  int year;
@override@JsonKey(fromJson: Month.fromInt, includeToJson: false) final  Month month;
@override final  String monthName;
@override@JsonKey(name: 'total_bookings_count', defaultValue: 0) final  int totalBookingsCount;
@override@JsonKey(name: 'total_sales_count', defaultValue: 0) final  int totalSalesCount;
@override@JsonKey(name: 'total_bookings_pending_count', defaultValue: 0) final  int totalPendingsCount;
@override@JsonKey(name: 'total_bookings_earned_amount', defaultValue: 0) final  int totalBookingsAmount;
@override@JsonKey(name: 'total_sales_earning', defaultValue: 0) final  int totalSalesAmount;
@override@JsonKey(name: 'total_bookings_pending_amount', defaultValue: 0) final  int totalPendingAmount;
@override@JsonKey(name: 'total_earning', defaultValue: 0) final  int totalAmount;
@override@JsonKey(name: 'performance_percent', defaultValue: 0) final  int performancePercent;

/// Create a copy of StaffAnalyticsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StaffAnalyticsModelCopyWith<_StaffAnalyticsModel> get copyWith => __$StaffAnalyticsModelCopyWithImpl<_StaffAnalyticsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StaffAnalyticsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StaffAnalyticsModel&&(identical(other.staffId, staffId) || other.staffId == staffId)&&(identical(other.staffName, staffName) || other.staffName == staffName)&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.monthName, monthName) || other.monthName == monthName)&&(identical(other.totalBookingsCount, totalBookingsCount) || other.totalBookingsCount == totalBookingsCount)&&(identical(other.totalSalesCount, totalSalesCount) || other.totalSalesCount == totalSalesCount)&&(identical(other.totalPendingsCount, totalPendingsCount) || other.totalPendingsCount == totalPendingsCount)&&(identical(other.totalBookingsAmount, totalBookingsAmount) || other.totalBookingsAmount == totalBookingsAmount)&&(identical(other.totalSalesAmount, totalSalesAmount) || other.totalSalesAmount == totalSalesAmount)&&(identical(other.totalPendingAmount, totalPendingAmount) || other.totalPendingAmount == totalPendingAmount)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.performancePercent, performancePercent) || other.performancePercent == performancePercent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,staffId,staffName,year,month,monthName,totalBookingsCount,totalSalesCount,totalPendingsCount,totalBookingsAmount,totalSalesAmount,totalPendingAmount,totalAmount,performancePercent);

@override
String toString() {
  return 'StaffAnalyticsModel(staffId: $staffId, staffName: $staffName, year: $year, month: $month, monthName: $monthName, totalBookingsCount: $totalBookingsCount, totalSalesCount: $totalSalesCount, totalPendingsCount: $totalPendingsCount, totalBookingsAmount: $totalBookingsAmount, totalSalesAmount: $totalSalesAmount, totalPendingAmount: $totalPendingAmount, totalAmount: $totalAmount, performancePercent: $performancePercent)';
}


}

/// @nodoc
abstract mixin class _$StaffAnalyticsModelCopyWith<$Res> implements $StaffAnalyticsModelCopyWith<$Res> {
  factory _$StaffAnalyticsModelCopyWith(_StaffAnalyticsModel value, $Res Function(_StaffAnalyticsModel) _then) = __$StaffAnalyticsModelCopyWithImpl;
@override @useResult
$Res call({
 int staffId, String staffName, int year,@JsonKey(fromJson: Month.fromInt, includeToJson: false) Month month, String monthName,@JsonKey(name: 'total_bookings_count', defaultValue: 0) int totalBookingsCount,@JsonKey(name: 'total_sales_count', defaultValue: 0) int totalSalesCount,@JsonKey(name: 'total_bookings_pending_count', defaultValue: 0) int totalPendingsCount,@JsonKey(name: 'total_bookings_earned_amount', defaultValue: 0) int totalBookingsAmount,@JsonKey(name: 'total_sales_earning', defaultValue: 0) int totalSalesAmount,@JsonKey(name: 'total_bookings_pending_amount', defaultValue: 0) int totalPendingAmount,@JsonKey(name: 'total_earning', defaultValue: 0) int totalAmount,@JsonKey(name: 'performance_percent', defaultValue: 0) int performancePercent
});




}
/// @nodoc
class __$StaffAnalyticsModelCopyWithImpl<$Res>
    implements _$StaffAnalyticsModelCopyWith<$Res> {
  __$StaffAnalyticsModelCopyWithImpl(this._self, this._then);

  final _StaffAnalyticsModel _self;
  final $Res Function(_StaffAnalyticsModel) _then;

/// Create a copy of StaffAnalyticsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? staffId = null,Object? staffName = null,Object? year = null,Object? month = null,Object? monthName = null,Object? totalBookingsCount = null,Object? totalSalesCount = null,Object? totalPendingsCount = null,Object? totalBookingsAmount = null,Object? totalSalesAmount = null,Object? totalPendingAmount = null,Object? totalAmount = null,Object? performancePercent = null,}) {
  return _then(_StaffAnalyticsModel(
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
