// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_details_payment_history_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BookingDetailsPaymentHistoryModel {

@JsonKey(name: 'amount') int get amount;@JsonKey(name: 'payment_method', defaultValue: PaymentMethod.cash, fromJson: PaymentMethod.fromJson) PaymentMethod get paymentMethod;@JsonKey(name: 'datetime', readValue: _readDateTime) String get dateTime;
/// Create a copy of BookingDetailsPaymentHistoryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingDetailsPaymentHistoryModelCopyWith<BookingDetailsPaymentHistoryModel> get copyWith => _$BookingDetailsPaymentHistoryModelCopyWithImpl<BookingDetailsPaymentHistoryModel>(this as BookingDetailsPaymentHistoryModel, _$identity);

  /// Serializes this BookingDetailsPaymentHistoryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingDetailsPaymentHistoryModel&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.dateTime, dateTime) || other.dateTime == dateTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount,paymentMethod,dateTime);

@override
String toString() {
  return 'BookingDetailsPaymentHistoryModel(amount: $amount, paymentMethod: $paymentMethod, dateTime: $dateTime)';
}


}

/// @nodoc
abstract mixin class $BookingDetailsPaymentHistoryModelCopyWith<$Res>  {
  factory $BookingDetailsPaymentHistoryModelCopyWith(BookingDetailsPaymentHistoryModel value, $Res Function(BookingDetailsPaymentHistoryModel) _then) = _$BookingDetailsPaymentHistoryModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'amount') int amount,@JsonKey(name: 'payment_method', defaultValue: PaymentMethod.cash, fromJson: PaymentMethod.fromJson) PaymentMethod paymentMethod,@JsonKey(name: 'datetime', readValue: _readDateTime) String dateTime
});




}
/// @nodoc
class _$BookingDetailsPaymentHistoryModelCopyWithImpl<$Res>
    implements $BookingDetailsPaymentHistoryModelCopyWith<$Res> {
  _$BookingDetailsPaymentHistoryModelCopyWithImpl(this._self, this._then);

  final BookingDetailsPaymentHistoryModel _self;
  final $Res Function(BookingDetailsPaymentHistoryModel) _then;

/// Create a copy of BookingDetailsPaymentHistoryModel
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


/// Adds pattern-matching-related methods to [BookingDetailsPaymentHistoryModel].
extension BookingDetailsPaymentHistoryModelPatterns on BookingDetailsPaymentHistoryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingDetailsPaymentHistoryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingDetailsPaymentHistoryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingDetailsPaymentHistoryModel value)  $default,){
final _that = this;
switch (_that) {
case _BookingDetailsPaymentHistoryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingDetailsPaymentHistoryModel value)?  $default,){
final _that = this;
switch (_that) {
case _BookingDetailsPaymentHistoryModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'amount')  int amount, @JsonKey(name: 'payment_method', defaultValue: PaymentMethod.cash, fromJson: PaymentMethod.fromJson)  PaymentMethod paymentMethod, @JsonKey(name: 'datetime', readValue: _readDateTime)  String dateTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingDetailsPaymentHistoryModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'amount')  int amount, @JsonKey(name: 'payment_method', defaultValue: PaymentMethod.cash, fromJson: PaymentMethod.fromJson)  PaymentMethod paymentMethod, @JsonKey(name: 'datetime', readValue: _readDateTime)  String dateTime)  $default,) {final _that = this;
switch (_that) {
case _BookingDetailsPaymentHistoryModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'amount')  int amount, @JsonKey(name: 'payment_method', defaultValue: PaymentMethod.cash, fromJson: PaymentMethod.fromJson)  PaymentMethod paymentMethod, @JsonKey(name: 'datetime', readValue: _readDateTime)  String dateTime)?  $default,) {final _that = this;
switch (_that) {
case _BookingDetailsPaymentHistoryModel() when $default != null:
return $default(_that.amount,_that.paymentMethod,_that.dateTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BookingDetailsPaymentHistoryModel implements BookingDetailsPaymentHistoryModel {
  const _BookingDetailsPaymentHistoryModel({@JsonKey(name: 'amount') required this.amount, @JsonKey(name: 'payment_method', defaultValue: PaymentMethod.cash, fromJson: PaymentMethod.fromJson) required this.paymentMethod, @JsonKey(name: 'datetime', readValue: _readDateTime) required this.dateTime});
  factory _BookingDetailsPaymentHistoryModel.fromJson(Map<String, dynamic> json) => _$BookingDetailsPaymentHistoryModelFromJson(json);

@override@JsonKey(name: 'amount') final  int amount;
@override@JsonKey(name: 'payment_method', defaultValue: PaymentMethod.cash, fromJson: PaymentMethod.fromJson) final  PaymentMethod paymentMethod;
@override@JsonKey(name: 'datetime', readValue: _readDateTime) final  String dateTime;

/// Create a copy of BookingDetailsPaymentHistoryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingDetailsPaymentHistoryModelCopyWith<_BookingDetailsPaymentHistoryModel> get copyWith => __$BookingDetailsPaymentHistoryModelCopyWithImpl<_BookingDetailsPaymentHistoryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookingDetailsPaymentHistoryModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingDetailsPaymentHistoryModel&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.dateTime, dateTime) || other.dateTime == dateTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount,paymentMethod,dateTime);

@override
String toString() {
  return 'BookingDetailsPaymentHistoryModel(amount: $amount, paymentMethod: $paymentMethod, dateTime: $dateTime)';
}


}

/// @nodoc
abstract mixin class _$BookingDetailsPaymentHistoryModelCopyWith<$Res> implements $BookingDetailsPaymentHistoryModelCopyWith<$Res> {
  factory _$BookingDetailsPaymentHistoryModelCopyWith(_BookingDetailsPaymentHistoryModel value, $Res Function(_BookingDetailsPaymentHistoryModel) _then) = __$BookingDetailsPaymentHistoryModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'amount') int amount,@JsonKey(name: 'payment_method', defaultValue: PaymentMethod.cash, fromJson: PaymentMethod.fromJson) PaymentMethod paymentMethod,@JsonKey(name: 'datetime', readValue: _readDateTime) String dateTime
});




}
/// @nodoc
class __$BookingDetailsPaymentHistoryModelCopyWithImpl<$Res>
    implements _$BookingDetailsPaymentHistoryModelCopyWith<$Res> {
  __$BookingDetailsPaymentHistoryModelCopyWithImpl(this._self, this._then);

  final _BookingDetailsPaymentHistoryModel _self;
  final $Res Function(_BookingDetailsPaymentHistoryModel) _then;

/// Create a copy of BookingDetailsPaymentHistoryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? amount = null,Object? paymentMethod = null,Object? dateTime = null,}) {
  return _then(_BookingDetailsPaymentHistoryModel(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethod,dateTime: null == dateTime ? _self.dateTime : dateTime // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
