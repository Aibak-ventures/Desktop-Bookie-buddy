// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AccountModel {

 int get id;@JsonKey(name: 'name') String get accountName;@JsonKey(name: 'account_type', fromJson: AccountType.fromJson, toJson: AccountType.toJson) AccountType get accountType;@JsonKey(name: 'account_number') String? get accountNumber;@JsonKey(name: 'description') String? get description;@JsonKey(name: 'is_active') bool get isActive;@JsonKey(name: 'is_default') bool get isDefault;@JsonKey(name: 'created_at') String get createdAt;// Present only in the accounts-with-amounts (summary) response
@JsonKey(name: 'current_balance') double? get currentBalance;
/// Create a copy of AccountModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountModelCopyWith<AccountModel> get copyWith => _$AccountModelCopyWithImpl<AccountModel>(this as AccountModel, _$identity);

  /// Serializes this AccountModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountModel&&(identical(other.id, id) || other.id == id)&&(identical(other.accountName, accountName) || other.accountName == accountName)&&(identical(other.accountType, accountType) || other.accountType == accountType)&&(identical(other.accountNumber, accountNumber) || other.accountNumber == accountNumber)&&(identical(other.description, description) || other.description == description)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.currentBalance, currentBalance) || other.currentBalance == currentBalance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,accountName,accountType,accountNumber,description,isActive,isDefault,createdAt,currentBalance);

@override
String toString() {
  return 'AccountModel(id: $id, accountName: $accountName, accountType: $accountType, accountNumber: $accountNumber, description: $description, isActive: $isActive, isDefault: $isDefault, createdAt: $createdAt, currentBalance: $currentBalance)';
}


}

