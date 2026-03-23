// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'staff_search_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StaffSearchState {

 List<StaffEntity> get staffs; StaffEntity? get selectedStaff; String? get errorMessage; bool get isLoading;
/// Create a copy of StaffSearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StaffSearchStateCopyWith<StaffSearchState> get copyWith => _$StaffSearchStateCopyWithImpl<StaffSearchState>(this as StaffSearchState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StaffSearchState&&const DeepCollectionEquality().equals(other.staffs, staffs)&&(identical(other.selectedStaff, selectedStaff) || other.selectedStaff == selectedStaff)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(staffs),selectedStaff,errorMessage,isLoading);

@override
String toString() {
  return 'StaffSearchState(staffs: $staffs, selectedStaff: $selectedStaff, errorMessage: $errorMessage, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class $StaffSearchStateCopyWith<$Res>  {
  factory $StaffSearchStateCopyWith(StaffSearchState value, $Res Function(StaffSearchState) _then) = _$StaffSearchStateCopyWithImpl;
@useResult
$Res call({
 List<StaffEntity> staffs, StaffEntity? selectedStaff, String? errorMessage, bool isLoading
});


$StaffEntityCopyWith<$Res>? get selectedStaff;

}
/// @nodoc
class _$StaffSearchStateCopyWithImpl<$Res>
    implements $StaffSearchStateCopyWith<$Res> {
  _$StaffSearchStateCopyWithImpl(this._self, this._then);

  final StaffSearchState _self;
  final $Res Function(StaffSearchState) _then;

/// Create a copy of StaffSearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? staffs = null,Object? selectedStaff = freezed,Object? errorMessage = freezed,Object? isLoading = null,}) {
  return _then(_self.copyWith(
staffs: null == staffs ? _self.staffs : staffs // ignore: cast_nullable_to_non_nullable
as List<StaffEntity>,selectedStaff: freezed == selectedStaff ? _self.selectedStaff : selectedStaff // ignore: cast_nullable_to_non_nullable
as StaffEntity?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of StaffSearchState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StaffEntityCopyWith<$Res>? get selectedStaff {
    if (_self.selectedStaff == null) {
    return null;
  }

  return $StaffEntityCopyWith<$Res>(_self.selectedStaff!, (value) {
    return _then(_self.copyWith(selectedStaff: value));
  });
}
}


/// Adds pattern-matching-related methods to [StaffSearchState].
extension StaffSearchStatePatterns on StaffSearchState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StaffSearchState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StaffSearchState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StaffSearchState value)  $default,){
final _that = this;
switch (_that) {
case _StaffSearchState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StaffSearchState value)?  $default,){
final _that = this;
switch (_that) {
case _StaffSearchState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<StaffEntity> staffs,  StaffEntity? selectedStaff,  String? errorMessage,  bool isLoading)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StaffSearchState() when $default != null:
return $default(_that.staffs,_that.selectedStaff,_that.errorMessage,_that.isLoading);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<StaffEntity> staffs,  StaffEntity? selectedStaff,  String? errorMessage,  bool isLoading)  $default,) {final _that = this;
switch (_that) {
case _StaffSearchState():
return $default(_that.staffs,_that.selectedStaff,_that.errorMessage,_that.isLoading);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<StaffEntity> staffs,  StaffEntity? selectedStaff,  String? errorMessage,  bool isLoading)?  $default,) {final _that = this;
switch (_that) {
case _StaffSearchState() when $default != null:
return $default(_that.staffs,_that.selectedStaff,_that.errorMessage,_that.isLoading);case _:
  return null;

}
}

}

/// @nodoc


class _StaffSearchState implements StaffSearchState {
  const _StaffSearchState({final  List<StaffEntity> staffs = const [], this.selectedStaff, this.errorMessage, this.isLoading = false}): _staffs = staffs;
  

 final  List<StaffEntity> _staffs;
@override@JsonKey() List<StaffEntity> get staffs {
  if (_staffs is EqualUnmodifiableListView) return _staffs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_staffs);
}

@override final  StaffEntity? selectedStaff;
@override final  String? errorMessage;
@override@JsonKey() final  bool isLoading;

/// Create a copy of StaffSearchState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StaffSearchStateCopyWith<_StaffSearchState> get copyWith => __$StaffSearchStateCopyWithImpl<_StaffSearchState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StaffSearchState&&const DeepCollectionEquality().equals(other._staffs, _staffs)&&(identical(other.selectedStaff, selectedStaff) || other.selectedStaff == selectedStaff)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_staffs),selectedStaff,errorMessage,isLoading);

@override
String toString() {
  return 'StaffSearchState(staffs: $staffs, selectedStaff: $selectedStaff, errorMessage: $errorMessage, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class _$StaffSearchStateCopyWith<$Res> implements $StaffSearchStateCopyWith<$Res> {
  factory _$StaffSearchStateCopyWith(_StaffSearchState value, $Res Function(_StaffSearchState) _then) = __$StaffSearchStateCopyWithImpl;
@override @useResult
$Res call({
 List<StaffEntity> staffs, StaffEntity? selectedStaff, String? errorMessage, bool isLoading
});


@override $StaffEntityCopyWith<$Res>? get selectedStaff;

}
/// @nodoc
class __$StaffSearchStateCopyWithImpl<$Res>
    implements _$StaffSearchStateCopyWith<$Res> {
  __$StaffSearchStateCopyWithImpl(this._self, this._then);

  final _StaffSearchState _self;
  final $Res Function(_StaffSearchState) _then;

/// Create a copy of StaffSearchState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? staffs = null,Object? selectedStaff = freezed,Object? errorMessage = freezed,Object? isLoading = null,}) {
  return _then(_StaffSearchState(
staffs: null == staffs ? _self._staffs : staffs // ignore: cast_nullable_to_non_nullable
as List<StaffEntity>,selectedStaff: freezed == selectedStaff ? _self.selectedStaff : selectedStaff // ignore: cast_nullable_to_non_nullable
as StaffEntity?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of StaffSearchState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StaffEntityCopyWith<$Res>? get selectedStaff {
    if (_self.selectedStaff == null) {
    return null;
  }

  return $StaffEntityCopyWith<$Res>(_self.selectedStaff!, (value) {
    return _then(_self.copyWith(selectedStaff: value));
  });
}
}

// dart format on
