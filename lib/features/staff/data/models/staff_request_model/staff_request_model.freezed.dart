// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'staff_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StaffRequestModel {

@JsonKey(includeToJson: false) int? get id;@JsonKey(name: 'name', includeIfNull: false) String? get name;@JsonKey(name: 'phone', includeIfNull: false) String? get phoneNumber;
/// Create a copy of StaffRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StaffRequestModelCopyWith<StaffRequestModel> get copyWith => _$StaffRequestModelCopyWithImpl<StaffRequestModel>(this as StaffRequestModel, _$identity);

  /// Serializes this StaffRequestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StaffRequestModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,phoneNumber);

@override
String toString() {
  return 'StaffRequestModel(id: $id, name: $name, phoneNumber: $phoneNumber)';
}


}

/// @nodoc
abstract mixin class $StaffRequestModelCopyWith<$Res>  {
  factory $StaffRequestModelCopyWith(StaffRequestModel value, $Res Function(StaffRequestModel) _then) = _$StaffRequestModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeToJson: false) int? id,@JsonKey(name: 'name', includeIfNull: false) String? name,@JsonKey(name: 'phone', includeIfNull: false) String? phoneNumber
});




}
/// @nodoc
class _$StaffRequestModelCopyWithImpl<$Res>
    implements $StaffRequestModelCopyWith<$Res> {
  _$StaffRequestModelCopyWithImpl(this._self, this._then);

  final StaffRequestModel _self;
  final $Res Function(StaffRequestModel) _then;

/// Create a copy of StaffRequestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = freezed,Object? phoneNumber = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [StaffRequestModel].
extension StaffRequestModelPatterns on StaffRequestModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StaffRequestModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StaffRequestModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StaffRequestModel value)  $default,){
final _that = this;
switch (_that) {
case _StaffRequestModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StaffRequestModel value)?  $default,){
final _that = this;
switch (_that) {
case _StaffRequestModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeToJson: false)  int? id, @JsonKey(name: 'name', includeIfNull: false)  String? name, @JsonKey(name: 'phone', includeIfNull: false)  String? phoneNumber)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StaffRequestModel() when $default != null:
return $default(_that.id,_that.name,_that.phoneNumber);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeToJson: false)  int? id, @JsonKey(name: 'name', includeIfNull: false)  String? name, @JsonKey(name: 'phone', includeIfNull: false)  String? phoneNumber)  $default,) {final _that = this;
switch (_that) {
case _StaffRequestModel():
return $default(_that.id,_that.name,_that.phoneNumber);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeToJson: false)  int? id, @JsonKey(name: 'name', includeIfNull: false)  String? name, @JsonKey(name: 'phone', includeIfNull: false)  String? phoneNumber)?  $default,) {final _that = this;
switch (_that) {
case _StaffRequestModel() when $default != null:
return $default(_that.id,_that.name,_that.phoneNumber);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StaffRequestModel implements StaffRequestModel {
  const _StaffRequestModel({@JsonKey(includeToJson: false) this.id, @JsonKey(name: 'name', includeIfNull: false) this.name, @JsonKey(name: 'phone', includeIfNull: false) this.phoneNumber});
  factory _StaffRequestModel.fromJson(Map<String, dynamic> json) => _$StaffRequestModelFromJson(json);

@override@JsonKey(includeToJson: false) final  int? id;
@override@JsonKey(name: 'name', includeIfNull: false) final  String? name;
@override@JsonKey(name: 'phone', includeIfNull: false) final  String? phoneNumber;

/// Create a copy of StaffRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StaffRequestModelCopyWith<_StaffRequestModel> get copyWith => __$StaffRequestModelCopyWithImpl<_StaffRequestModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StaffRequestModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StaffRequestModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,phoneNumber);

@override
String toString() {
  return 'StaffRequestModel(id: $id, name: $name, phoneNumber: $phoneNumber)';
}


}

/// @nodoc
abstract mixin class _$StaffRequestModelCopyWith<$Res> implements $StaffRequestModelCopyWith<$Res> {
  factory _$StaffRequestModelCopyWith(_StaffRequestModel value, $Res Function(_StaffRequestModel) _then) = __$StaffRequestModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeToJson: false) int? id,@JsonKey(name: 'name', includeIfNull: false) String? name,@JsonKey(name: 'phone', includeIfNull: false) String? phoneNumber
});




}
/// @nodoc
class __$StaffRequestModelCopyWithImpl<$Res>
    implements _$StaffRequestModelCopyWith<$Res> {
  __$StaffRequestModelCopyWithImpl(this._self, this._then);

  final _StaffRequestModel _self;
  final $Res Function(_StaffRequestModel) _then;

/// Create a copy of StaffRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = freezed,Object? phoneNumber = freezed,}) {
  return _then(_StaffRequestModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