/// @nodoc
abstract mixin class $AccountModelCopyWith<$Res>  {
  factory $AccountModelCopyWith(AccountModel value, $Res Function(AccountModel) _then) = _$AccountModelCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'name') String accountName,@JsonKey(name: 'account_type', fromJson: AccountType.fromJson, toJson: AccountType.toJson) AccountType accountType,@JsonKey(name: 'account_number') String? accountNumber,@JsonKey(name: 'description') String? description,@JsonKey(name: 'is_active') bool isActive,@JsonKey(name: 'is_default') bool isDefault,@JsonKey(name: 'created_at') String createdAt,@JsonKey(name: 'current_balance') double? currentBalance
});




}
/// @nodoc
class _$AccountModelCopyWithImpl<$Res>
    implements $AccountModelCopyWith<$Res> {
  _$AccountModelCopyWithImpl(this._self, this._then);

  final AccountModel _self;
  final $Res Function(AccountModel) _then;

/// Create a copy of AccountModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? accountName = null,Object? accountType = null,Object? accountNumber = freezed,Object? description = freezed,Object? isActive = null,Object? isDefault = null,Object? createdAt = null,Object? currentBalance = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,accountName: null == accountName ? _self.accountName : accountName // ignore: cast_nullable_to_non_nullable
as String,accountType: null == accountType ? _self.accountType : accountType // ignore: cast_nullable_to_non_nullable
as AccountType,accountNumber: freezed == accountNumber ? _self.accountNumber : accountNumber // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isDefault: null == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,currentBalance: freezed == currentBalance ? _self.currentBalance : currentBalance // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [AccountModel].
extension AccountModelPatterns on AccountModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccountModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccountModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccountModel value)  $default,){
final _that = this;
switch (_that) {
case _AccountModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccountModel value)?  $default,){
final _that = this;
switch (_that) {
case _AccountModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'name')  String accountName, @JsonKey(name: 'account_type', fromJson: AccountType.fromJson, toJson: AccountType.toJson)  AccountType accountType, @JsonKey(name: 'account_number')  String? accountNumber, @JsonKey(name: 'description')  String? description, @JsonKey(name: 'is_active')  bool isActive, @JsonKey(name: 'is_default')  bool isDefault, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'current_balance')  double? currentBalance)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccountModel() when $default != null:
return $default(_that.id,_that.accountName,_that.accountType,_that.accountNumber,_that.description,_that.isActive,_that.isDefault,_that.createdAt,_that.currentBalance);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'name')  String accountName, @JsonKey(name: 'account_type', fromJson: AccountType.fromJson, toJson: AccountType.toJson)  AccountType accountType, @JsonKey(name: 'account_number')  String? accountNumber, @JsonKey(name: 'description')  String? description, @JsonKey(name: 'is_active')  bool isActive, @JsonKey(name: 'is_default')  bool isDefault, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'current_balance')  double? currentBalance)  $default,) {final _that = this;
switch (_that) {
case _AccountModel():
return $default(_that.id,_that.accountName,_that.accountType,_that.accountNumber,_that.description,_that.isActive,_that.isDefault,_that.createdAt,_that.currentBalance);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'name')  String accountName, @JsonKey(name: 'account_type', fromJson: AccountType.fromJson, toJson: AccountType.toJson)  AccountType accountType, @JsonKey(name: 'account_number')  String? accountNumber, @JsonKey(name: 'description')  String? description, @JsonKey(name: 'is_active')  bool isActive, @JsonKey(name: 'is_default')  bool isDefault, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'current_balance')  double? currentBalance)?  $default,) {final _that = this;
switch (_that) {
case _AccountModel() when $default != null:
return $default(_that.id,_that.accountName,_that.accountType,_that.accountNumber,_that.description,_that.isActive,_that.isDefault,_that.createdAt,_that.currentBalance);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AccountModel implements AccountModel {
  const _AccountModel({required this.id, @JsonKey(name: 'name') required this.accountName, @JsonKey(name: 'account_type', fromJson: AccountType.fromJson, toJson: AccountType.toJson) required this.accountType, @JsonKey(name: 'account_number') this.accountNumber, @JsonKey(name: 'description') this.description, @JsonKey(name: 'is_active') required this.isActive, @JsonKey(name: 'is_default') required this.isDefault, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'current_balance') this.currentBalance});
  factory _AccountModel.fromJson(Map<String, dynamic> json) => _$AccountModelFromJson(json);

@override final  int id;
@override@JsonKey(name: 'name') final  String accountName;
@override@JsonKey(name: 'account_type', fromJson: AccountType.fromJson, toJson: AccountType.toJson) final  AccountType accountType;
@override@JsonKey(name: 'account_number') final  String? accountNumber;
@override@JsonKey(name: 'description') final  String? description;
@override@JsonKey(name: 'is_active') final  bool isActive;
@override@JsonKey(name: 'is_default') final  bool isDefault;
@override@JsonKey(name: 'created_at') final  String createdAt;
// Present only in the accounts-with-amounts (summary) response
@override@JsonKey(name: 'current_balance') final  double? currentBalance;

/// Create a copy of AccountModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountModelCopyWith<_AccountModel> get copyWith => __$AccountModelCopyWithImpl<_AccountModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AccountModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccountModel&&(identical(other.id, id) || other.id == id)&&(identical(other.accountName, accountName) || other.accountName == accountName)&&(identical(other.accountType, accountType) || other.accountType == accountType)&&(identical(other.accountNumber, accountNumber) || other.accountNumber == accountNumber)&&(identical(other.description, description) || other.description == description)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.currentBalance, currentBalance) || other.currentBalance == currentBalance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,accountName,accountType,accountNumber,description,isActive,isDefault,createdAt,currentBalance);

@override
String toString() {
  return 'AccountModel(id: $id, accountName: $accountName, accountType: $accountType, accountNumber: $accountNumber, description: $description, isActive: $isActive, isDefault: $isDefault, createdAt: $createdAt, currentBalance: $currentBalance)';
}


}

/// @nodoc
abstract mixin class _$AccountModelCopyWith<$Res> implements $AccountModelCopyWith<$Res> {
  factory _$AccountModelCopyWith(_AccountModel value, $Res Function(_AccountModel) _then) = __$AccountModelCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'name') String accountName,@JsonKey(name: 'account_type', fromJson: AccountType.fromJson, toJson: AccountType.toJson) AccountType accountType,@JsonKey(name: 'account_number') String? accountNumber,@JsonKey(name: 'description') String? description,@JsonKey(name: 'is_active') bool isActive,@JsonKey(name: 'is_default') bool isDefault,@JsonKey(name: 'created_at') String createdAt,@JsonKey(name: 'current_balance') double? currentBalance
});




}
/// @nodoc
class __$AccountModelCopyWithImpl<$Res>
    implements _$AccountModelCopyWith<$Res> {
  __$AccountModelCopyWithImpl(this._self, this._then);

  final _AccountModel _self;
  final $Res Function(_AccountModel) _then;

/// Create a copy of AccountModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? accountName = null,Object? accountType = null,Object? accountNumber = freezed,Object? description = freezed,Object? isActive = null,Object? isDefault = null,Object? createdAt = null,Object? currentBalance = freezed,}) {
  return _then(_AccountModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,accountName: null == accountName ? _self.accountName : accountName // ignore: cast_nullable_to_non_nullable
as String,accountType: null == accountType ? _self.accountType : accountType // ignore: cast_nullable_to_non_nullable
as AccountType,accountNumber: freezed == accountNumber ? _self.accountNumber : accountNumber // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isDefault: null == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,currentBalance: freezed == currentBalance ? _self.currentBalance : currentBalance // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
