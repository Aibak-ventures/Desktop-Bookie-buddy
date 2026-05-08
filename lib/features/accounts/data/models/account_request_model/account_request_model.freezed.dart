// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AccountRequestModel {

@JsonKey(name: 'name', includeIfNull: false) String? get accountName;@JsonKey(name: 'account_number', includeIfNull: false) String? get accountNumber;// optional
@JsonKey(name: 'account_type', fromJson: AccountType.fromJson, toJson: AccountType.toJson) AccountType get accountType;// default to cash if not provided
@JsonKey(name: 'description', includeIfNull: false) String? get description;// optional
@JsonKey(name: 'is_active', includeIfNull: false) bool? get isActive;// only use in patch if needed
@JsonKey(name: 'is_default', includeIfNull: false) bool? get isDefault;
/// Create a copy of AccountRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountRequestModelCopyWith<AccountRequestModel> get copyWith => _$AccountRequestModelCopyWithImpl<AccountRequestModel>(this as AccountRequestModel, _$identity);

  /// Serializes this AccountRequestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountRequestModel&&(identical(other.accountName, accountName) || other.accountName == accountName)&&(identical(other.accountNumber, accountNumber) || other.accountNumber == accountNumber)&&(identical(other.accountType, accountType) || other.accountType == accountType)&&(identical(other.description, description) || other.description == description)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accountName,accountNumber,accountType,description,isActive,isDefault);

@override
String toString() {
  return 'AccountRequestModel(accountName: $accountName, accountNumber: $accountNumber, accountType: $accountType, description: $description, isActive: $isActive, isDefault: $isDefault)';
}


}

