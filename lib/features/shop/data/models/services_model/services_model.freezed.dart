// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'services_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ServicesModel {

 int get id;@JsonKey(name: 'service_name') String get name;@JsonKey(name: 'description') String get description;@JsonKey(name: 'icon') String? get icon;@JsonKey(name: 'main_service_name', defaultValue: 'Other') String get mainServiceName;
/// Create a copy of ServicesModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServicesModelCopyWith<ServicesModel> get copyWith => _$ServicesModelCopyWithImpl<ServicesModel>(this as ServicesModel, _$identity);

  /// Serializes this ServicesModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServicesModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.mainServiceName, mainServiceName) || other.mainServiceName == mainServiceName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,icon,mainServiceName);

@override
String toString() {
  return 'ServicesModel(id: $id, name: $name, description: $description, icon: $icon, mainServiceName: $mainServiceName)';
}


}

/// @nodoc
abstract mixin class $ServicesModelCopyWith<$Res>  {
  factory $ServicesModelCopyWith(ServicesModel value, $Res Function(ServicesModel) _then) = _$ServicesModelCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'service_name') String name,@JsonKey(name: 'description') String description,@JsonKey(name: 'icon') String? icon,@JsonKey(name: 'main_service_name', defaultValue: 'Other') String mainServiceName
});




}
/// @nodoc
class _$ServicesModelCopyWithImpl<$Res>
    implements $ServicesModelCopyWith<$Res> {
  _$ServicesModelCopyWithImpl(this._self, this._then);

  final ServicesModel _self;
  final $Res Function(ServicesModel) _then;

/// Create a copy of ServicesModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = null,Object? icon = freezed,Object? mainServiceName = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,mainServiceName: null == mainServiceName ? _self.mainServiceName : mainServiceName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ServicesModel].
extension ServicesModelPatterns on ServicesModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServicesModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServicesModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServicesModel value)  $default,){
final _that = this;
switch (_that) {
case _ServicesModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServicesModel value)?  $default,){
final _that = this;
switch (_that) {
case _ServicesModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'service_name')  String name, @JsonKey(name: 'description')  String description, @JsonKey(name: 'icon')  String? icon, @JsonKey(name: 'main_service_name', defaultValue: 'Other')  String mainServiceName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServicesModel() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.icon,_that.mainServiceName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'service_name')  String name, @JsonKey(name: 'description')  String description, @JsonKey(name: 'icon')  String? icon, @JsonKey(name: 'main_service_name', defaultValue: 'Other')  String mainServiceName)  $default,) {final _that = this;
switch (_that) {
case _ServicesModel():
return $default(_that.id,_that.name,_that.description,_that.icon,_that.mainServiceName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'service_name')  String name, @JsonKey(name: 'description')  String description, @JsonKey(name: 'icon')  String? icon, @JsonKey(name: 'main_service_name', defaultValue: 'Other')  String mainServiceName)?  $default,) {final _that = this;
switch (_that) {
case _ServicesModel() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.icon,_that.mainServiceName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ServicesModel implements ServicesModel {
   _ServicesModel({required this.id, @JsonKey(name: 'service_name') required this.name, @JsonKey(name: 'description') required this.description, @JsonKey(name: 'icon') this.icon, @JsonKey(name: 'main_service_name', defaultValue: 'Other') required this.mainServiceName});
  factory _ServicesModel.fromJson(Map<String, dynamic> json) => _$ServicesModelFromJson(json);

@override final  int id;
@override@JsonKey(name: 'service_name') final  String name;
@override@JsonKey(name: 'description') final  String description;
@override@JsonKey(name: 'icon') final  String? icon;
@override@JsonKey(name: 'main_service_name', defaultValue: 'Other') final  String mainServiceName;

/// Create a copy of ServicesModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServicesModelCopyWith<_ServicesModel> get copyWith => __$ServicesModelCopyWithImpl<_ServicesModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServicesModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServicesModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.mainServiceName, mainServiceName) || other.mainServiceName == mainServiceName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,icon,mainServiceName);

@override
String toString() {
  return 'ServicesModel(id: $id, name: $name, description: $description, icon: $icon, mainServiceName: $mainServiceName)';
}


}

/// @nodoc
abstract mixin class _$ServicesModelCopyWith<$Res> implements $ServicesModelCopyWith<$Res> {
  factory _$ServicesModelCopyWith(_ServicesModel value, $Res Function(_ServicesModel) _then) = __$ServicesModelCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'service_name') String name,@JsonKey(name: 'description') String description,@JsonKey(name: 'icon') String? icon,@JsonKey(name: 'main_service_name', defaultValue: 'Other') String mainServiceName
});




}
/// @nodoc
class __$ServicesModelCopyWithImpl<$Res>
    implements _$ServicesModelCopyWith<$Res> {
  __$ServicesModelCopyWithImpl(this._self, this._then);

  final _ServicesModel _self;
  final $Res Function(_ServicesModel) _then;

/// Create a copy of ServicesModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,Object? icon = freezed,Object? mainServiceName = null,}) {
  return _then(_ServicesModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,mainServiceName: null == mainServiceName ? _self.mainServiceName : mainServiceName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
