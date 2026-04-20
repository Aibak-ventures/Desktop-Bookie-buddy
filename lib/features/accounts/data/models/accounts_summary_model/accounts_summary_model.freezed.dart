// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'accounts_summary_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AccountsSummaryModel {

@JsonKey(name: 'total_balance') double get totalBalance;@JsonKey(name: 'accounts') List<AccountModel> get accounts;
/// Create a copy of AccountsSummaryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountsSummaryModelCopyWith<AccountsSummaryModel> get copyWith => _$AccountsSummaryModelCopyWithImpl<AccountsSummaryModel>(this as AccountsSummaryModel, _$identity);

  /// Serializes this AccountsSummaryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountsSummaryModel&&(identical(other.totalBalance, totalBalance) || other.totalBalance == totalBalance)&&const DeepCollectionEquality().equals(other.accounts, accounts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalBalance,const DeepCollectionEquality().hash(accounts));

@override
String toString() {
  return 'AccountsSummaryModel(totalBalance: $totalBalance, accounts: $accounts)';
}


}

/// @nodoc
abstract mixin class $AccountsSummaryModelCopyWith<$Res>  {
  factory $AccountsSummaryModelCopyWith(AccountsSummaryModel value, $Res Function(AccountsSummaryModel) _then) = _$AccountsSummaryModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'total_balance') double totalBalance,@JsonKey(name: 'accounts') List<AccountModel> accounts
});




}
/// @nodoc
class _$AccountsSummaryModelCopyWithImpl<$Res>
    implements $AccountsSummaryModelCopyWith<$Res> {
  _$AccountsSummaryModelCopyWithImpl(this._self, this._then);

  final AccountsSummaryModel _self;
  final $Res Function(AccountsSummaryModel) _then;

/// Create a copy of AccountsSummaryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalBalance = null,Object? accounts = null,}) {
  return _then(_self.copyWith(
totalBalance: null == totalBalance ? _self.totalBalance : totalBalance // ignore: cast_nullable_to_non_nullable
as double,accounts: null == accounts ? _self.accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<AccountModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [AccountsSummaryModel].
extension AccountsSummaryModelPatterns on AccountsSummaryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccountsSummaryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccountsSummaryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccountsSummaryModel value)  $default,){
final _that = this;
switch (_that) {
case _AccountsSummaryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccountsSummaryModel value)?  $default,){
final _that = this;
switch (_that) {
case _AccountsSummaryModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'total_balance')  double totalBalance, @JsonKey(name: 'accounts')  List<AccountModel> accounts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccountsSummaryModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'total_balance')  double totalBalance, @JsonKey(name: 'accounts')  List<AccountModel> accounts)  $default,) {final _that = this;
switch (_that) {
case _AccountsSummaryModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'total_balance')  double totalBalance, @JsonKey(name: 'accounts')  List<AccountModel> accounts)?  $default,) {final _that = this;
switch (_that) {
case _AccountsSummaryModel() when $default != null:
return $default(_that.totalBalance,_that.accounts);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AccountsSummaryModel implements AccountsSummaryModel {
  const _AccountsSummaryModel({@JsonKey(name: 'total_balance') required this.totalBalance, @JsonKey(name: 'accounts') required final  List<AccountModel> accounts}): _accounts = accounts;
  factory _AccountsSummaryModel.fromJson(Map<String, dynamic> json) => _$AccountsSummaryModelFromJson(json);

@override@JsonKey(name: 'total_balance') final  double totalBalance;
 final  List<AccountModel> _accounts;
@override@JsonKey(name: 'accounts') List<AccountModel> get accounts {
  if (_accounts is EqualUnmodifiableListView) return _accounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_accounts);
}


/// Create a copy of AccountsSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountsSummaryModelCopyWith<_AccountsSummaryModel> get copyWith => __$AccountsSummaryModelCopyWithImpl<_AccountsSummaryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AccountsSummaryModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccountsSummaryModel&&(identical(other.totalBalance, totalBalance) || other.totalBalance == totalBalance)&&const DeepCollectionEquality().equals(other._accounts, _accounts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalBalance,const DeepCollectionEquality().hash(_accounts));

@override
String toString() {
  return 'AccountsSummaryModel(totalBalance: $totalBalance, accounts: $accounts)';
}


}

/// @nodoc
abstract mixin class _$AccountsSummaryModelCopyWith<$Res> implements $AccountsSummaryModelCopyWith<$Res> {
  factory _$AccountsSummaryModelCopyWith(_AccountsSummaryModel value, $Res Function(_AccountsSummaryModel) _then) = __$AccountsSummaryModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'total_balance') double totalBalance,@JsonKey(name: 'accounts') List<AccountModel> accounts
});




}
/// @nodoc
class __$AccountsSummaryModelCopyWithImpl<$Res>
    implements _$AccountsSummaryModelCopyWith<$Res> {
  __$AccountsSummaryModelCopyWithImpl(this._self, this._then);

  final _AccountsSummaryModel _self;
  final $Res Function(_AccountsSummaryModel) _then;

/// Create a copy of AccountsSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalBalance = null,Object? accounts = null,}) {
  return _then(_AccountsSummaryModel(
totalBalance: null == totalBalance ? _self.totalBalance : totalBalance // ignore: cast_nullable_to_non_nullable
as double,accounts: null == accounts ? _self._accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<AccountModel>,
  ));
}


}

// dart format on
