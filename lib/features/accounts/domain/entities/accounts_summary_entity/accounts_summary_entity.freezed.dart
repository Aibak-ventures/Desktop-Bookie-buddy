// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'accounts_summary_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AccountsSummaryEntity {

 double get totalBalance; List<AccountBalanceEntity> get accounts;
/// Create a copy of AccountsSummaryEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountsSummaryEntityCopyWith<AccountsSummaryEntity> get copyWith => _$AccountsSummaryEntityCopyWithImpl<AccountsSummaryEntity>(this as AccountsSummaryEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountsSummaryEntity&&(identical(other.totalBalance, totalBalance) || other.totalBalance == totalBalance)&&const DeepCollectionEquality().equals(other.accounts, accounts));
}


@override
int get hashCode => Object.hash(runtimeType,totalBalance,const DeepCollectionEquality().hash(accounts));

@override
String toString() {
  return 'AccountsSummaryEntity(totalBalance: $totalBalance, accounts: $accounts)';
}


}

/// @nodoc
abstract mixin class $AccountsSummaryEntityCopyWith<$Res>  {
  factory $AccountsSummaryEntityCopyWith(AccountsSummaryEntity value, $Res Function(AccountsSummaryEntity) _then) = _$AccountsSummaryEntityCopyWithImpl;
@useResult
$Res call({
 double totalBalance, List<AccountBalanceEntity> accounts
});




}
/// @nodoc
class _$AccountsSummaryEntityCopyWithImpl<$Res>
    implements $AccountsSummaryEntityCopyWith<$Res> {
  _$AccountsSummaryEntityCopyWithImpl(this._self, this._then);

  final AccountsSummaryEntity _self;
  final $Res Function(AccountsSummaryEntity) _then;

/// Create a copy of AccountsSummaryEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalBalance = null,Object? accounts = null,}) {
  return _then(_self.copyWith(
totalBalance: null == totalBalance ? _self.totalBalance : totalBalance // ignore: cast_nullable_to_non_nullable
as double,accounts: null == accounts ? _self.accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<AccountBalanceEntity>,
  ));
}

}


/// Adds pattern-matching-related methods to [AccountsSummaryEntity].
extension AccountsSummaryEntityPatterns on AccountsSummaryEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccountsSummaryEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccountsSummaryEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccountsSummaryEntity value)  $default,){
final _that = this;
switch (_that) {
case _AccountsSummaryEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccountsSummaryEntity value)?  $default,){
final _that = this;
switch (_that) {
case _AccountsSummaryEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double totalBalance,  List<AccountBalanceEntity> accounts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccountsSummaryEntity() when $default != null:
return $default(_that.totalBalance,_that.accounts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double totalBalance,  List<AccountBalanceEntity> accounts)  $default,) {final _that = this;
switch (_that) {
case _AccountsSummaryEntity():
return $default(_that.totalBalance,_that.accounts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double totalBalance,  List<AccountBalanceEntity> accounts)?  $default,) {final _that = this;
switch (_that) {
case _AccountsSummaryEntity() when $default != null:
return $default(_that.totalBalance,_that.accounts);case _:
  return null;

}
}

}

/// @nodoc


class _AccountsSummaryEntity implements AccountsSummaryEntity {
  const _AccountsSummaryEntity({required this.totalBalance, required final  List<AccountBalanceEntity> accounts}): _accounts = accounts;
  

@override final  double totalBalance;
 final  List<AccountBalanceEntity> _accounts;
@override List<AccountBalanceEntity> get accounts {
  if (_accounts is EqualUnmodifiableListView) return _accounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_accounts);
}


/// Create a copy of AccountsSummaryEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountsSummaryEntityCopyWith<_AccountsSummaryEntity> get copyWith => __$AccountsSummaryEntityCopyWithImpl<_AccountsSummaryEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccountsSummaryEntity&&(identical(other.totalBalance, totalBalance) || other.totalBalance == totalBalance)&&const DeepCollectionEquality().equals(other._accounts, _accounts));
}


@override
int get hashCode => Object.hash(runtimeType,totalBalance,const DeepCollectionEquality().hash(_accounts));

@override
String toString() {
  return 'AccountsSummaryEntity(totalBalance: $totalBalance, accounts: $accounts)';
}


}

/// @nodoc
abstract mixin class _$AccountsSummaryEntityCopyWith<$Res> implements $AccountsSummaryEntityCopyWith<$Res> {
  factory _$AccountsSummaryEntityCopyWith(_AccountsSummaryEntity value, $Res Function(_AccountsSummaryEntity) _then) = __$AccountsSummaryEntityCopyWithImpl;
@override @useResult
$Res call({
 double totalBalance, List<AccountBalanceEntity> accounts
});




}
/// @nodoc
class __$AccountsSummaryEntityCopyWithImpl<$Res>
    implements _$AccountsSummaryEntityCopyWith<$Res> {
  __$AccountsSummaryEntityCopyWithImpl(this._self, this._then);

  final _AccountsSummaryEntity _self;
  final $Res Function(_AccountsSummaryEntity) _then;

/// Create a copy of AccountsSummaryEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalBalance = null,Object? accounts = null,}) {
  return _then(_AccountsSummaryEntity(
totalBalance: null == totalBalance ? _self.totalBalance : totalBalance // ignore: cast_nullable_to_non_nullable
as double,accounts: null == accounts ? _self._accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<AccountBalanceEntity>,
  ));
}


}

// dart format on
