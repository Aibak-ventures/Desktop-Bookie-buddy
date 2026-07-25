// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_refund_history_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BookingRefundHistoryEntity {

 int get id; int get amount; String? get accountName; int? get accountId; String? get refundReason; String get createdAt;
/// Create a copy of BookingRefundHistoryEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingRefundHistoryEntityCopyWith<BookingRefundHistoryEntity> get copyWith => _$BookingRefundHistoryEntityCopyWithImpl<BookingRefundHistoryEntity>(this as BookingRefundHistoryEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingRefundHistoryEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.accountName, accountName) || other.accountName == accountName)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.refundReason, refundReason) || other.refundReason == refundReason)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,amount,accountName,accountId,refundReason,createdAt);

@override
String toString() {
  return 'BookingRefundHistoryEntity(id: $id, amount: $amount, accountName: $accountName, accountId: $accountId, refundReason: $refundReason, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $BookingRefundHistoryEntityCopyWith<$Res>  {
  factory $BookingRefundHistoryEntityCopyWith(BookingRefundHistoryEntity value, $Res Function(BookingRefundHistoryEntity) _then) = _$BookingRefundHistoryEntityCopyWithImpl;
@useResult
$Res call({
 int id, int amount, String? accountName, int? accountId, String? refundReason, String createdAt
});




}
/// @nodoc
class _$BookingRefundHistoryEntityCopyWithImpl<$Res>
    implements $BookingRefundHistoryEntityCopyWith<$Res> {
  _$BookingRefundHistoryEntityCopyWithImpl(this._self, this._then);

  final BookingRefundHistoryEntity _self;
  final $Res Function(BookingRefundHistoryEntity) _then;

/// Create a copy of BookingRefundHistoryEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? amount = null,Object? accountName = freezed,Object? accountId = freezed,Object? refundReason = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,accountName: freezed == accountName ? _self.accountName : accountName // ignore: cast_nullable_to_non_nullable
as String?,accountId: freezed == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as int?,refundReason: freezed == refundReason ? _self.refundReason : refundReason // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BookingRefundHistoryEntity].
extension BookingRefundHistoryEntityPatterns on BookingRefundHistoryEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingRefundHistoryEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingRefundHistoryEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingRefundHistoryEntity value)  $default,){
final _that = this;
switch (_that) {
case _BookingRefundHistoryEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingRefundHistoryEntity value)?  $default,){
final _that = this;
switch (_that) {
case _BookingRefundHistoryEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int amount,  String? accountName,  int? accountId,  String? refundReason,  String createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingRefundHistoryEntity() when $default != null:
return $default(_that.id,_that.amount,_that.accountName,_that.accountId,_that.refundReason,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int amount,  String? accountName,  int? accountId,  String? refundReason,  String createdAt)  $default,) {final _that = this;
switch (_that) {
case _BookingRefundHistoryEntity():
return $default(_that.id,_that.amount,_that.accountName,_that.accountId,_that.refundReason,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int amount,  String? accountName,  int? accountId,  String? refundReason,  String createdAt)?  $default,) {final _that = this;
switch (_that) {
case _BookingRefundHistoryEntity() when $default != null:
return $default(_that.id,_that.amount,_that.accountName,_that.accountId,_that.refundReason,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _BookingRefundHistoryEntity implements BookingRefundHistoryEntity {
  const _BookingRefundHistoryEntity({required this.id, required this.amount, required this.accountName, required this.accountId, this.refundReason, required this.createdAt});
  

@override final  int id;
@override final  int amount;
@override final  String? accountName;
@override final  int? accountId;
@override final  String? refundReason;
@override final  String createdAt;

/// Create a copy of BookingRefundHistoryEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingRefundHistoryEntityCopyWith<_BookingRefundHistoryEntity> get copyWith => __$BookingRefundHistoryEntityCopyWithImpl<_BookingRefundHistoryEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingRefundHistoryEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.accountName, accountName) || other.accountName == accountName)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.refundReason, refundReason) || other.refundReason == refundReason)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,amount,accountName,accountId,refundReason,createdAt);

@override
String toString() {
  return 'BookingRefundHistoryEntity(id: $id, amount: $amount, accountName: $accountName, accountId: $accountId, refundReason: $refundReason, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$BookingRefundHistoryEntityCopyWith<$Res> implements $BookingRefundHistoryEntityCopyWith<$Res> {
  factory _$BookingRefundHistoryEntityCopyWith(_BookingRefundHistoryEntity value, $Res Function(_BookingRefundHistoryEntity) _then) = __$BookingRefundHistoryEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, int amount, String? accountName, int? accountId, String? refundReason, String createdAt
});




}
/// @nodoc
class __$BookingRefundHistoryEntityCopyWithImpl<$Res>
    implements _$BookingRefundHistoryEntityCopyWith<$Res> {
  __$BookingRefundHistoryEntityCopyWithImpl(this._self, this._then);

  final _BookingRefundHistoryEntity _self;
  final $Res Function(_BookingRefundHistoryEntity) _then;

/// Create a copy of BookingRefundHistoryEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? amount = null,Object? accountName = freezed,Object? accountId = freezed,Object? refundReason = freezed,Object? createdAt = null,}) {
  return _then(_BookingRefundHistoryEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,accountName: freezed == accountName ? _self.accountName : accountName // ignore: cast_nullable_to_non_nullable
as String?,accountId: freezed == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as int?,refundReason: freezed == refundReason ? _self.refundReason : refundReason // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
