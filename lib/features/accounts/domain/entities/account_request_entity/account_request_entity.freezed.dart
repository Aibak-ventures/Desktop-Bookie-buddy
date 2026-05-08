// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_request_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AccountRequestEntity {

 String? get accountName; String? get accountNumber; AccountType get accountType; String? get description; bool? get isActive; bool? get isDefault;
/// Create a copy of AccountRequestEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountRequestEntityCopyWith<AccountRequestEntity> get copyWith => _$AccountRequestEntityCopyWithImpl<AccountRequestEntity>(this as AccountRequestEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountRequestEntity&&(identical(other.accountName, accountName) || other.accountName == accountName)&&(identical(other.accountNumber, accountNumber) || other.accountNumber == accountNumber)&&(identical(other.accountType, accountType) || other.accountType == accountType)&&(identical(other.description, description) || other.description == description)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault));
}


@override
int get hashCode => Object.hash(runtimeType,accountName,accountNumber,accountType,description,isActive,isDefault);

@override
String toString() {
  return 'AccountRequestEntity(accountName: $accountName, accountNumber: $accountNumber, accountType: $accountType, description: $description, isActive: $isActive, isDefault: $isDefault)';
}


}

/// @nodoc
abstract mixin class $AccountRequestEntityCopyWith<$Res>  {
  factory $AccountRequestEntityCopyWith(AccountRequestEntity value, $Res Function(AccountRequestEntity) _then) = _$AccountRequestEntityCopyWithImpl;
@useResult
$Res call({
 String? accountName, String? accountNumber, AccountType accountType, String? description, bool? isActive, bool? isDefault
});




}
/// @nodoc
class _$AccountRequestEntityCopyWithImpl<$Res>
    implements $AccountRequestEntityCopyWith<$Res> {
  _$AccountRequestEntityCopyWithImpl(this._self, this._then);

  final AccountRequestEntity _self;
  final $Res Function(AccountRequestEntity) _then;

/// Create a copy of AccountRequestEntity
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


/// Adds pattern-matching-related methods to [AccountRequestEntity].
extension AccountRequestEntityPatterns on AccountRequestEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccountRequestEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccountRequestEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccountRequestEntity value)  $default,){
final _that = this;
switch (_that) {
case _AccountRequestEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccountRequestEntity value)?  $default,){
final _that = this;
switch (_that) {
case _AccountRequestEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? accountName,  String? accountNumber,  AccountType accountType,  String? description,  bool? isActive,  bool? isDefault)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccountRequestEntity() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? accountName,  String? accountNumber,  AccountType accountType,  String? description,  bool? isActive,  bool? isDefault)  $default,) {final _that = this;
switch (_that) {
case _AccountRequestEntity():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? accountName,  String? accountNumber,  AccountType accountType,  String? description,  bool? isActive,  bool? isDefault)?  $default,) {final _that = this;
switch (_that) {
case _AccountRequestEntity() when $default != null:
return $default(_that.accountName,_that.accountNumber,_that.accountType,_that.description,_that.isActive,_that.isDefault);case _:
  return null;

}
}

}

/// @nodoc


class _AccountRequestEntity implements AccountRequestEntity {
  const _AccountRequestEntity({this.accountName, this.accountNumber, this.accountType = AccountType.bank, this.description, this.isActive, this.isDefault});
  

@override final  String? accountName;
@override final  String? accountNumber;
@override@JsonKey() final  AccountType accountType;
@override final  String? description;
@override final  bool? isActive;
@override final  bool? isDefault;

/// Create a copy of AccountRequestEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountRequestEntityCopyWith<_AccountRequestEntity> get copyWith => __$AccountRequestEntityCopyWithImpl<_AccountRequestEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccountRequestEntity&&(identical(other.accountName, accountName) || other.accountName == accountName)&&(identical(other.accountNumber, accountNumber) || other.accountNumber == accountNumber)&&(identical(other.accountType, accountType) || other.accountType == accountType)&&(identical(other.description, description) || other.description == description)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault));
}


@override
int get hashCode => Object.hash(runtimeType,accountName,accountNumber,accountType,description,isActive,isDefault);

@override
String toString() {
  return 'AccountRequestEntity(accountName: $accountName, accountNumber: $accountNumber, accountType: $accountType, description: $description, isActive: $isActive, isDefault: $isDefault)';
}


}

/// @nodoc
abstract mixin class _$AccountRequestEntityCopyWith<$Res> implements $AccountRequestEntityCopyWith<$Res> {
  factory _$AccountRequestEntityCopyWith(_AccountRequestEntity value, $Res Function(_AccountRequestEntity) _then) = __$AccountRequestEntityCopyWithImpl;
@override @useResult
$Res call({
 String? accountName, String? accountNumber, AccountType accountType, String? description, bool? isActive, bool? isDefault
});




}
/// @nodoc
class __$AccountRequestEntityCopyWithImpl<$Res>
    implements _$AccountRequestEntityCopyWith<$Res> {
  __$AccountRequestEntityCopyWithImpl(this._self, this._then);

  final _AccountRequestEntity _self;
  final $Res Function(_AccountRequestEntity) _then;

/// Create a copy of AccountRequestEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accountName = freezed,Object? accountNumber = freezed,Object? accountType = null,Object? description = freezed,Object? isActive = freezed,Object? isDefault = freezed,}) {
  return _then(_AccountRequestEntity(
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
