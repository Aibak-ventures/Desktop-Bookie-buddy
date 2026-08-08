// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'printer_device_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PrinterDeviceEntity {

 String get name;
/// Create a copy of PrinterDeviceEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrinterDeviceEntityCopyWith<PrinterDeviceEntity> get copyWith => _$PrinterDeviceEntityCopyWithImpl<PrinterDeviceEntity>(this as PrinterDeviceEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrinterDeviceEntity&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'PrinterDeviceEntity(name: $name)';
}


}

/// @nodoc
abstract mixin class $PrinterDeviceEntityCopyWith<$Res>  {
  factory $PrinterDeviceEntityCopyWith(PrinterDeviceEntity value, $Res Function(PrinterDeviceEntity) _then) = _$PrinterDeviceEntityCopyWithImpl;
@useResult
$Res call({
 String name
});




}
/// @nodoc
class _$PrinterDeviceEntityCopyWithImpl<$Res>
    implements $PrinterDeviceEntityCopyWith<$Res> {
  _$PrinterDeviceEntityCopyWithImpl(this._self, this._then);

  final PrinterDeviceEntity _self;
  final $Res Function(PrinterDeviceEntity) _then;

/// Create a copy of PrinterDeviceEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PrinterDeviceEntity].
extension PrinterDeviceEntityPatterns on PrinterDeviceEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PrinterDeviceEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PrinterDeviceEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PrinterDeviceEntity value)  $default,){
final _that = this;
switch (_that) {
case _PrinterDeviceEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PrinterDeviceEntity value)?  $default,){
final _that = this;
switch (_that) {
case _PrinterDeviceEntity() when $default != null:
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
case _PrinterDeviceEntity() when $default != null:
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
case _PrinterDeviceEntity():
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
case _PrinterDeviceEntity() when $default != null:
return $default(_that.name);case _:
  return null;

}
}

}

/// @nodoc


class _PrinterDeviceEntity implements PrinterDeviceEntity {
  const _PrinterDeviceEntity({required this.name});
  

@override final  String name;

/// Create a copy of PrinterDeviceEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PrinterDeviceEntityCopyWith<_PrinterDeviceEntity> get copyWith => __$PrinterDeviceEntityCopyWithImpl<_PrinterDeviceEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PrinterDeviceEntity&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'PrinterDeviceEntity(name: $name)';
}


}

/// @nodoc
abstract mixin class _$PrinterDeviceEntityCopyWith<$Res> implements $PrinterDeviceEntityCopyWith<$Res> {
  factory _$PrinterDeviceEntityCopyWith(_PrinterDeviceEntity value, $Res Function(_PrinterDeviceEntity) _then) = __$PrinterDeviceEntityCopyWithImpl;
@override @useResult
$Res call({
 String name
});




}
/// @nodoc
class __$PrinterDeviceEntityCopyWithImpl<$Res>
    implements _$PrinterDeviceEntityCopyWith<$Res> {
  __$PrinterDeviceEntityCopyWithImpl(this._self, this._then);

  final _PrinterDeviceEntity _self;
  final $Res Function(_PrinterDeviceEntity) _then;

/// Create a copy of PrinterDeviceEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,}) {
  return _then(_PrinterDeviceEntity(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
