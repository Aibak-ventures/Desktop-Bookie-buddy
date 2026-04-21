// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_payment_request_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BookingPaymentRequestEntity {

 int get accountId; int get amount;
/// Create a copy of BookingPaymentRequestEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingPaymentRequestEntityCopyWith<BookingPaymentRequestEntity> get copyWith => _$BookingPaymentRequestEntityCopyWithImpl<BookingPaymentRequestEntity>(this as BookingPaymentRequestEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingPaymentRequestEntity&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.amount, amount) || other.amount == amount));
}


@override
int get hashCode => Object.hash(runtimeType,accountId,amount);

@override
String toString() {
  return 'BookingPaymentRequestEntity(accountId: $accountId, amount: $amount)';
}


}

/// @nodoc
abstract mixin class $BookingPaymentRequestEntityCopyWith<$Res>  {
  factory $BookingPaymentRequestEntityCopyWith(BookingPaymentRequestEntity value, $Res Function(BookingPaymentRequestEntity) _then) = _$BookingPaymentRequestEntityCopyWithImpl;
@useResult
$Res call({
 int accountId, int amount
});




}
/// @nodoc
class _$BookingPaymentRequestEntityCopyWithImpl<$Res>
    implements $BookingPaymentRequestEntityCopyWith<$Res> {
  _$BookingPaymentRequestEntityCopyWithImpl(this._self, this._then);

  final BookingPaymentRequestEntity _self;
  final $Res Function(BookingPaymentRequestEntity) _then;

/// Create a copy of BookingPaymentRequestEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accountId = null,Object? amount = null,}) {
  return _then(_self.copyWith(
accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as int,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [BookingPaymentRequestEntity].
extension BookingPaymentRequestEntityPatterns on BookingPaymentRequestEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingPaymentRequestEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingPaymentRequestEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingPaymentRequestEntity value)  $default,){
final _that = this;
switch (_that) {
case _BookingPaymentRequestEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingPaymentRequestEntity value)?  $default,){
final _that = this;
switch (_that) {
case _BookingPaymentRequestEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int accountId,  int amount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingPaymentRequestEntity() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int accountId,  int amount)  $default,) {final _that = this;
switch (_that) {
case _BookingPaymentRequestEntity():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int accountId,  int amount)?  $default,) {final _that = this;
switch (_that) {
case _BookingPaymentRequestEntity() when $default != null:
return $default(_that.accountId,_that.amount);case _:
  return null;

}
}

}

/// @nodoc


class _BookingPaymentRequestEntity implements BookingPaymentRequestEntity {
  const _BookingPaymentRequestEntity({required this.accountId, required this.amount});
  

@override final  int accountId;
@override final  int amount;

/// Create a copy of BookingPaymentRequestEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingPaymentRequestEntityCopyWith<_BookingPaymentRequestEntity> get copyWith => __$BookingPaymentRequestEntityCopyWithImpl<_BookingPaymentRequestEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingPaymentRequestEntity&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.amount, amount) || other.amount == amount));
}


@override
int get hashCode => Object.hash(runtimeType,accountId,amount);

@override
String toString() {
  return 'BookingPaymentRequestEntity(accountId: $accountId, amount: $amount)';
}


}

/// @nodoc
abstract mixin class _$BookingPaymentRequestEntityCopyWith<$Res> implements $BookingPaymentRequestEntityCopyWith<$Res> {
  factory _$BookingPaymentRequestEntityCopyWith(_BookingPaymentRequestEntity value, $Res Function(_BookingPaymentRequestEntity) _then) = __$BookingPaymentRequestEntityCopyWithImpl;
@override @useResult
$Res call({
 int accountId, int amount
});




}
/// @nodoc
class __$BookingPaymentRequestEntityCopyWithImpl<$Res>
    implements _$BookingPaymentRequestEntityCopyWith<$Res> {
  __$BookingPaymentRequestEntityCopyWithImpl(this._self, this._then);

  final _BookingPaymentRequestEntity _self;
  final $Res Function(_BookingPaymentRequestEntity) _then;

/// Create a copy of BookingPaymentRequestEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accountId = null,Object? amount = null,}) {
  return _then(_BookingPaymentRequestEntity(
accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as int,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
