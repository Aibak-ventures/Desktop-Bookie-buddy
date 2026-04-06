// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'measurement_value_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MeasurementValueModel {

 String get name; String get key; String get value; GenderType? get gender;
/// Create a copy of MeasurementValueModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MeasurementValueModelCopyWith<MeasurementValueModel> get copyWith => _$MeasurementValueModelCopyWithImpl<MeasurementValueModel>(this as MeasurementValueModel, _$identity);

  /// Serializes this MeasurementValueModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MeasurementValueModel&&(identical(other.name, name) || other.name == name)&&(identical(other.key, key) || other.key == key)&&(identical(other.value, value) || other.value == value)&&(identical(other.gender, gender) || other.gender == gender));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,key,value,gender);

@override
String toString() {
  return 'MeasurementValueModel(name: $name, key: $key, value: $value, gender: $gender)';
}


}

/// @nodoc
abstract mixin class $MeasurementValueModelCopyWith<$Res>  {
  factory $MeasurementValueModelCopyWith(MeasurementValueModel value, $Res Function(MeasurementValueModel) _then) = _$MeasurementValueModelCopyWithImpl;
@useResult
$Res call({
 String name, String key, String value, GenderType? gender
});




}
/// @nodoc
class _$MeasurementValueModelCopyWithImpl<$Res>
    implements $MeasurementValueModelCopyWith<$Res> {
  _$MeasurementValueModelCopyWithImpl(this._self, this._then);

  final MeasurementValueModel _self;
  final $Res Function(MeasurementValueModel) _then;

/// Create a copy of MeasurementValueModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? key = null,Object? value = null,Object? gender = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as GenderType?,
  ));
}

}


/// Adds pattern-matching-related methods to [MeasurementValueModel].
extension MeasurementValueModelPatterns on MeasurementValueModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MeasurementValueModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MeasurementValueModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MeasurementValueModel value)  $default,){
final _that = this;
switch (_that) {
case _MeasurementValueModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MeasurementValueModel value)?  $default,){
final _that = this;
switch (_that) {
case _MeasurementValueModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String key,  String value,  GenderType? gender)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MeasurementValueModel() when $default != null:
return $default(_that.name,_that.key,_that.value,_that.gender);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String key,  String value,  GenderType? gender)  $default,) {final _that = this;
switch (_that) {
case _MeasurementValueModel():
return $default(_that.name,_that.key,_that.value,_that.gender);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String key,  String value,  GenderType? gender)?  $default,) {final _that = this;
switch (_that) {
case _MeasurementValueModel() when $default != null:
return $default(_that.name,_that.key,_that.value,_that.gender);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MeasurementValueModel implements MeasurementValueModel {
  const _MeasurementValueModel({required this.name, required this.key, required this.value, this.gender});
  factory _MeasurementValueModel.fromJson(Map<String, dynamic> json) => _$MeasurementValueModelFromJson(json);

@override final  String name;
@override final  String key;
@override final  String value;
@override final  GenderType? gender;

/// Create a copy of MeasurementValueModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MeasurementValueModelCopyWith<_MeasurementValueModel> get copyWith => __$MeasurementValueModelCopyWithImpl<_MeasurementValueModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MeasurementValueModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MeasurementValueModel&&(identical(other.name, name) || other.name == name)&&(identical(other.key, key) || other.key == key)&&(identical(other.value, value) || other.value == value)&&(identical(other.gender, gender) || other.gender == gender));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,key,value,gender);

@override
String toString() {
  return 'MeasurementValueModel(name: $name, key: $key, value: $value, gender: $gender)';
}


}

/// @nodoc
abstract mixin class _$MeasurementValueModelCopyWith<$Res> implements $MeasurementValueModelCopyWith<$Res> {
  factory _$MeasurementValueModelCopyWith(_MeasurementValueModel value, $Res Function(_MeasurementValueModel) _then) = __$MeasurementValueModelCopyWithImpl;
@override @useResult
$Res call({
 String name, String key, String value, GenderType? gender
});




}
/// @nodoc
class __$MeasurementValueModelCopyWithImpl<$Res>
    implements _$MeasurementValueModelCopyWith<$Res> {
  __$MeasurementValueModelCopyWithImpl(this._self, this._then);

  final _MeasurementValueModel _self;
  final $Res Function(_MeasurementValueModel) _then;

/// Create a copy of MeasurementValueModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? key = null,Object? value = null,Object? gender = freezed,}) {
  return _then(_MeasurementValueModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as GenderType?,
  ));
}


}

// dart format on
