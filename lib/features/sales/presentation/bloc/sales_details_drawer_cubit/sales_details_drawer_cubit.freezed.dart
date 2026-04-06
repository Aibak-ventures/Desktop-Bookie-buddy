// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sales_details_drawer_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SalesDetailsDrawerState {

 bool get isOpen; int? get selectedSaleId;
/// Create a copy of SalesDetailsDrawerState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SalesDetailsDrawerStateCopyWith<SalesDetailsDrawerState> get copyWith => _$SalesDetailsDrawerStateCopyWithImpl<SalesDetailsDrawerState>(this as SalesDetailsDrawerState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SalesDetailsDrawerState&&(identical(other.isOpen, isOpen) || other.isOpen == isOpen)&&(identical(other.selectedSaleId, selectedSaleId) || other.selectedSaleId == selectedSaleId));
}


@override
int get hashCode => Object.hash(runtimeType,isOpen,selectedSaleId);

@override
String toString() {
  return 'SalesDetailsDrawerState(isOpen: $isOpen, selectedSaleId: $selectedSaleId)';
}


}

/// @nodoc
abstract mixin class $SalesDetailsDrawerStateCopyWith<$Res>  {
  factory $SalesDetailsDrawerStateCopyWith(SalesDetailsDrawerState value, $Res Function(SalesDetailsDrawerState) _then) = _$SalesDetailsDrawerStateCopyWithImpl;
@useResult
$Res call({
 bool isOpen, int? selectedSaleId
});




}
/// @nodoc
class _$SalesDetailsDrawerStateCopyWithImpl<$Res>
    implements $SalesDetailsDrawerStateCopyWith<$Res> {
  _$SalesDetailsDrawerStateCopyWithImpl(this._self, this._then);

  final SalesDetailsDrawerState _self;
  final $Res Function(SalesDetailsDrawerState) _then;

/// Create a copy of SalesDetailsDrawerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isOpen = null,Object? selectedSaleId = freezed,}) {
  return _then(_self.copyWith(
isOpen: null == isOpen ? _self.isOpen : isOpen // ignore: cast_nullable_to_non_nullable
as bool,selectedSaleId: freezed == selectedSaleId ? _self.selectedSaleId : selectedSaleId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [SalesDetailsDrawerState].
extension SalesDetailsDrawerStatePatterns on SalesDetailsDrawerState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SalesDetailsDrawerState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SalesDetailsDrawerState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SalesDetailsDrawerState value)  $default,){
final _that = this;
switch (_that) {
case _SalesDetailsDrawerState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SalesDetailsDrawerState value)?  $default,){
final _that = this;
switch (_that) {
case _SalesDetailsDrawerState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isOpen,  int? selectedSaleId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SalesDetailsDrawerState() when $default != null:
return $default(_that.isOpen,_that.selectedSaleId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isOpen,  int? selectedSaleId)  $default,) {final _that = this;
switch (_that) {
case _SalesDetailsDrawerState():
return $default(_that.isOpen,_that.selectedSaleId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isOpen,  int? selectedSaleId)?  $default,) {final _that = this;
switch (_that) {
case _SalesDetailsDrawerState() when $default != null:
return $default(_that.isOpen,_that.selectedSaleId);case _:
  return null;

}
}

}

/// @nodoc


class _SalesDetailsDrawerState implements SalesDetailsDrawerState {
  const _SalesDetailsDrawerState({this.isOpen = false, this.selectedSaleId});
  

@override@JsonKey() final  bool isOpen;
@override final  int? selectedSaleId;

/// Create a copy of SalesDetailsDrawerState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SalesDetailsDrawerStateCopyWith<_SalesDetailsDrawerState> get copyWith => __$SalesDetailsDrawerStateCopyWithImpl<_SalesDetailsDrawerState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SalesDetailsDrawerState&&(identical(other.isOpen, isOpen) || other.isOpen == isOpen)&&(identical(other.selectedSaleId, selectedSaleId) || other.selectedSaleId == selectedSaleId));
}


@override
int get hashCode => Object.hash(runtimeType,isOpen,selectedSaleId);

@override
String toString() {
  return 'SalesDetailsDrawerState(isOpen: $isOpen, selectedSaleId: $selectedSaleId)';
}


}

/// @nodoc
abstract mixin class _$SalesDetailsDrawerStateCopyWith<$Res> implements $SalesDetailsDrawerStateCopyWith<$Res> {
  factory _$SalesDetailsDrawerStateCopyWith(_SalesDetailsDrawerState value, $Res Function(_SalesDetailsDrawerState) _then) = __$SalesDetailsDrawerStateCopyWithImpl;
@override @useResult
$Res call({
 bool isOpen, int? selectedSaleId
});




}
/// @nodoc
class __$SalesDetailsDrawerStateCopyWithImpl<$Res>
    implements _$SalesDetailsDrawerStateCopyWith<$Res> {
  __$SalesDetailsDrawerStateCopyWithImpl(this._self, this._then);

  final _SalesDetailsDrawerState _self;
  final $Res Function(_SalesDetailsDrawerState) _then;

/// Create a copy of SalesDetailsDrawerState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isOpen = null,Object? selectedSaleId = freezed,}) {
  return _then(_SalesDetailsDrawerState(
isOpen: null == isOpen ? _self.isOpen : isOpen // ignore: cast_nullable_to_non_nullable
as bool,selectedSaleId: freezed == selectedSaleId ? _self.selectedSaleId : selectedSaleId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
