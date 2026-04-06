// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_payment_history_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BookingPaymentHistoryEntity {

 int get amount; PaymentMethod get paymentMethod; String get dateTime;
/// Create a copy of BookingPaymentHistoryEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingPaymentHistoryEntityCopyWith<BookingPaymentHistoryEntity> get copyWith => _$BookingPaymentHistoryEntityCopyWithImpl<BookingPaymentHistoryEntity>(this as BookingPaymentHistoryEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingPaymentHistoryEntity&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.dateTime, dateTime) || other.dateTime == dateTime));
}


@override
int get hashCode => Object.hash(runtimeType,amount,paymentMethod,dateTime);

@override
String toString() {
  return 'BookingPaymentHistoryEntity(amount: $amount, paymentMethod: $paymentMethod, dateTime: $dateTime)';
}


}

/// @nodoc
abstract mixin class $BookingPaymentHistoryEntityCopyWith<$Res>  {
  factory $BookingPaymentHistoryEntityCopyWith(BookingPaymentHistoryEntity value, $Res Function(BookingPaymentHistoryEntity) _then) = _$BookingPaymentHistoryEntityCopyWithImpl;
@useResult
$Res call({
 int amount, PaymentMethod paymentMethod, String dateTime
});




}
/// @nodoc
class _$BookingPaymentHistoryEntityCopyWithImpl<$Res>
    implements $BookingPaymentHistoryEntityCopyWith<$Res> {
  _$BookingPaymentHistoryEntityCopyWithImpl(this._self, this._then);

  final BookingPaymentHistoryEntity _self;
  final $Res Function(BookingPaymentHistoryEntity) _then;

/// Create a copy of BookingPaymentHistoryEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? amount = null,Object? paymentMethod = null,Object? dateTime = null,}) {
  return _then(_self.copyWith(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethod,dateTime: null == dateTime ? _self.dateTime : dateTime // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BookingPaymentHistoryEntity].
extension BookingPaymentHistoryEntityPatterns on BookingPaymentHistoryEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingPaymentHistoryEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingPaymentHistoryEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingPaymentHistoryEntity value)  $default,){
final _that = this;
switch (_that) {
case _BookingPaymentHistoryEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingPaymentHistoryEntity value)?  $default,){
final _that = this;
switch (_that) {
case _BookingPaymentHistoryEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int amount,  PaymentMethod paymentMethod,  String dateTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingPaymentHistoryEntity() when $default != null:
return $default(_that.amount,_that.paymentMethod,_that.dateTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int amount,  PaymentMethod paymentMethod,  String dateTime)  $default,) {final _that = this;
switch (_that) {
case _BookingPaymentHistoryEntity():
return $default(_that.amount,_that.paymentMethod,_that.dateTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int amount,  PaymentMethod paymentMethod,  String dateTime)?  $default,) {final _that = this;
switch (_that) {
case _BookingPaymentHistoryEntity() when $default != null:
return $default(_that.amount,_that.paymentMethod,_that.dateTime);case _:
  return null;

}
}

}

/// @nodoc


class _BookingPaymentHistoryEntity implements BookingPaymentHistoryEntity {
  const _BookingPaymentHistoryEntity({required this.amount, required this.paymentMethod, required this.dateTime});
  

@override final  int amount;
@override final  PaymentMethod paymentMethod;
@override final  String dateTime;

/// Create a copy of BookingPaymentHistoryEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingPaymentHistoryEntityCopyWith<_BookingPaymentHistoryEntity> get copyWith => __$BookingPaymentHistoryEntityCopyWithImpl<_BookingPaymentHistoryEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingPaymentHistoryEntity&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.dateTime, dateTime) || other.dateTime == dateTime));
}


@override
int get hashCode => Object.hash(runtimeType,amount,paymentMethod,dateTime);

@override
String toString() {
  return 'BookingPaymentHistoryEntity(amount: $amount, paymentMethod: $paymentMethod, dateTime: $dateTime)';
}


}

/// @nodoc
abstract mixin class _$BookingPaymentHistoryEntityCopyWith<$Res> implements $BookingPaymentHistoryEntityCopyWith<$Res> {
  factory _$BookingPaymentHistoryEntityCopyWith(_BookingPaymentHistoryEntity value, $Res Function(_BookingPaymentHistoryEntity) _then) = __$BookingPaymentHistoryEntityCopyWithImpl;
@override @useResult
$Res call({
 int amount, PaymentMethod paymentMethod, String dateTime
});




}
/// @nodoc
class __$BookingPaymentHistoryEntityCopyWithImpl<$Res>
    implements _$BookingPaymentHistoryEntityCopyWith<$Res> {
  __$BookingPaymentHistoryEntityCopyWithImpl(this._self, this._then);

  final _BookingPaymentHistoryEntity _self;
  final $Res Function(_BookingPaymentHistoryEntity) _then;

/// Create a copy of BookingPaymentHistoryEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? amount = null,Object? paymentMethod = null,Object? dateTime = null,}) {
  return _then(_BookingPaymentHistoryEntity(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethod,dateTime: null == dateTime ? _self.dateTime : dateTime // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
