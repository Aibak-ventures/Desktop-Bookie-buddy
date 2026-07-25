// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_details_security_refund_history_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BookingDetailsSecurityRefundHistoryModel {

@JsonKey(name: 'id') int get id;@JsonKey(name: 'amount') int get amount;@JsonKey(name: 'account_name') String? get accountName;@JsonKey(name: 'account_id') int? get accountId;@JsonKey(name: 'reason') String get note;@JsonKey(name: 'type', fromJson: SecurityPaymentHistoryType.fromJson, includeToJson: false) SecurityPaymentHistoryType get type;@JsonKey(name: 'created_at') String get createdAt;
/// Create a copy of BookingDetailsSecurityRefundHistoryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingDetailsSecurityRefundHistoryModelCopyWith<BookingDetailsSecurityRefundHistoryModel> get copyWith => _$BookingDetailsSecurityRefundHistoryModelCopyWithImpl<BookingDetailsSecurityRefundHistoryModel>(this as BookingDetailsSecurityRefundHistoryModel, _$identity);

  /// Serializes this BookingDetailsSecurityRefundHistoryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingDetailsSecurityRefundHistoryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.accountName, accountName) || other.accountName == accountName)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.note, note) || other.note == note)&&(identical(other.type, type) || other.type == type)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,amount,accountName,accountId,note,type,createdAt);

