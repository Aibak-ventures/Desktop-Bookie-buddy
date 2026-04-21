// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_payment_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BookingPaymentRequestModel {

@JsonKey(name: 'account_id') int get accountId;@JsonKey(name: 'amount') int get amount;
/// Create a copy of BookingPaymentRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingPaymentRequestModelCopyWith<BookingPaymentRequestModel> get copyWith => _$BookingPaymentRequestModelCopyWithImpl<BookingPaymentRequestModel>(this as BookingPaymentRequestModel, _$identity);

  /// Serializes this BookingPaymentRequestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingPaymentRequestModel&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accountId,amount);

@override
String toString() {
  return 'BookingPaymentRequestModel(accountId: $accountId, amount: $amount)';
}


}

/// @nodoc
abstract mixin class $BookingPaymentRequestModelCopyWith<$Res>  {
  factory $BookingPaymentRequestModelCopyWith(BookingPaymentRequestModel value, $Res Function(BookingPaymentRequestModel) _then) = _$BookingPaymentRequestModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'account_id') int accountId,@JsonKey(name: 'amount') int amount
});




}
/// @nodoc
class _$BookingPaymentRequestModelCopyWithImpl<$Res>
    implements $BookingPaymentRequestModelCopyWith<$Res> {
  _$BookingPaymentRequestModelCopyWithImpl(this._self, this._then);

  final BookingPaymentRequestModel _self;
  final $Res Function(BookingPaymentRequestModel) _then;

/// Create a copy of BookingPaymentRequestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accountId = null,Object? amount = null,}) {
  return _then(_self.copyWith(
accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as int,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [BookingPaymentRequestModel].
extension BookingPaymentRequestModelPatterns on BookingPaymentRequestModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingPaymentRequestModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingPaymentRequestModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingPaymentRequestModel value)  $default,){
final _that = this;
switch (_that) {
case _BookingPaymentRequestModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingPaymentRequestModel value)?  $default,){
final _that = this;
switch (_that) {
case _BookingPaymentRequestModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'account_id')  int accountId, @JsonKey(name: 'amount')  int amount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingPaymentRequestModel() when $default != null:
return $default(_that.accountId,_that.amount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'account_id')  int accountId, @JsonKey(name: 'amount')  int amount)  $default,) {final _that = this;
switch (_that) {
case _BookingPaymentRequestModel():
return $default(_that.accountId,_that.amount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'account_id')  int accountId, @JsonKey(name: 'amount')  int amount)?  $default,) {final _that = this;
switch (_that) {
case _BookingPaymentRequestModel() when $default != null:
return $default(_that.accountId,_that.amount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BookingPaymentRequestModel implements BookingPaymentRequestModel {
  const _BookingPaymentRequestModel({@JsonKey(name: 'account_id') required this.accountId, @JsonKey(name: 'amount') required this.amount});
  factory _BookingPaymentRequestModel.fromJson(Map<String, dynamic> json) => _$BookingPaymentRequestModelFromJson(json);

@override@JsonKey(name: 'account_id') final  int accountId;
@override@JsonKey(name: 'amount') final  int amount;

/// Create a copy of BookingPaymentRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingPaymentRequestModelCopyWith<_BookingPaymentRequestModel> get copyWith => __$BookingPaymentRequestModelCopyWithImpl<_BookingPaymentRequestModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookingPaymentRequestModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingPaymentRequestModel&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accountId,amount);

@override
String toString() {
  return 'BookingPaymentRequestModel(accountId: $accountId, amount: $amount)';
}


}

/// @nodoc
abstract mixin class _$BookingPaymentRequestModelCopyWith<$Res> implements $BookingPaymentRequestModelCopyWith<$Res> {
  factory _$BookingPaymentRequestModelCopyWith(_BookingPaymentRequestModel value, $Res Function(_BookingPaymentRequestModel) _then) = __$BookingPaymentRequestModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'account_id') int accountId,@JsonKey(name: 'amount') int amount
});




}
/// @nodoc
class __$BookingPaymentRequestModelCopyWithImpl<$Res>
    implements _$BookingPaymentRequestModelCopyWith<$Res> {
  __$BookingPaymentRequestModelCopyWithImpl(this._self, this._then);

  final _BookingPaymentRequestModel _self;
  final $Res Function(_BookingPaymentRequestModel) _then;

/// Create a copy of BookingPaymentRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accountId = null,Object? amount = null,}) {
  return _then(_BookingPaymentRequestModel(
accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as int,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
