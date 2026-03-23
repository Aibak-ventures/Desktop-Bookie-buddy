// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'additional_charges_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AdditionalChargesModel {

@JsonKey(includeIfNull: false) int? get id; String? get name;@JsonKey(fromJson: _amountFromJson) int? get amount;
/// Create a copy of AdditionalChargesModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdditionalChargesModelCopyWith<AdditionalChargesModel> get copyWith => _$AdditionalChargesModelCopyWithImpl<AdditionalChargesModel>(this as AdditionalChargesModel, _$identity);

  /// Serializes this AdditionalChargesModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdditionalChargesModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,amount);

@override
String toString() {
  return 'AdditionalChargesModel(id: $id, name: $name, amount: $amount)';
}


}

/// @nodoc
abstract mixin class $AdditionalChargesModelCopyWith<$Res>  {
  factory $AdditionalChargesModelCopyWith(AdditionalChargesModel value, $Res Function(AdditionalChargesModel) _then) = _$AdditionalChargesModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeIfNull: false) int? id, String? name,@JsonKey(fromJson: _amountFromJson) int? amount
});




}
/// @nodoc
class _$AdditionalChargesModelCopyWithImpl<$Res>
    implements $AdditionalChargesModelCopyWith<$Res> {
  _$AdditionalChargesModelCopyWithImpl(this._self, this._then);

  final AdditionalChargesModel _self;
  final $Res Function(AdditionalChargesModel) _then;

/// Create a copy of AdditionalChargesModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = freezed,Object? amount = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [AdditionalChargesModel].
extension AdditionalChargesModelPatterns on AdditionalChargesModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdditionalChargesModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdditionalChargesModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdditionalChargesModel value)  $default,){
final _that = this;
switch (_that) {
case _AdditionalChargesModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdditionalChargesModel value)?  $default,){
final _that = this;
switch (_that) {
case _AdditionalChargesModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false)  int? id,  String? name, @JsonKey(fromJson: _amountFromJson)  int? amount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdditionalChargesModel() when $default != null:
return $default(_that.id,_that.name,_that.amount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false)  int? id,  String? name, @JsonKey(fromJson: _amountFromJson)  int? amount)  $default,) {final _that = this;
switch (_that) {
case _AdditionalChargesModel():
return $default(_that.id,_that.name,_that.amount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeIfNull: false)  int? id,  String? name, @JsonKey(fromJson: _amountFromJson)  int? amount)?  $default,) {final _that = this;
switch (_that) {
case _AdditionalChargesModel() when $default != null:
return $default(_that.id,_that.name,_that.amount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AdditionalChargesModel implements AdditionalChargesModel {
  const _AdditionalChargesModel({@JsonKey(includeIfNull: false) this.id, this.name, @JsonKey(fromJson: _amountFromJson) this.amount});
  factory _AdditionalChargesModel.fromJson(Map<String, dynamic> json) => _$AdditionalChargesModelFromJson(json);

@override@JsonKey(includeIfNull: false) final  int? id;
@override final  String? name;
@override@JsonKey(fromJson: _amountFromJson) final  int? amount;

/// Create a copy of AdditionalChargesModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdditionalChargesModelCopyWith<_AdditionalChargesModel> get copyWith => __$AdditionalChargesModelCopyWithImpl<_AdditionalChargesModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AdditionalChargesModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdditionalChargesModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,amount);

@override
String toString() {
  return 'AdditionalChargesModel(id: $id, name: $name, amount: $amount)';
}


}

/// @nodoc
abstract mixin class _$AdditionalChargesModelCopyWith<$Res> implements $AdditionalChargesModelCopyWith<$Res> {
  factory _$AdditionalChargesModelCopyWith(_AdditionalChargesModel value, $Res Function(_AdditionalChargesModel) _then) = __$AdditionalChargesModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeIfNull: false) int? id, String? name,@JsonKey(fromJson: _amountFromJson) int? amount
});




}
/// @nodoc
class __$AdditionalChargesModelCopyWithImpl<$Res>
    implements _$AdditionalChargesModelCopyWith<$Res> {
  __$AdditionalChargesModelCopyWithImpl(this._self, this._then);

  final _AdditionalChargesModel _self;
  final $Res Function(_AdditionalChargesModel) _then;

/// Create a copy of AdditionalChargesModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = freezed,Object? amount = freezed,}) {
  return _then(_AdditionalChargesModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
