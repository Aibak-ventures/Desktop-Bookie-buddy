// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_monthly_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProductMonthlyDataModel {

 int get year; int get month;@JsonKey(name: 'total_expense') double get totalExpense;@JsonKey(name: 'total_earned') double get totalEarned;
/// Create a copy of ProductMonthlyDataModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductMonthlyDataModelCopyWith<ProductMonthlyDataModel> get copyWith => _$ProductMonthlyDataModelCopyWithImpl<ProductMonthlyDataModel>(this as ProductMonthlyDataModel, _$identity);

  /// Serializes this ProductMonthlyDataModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductMonthlyDataModel&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.totalExpense, totalExpense) || other.totalExpense == totalExpense)&&(identical(other.totalEarned, totalEarned) || other.totalEarned == totalEarned));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,year,month,totalExpense,totalEarned);

@override
String toString() {
  return 'ProductMonthlyDataModel(year: $year, month: $month, totalExpense: $totalExpense, totalEarned: $totalEarned)';
}


}

/// @nodoc
abstract mixin class $ProductMonthlyDataModelCopyWith<$Res>  {
  factory $ProductMonthlyDataModelCopyWith(ProductMonthlyDataModel value, $Res Function(ProductMonthlyDataModel) _then) = _$ProductMonthlyDataModelCopyWithImpl;
@useResult
$Res call({
 int year, int month,@JsonKey(name: 'total_expense') double totalExpense,@JsonKey(name: 'total_earned') double totalEarned
});




}
/// @nodoc
class _$ProductMonthlyDataModelCopyWithImpl<$Res>
    implements $ProductMonthlyDataModelCopyWith<$Res> {
  _$ProductMonthlyDataModelCopyWithImpl(this._self, this._then);

  final ProductMonthlyDataModel _self;
  final $Res Function(ProductMonthlyDataModel) _then;

/// Create a copy of ProductMonthlyDataModel
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


/// Adds pattern-matching-related methods to [ProductMonthlyDataModel].
extension ProductMonthlyDataModelPatterns on ProductMonthlyDataModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductMonthlyDataModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductMonthlyDataModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductMonthlyDataModel value)  $default,){
final _that = this;
switch (_that) {
case _ProductMonthlyDataModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductMonthlyDataModel value)?  $default,){
final _that = this;
switch (_that) {
case _ProductMonthlyDataModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int year,  int month, @JsonKey(name: 'total_expense')  double totalExpense, @JsonKey(name: 'total_earned')  double totalEarned)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductMonthlyDataModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int year,  int month, @JsonKey(name: 'total_expense')  double totalExpense, @JsonKey(name: 'total_earned')  double totalEarned)  $default,) {final _that = this;
switch (_that) {
case _ProductMonthlyDataModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int year,  int month, @JsonKey(name: 'total_expense')  double totalExpense, @JsonKey(name: 'total_earned')  double totalEarned)?  $default,) {final _that = this;
switch (_that) {
case _ProductMonthlyDataModel() when $default != null:
return $default(_that.year,_that.month,_that.totalExpense,_that.totalEarned);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductMonthlyDataModel implements ProductMonthlyDataModel {
  const _ProductMonthlyDataModel({required this.year, required this.month, @JsonKey(name: 'total_expense') required this.totalExpense, @JsonKey(name: 'total_earned') required this.totalEarned});
  factory _ProductMonthlyDataModel.fromJson(Map<String, dynamic> json) => _$ProductMonthlyDataModelFromJson(json);

@override final  int year;
@override final  int month;
@override@JsonKey(name: 'total_expense') final  double totalExpense;
@override@JsonKey(name: 'total_earned') final  double totalEarned;

/// Create a copy of ProductMonthlyDataModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductMonthlyDataModelCopyWith<_ProductMonthlyDataModel> get copyWith => __$ProductMonthlyDataModelCopyWithImpl<_ProductMonthlyDataModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductMonthlyDataModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductMonthlyDataModel&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.totalExpense, totalExpense) || other.totalExpense == totalExpense)&&(identical(other.totalEarned, totalEarned) || other.totalEarned == totalEarned));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,year,month,totalExpense,totalEarned);

@override
String toString() {
  return 'ProductMonthlyDataModel(year: $year, month: $month, totalExpense: $totalExpense, totalEarned: $totalEarned)';
}


}

/// @nodoc
abstract mixin class _$ProductMonthlyDataModelCopyWith<$Res> implements $ProductMonthlyDataModelCopyWith<$Res> {
  factory _$ProductMonthlyDataModelCopyWith(_ProductMonthlyDataModel value, $Res Function(_ProductMonthlyDataModel) _then) = __$ProductMonthlyDataModelCopyWithImpl;
@override @useResult
$Res call({
 int year, int month,@JsonKey(name: 'total_expense') double totalExpense,@JsonKey(name: 'total_earned') double totalEarned
});




}
/// @nodoc
class __$ProductMonthlyDataModelCopyWithImpl<$Res>
    implements _$ProductMonthlyDataModelCopyWith<$Res> {
  __$ProductMonthlyDataModelCopyWithImpl(this._self, this._then);

  final _ProductMonthlyDataModel _self;
  final $Res Function(_ProductMonthlyDataModel) _then;

/// Create a copy of ProductMonthlyDataModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? year = null,Object? month = null,Object? totalExpense = null,Object? totalEarned = null,}) {
  return _then(_ProductMonthlyDataModel(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,totalExpense: null == totalExpense ? _self.totalExpense : totalExpense // ignore: cast_nullable_to_non_nullable
as double,totalEarned: null == totalEarned ? _self.totalEarned : totalEarned // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
