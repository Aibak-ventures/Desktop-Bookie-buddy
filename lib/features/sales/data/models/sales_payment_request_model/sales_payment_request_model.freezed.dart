// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sales_payment_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SalesPaymentRequestModel {

@JsonKey(name: 'id') int? get id;@JsonKey(name: 'account_id') int get accountId;@JsonKey(name: 'amount') int get amount;
/// Create a copy of SalesPaymentRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SalesPaymentRequestModelCopyWith<SalesPaymentRequestModel> get copyWith => _$SalesPaymentRequestModelCopyWithImpl<SalesPaymentRequestModel>(this as SalesPaymentRequestModel, _$identity);

  /// Serializes this SalesPaymentRequestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SalesPaymentRequestModel&&(identical(other.id, id) || other.id == id)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,accountId,amount);

@override
String toString() {
  return 'SalesPaymentRequestModel(id: $id, accountId: $accountId, amount: $amount)';
}


}

/// @nodoc
abstract mixin class $SalesPaymentRequestModelCopyWith<$Res>  {
  factory $SalesPaymentRequestModelCopyWith(SalesPaymentRequestModel value, $Res Function(SalesPaymentRequestModel) _then) = _$SalesPaymentRequestModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id') int? id,@JsonKey(name: 'account_id') int accountId,@JsonKey(name: 'amount') int amount
});




}
/// @nodoc
class _$SalesPaymentRequestModelCopyWithImpl<$Res>
    implements $SalesPaymentRequestModelCopyWith<$Res> {
  _$SalesPaymentRequestModelCopyWithImpl(this._self, this._then);

  final SalesPaymentRequestModel _self;
  final $Res Function(SalesPaymentRequestModel) _then;

/// Create a copy of SalesPaymentRequestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? accountId = null,Object? amount = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as int,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SalesPaymentRequestModel].
extension SalesPaymentRequestModelPatterns on SalesPaymentRequestModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SalesPaymentRequestModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SalesPaymentRequestModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SalesPaymentRequestModel value)  $default,){
final _that = this;
switch (_that) {
case _SalesPaymentRequestModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SalesPaymentRequestModel value)?  $default,){
final _that = this;
switch (_that) {
case _SalesPaymentRequestModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  int? id, @JsonKey(name: 'account_id')  int accountId, @JsonKey(name: 'amount')  int amount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SalesPaymentRequestModel() when $default != null:
return $default(_that.id,_that.accountId,_that.amount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  int? id, @JsonKey(name: 'account_id')  int accountId, @JsonKey(name: 'amount')  int amount)  $default,) {final _that = this;
switch (_that) {
case _SalesPaymentRequestModel():
return $default(_that.id,_that.accountId,_that.amount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id')  int? id, @JsonKey(name: 'account_id')  int accountId, @JsonKey(name: 'amount')  int amount)?  $default,) {final _that = this;
switch (_that) {
case _SalesPaymentRequestModel() when $default != null:
return $default(_that.id,_that.accountId,_that.amount);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _SalesPaymentRequestModel implements SalesPaymentRequestModel {
  const _SalesPaymentRequestModel({@JsonKey(name: 'id') this.id, @JsonKey(name: 'account_id') required this.accountId, @JsonKey(name: 'amount') required this.amount});
  factory _SalesPaymentRequestModel.fromJson(Map<String, dynamic> json) => _$SalesPaymentRequestModelFromJson(json);

@override@JsonKey(name: 'id') final  int? id;
@override@JsonKey(name: 'account_id') final  int accountId;
@override@JsonKey(name: 'amount') final  int amount;

/// Create a copy of SalesPaymentRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SalesPaymentRequestModelCopyWith<_SalesPaymentRequestModel> get copyWith => __$SalesPaymentRequestModelCopyWithImpl<_SalesPaymentRequestModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SalesPaymentRequestModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SalesPaymentRequestModel&&(identical(other.id, id) || other.id == id)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,accountId,amount);

@override
String toString() {
  return 'SalesPaymentRequestModel(id: $id, accountId: $accountId, amount: $amount)';
}


}

/// @nodoc
abstract mixin class _$SalesPaymentRequestModelCopyWith<$Res> implements $SalesPaymentRequestModelCopyWith<$Res> {
  factory _$SalesPaymentRequestModelCopyWith(_SalesPaymentRequestModel value, $Res Function(_SalesPaymentRequestModel) _then) = __$SalesPaymentRequestModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id') int? id,@JsonKey(name: 'account_id') int accountId,@JsonKey(name: 'amount') int amount
});




}
/// @nodoc
class __$SalesPaymentRequestModelCopyWithImpl<$Res>
    implements _$SalesPaymentRequestModelCopyWith<$Res> {
  __$SalesPaymentRequestModelCopyWithImpl(this._self, this._then);

  final _SalesPaymentRequestModel _self;
  final $Res Function(_SalesPaymentRequestModel) _then;

/// Create a copy of SalesPaymentRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? accountId = null,Object? amount = null,}) {
  return _then(_SalesPaymentRequestModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as int,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
