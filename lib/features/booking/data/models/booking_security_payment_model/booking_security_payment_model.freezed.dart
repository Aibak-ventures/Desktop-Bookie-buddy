// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_security_payment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BookingSecurityPaymentModel {

 int? get id;@JsonKey(name: 'amount') int get amount;@JsonKey(name: 'account_name') String? get accountName;@JsonKey(name: 'account_id') int? get accountId;@JsonKey(name: 'paid_at') String? get paidAt;@JsonKey(name: 'created_at') String? get createdAt;
/// Create a copy of BookingSecurityPaymentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingSecurityPaymentModelCopyWith<BookingSecurityPaymentModel> get copyWith => _$BookingSecurityPaymentModelCopyWithImpl<BookingSecurityPaymentModel>(this as BookingSecurityPaymentModel, _$identity);

  /// Serializes this BookingSecurityPaymentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingSecurityPaymentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.accountName, accountName) || other.accountName == accountName)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.paidAt, paidAt) || other.paidAt == paidAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,amount,accountName,accountId,paidAt,createdAt);

@override
String toString() {
  return 'BookingSecurityPaymentModel(id: $id, amount: $amount, accountName: $accountName, accountId: $accountId, paidAt: $paidAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $BookingSecurityPaymentModelCopyWith<$Res>  {
  factory $BookingSecurityPaymentModelCopyWith(BookingSecurityPaymentModel value, $Res Function(BookingSecurityPaymentModel) _then) = _$BookingSecurityPaymentModelCopyWithImpl;
@useResult
$Res call({
 int? id,@JsonKey(name: 'amount') int amount,@JsonKey(name: 'account_name') String? accountName,@JsonKey(name: 'account_id') int? accountId,@JsonKey(name: 'paid_at') String? paidAt,@JsonKey(name: 'created_at') String? createdAt
});




}
/// @nodoc
class _$BookingSecurityPaymentModelCopyWithImpl<$Res>
    implements $BookingSecurityPaymentModelCopyWith<$Res> {
  _$BookingSecurityPaymentModelCopyWithImpl(this._self, this._then);

  final BookingSecurityPaymentModel _self;
  final $Res Function(BookingSecurityPaymentModel) _then;

/// Create a copy of BookingSecurityPaymentModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? amount = null,Object? accountName = freezed,Object? accountId = freezed,Object? paidAt = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,accountName: freezed == accountName ? _self.accountName : accountName // ignore: cast_nullable_to_non_nullable
as String?,accountId: freezed == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as int?,paidAt: freezed == paidAt ? _self.paidAt : paidAt // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BookingSecurityPaymentModel].
extension BookingSecurityPaymentModelPatterns on BookingSecurityPaymentModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingSecurityPaymentModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingSecurityPaymentModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingSecurityPaymentModel value)  $default,){
final _that = this;
switch (_that) {
case _BookingSecurityPaymentModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingSecurityPaymentModel value)?  $default,){
final _that = this;
switch (_that) {
case _BookingSecurityPaymentModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id, @JsonKey(name: 'amount')  int amount, @JsonKey(name: 'account_name')  String? accountName, @JsonKey(name: 'account_id')  int? accountId, @JsonKey(name: 'paid_at')  String? paidAt, @JsonKey(name: 'created_at')  String? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingSecurityPaymentModel() when $default != null:
return $default(_that.id,_that.amount,_that.accountName,_that.accountId,_that.paidAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id, @JsonKey(name: 'amount')  int amount, @JsonKey(name: 'account_name')  String? accountName, @JsonKey(name: 'account_id')  int? accountId, @JsonKey(name: 'paid_at')  String? paidAt, @JsonKey(name: 'created_at')  String? createdAt)  $default,) {final _that = this;
switch (_that) {
case _BookingSecurityPaymentModel():
return $default(_that.id,_that.amount,_that.accountName,_that.accountId,_that.paidAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id, @JsonKey(name: 'amount')  int amount, @JsonKey(name: 'account_name')  String? accountName, @JsonKey(name: 'account_id')  int? accountId, @JsonKey(name: 'paid_at')  String? paidAt, @JsonKey(name: 'created_at')  String? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _BookingSecurityPaymentModel() when $default != null:
return $default(_that.id,_that.amount,_that.accountName,_that.accountId,_that.paidAt,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BookingSecurityPaymentModel implements BookingSecurityPaymentModel {
  const _BookingSecurityPaymentModel({this.id, @JsonKey(name: 'amount') required this.amount, @JsonKey(name: 'account_name') this.accountName, @JsonKey(name: 'account_id') this.accountId, @JsonKey(name: 'paid_at') this.paidAt, @JsonKey(name: 'created_at') this.createdAt});
  factory _BookingSecurityPaymentModel.fromJson(Map<String, dynamic> json) => _$BookingSecurityPaymentModelFromJson(json);

@override final  int? id;
@override@JsonKey(name: 'amount') final  int amount;
@override@JsonKey(name: 'account_name') final  String? accountName;
@override@JsonKey(name: 'account_id') final  int? accountId;
@override@JsonKey(name: 'paid_at') final  String? paidAt;
@override@JsonKey(name: 'created_at') final  String? createdAt;

/// Create a copy of BookingSecurityPaymentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingSecurityPaymentModelCopyWith<_BookingSecurityPaymentModel> get copyWith => __$BookingSecurityPaymentModelCopyWithImpl<_BookingSecurityPaymentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookingSecurityPaymentModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingSecurityPaymentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.accountName, accountName) || other.accountName == accountName)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.paidAt, paidAt) || other.paidAt == paidAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,amount,accountName,accountId,paidAt,createdAt);

@override
String toString() {
  return 'BookingSecurityPaymentModel(id: $id, amount: $amount, accountName: $accountName, accountId: $accountId, paidAt: $paidAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$BookingSecurityPaymentModelCopyWith<$Res> implements $BookingSecurityPaymentModelCopyWith<$Res> {
  factory _$BookingSecurityPaymentModelCopyWith(_BookingSecurityPaymentModel value, $Res Function(_BookingSecurityPaymentModel) _then) = __$BookingSecurityPaymentModelCopyWithImpl;
@override @useResult
$Res call({
 int? id,@JsonKey(name: 'amount') int amount,@JsonKey(name: 'account_name') String? accountName,@JsonKey(name: 'account_id') int? accountId,@JsonKey(name: 'paid_at') String? paidAt,@JsonKey(name: 'created_at') String? createdAt
});




}
/// @nodoc
class __$BookingSecurityPaymentModelCopyWithImpl<$Res>
    implements _$BookingSecurityPaymentModelCopyWith<$Res> {
  __$BookingSecurityPaymentModelCopyWithImpl(this._self, this._then);

  final _BookingSecurityPaymentModel _self;
  final $Res Function(_BookingSecurityPaymentModel) _then;

/// Create a copy of BookingSecurityPaymentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? amount = null,Object? accountName = freezed,Object? accountId = freezed,Object? paidAt = freezed,Object? createdAt = freezed,}) {
  return _then(_BookingSecurityPaymentModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,accountName: freezed == accountName ? _self.accountName : accountName // ignore: cast_nullable_to_non_nullable
as String?,accountId: freezed == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as int?,paidAt: freezed == paidAt ? _self.paidAt : paidAt // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