@override
String toString() {
  return 'BookingDetailsSecurityRefundHistoryModel(id: $id, amount: $amount, accountName: $accountName, accountId: $accountId, note: $note, type: $type, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $BookingDetailsSecurityRefundHistoryModelCopyWith<$Res>  {
  factory $BookingDetailsSecurityRefundHistoryModelCopyWith(BookingDetailsSecurityRefundHistoryModel value, $Res Function(BookingDetailsSecurityRefundHistoryModel) _then) = _$BookingDetailsSecurityRefundHistoryModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id') int id,@JsonKey(name: 'amount') int amount,@JsonKey(name: 'account_name') String? accountName,@JsonKey(name: 'account_id') int? accountId,@JsonKey(name: 'reason') String note,@JsonKey(name: 'type', fromJson: SecurityPaymentHistoryType.fromJson, includeToJson: false) SecurityPaymentHistoryType type,@JsonKey(name: 'created_at') String createdAt
});




}
/// @nodoc
class _$BookingDetailsSecurityRefundHistoryModelCopyWithImpl<$Res>
    implements $BookingDetailsSecurityRefundHistoryModelCopyWith<$Res> {
  _$BookingDetailsSecurityRefundHistoryModelCopyWithImpl(this._self, this._then);

  final BookingDetailsSecurityRefundHistoryModel _self;
  final $Res Function(BookingDetailsSecurityRefundHistoryModel) _then;

/// Create a copy of BookingDetailsSecurityRefundHistoryModel
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


/// Adds pattern-matching-related methods to [BookingDetailsSecurityRefundHistoryModel].
extension BookingDetailsSecurityRefundHistoryModelPatterns on BookingDetailsSecurityRefundHistoryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingDetailsSecurityRefundHistoryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingDetailsSecurityRefundHistoryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingDetailsSecurityRefundHistoryModel value)  $default,){
final _that = this;
switch (_that) {
case _BookingDetailsSecurityRefundHistoryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingDetailsSecurityRefundHistoryModel value)?  $default,){
final _that = this;
switch (_that) {
case _BookingDetailsSecurityRefundHistoryModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  int id, @JsonKey(name: 'amount')  int amount, @JsonKey(name: 'account_name')  String? accountName, @JsonKey(name: 'account_id')  int? accountId, @JsonKey(name: 'reason')  String note, @JsonKey(name: 'type', fromJson: SecurityPaymentHistoryType.fromJson, includeToJson: false)  SecurityPaymentHistoryType type, @JsonKey(name: 'created_at')  String createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingDetailsSecurityRefundHistoryModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  int id, @JsonKey(name: 'amount')  int amount, @JsonKey(name: 'account_name')  String? accountName, @JsonKey(name: 'account_id')  int? accountId, @JsonKey(name: 'reason')  String note, @JsonKey(name: 'type', fromJson: SecurityPaymentHistoryType.fromJson, includeToJson: false)  SecurityPaymentHistoryType type, @JsonKey(name: 'created_at')  String createdAt)  $default,) {final _that = this;
switch (_that) {
case _BookingDetailsSecurityRefundHistoryModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id')  int id, @JsonKey(name: 'amount')  int amount, @JsonKey(name: 'account_name')  String? accountName, @JsonKey(name: 'account_id')  int? accountId, @JsonKey(name: 'reason')  String note, @JsonKey(name: 'type', fromJson: SecurityPaymentHistoryType.fromJson, includeToJson: false)  SecurityPaymentHistoryType type, @JsonKey(name: 'created_at')  String createdAt)?  $default,) {final _that = this;
switch (_that) {
case _BookingDetailsSecurityRefundHistoryModel() when $default != null:
return $default(_that.id,_that.amount,_that.accountName,_that.accountId,_that.note,_that.type,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BookingDetailsSecurityRefundHistoryModel implements BookingDetailsSecurityRefundHistoryModel {
  const _BookingDetailsSecurityRefundHistoryModel({@JsonKey(name: 'id') required this.id, @JsonKey(name: 'amount') required this.amount, @JsonKey(name: 'account_name') this.accountName, @JsonKey(name: 'account_id') this.accountId, @JsonKey(name: 'reason') required this.note, @JsonKey(name: 'type', fromJson: SecurityPaymentHistoryType.fromJson, includeToJson: false) required this.type, @JsonKey(name: 'created_at') required this.createdAt});
  factory _BookingDetailsSecurityRefundHistoryModel.fromJson(Map<String, dynamic> json) => _$BookingDetailsSecurityRefundHistoryModelFromJson(json);

@override@JsonKey(name: 'id') final  int id;
@override@JsonKey(name: 'amount') final  int amount;
@override@JsonKey(name: 'account_name') final  String? accountName;
@override@JsonKey(name: 'account_id') final  int? accountId;
@override@JsonKey(name: 'reason') final  String note;
@override@JsonKey(name: 'type', fromJson: SecurityPaymentHistoryType.fromJson, includeToJson: false) final  SecurityPaymentHistoryType type;
@override@JsonKey(name: 'created_at') final  String createdAt;

/// Create a copy of BookingDetailsSecurityRefundHistoryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingDetailsSecurityRefundHistoryModelCopyWith<_BookingDetailsSecurityRefundHistoryModel> get copyWith => __$BookingDetailsSecurityRefundHistoryModelCopyWithImpl<_BookingDetailsSecurityRefundHistoryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookingDetailsSecurityRefundHistoryModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingDetailsSecurityRefundHistoryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.accountName, accountName) || other.accountName == accountName)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.note, note) || other.note == note)&&(identical(other.type, type) || other.type == type)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,amount,accountName,accountId,note,type,createdAt);

@override
String toString() {
  return 'BookingDetailsSecurityRefundHistoryModel(id: $id, amount: $amount, accountName: $accountName, accountId: $accountId, note: $note, type: $type, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$BookingDetailsSecurityRefundHistoryModelCopyWith<$Res> implements $BookingDetailsSecurityRefundHistoryModelCopyWith<$Res> {
  factory _$BookingDetailsSecurityRefundHistoryModelCopyWith(_BookingDetailsSecurityRefundHistoryModel value, $Res Function(_BookingDetailsSecurityRefundHistoryModel) _then) = __$BookingDetailsSecurityRefundHistoryModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id') int id,@JsonKey(name: 'amount') int amount,@JsonKey(name: 'account_name') String? accountName,@JsonKey(name: 'account_id') int? accountId,@JsonKey(name: 'reason') String note,@JsonKey(name: 'type', fromJson: SecurityPaymentHistoryType.fromJson, includeToJson: false) SecurityPaymentHistoryType type,@JsonKey(name: 'created_at') String createdAt
});




}
/// @nodoc
class __$BookingDetailsSecurityRefundHistoryModelCopyWithImpl<$Res>
    implements _$BookingDetailsSecurityRefundHistoryModelCopyWith<$Res> {
  __$BookingDetailsSecurityRefundHistoryModelCopyWithImpl(this._self, this._then);

  final _BookingDetailsSecurityRefundHistoryModel _self;
  final $Res Function(_BookingDetailsSecurityRefundHistoryModel) _then;

/// Create a copy of BookingDetailsSecurityRefundHistoryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? amount = null,Object? accountName = freezed,Object? accountId = freezed,Object? note = null,Object? type = null,Object? createdAt = null,}) {
  return _then(_BookingDetailsSecurityRefundHistoryModel(
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
