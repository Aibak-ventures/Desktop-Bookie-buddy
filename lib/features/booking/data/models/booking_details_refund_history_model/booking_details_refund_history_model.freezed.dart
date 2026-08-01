// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_details_refund_history_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BookingDetailsRefundHistoryModel {

@JsonKey(name: 'id') int get id;@JsonKey(name: 'refunded_amount') int get amount;@JsonKey(name: 'account_name') String? get accountName;@JsonKey(name: 'account_id') int? get accountId;@JsonKey(name: 'refund_reason') String? get refundReason;@JsonKey(name: 'created_at') String get createdAt;
/// Create a copy of BookingDetailsRefundHistoryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingDetailsRefundHistoryModelCopyWith<BookingDetailsRefundHistoryModel> get copyWith => _$BookingDetailsRefundHistoryModelCopyWithImpl<BookingDetailsRefundHistoryModel>(this as BookingDetailsRefundHistoryModel, _$identity);

  /// Serializes this BookingDetailsRefundHistoryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingDetailsRefundHistoryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.accountName, accountName) || other.accountName == accountName)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.refundReason, refundReason) || other.refundReason == refundReason)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,amount,accountName,accountId,refundReason,createdAt);

@override
String toString() {
  return 'BookingDetailsRefundHistoryModel(id: $id, amount: $amount, accountName: $accountName, accountId: $accountId, refundReason: $refundReason, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $BookingDetailsRefundHistoryModelCopyWith<$Res>  {
  factory $BookingDetailsRefundHistoryModelCopyWith(BookingDetailsRefundHistoryModel value, $Res Function(BookingDetailsRefundHistoryModel) _then) = _$BookingDetailsRefundHistoryModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id') int id,@JsonKey(name: 'refunded_amount') int amount,@JsonKey(name: 'account_name') String? accountName,@JsonKey(name: 'account_id') int? accountId,@JsonKey(name: 'refund_reason') String? refundReason,@JsonKey(name: 'created_at') String createdAt
});




}
/// @nodoc
class _$BookingDetailsRefundHistoryModelCopyWithImpl<$Res>
    implements $BookingDetailsRefundHistoryModelCopyWith<$Res> {
  _$BookingDetailsRefundHistoryModelCopyWithImpl(this._self, this._then);

  final BookingDetailsRefundHistoryModel _self;
  final $Res Function(BookingDetailsRefundHistoryModel) _then;

/// Create a copy of BookingDetailsRefundHistoryModel
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


/// Adds pattern-matching-related methods to [BookingDetailsRefundHistoryModel].
extension BookingDetailsRefundHistoryModelPatterns on BookingDetailsRefundHistoryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingDetailsRefundHistoryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingDetailsRefundHistoryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingDetailsRefundHistoryModel value)  $default,){
final _that = this;
switch (_that) {
case _BookingDetailsRefundHistoryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingDetailsRefundHistoryModel value)?  $default,){
final _that = this;
switch (_that) {
case _BookingDetailsRefundHistoryModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  int id, @JsonKey(name: 'refunded_amount')  int amount, @JsonKey(name: 'account_name')  String? accountName, @JsonKey(name: 'account_id')  int? accountId, @JsonKey(name: 'refund_reason')  String? refundReason, @JsonKey(name: 'created_at')  String createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingDetailsRefundHistoryModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  int id, @JsonKey(name: 'refunded_amount')  int amount, @JsonKey(name: 'account_name')  String? accountName, @JsonKey(name: 'account_id')  int? accountId, @JsonKey(name: 'refund_reason')  String? refundReason, @JsonKey(name: 'created_at')  String createdAt)  $default,) {final _that = this;
switch (_that) {
case _BookingDetailsRefundHistoryModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id')  int id, @JsonKey(name: 'refunded_amount')  int amount, @JsonKey(name: 'account_name')  String? accountName, @JsonKey(name: 'account_id')  int? accountId, @JsonKey(name: 'refund_reason')  String? refundReason, @JsonKey(name: 'created_at')  String createdAt)?  $default,) {final _that = this;
switch (_that) {
case _BookingDetailsRefundHistoryModel() when $default != null:
return $default(_that.id,_that.amount,_that.accountName,_that.accountId,_that.refundReason,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BookingDetailsRefundHistoryModel implements BookingDetailsRefundHistoryModel {
  const _BookingDetailsRefundHistoryModel({@JsonKey(name: 'id') required this.id, @JsonKey(name: 'refunded_amount') required this.amount, @JsonKey(name: 'account_name') this.accountName, @JsonKey(name: 'account_id') this.accountId, @JsonKey(name: 'refund_reason') this.refundReason, @JsonKey(name: 'created_at') required this.createdAt});
  factory _BookingDetailsRefundHistoryModel.fromJson(Map<String, dynamic> json) => _$BookingDetailsRefundHistoryModelFromJson(json);

@override@JsonKey(name: 'id') final  int id;
@override@JsonKey(name: 'refunded_amount') final  int amount;
@override@JsonKey(name: 'account_name') final  String? accountName;
@override@JsonKey(name: 'account_id') final  int? accountId;
@override@JsonKey(name: 'refund_reason') final  String? refundReason;
@override@JsonKey(name: 'created_at') final  String createdAt;

/// Create a copy of BookingDetailsRefundHistoryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingDetailsRefundHistoryModelCopyWith<_BookingDetailsRefundHistoryModel> get copyWith => __$BookingDetailsRefundHistoryModelCopyWithImpl<_BookingDetailsRefundHistoryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookingDetailsRefundHistoryModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingDetailsRefundHistoryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.accountName, accountName) || other.accountName == accountName)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.refundReason, refundReason) || other.refundReason == refundReason)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,amount,accountName,accountId,refundReason,createdAt);

@override
String toString() {
  return 'BookingDetailsRefundHistoryModel(id: $id, amount: $amount, accountName: $accountName, accountId: $accountId, refundReason: $refundReason, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$BookingDetailsRefundHistoryModelCopyWith<$Res> implements $BookingDetailsRefundHistoryModelCopyWith<$Res> {
  factory _$BookingDetailsRefundHistoryModelCopyWith(_BookingDetailsRefundHistoryModel value, $Res Function(_BookingDetailsRefundHistoryModel) _then) = __$BookingDetailsRefundHistoryModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id') int id,@JsonKey(name: 'refunded_amount') int amount,@JsonKey(name: 'account_name') String? accountName,@JsonKey(name: 'account_id') int? accountId,@JsonKey(name: 'refund_reason') String? refundReason,@JsonKey(name: 'created_at') String createdAt
});




}
/// @nodoc
class __$BookingDetailsRefundHistoryModelCopyWithImpl<$Res>
    implements _$BookingDetailsRefundHistoryModelCopyWith<$Res> {
  __$BookingDetailsRefundHistoryModelCopyWithImpl(this._self, this._then);

  final _BookingDetailsRefundHistoryModel _self;
  final $Res Function(_BookingDetailsRefundHistoryModel) _then;

/// Create a copy of BookingDetailsRefundHistoryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? amount = null,Object? accountName = freezed,Object? accountId = freezed,Object? refundReason = freezed,Object? createdAt = null,}) {
  return _then(_BookingDetailsRefundHistoryModel(
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
