// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'staff_details_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StaffDetailsModel {

 int get id; String get name;@JsonKey(name: 'phone') String get phoneNumber;@JsonKey(name: 'created_at', defaultValue: '') String get createdAt;
/// Create a copy of StaffDetailsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StaffDetailsModelCopyWith<StaffDetailsModel> get copyWith => _$StaffDetailsModelCopyWithImpl<StaffDetailsModel>(this as StaffDetailsModel, _$identity);

  /// Serializes this StaffDetailsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StaffDetailsModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,phoneNumber,createdAt);

@override
String toString() {
  return 'StaffDetailsModel(id: $id, name: $name, phoneNumber: $phoneNumber, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $StaffDetailsModelCopyWith<$Res>  {
  factory $StaffDetailsModelCopyWith(StaffDetailsModel value, $Res Function(StaffDetailsModel) _then) = _$StaffDetailsModelCopyWithImpl;
@useResult
$Res call({
 int id, String name,@JsonKey(name: 'phone') String phoneNumber,@JsonKey(name: 'created_at', defaultValue: '') String createdAt
});




}
/// @nodoc
class _$StaffDetailsModelCopyWithImpl<$Res>
    implements $StaffDetailsModelCopyWith<$Res> {
  _$StaffDetailsModelCopyWithImpl(this._self, this._then);

  final StaffDetailsModel _self;
  final $Res Function(StaffDetailsModel) _then;

/// Create a copy of StaffDetailsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? phoneNumber = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [StaffDetailsModel].
extension StaffDetailsModelPatterns on StaffDetailsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StaffDetailsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StaffDetailsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StaffDetailsModel value)  $default,){
final _that = this;
switch (_that) {
case _StaffDetailsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StaffDetailsModel value)?  $default,){
final _that = this;
switch (_that) {
case _StaffDetailsModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name, @JsonKey(name: 'phone')  String phoneNumber, @JsonKey(name: 'created_at', defaultValue: '')  String createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StaffDetailsModel() when $default != null:
return $default(_that.id,_that.name,_that.phoneNumber,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name, @JsonKey(name: 'phone')  String phoneNumber, @JsonKey(name: 'created_at', defaultValue: '')  String createdAt)  $default,) {final _that = this;
switch (_that) {
case _StaffDetailsModel():
return $default(_that.id,_that.name,_that.phoneNumber,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name, @JsonKey(name: 'phone')  String phoneNumber, @JsonKey(name: 'created_at', defaultValue: '')  String createdAt)?  $default,) {final _that = this;
switch (_that) {
case _StaffDetailsModel() when $default != null:
return $default(_that.id,_that.name,_that.phoneNumber,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StaffDetailsModel implements StaffDetailsModel {
  const _StaffDetailsModel({required this.id, required this.name, @JsonKey(name: 'phone') required this.phoneNumber, @JsonKey(name: 'created_at', defaultValue: '') required this.createdAt});
  factory _StaffDetailsModel.fromJson(Map<String, dynamic> json) => _$StaffDetailsModelFromJson(json);

@override final  int id;
@override final  String name;
@override@JsonKey(name: 'phone') final  String phoneNumber;
@override@JsonKey(name: 'created_at', defaultValue: '') final  String createdAt;

/// Create a copy of StaffDetailsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StaffDetailsModelCopyWith<_StaffDetailsModel> get copyWith => __$StaffDetailsModelCopyWithImpl<_StaffDetailsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StaffDetailsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StaffDetailsModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,phoneNumber,createdAt);

@override
String toString() {
  return 'StaffDetailsModel(id: $id, name: $name, phoneNumber: $phoneNumber, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$StaffDetailsModelCopyWith<$Res> implements $StaffDetailsModelCopyWith<$Res> {
  factory _$StaffDetailsModelCopyWith(_StaffDetailsModel value, $Res Function(_StaffDetailsModel) _then) = __$StaffDetailsModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String name,@JsonKey(name: 'phone') String phoneNumber,@JsonKey(name: 'created_at', defaultValue: '') String createdAt
});




}
/// @nodoc
class __$StaffDetailsModelCopyWithImpl<$Res>
    implements _$StaffDetailsModelCopyWith<$Res> {
  __$StaffDetailsModelCopyWithImpl(this._self, this._then);

  final _StaffDetailsModel _self;
  final $Res Function(_StaffDetailsModel) _then;

/// Create a copy of StaffDetailsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? phoneNumber = null,Object? createdAt = null,}) {
  return _then(_StaffDetailsModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
