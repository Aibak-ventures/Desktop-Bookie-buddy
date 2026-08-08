// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'printer_device_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PrinterDeviceModel {

 String get name;
/// Create a copy of PrinterDeviceModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrinterDeviceModelCopyWith<PrinterDeviceModel> get copyWith => _$PrinterDeviceModelCopyWithImpl<PrinterDeviceModel>(this as PrinterDeviceModel, _$identity);

  /// Serializes this PrinterDeviceModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrinterDeviceModel&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'PrinterDeviceModel(name: $name)';
}


}

/// @nodoc
abstract mixin class $PrinterDeviceModelCopyWith<$Res>  {
  factory $PrinterDeviceModelCopyWith(PrinterDeviceModel value, $Res Function(PrinterDeviceModel) _then) = _$PrinterDeviceModelCopyWithImpl;
@useResult
$Res call({
 String name
});




}
/// @nodoc
class _$PrinterDeviceModelCopyWithImpl<$Res>
    implements $PrinterDeviceModelCopyWith<$Res> {
  _$PrinterDeviceModelCopyWithImpl(this._self, this._then);

  final PrinterDeviceModel _self;
  final $Res Function(PrinterDeviceModel) _then;

/// Create a copy of PrinterDeviceModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PrinterDeviceModel].
extension PrinterDeviceModelPatterns on PrinterDeviceModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PrinterDeviceModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PrinterDeviceModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PrinterDeviceModel value)  $default,){
final _that = this;
switch (_that) {
case _PrinterDeviceModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PrinterDeviceModel value)?  $default,){
final _that = this;
switch (_that) {
case _PrinterDeviceModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PrinterDeviceModel() when $default != null:
return $default(_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name)  $default,) {final _that = this;
switch (_that) {
case _PrinterDeviceModel():
return $default(_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name)?  $default,) {final _that = this;
switch (_that) {
case _PrinterDeviceModel() when $default != null:
return $default(_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PrinterDeviceModel implements PrinterDeviceModel {
  const _PrinterDeviceModel({required this.name});
  factory _PrinterDeviceModel.fromJson(Map<String, dynamic> json) => _$PrinterDeviceModelFromJson(json);

@override final  String name;

/// Create a copy of PrinterDeviceModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PrinterDeviceModelCopyWith<_PrinterDeviceModel> get copyWith => __$PrinterDeviceModelCopyWithImpl<_PrinterDeviceModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PrinterDeviceModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PrinterDeviceModel&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'PrinterDeviceModel(name: $name)';
}


}

/// @nodoc
abstract mixin class _$PrinterDeviceModelCopyWith<$Res> implements $PrinterDeviceModelCopyWith<$Res> {
  factory _$PrinterDeviceModelCopyWith(_PrinterDeviceModel value, $Res Function(_PrinterDeviceModel) _then) = __$PrinterDeviceModelCopyWithImpl;
@override @useResult
$Res call({
 String name
});




}
/// @nodoc
class __$PrinterDeviceModelCopyWithImpl<$Res>
    implements _$PrinterDeviceModelCopyWith<$Res> {
  __$PrinterDeviceModelCopyWithImpl(this._self, this._then);

  final _PrinterDeviceModel _self;
  final $Res Function(_PrinterDeviceModel) _then;

/// Create a copy of PrinterDeviceModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,}) {
  return _then(_PrinterDeviceModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
