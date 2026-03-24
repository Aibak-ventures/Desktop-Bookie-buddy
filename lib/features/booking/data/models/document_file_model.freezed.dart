// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'document_file_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DocumentFileModel {

 String get name; String get path; List<int>? get bytes;
/// Create a copy of DocumentFileModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DocumentFileModelCopyWith<DocumentFileModel> get copyWith => _$DocumentFileModelCopyWithImpl<DocumentFileModel>(this as DocumentFileModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DocumentFileModel&&(identical(other.name, name) || other.name == name)&&(identical(other.path, path) || other.path == path)&&const DeepCollectionEquality().equals(other.bytes, bytes));
}


@override
int get hashCode => Object.hash(runtimeType,name,path,const DeepCollectionEquality().hash(bytes));

@override
String toString() {
  return 'DocumentFileModel(name: $name, path: $path, bytes: $bytes)';
}


}

/// @nodoc
abstract mixin class $DocumentFileModelCopyWith<$Res>  {
  factory $DocumentFileModelCopyWith(DocumentFileModel value, $Res Function(DocumentFileModel) _then) = _$DocumentFileModelCopyWithImpl;
@useResult
$Res call({
 String name, String path, List<int>? bytes
});




}
/// @nodoc
class _$DocumentFileModelCopyWithImpl<$Res>
    implements $DocumentFileModelCopyWith<$Res> {
  _$DocumentFileModelCopyWithImpl(this._self, this._then);

  final DocumentFileModel _self;
  final $Res Function(DocumentFileModel) _then;

/// Create a copy of DocumentFileModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? path = null,Object? bytes = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,bytes: freezed == bytes ? _self.bytes : bytes // ignore: cast_nullable_to_non_nullable
as List<int>?,
  ));
}

}


/// Adds pattern-matching-related methods to [DocumentFileModel].
extension DocumentFileModelPatterns on DocumentFileModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DocumentFileModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DocumentFileModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DocumentFileModel value)  $default,){
final _that = this;
switch (_that) {
case _DocumentFileModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DocumentFileModel value)?  $default,){
final _that = this;
switch (_that) {
case _DocumentFileModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String path,  List<int>? bytes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DocumentFileModel() when $default != null:
return $default(_that.name,_that.path,_that.bytes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String path,  List<int>? bytes)  $default,) {final _that = this;
switch (_that) {
case _DocumentFileModel():
return $default(_that.name,_that.path,_that.bytes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String path,  List<int>? bytes)?  $default,) {final _that = this;
switch (_that) {
case _DocumentFileModel() when $default != null:
return $default(_that.name,_that.path,_that.bytes);case _:
  return null;

}
}

}

/// @nodoc


class _DocumentFileModel implements DocumentFileModel {
  const _DocumentFileModel({required this.name, required this.path, final  List<int>? bytes}): _bytes = bytes;
  

@override final  String name;
@override final  String path;
 final  List<int>? _bytes;
@override List<int>? get bytes {
  final value = _bytes;
  if (value == null) return null;
  if (_bytes is EqualUnmodifiableListView) return _bytes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of DocumentFileModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DocumentFileModelCopyWith<_DocumentFileModel> get copyWith => __$DocumentFileModelCopyWithImpl<_DocumentFileModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DocumentFileModel&&(identical(other.name, name) || other.name == name)&&(identical(other.path, path) || other.path == path)&&const DeepCollectionEquality().equals(other._bytes, _bytes));
}


@override
int get hashCode => Object.hash(runtimeType,name,path,const DeepCollectionEquality().hash(_bytes));

@override
String toString() {
  return 'DocumentFileModel(name: $name, path: $path, bytes: $bytes)';
}


}

/// @nodoc
abstract mixin class _$DocumentFileModelCopyWith<$Res> implements $DocumentFileModelCopyWith<$Res> {
  factory _$DocumentFileModelCopyWith(_DocumentFileModel value, $Res Function(_DocumentFileModel) _then) = __$DocumentFileModelCopyWithImpl;
@override @useResult
$Res call({
 String name, String path, List<int>? bytes
});




}
/// @nodoc
class __$DocumentFileModelCopyWithImpl<$Res>
    implements _$DocumentFileModelCopyWith<$Res> {
  __$DocumentFileModelCopyWithImpl(this._self, this._then);

  final _DocumentFileModel _self;
  final $Res Function(_DocumentFileModel) _then;

/// Create a copy of DocumentFileModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? path = null,Object? bytes = freezed,}) {
  return _then(_DocumentFileModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,bytes: freezed == bytes ? _self._bytes : bytes // ignore: cast_nullable_to_non_nullable
as List<int>?,
  ));
}


}

// dart format on
