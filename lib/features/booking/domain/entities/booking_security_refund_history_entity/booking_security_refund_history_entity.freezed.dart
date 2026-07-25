// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_security_refund_history_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BookingSecurityRefundHistoryEntity {

 int get id; int get amount; String? get accountName; int? get accountId; String get note; SecurityPaymentHistoryType get type; String get createdAt;
/// Create a copy of BookingSecurityRefundHistoryEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingSecurityRefundHistoryEntityCopyWith<BookingSecurityRefundHistoryEntity> get copyWith => _$BookingSecurityRefundHistoryEntityCopyWithImpl<BookingSecurityRefundHistoryEntity>(this as BookingSecurityRefundHistoryEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingSecurityRefundHistoryEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.accountName, accountName) || other.accountName == accountName)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.note, note) || other.note == note)&&(identical(other.type, type) || other.type == type)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,amount,accountName,accountId,note,type,createdAt);

@override
String toString() {
  return 'BookingSecurityRefundHistoryEntity(id: $id, amount: $amount, accountName: $accountName, accountId: $accountId, note: $note, type: $type, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $BookingSecurityRefundHistoryEntityCopyWith<$Res>  {
  factory $BookingSecurityRefundHistoryEntityCopyWith(BookingSecurityRefundHistoryEntity value, $Res Function(BookingSecurityRefundHistoryEntity) _then) = _$BookingSecurityRefundHistoryEntityCopyWithImpl;
@useResult
$Res call({
 int id, int amount, String? accountName, int? accountId, String note, SecurityPaymentHistoryType type, String createdAt
});




}
/// @nodoc
class _$BookingSecurityRefundHistoryEntityCopyWithImpl<$Res>
    implements $BookingSecurityRefundHistoryEntityCopyWith<$Res> {
  _$BookingSecurityRefundHistoryEntityCopyWithImpl(this._self, this._then);

  final BookingSecurityRefundHistoryEntity _self;
  final $Res Function(BookingSecurityRefundHistoryEntity) _then;

/// Create a copy of BookingSecurityRefundHistoryEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? amount = null,Object? accountName = freezed,Object? accountId = freezed,Object? note = null,Object? type = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,accountName: freezed == accountName ? _self.accountName : accountName // ignore: cast_nullable_to_non_nullable
as String?,accountId: freezed == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as int?,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SecurityPaymentHistoryType,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BookingSecurityRefundHistoryEntity].
extension BookingSecurityRefundHistoryEntityPatterns on BookingSecurityRefundHistoryEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingSecurityRefundHistoryEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingSecurityRefundHistoryEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingSecurityRefundHistoryEntity value)  $default,){
final _that = this;
switch (_that) {
case _BookingSecurityRefundHistoryEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingSecurityRefundHistoryEntity value)?  $default,){
final _that = this;
switch (_that) {
case _BookingSecurityRefundHistoryEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int amount,  String? accountName,  int? accountId,  String note,  SecurityPaymentHistoryType type,  String createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingSecurityRefundHistoryEntity() when $default != null:
return $default(_that.id,_that.amount,_that.accountName,_that.accountId,_that.note,_that.type,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int amount,  String? accountName,  int? accountId,  String note,  SecurityPaymentHistoryType type,  String createdAt)  $default,) {final _that = this;
switch (_that) {
case _BookingSecurityRefundHistoryEntity():
return $default(_that.id,_that.amount,_that.accountName,_that.accountId,_that.note,_that.type,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int amount,  String? accountName,  int? accountId,  String note,  SecurityPaymentHistoryType type,  String createdAt)?  $default,) {final _that = this;
switch (_that) {
case _BookingSecurityRefundHistoryEntity() when $default != null:
return $default(_that.id,_that.amount,_that.accountName,_that.accountId,_that.note,_that.type,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _BookingSecurityRefundHistoryEntity implements BookingSecurityRefundHistoryEntity {
  const _BookingSecurityRefundHistoryEntity({required this.id, required this.amount, this.accountName, this.accountId, required this.note, required this.type, required this.createdAt});
  

@override final  int id;
@override final  int amount;
@override final  String? accountName;
@override final  int? accountId;
@override final  String note;
@override final  SecurityPaymentHistoryType type;
@override final  String createdAt;

/// Create a copy of BookingSecurityRefundHistoryEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingSecurityRefundHistoryEntityCopyWith<_BookingSecurityRefundHistoryEntity> get copyWith => __$BookingSecurityRefundHistoryEntityCopyWithImpl<_BookingSecurityRefundHistoryEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingSecurityRefundHistoryEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.accountName, accountName) || other.accountName == accountName)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.note, note) || other.note == note)&&(identical(other.type, type) || other.type == type)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,amount,accountName,accountId,note,type,createdAt);

@override
String toString() {
  return 'BookingSecurityRefundHistoryEntity(id: $id, amount: $amount, accountName: $accountName, accountId: $accountId, note: $note, type: $type, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$BookingSecurityRefundHistoryEntityCopyWith<$Res> implements $BookingSecurityRefundHistoryEntityCopyWith<$Res> {
  factory _$BookingSecurityRefundHistoryEntityCopyWith(_BookingSecurityRefundHistoryEntity value, $Res Function(_BookingSecurityRefundHistoryEntity) _then) = __$BookingSecurityRefundHistoryEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, int amount, String? accountName, int? accountId, String note, SecurityPaymentHistoryType type, String createdAt
});




}
/// @nodoc
class __$BookingSecurityRefundHistoryEntityCopyWithImpl<$Res>
    implements _$BookingSecurityRefundHistoryEntityCopyWith<$Res> {
  __$BookingSecurityRefundHistoryEntityCopyWithImpl(this._self, this._then);

  final _BookingSecurityRefundHistoryEntity _self;
  final $Res Function(_BookingSecurityRefundHistoryEntity) _then;

/// Create a copy of BookingSecurityRefundHistoryEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? amount = null,Object? accountName = freezed,Object? accountId = freezed,Object? note = null,Object? type = null,Object? createdAt = null,}) {
  return _then(_BookingSecurityRefundHistoryEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,accountName: freezed == accountName ? _self.accountName : accountName // ignore: cast_nullable_to_non_nullable
as String?,accountId: freezed == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as int?,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SecurityPaymentHistoryType,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
