// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'details_drawer_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DetailsDrawerState {

 bool get isOpen; DetailsDrawerType? get type; int? get selectedId;
/// Create a copy of DetailsDrawerState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DetailsDrawerStateCopyWith<DetailsDrawerState> get copyWith => _$DetailsDrawerStateCopyWithImpl<DetailsDrawerState>(this as DetailsDrawerState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DetailsDrawerState&&(identical(other.isOpen, isOpen) || other.isOpen == isOpen)&&(identical(other.type, type) || other.type == type)&&(identical(other.selectedId, selectedId) || other.selectedId == selectedId));
}


@override
int get hashCode => Object.hash(runtimeType,isOpen,type,selectedId);

@override
String toString() {
  return 'DetailsDrawerState(isOpen: $isOpen, type: $type, selectedId: $selectedId)';
}


}

/// @nodoc
abstract mixin class $DetailsDrawerStateCopyWith<$Res>  {
  factory $DetailsDrawerStateCopyWith(DetailsDrawerState value, $Res Function(DetailsDrawerState) _then) = _$DetailsDrawerStateCopyWithImpl;
@useResult
$Res call({
 bool isOpen, DetailsDrawerType? type, int? selectedId
});




}
/// @nodoc
class _$DetailsDrawerStateCopyWithImpl<$Res>
    implements $DetailsDrawerStateCopyWith<$Res> {
  _$DetailsDrawerStateCopyWithImpl(this._self, this._then);

  final DetailsDrawerState _self;
  final $Res Function(DetailsDrawerState) _then;

/// Create a copy of DetailsDrawerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isOpen = null,Object? type = freezed,Object? selectedId = freezed,}) {
  return _then(_self.copyWith(
isOpen: null == isOpen ? _self.isOpen : isOpen // ignore: cast_nullable_to_non_nullable
as bool,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as DetailsDrawerType?,selectedId: freezed == selectedId ? _self.selectedId : selectedId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [DetailsDrawerState].
extension DetailsDrawerStatePatterns on DetailsDrawerState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DetailsDrawerState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DetailsDrawerState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DetailsDrawerState value)  $default,){
final _that = this;
switch (_that) {
case _DetailsDrawerState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DetailsDrawerState value)?  $default,){
final _that = this;
switch (_that) {
case _DetailsDrawerState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isOpen,  DetailsDrawerType? type,  int? selectedId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DetailsDrawerState() when $default != null:
return $default(_that.isOpen,_that.type,_that.selectedId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isOpen,  DetailsDrawerType? type,  int? selectedId)  $default,) {final _that = this;
switch (_that) {
case _DetailsDrawerState():
return $default(_that.isOpen,_that.type,_that.selectedId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isOpen,  DetailsDrawerType? type,  int? selectedId)?  $default,) {final _that = this;
switch (_that) {
case _DetailsDrawerState() when $default != null:
return $default(_that.isOpen,_that.type,_that.selectedId);case _:
  return null;

}
}

}

/// @nodoc


class _DetailsDrawerState implements DetailsDrawerState {
  const _DetailsDrawerState({this.isOpen = false, this.type, this.selectedId});
  

@override@JsonKey() final  bool isOpen;
@override final  DetailsDrawerType? type;
@override final  int? selectedId;

/// Create a copy of DetailsDrawerState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DetailsDrawerStateCopyWith<_DetailsDrawerState> get copyWith => __$DetailsDrawerStateCopyWithImpl<_DetailsDrawerState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DetailsDrawerState&&(identical(other.isOpen, isOpen) || other.isOpen == isOpen)&&(identical(other.type, type) || other.type == type)&&(identical(other.selectedId, selectedId) || other.selectedId == selectedId));
}


@override
int get hashCode => Object.hash(runtimeType,isOpen,type,selectedId);

@override
String toString() {
  return 'DetailsDrawerState(isOpen: $isOpen, type: $type, selectedId: $selectedId)';
}


}

/// @nodoc
abstract mixin class _$DetailsDrawerStateCopyWith<$Res> implements $DetailsDrawerStateCopyWith<$Res> {
  factory _$DetailsDrawerStateCopyWith(_DetailsDrawerState value, $Res Function(_DetailsDrawerState) _then) = __$DetailsDrawerStateCopyWithImpl;
@override @useResult
$Res call({
 bool isOpen, DetailsDrawerType? type, int? selectedId
});




}
/// @nodoc
class __$DetailsDrawerStateCopyWithImpl<$Res>
    implements _$DetailsDrawerStateCopyWith<$Res> {
  __$DetailsDrawerStateCopyWithImpl(this._self, this._then);

  final _DetailsDrawerState _self;
  final $Res Function(_DetailsDrawerState) _then;

/// Create a copy of DetailsDrawerState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isOpen = null,Object? type = freezed,Object? selectedId = freezed,}) {
  return _then(_DetailsDrawerState(
isOpen: null == isOpen ? _self.isOpen : isOpen // ignore: cast_nullable_to_non_nullable
as bool,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as DetailsDrawerType?,selectedId: freezed == selectedId ? _self.selectedId : selectedId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
