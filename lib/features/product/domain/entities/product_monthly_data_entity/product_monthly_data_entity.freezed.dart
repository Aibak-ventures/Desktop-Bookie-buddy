// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_monthly_data_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductMonthlyDataEntity {

 int get year; int get month; double get totalExpense; double get totalEarned;
/// Create a copy of ProductMonthlyDataEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductMonthlyDataEntityCopyWith<ProductMonthlyDataEntity> get copyWith => _$ProductMonthlyDataEntityCopyWithImpl<ProductMonthlyDataEntity>(this as ProductMonthlyDataEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductMonthlyDataEntity&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.totalExpense, totalExpense) || other.totalExpense == totalExpense)&&(identical(other.totalEarned, totalEarned) || other.totalEarned == totalEarned));
}


@override
int get hashCode => Object.hash(runtimeType,year,month,totalExpense,totalEarned);

@override
String toString() {
  return 'ProductMonthlyDataEntity(year: $year, month: $month, totalExpense: $totalExpense, totalEarned: $totalEarned)';
}


}

/// @nodoc
abstract mixin class $ProductMonthlyDataEntityCopyWith<$Res>  {
  factory $ProductMonthlyDataEntityCopyWith(ProductMonthlyDataEntity value, $Res Function(ProductMonthlyDataEntity) _then) = _$ProductMonthlyDataEntityCopyWithImpl;
@useResult
$Res call({
 int year, int month, double totalExpense, double totalEarned
});




}
/// @nodoc
class _$ProductMonthlyDataEntityCopyWithImpl<$Res>
    implements $ProductMonthlyDataEntityCopyWith<$Res> {
  _$ProductMonthlyDataEntityCopyWithImpl(this._self, this._then);

  final ProductMonthlyDataEntity _self;
  final $Res Function(ProductMonthlyDataEntity) _then;

/// Create a copy of ProductMonthlyDataEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? year = null,Object? month = null,Object? totalExpense = null,Object? totalEarned = null,}) {
  return _then(_self.copyWith(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,totalExpense: null == totalExpense ? _self.totalExpense : totalExpense // ignore: cast_nullable_to_non_nullable
as double,totalEarned: null == totalEarned ? _self.totalEarned : totalEarned // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductMonthlyDataEntity].
extension ProductMonthlyDataEntityPatterns on ProductMonthlyDataEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductMonthlyDataEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductMonthlyDataEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductMonthlyDataEntity value)  $default,){
final _that = this;
switch (_that) {
case _ProductMonthlyDataEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductMonthlyDataEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ProductMonthlyDataEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int year,  int month,  double totalExpense,  double totalEarned)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductMonthlyDataEntity() when $default != null:
return $default(_that.year,_that.month,_that.totalExpense,_that.totalEarned);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int year,  int month,  double totalExpense,  double totalEarned)  $default,) {final _that = this;
switch (_that) {
case _ProductMonthlyDataEntity():
return $default(_that.year,_that.month,_that.totalExpense,_that.totalEarned);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int year,  int month,  double totalExpense,  double totalEarned)?  $default,) {final _that = this;
switch (_that) {
case _ProductMonthlyDataEntity() when $default != null:
return $default(_that.year,_that.month,_that.totalExpense,_that.totalEarned);case _:
  return null;

}
}

}

/// @nodoc


class _ProductMonthlyDataEntity implements ProductMonthlyDataEntity {
  const _ProductMonthlyDataEntity({required this.year, required this.month, required this.totalExpense, required this.totalEarned});
  

@override final  int year;
@override final  int month;
@override final  double totalExpense;
@override final  double totalEarned;

/// Create a copy of ProductMonthlyDataEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductMonthlyDataEntityCopyWith<_ProductMonthlyDataEntity> get copyWith => __$ProductMonthlyDataEntityCopyWithImpl<_ProductMonthlyDataEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductMonthlyDataEntity&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.totalExpense, totalExpense) || other.totalExpense == totalExpense)&&(identical(other.totalEarned, totalEarned) || other.totalEarned == totalEarned));
}


@override
int get hashCode => Object.hash(runtimeType,year,month,totalExpense,totalEarned);

@override
String toString() {
  return 'ProductMonthlyDataEntity(year: $year, month: $month, totalExpense: $totalExpense, totalEarned: $totalEarned)';
}


}

/// @nodoc
abstract mixin class _$ProductMonthlyDataEntityCopyWith<$Res> implements $ProductMonthlyDataEntityCopyWith<$Res> {
  factory _$ProductMonthlyDataEntityCopyWith(_ProductMonthlyDataEntity value, $Res Function(_ProductMonthlyDataEntity) _then) = __$ProductMonthlyDataEntityCopyWithImpl;
@override @useResult
$Res call({
 int year, int month, double totalExpense, double totalEarned
});




}
/// @nodoc
class __$ProductMonthlyDataEntityCopyWithImpl<$Res>
    implements _$ProductMonthlyDataEntityCopyWith<$Res> {
  __$ProductMonthlyDataEntityCopyWithImpl(this._self, this._then);

  final _ProductMonthlyDataEntity _self;
  final $Res Function(_ProductMonthlyDataEntity) _then;

/// Create a copy of ProductMonthlyDataEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? year = null,Object? month = null,Object? totalExpense = null,Object? totalEarned = null,}) {
  return _then(_ProductMonthlyDataEntity(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,totalExpense: null == totalExpense ? _self.totalExpense : totalExpense // ignore: cast_nullable_to_non_nullable
as double,totalEarned: null == totalEarned ? _self.totalEarned : totalEarned // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