/// @nodoc
abstract mixin class $AccountRequestModelCopyWith<$Res>  {
  factory $AccountRequestModelCopyWith(AccountRequestModel value, $Res Function(AccountRequestModel) _then) = _$AccountRequestModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'name', includeIfNull: false) String? accountName,@JsonKey(name: 'account_number', includeIfNull: false) String? accountNumber,@JsonKey(name: 'account_type', fromJson: AccountType.fromJson, toJson: AccountType.toJson) AccountType accountType,@JsonKey(name: 'description', includeIfNull: false) String? description,@JsonKey(name: 'is_active', includeIfNull: false) bool? isActive,@JsonKey(name: 'is_default', includeIfNull: false) bool? isDefault
});




}
/// @nodoc
class _$AccountRequestModelCopyWithImpl<$Res>
    implements $AccountRequestModelCopyWith<$Res> {
  _$AccountRequestModelCopyWithImpl(this._self, this._then);

  final AccountRequestModel _self;
  final $Res Function(AccountRequestModel) _then;

/// Create a copy of AccountRequestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accountName = freezed,Object? accountNumber = freezed,Object? accountType = null,Object? description = freezed,Object? isActive = freezed,Object? isDefault = freezed,}) {
  return _then(_self.copyWith(
accountName: freezed == accountName ? _self.accountName : accountName // ignore: cast_nullable_to_non_nullable
as String?,accountNumber: freezed == accountNumber ? _self.accountNumber : accountNumber // ignore: cast_nullable_to_non_nullable
as String?,accountType: null == accountType ? _self.accountType : accountType // ignore: cast_nullable_to_non_nullable
as AccountType,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,isDefault: freezed == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [AccountRequestModel].
extension AccountRequestModelPatterns on AccountRequestModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccountRequestModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccountRequestModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccountRequestModel value)  $default,){
final _that = this;
switch (_that) {
case _AccountRequestModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccountRequestModel value)?  $default,){
final _that = this;
switch (_that) {
case _AccountRequestModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'name', includeIfNull: false)  String? accountName, @JsonKey(name: 'account_number', includeIfNull: false)  String? accountNumber, @JsonKey(name: 'account_type', fromJson: AccountType.fromJson, toJson: AccountType.toJson)  AccountType accountType, @JsonKey(name: 'description', includeIfNull: false)  String? description, @JsonKey(name: 'is_active', includeIfNull: false)  bool? isActive, @JsonKey(name: 'is_default', includeIfNull: false)  bool? isDefault)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccountRequestModel() when $default != null:
return $default(_that.accountName,_that.accountNumber,_that.accountType,_that.description,_that.isActive,_that.isDefault);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'name', includeIfNull: false)  String? accountName, @JsonKey(name: 'account_number', includeIfNull: false)  String? accountNumber, @JsonKey(name: 'account_type', fromJson: AccountType.fromJson, toJson: AccountType.toJson)  AccountType accountType, @JsonKey(name: 'description', includeIfNull: false)  String? description, @JsonKey(name: 'is_active', includeIfNull: false)  bool? isActive, @JsonKey(name: 'is_default', includeIfNull: false)  bool? isDefault)  $default,) {final _that = this;
switch (_that) {
case _AccountRequestModel():
return $default(_that.accountName,_that.accountNumber,_that.accountType,_that.description,_that.isActive,_that.isDefault);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'name', includeIfNull: false)  String? accountName, @JsonKey(name: 'account_number', includeIfNull: false)  String? accountNumber, @JsonKey(name: 'account_type', fromJson: AccountType.fromJson, toJson: AccountType.toJson)  AccountType accountType, @JsonKey(name: 'description', includeIfNull: false)  String? description, @JsonKey(name: 'is_active', includeIfNull: false)  bool? isActive, @JsonKey(name: 'is_default', includeIfNull: false)  bool? isDefault)?  $default,) {final _that = this;
switch (_that) {
case _AccountRequestModel() when $default != null:
return $default(_that.accountName,_that.accountNumber,_that.accountType,_that.description,_that.isActive,_that.isDefault);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AccountRequestModel implements AccountRequestModel {
  const _AccountRequestModel({@JsonKey(name: 'name', includeIfNull: false) this.accountName, @JsonKey(name: 'account_number', includeIfNull: false) this.accountNumber, @JsonKey(name: 'account_type', fromJson: AccountType.fromJson, toJson: AccountType.toJson) this.accountType = AccountType.bank, @JsonKey(name: 'description', includeIfNull: false) this.description, @JsonKey(name: 'is_active', includeIfNull: false) this.isActive, @JsonKey(name: 'is_default', includeIfNull: false) this.isDefault});
  factory _AccountRequestModel.fromJson(Map<String, dynamic> json) => _$AccountRequestModelFromJson(json);

@override@JsonKey(name: 'name', includeIfNull: false) final  String? accountName;
@override@JsonKey(name: 'account_number', includeIfNull: false) final  String? accountNumber;
// optional
@override@JsonKey(name: 'account_type', fromJson: AccountType.fromJson, toJson: AccountType.toJson) final  AccountType accountType;
// default to cash if not provided
@override@JsonKey(name: 'description', includeIfNull: false) final  String? description;
// optional
@override@JsonKey(name: 'is_active', includeIfNull: false) final  bool? isActive;
// only use in patch if needed
@override@JsonKey(name: 'is_default', includeIfNull: false) final  bool? isDefault;

/// Create a copy of AccountRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountRequestModelCopyWith<_AccountRequestModel> get copyWith => __$AccountRequestModelCopyWithImpl<_AccountRequestModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AccountRequestModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccountRequestModel&&(identical(other.accountName, accountName) || other.accountName == accountName)&&(identical(other.accountNumber, accountNumber) || other.accountNumber == accountNumber)&&(identical(other.accountType, accountType) || other.accountType == accountType)&&(identical(other.description, description) || other.description == description)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accountName,accountNumber,accountType,description,isActive,isDefault);

@override
String toString() {
  return 'AccountRequestModel(accountName: $accountName, accountNumber: $accountNumber, accountType: $accountType, description: $description, isActive: $isActive, isDefault: $isDefault)';
}


}

/// @nodoc
abstract mixin class _$AccountRequestModelCopyWith<$Res> implements $AccountRequestModelCopyWith<$Res> {
  factory _$AccountRequestModelCopyWith(_AccountRequestModel value, $Res Function(_AccountRequestModel) _then) = __$AccountRequestModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'name', includeIfNull: false) String? accountName,@JsonKey(name: 'account_number', includeIfNull: false) String? accountNumber,@JsonKey(name: 'account_type', fromJson: AccountType.fromJson, toJson: AccountType.toJson) AccountType accountType,@JsonKey(name: 'description', includeIfNull: false) String? description,@JsonKey(name: 'is_active', includeIfNull: false) bool? isActive,@JsonKey(name: 'is_default', includeIfNull: false) bool? isDefault
});




}
/// @nodoc
class __$AccountRequestModelCopyWithImpl<$Res>
    implements _$AccountRequestModelCopyWith<$Res> {
  __$AccountRequestModelCopyWithImpl(this._self, this._then);

  final _AccountRequestModel _self;
  final $Res Function(_AccountRequestModel) _then;

/// Create a copy of AccountRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accountName = freezed,Object? accountNumber = freezed,Object? accountType = null,Object? description = freezed,Object? isActive = freezed,Object? isDefault = freezed,}) {
  return _then(_AccountRequestModel(
accountName: freezed == accountName ? _self.accountName : accountName // ignore: cast_nullable_to_non_nullable
as String?,accountNumber: freezed == accountNumber ? _self.accountNumber : accountNumber // ignore: cast_nullable_to_non_nullable
as String?,accountType: null == accountType ? _self.accountType : accountType // ignore: cast_nullable_to_non_nullable
as AccountType,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,isDefault: freezed == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
