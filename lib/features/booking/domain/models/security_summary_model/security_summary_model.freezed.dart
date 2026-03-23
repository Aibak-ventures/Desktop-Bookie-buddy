// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'security_summary_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SecuritySummaryModel {

 double get securityAmount; double get totalRefunded; double get totalDeducted; double get remainingBalance;
/// Create a copy of SecuritySummaryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SecuritySummaryModelCopyWith<SecuritySummaryModel> get copyWith => _$SecuritySummaryModelCopyWithImpl<SecuritySummaryModel>(this as SecuritySummaryModel, _$identity);

  /// Serializes this SecuritySummaryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SecuritySummaryModel&&(identical(other.securityAmount, securityAmount) || other.securityAmount == securityAmount)&&(identical(other.totalRefunded, totalRefunded) || other.totalRefunded == totalRefunded)&&(identical(other.totalDeducted, totalDeducted) || other.totalDeducted == totalDeducted)&&(identical(other.remainingBalance, remainingBalance) || other.remainingBalance == remainingBalance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,securityAmount,totalRefunded,totalDeducted,remainingBalance);

@override
String toString() {
  return 'SecuritySummaryModel(securityAmount: $securityAmount, totalRefunded: $totalRefunded, totalDeducted: $totalDeducted, remainingBalance: $remainingBalance)';
}


}

/// @nodoc
abstract mixin class $SecuritySummaryModelCopyWith<$Res>  {
  factory $SecuritySummaryModelCopyWith(SecuritySummaryModel value, $Res Function(SecuritySummaryModel) _then) = _$SecuritySummaryModelCopyWithImpl;
@useResult
$Res call({
 double securityAmount, double totalRefunded, double totalDeducted, double remainingBalance
});




}
/// @nodoc
class _$SecuritySummaryModelCopyWithImpl<$Res>
    implements $SecuritySummaryModelCopyWith<$Res> {
  _$SecuritySummaryModelCopyWithImpl(this._self, this._then);

  final SecuritySummaryModel _self;
  final $Res Function(SecuritySummaryModel) _then;

/// Create a copy of SecuritySummaryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? securityAmount = null,Object? totalRefunded = null,Object? totalDeducted = null,Object? remainingBalance = null,}) {
  return _then(_self.copyWith(
securityAmount: null == securityAmount ? _self.securityAmount : securityAmount // ignore: cast_nullable_to_non_nullable
as double,totalRefunded: null == totalRefunded ? _self.totalRefunded : totalRefunded // ignore: cast_nullable_to_non_nullable
as double,totalDeducted: null == totalDeducted ? _self.totalDeducted : totalDeducted // ignore: cast_nullable_to_non_nullable
as double,remainingBalance: null == remainingBalance ? _self.remainingBalance : remainingBalance // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [SecuritySummaryModel].
extension SecuritySummaryModelPatterns on SecuritySummaryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SecuritySummaryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SecuritySummaryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SecuritySummaryModel value)  $default,){
final _that = this;
switch (_that) {
case _SecuritySummaryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SecuritySummaryModel value)?  $default,){
final _that = this;
switch (_that) {
case _SecuritySummaryModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double securityAmount,  double totalRefunded,  double totalDeducted,  double remainingBalance)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SecuritySummaryModel() when $default != null:
return $default(_that.securityAmount,_that.totalRefunded,_that.totalDeducted,_that.remainingBalance);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double securityAmount,  double totalRefunded,  double totalDeducted,  double remainingBalance)  $default,) {final _that = this;
switch (_that) {
case _SecuritySummaryModel():
return $default(_that.securityAmount,_that.totalRefunded,_that.totalDeducted,_that.remainingBalance);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double securityAmount,  double totalRefunded,  double totalDeducted,  double remainingBalance)?  $default,) {final _that = this;
switch (_that) {
case _SecuritySummaryModel() when $default != null:
return $default(_that.securityAmount,_that.totalRefunded,_that.totalDeducted,_that.remainingBalance);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _SecuritySummaryModel implements SecuritySummaryModel {
  const _SecuritySummaryModel({this.securityAmount = 0.0, this.totalRefunded = 0.0, this.totalDeducted = 0.0, this.remainingBalance = 0.0});
  factory _SecuritySummaryModel.fromJson(Map<String, dynamic> json) => _$SecuritySummaryModelFromJson(json);

@override@JsonKey() final  double securityAmount;
@override@JsonKey() final  double totalRefunded;
@override@JsonKey() final  double totalDeducted;
@override@JsonKey() final  double remainingBalance;

/// Create a copy of SecuritySummaryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SecuritySummaryModelCopyWith<_SecuritySummaryModel> get copyWith => __$SecuritySummaryModelCopyWithImpl<_SecuritySummaryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SecuritySummaryModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SecuritySummaryModel&&(identical(other.securityAmount, securityAmount) || other.securityAmount == securityAmount)&&(identical(other.totalRefunded, totalRefunded) || other.totalRefunded == totalRefunded)&&(identical(other.totalDeducted, totalDeducted) || other.totalDeducted == totalDeducted)&&(identical(other.remainingBalance, remainingBalance) || other.remainingBalance == remainingBalance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,securityAmount,totalRefunded,totalDeducted,remainingBalance);

@override
String toString() {
  return 'SecuritySummaryModel(securityAmount: $securityAmount, totalRefunded: $totalRefunded, totalDeducted: $totalDeducted, remainingBalance: $remainingBalance)';
}


}

/// @nodoc
abstract mixin class _$SecuritySummaryModelCopyWith<$Res> implements $SecuritySummaryModelCopyWith<$Res> {
  factory _$SecuritySummaryModelCopyWith(_SecuritySummaryModel value, $Res Function(_SecuritySummaryModel) _then) = __$SecuritySummaryModelCopyWithImpl;
@override @useResult
$Res call({
 double securityAmount, double totalRefunded, double totalDeducted, double remainingBalance
});




}
/// @nodoc
class __$SecuritySummaryModelCopyWithImpl<$Res>
    implements _$SecuritySummaryModelCopyWith<$Res> {
  __$SecuritySummaryModelCopyWithImpl(this._self, this._then);

  final _SecuritySummaryModel _self;
  final $Res Function(_SecuritySummaryModel) _then;

/// Create a copy of SecuritySummaryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? securityAmount = null,Object? totalRefunded = null,Object? totalDeducted = null,Object? remainingBalance = null,}) {
  return _then(_SecuritySummaryModel(
securityAmount: null == securityAmount ? _self.securityAmount : securityAmount // ignore: cast_nullable_to_non_nullable
as double,totalRefunded: null == totalRefunded ? _self.totalRefunded : totalRefunded // ignore: cast_nullable_to_non_nullable
as double,totalDeducted: null == totalDeducted ? _self.totalDeducted : totalDeducted // ignore: cast_nullable_to_non_nullable
as double,remainingBalance: null == remainingBalance ? _self.remainingBalance : remainingBalance // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
