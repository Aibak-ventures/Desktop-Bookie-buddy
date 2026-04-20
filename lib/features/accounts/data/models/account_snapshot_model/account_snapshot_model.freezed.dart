// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_snapshot_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AccountSnapshotModel {

@JsonKey(name: 'name', defaultValue: '') String get name;@JsonKey(name: 'amount', fromJson: StringX.toDoubleFromString) double get amount;
/// Create a copy of AccountSnapshotModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountSnapshotModelCopyWith<AccountSnapshotModel> get copyWith => _$AccountSnapshotModelCopyWithImpl<AccountSnapshotModel>(this as AccountSnapshotModel, _$identity);

  /// Serializes this AccountSnapshotModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountSnapshotModel&&(identical(other.name, name) || other.name == name)&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,amount);

@override
String toString() {
  return 'AccountSnapshotModel(name: $name, amount: $amount)';
}


}

/// @nodoc
abstract mixin class $AccountSnapshotModelCopyWith<$Res>  {
  factory $AccountSnapshotModelCopyWith(AccountSnapshotModel value, $Res Function(AccountSnapshotModel) _then) = _$AccountSnapshotModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'name', defaultValue: '') String name,@JsonKey(name: 'amount', fromJson: StringX.toDoubleFromString) double amount
});




}
/// @nodoc
class _$AccountSnapshotModelCopyWithImpl<$Res>
    implements $AccountSnapshotModelCopyWith<$Res> {
  _$AccountSnapshotModelCopyWithImpl(this._self, this._then);

  final AccountSnapshotModel _self;
  final $Res Function(AccountSnapshotModel) _then;

/// Create a copy of AccountSnapshotModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? amount = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [AccountSnapshotModel].
extension AccountSnapshotModelPatterns on AccountSnapshotModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccountSnapshotModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccountSnapshotModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccountSnapshotModel value)  $default,){
final _that = this;
switch (_that) {
case _AccountSnapshotModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccountSnapshotModel value)?  $default,){
final _that = this;
switch (_that) {
case _AccountSnapshotModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'name', defaultValue: '')  String name, @JsonKey(name: 'amount', fromJson: StringX.toDoubleFromString)  double amount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccountSnapshotModel() when $default != null:
return $default(_that.name,_that.amount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'name', defaultValue: '')  String name, @JsonKey(name: 'amount', fromJson: StringX.toDoubleFromString)  double amount)  $default,) {final _that = this;
switch (_that) {
case _AccountSnapshotModel():
return $default(_that.name,_that.amount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'name', defaultValue: '')  String name, @JsonKey(name: 'amount', fromJson: StringX.toDoubleFromString)  double amount)?  $default,) {final _that = this;
switch (_that) {
case _AccountSnapshotModel() when $default != null:
return $default(_that.name,_that.amount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AccountSnapshotModel implements AccountSnapshotModel {
  const _AccountSnapshotModel({@JsonKey(name: 'name', defaultValue: '') required this.name, @JsonKey(name: 'amount', fromJson: StringX.toDoubleFromString) required this.amount});
  factory _AccountSnapshotModel.fromJson(Map<String, dynamic> json) => _$AccountSnapshotModelFromJson(json);

@override@JsonKey(name: 'name', defaultValue: '') final  String name;
@override@JsonKey(name: 'amount', fromJson: StringX.toDoubleFromString) final  double amount;

/// Create a copy of AccountSnapshotModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountSnapshotModelCopyWith<_AccountSnapshotModel> get copyWith => __$AccountSnapshotModelCopyWithImpl<_AccountSnapshotModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AccountSnapshotModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccountSnapshotModel&&(identical(other.name, name) || other.name == name)&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,amount);

@override
String toString() {
  return 'AccountSnapshotModel(name: $name, amount: $amount)';
}


}

/// @nodoc
abstract mixin class _$AccountSnapshotModelCopyWith<$Res> implements $AccountSnapshotModelCopyWith<$Res> {
  factory _$AccountSnapshotModelCopyWith(_AccountSnapshotModel value, $Res Function(_AccountSnapshotModel) _then) = __$AccountSnapshotModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'name', defaultValue: '') String name,@JsonKey(name: 'amount', fromJson: StringX.toDoubleFromString) double amount
});




}
/// @nodoc
class __$AccountSnapshotModelCopyWithImpl<$Res>
    implements _$AccountSnapshotModelCopyWith<$Res> {
  __$AccountSnapshotModelCopyWithImpl(this._self, this._then);

  final _AccountSnapshotModel _self;
  final $Res Function(_AccountSnapshotModel) _then;

/// Create a copy of AccountSnapshotModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? amount = null,}) {
  return _then(_AccountSnapshotModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
