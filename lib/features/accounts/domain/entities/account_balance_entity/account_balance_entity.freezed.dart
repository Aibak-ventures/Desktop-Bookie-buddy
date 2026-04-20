// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_balance_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AccountBalanceEntity {

 AccountEntity get account; double get balance;
/// Create a copy of AccountBalanceEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountBalanceEntityCopyWith<AccountBalanceEntity> get copyWith => _$AccountBalanceEntityCopyWithImpl<AccountBalanceEntity>(this as AccountBalanceEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountBalanceEntity&&(identical(other.account, account) || other.account == account)&&(identical(other.balance, balance) || other.balance == balance));
}


@override
int get hashCode => Object.hash(runtimeType,account,balance);

@override
String toString() {
  return 'AccountBalanceEntity(account: $account, balance: $balance)';
}


}

/// @nodoc
abstract mixin class $AccountBalanceEntityCopyWith<$Res>  {
  factory $AccountBalanceEntityCopyWith(AccountBalanceEntity value, $Res Function(AccountBalanceEntity) _then) = _$AccountBalanceEntityCopyWithImpl;
@useResult
$Res call({
 AccountEntity account, double balance
});


$AccountEntityCopyWith<$Res> get account;

}
/// @nodoc
class _$AccountBalanceEntityCopyWithImpl<$Res>
    implements $AccountBalanceEntityCopyWith<$Res> {
  _$AccountBalanceEntityCopyWithImpl(this._self, this._then);

  final AccountBalanceEntity _self;
  final $Res Function(AccountBalanceEntity) _then;

/// Create a copy of AccountBalanceEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? account = null,Object? balance = null,}) {
  return _then(_self.copyWith(
account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as AccountEntity,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as double,
  ));
}
/// Create a copy of AccountBalanceEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AccountEntityCopyWith<$Res> get account {
  
  return $AccountEntityCopyWith<$Res>(_self.account, (value) {
    return _then(_self.copyWith(account: value));
  });
}
}


/// Adds pattern-matching-related methods to [AccountBalanceEntity].
extension AccountBalanceEntityPatterns on AccountBalanceEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccountBalanceEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccountBalanceEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccountBalanceEntity value)  $default,){
final _that = this;
switch (_that) {
case _AccountBalanceEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccountBalanceEntity value)?  $default,){
final _that = this;
switch (_that) {
case _AccountBalanceEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AccountEntity account,  double balance)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccountBalanceEntity() when $default != null:
return $default(_that.account,_that.balance);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AccountEntity account,  double balance)  $default,) {final _that = this;
switch (_that) {
case _AccountBalanceEntity():
return $default(_that.account,_that.balance);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AccountEntity account,  double balance)?  $default,) {final _that = this;
switch (_that) {
case _AccountBalanceEntity() when $default != null:
return $default(_that.account,_that.balance);case _:
  return null;

}
}

}

/// @nodoc


class _AccountBalanceEntity implements AccountBalanceEntity {
  const _AccountBalanceEntity({required this.account, required this.balance});
  

@override final  AccountEntity account;
@override final  double balance;

/// Create a copy of AccountBalanceEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountBalanceEntityCopyWith<_AccountBalanceEntity> get copyWith => __$AccountBalanceEntityCopyWithImpl<_AccountBalanceEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccountBalanceEntity&&(identical(other.account, account) || other.account == account)&&(identical(other.balance, balance) || other.balance == balance));
}


@override
int get hashCode => Object.hash(runtimeType,account,balance);

@override
String toString() {
  return 'AccountBalanceEntity(account: $account, balance: $balance)';
}


}

/// @nodoc
abstract mixin class _$AccountBalanceEntityCopyWith<$Res> implements $AccountBalanceEntityCopyWith<$Res> {
  factory _$AccountBalanceEntityCopyWith(_AccountBalanceEntity value, $Res Function(_AccountBalanceEntity) _then) = __$AccountBalanceEntityCopyWithImpl;
@override @useResult
$Res call({
 AccountEntity account, double balance
});


@override $AccountEntityCopyWith<$Res> get account;

}
/// @nodoc
class __$AccountBalanceEntityCopyWithImpl<$Res>
    implements _$AccountBalanceEntityCopyWith<$Res> {
  __$AccountBalanceEntityCopyWithImpl(this._self, this._then);

  final _AccountBalanceEntity _self;
  final $Res Function(_AccountBalanceEntity) _then;

/// Create a copy of AccountBalanceEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? account = null,Object? balance = null,}) {
  return _then(_AccountBalanceEntity(
account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as AccountEntity,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

/// Create a copy of AccountBalanceEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AccountEntityCopyWith<$Res> get account {
  
  return $AccountEntityCopyWith<$Res>(_self.account, (value) {
    return _then(_self.copyWith(account: value));
  });
}
}

// dart format on
