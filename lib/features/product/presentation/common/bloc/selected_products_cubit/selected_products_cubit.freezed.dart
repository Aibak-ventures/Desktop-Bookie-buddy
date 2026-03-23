// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'selected_products_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SelectedProductsState {

 List<ProductSelectedModel> get selectedProductsWithAmount;
/// Create a copy of SelectedProductsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelectedProductsStateCopyWith<SelectedProductsState> get copyWith => _$SelectedProductsStateCopyWithImpl<SelectedProductsState>(this as SelectedProductsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectedProductsState&&const DeepCollectionEquality().equals(other.selectedProductsWithAmount, selectedProductsWithAmount));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(selectedProductsWithAmount));

@override
String toString() {
  return 'SelectedProductsState(selectedProductsWithAmount: $selectedProductsWithAmount)';
}


}

/// @nodoc
abstract mixin class $SelectedProductsStateCopyWith<$Res>  {
  factory $SelectedProductsStateCopyWith(SelectedProductsState value, $Res Function(SelectedProductsState) _then) = _$SelectedProductsStateCopyWithImpl;
@useResult
$Res call({
 List<ProductSelectedModel> selectedProductsWithAmount
});




}
/// @nodoc
class _$SelectedProductsStateCopyWithImpl<$Res>
    implements $SelectedProductsStateCopyWith<$Res> {
  _$SelectedProductsStateCopyWithImpl(this._self, this._then);

  final SelectedProductsState _self;
  final $Res Function(SelectedProductsState) _then;

/// Create a copy of SelectedProductsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? selectedProductsWithAmount = null,}) {
  return _then(_self.copyWith(
selectedProductsWithAmount: null == selectedProductsWithAmount ? _self.selectedProductsWithAmount : selectedProductsWithAmount // ignore: cast_nullable_to_non_nullable
as List<ProductSelectedModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [SelectedProductsState].
extension SelectedProductsStatePatterns on SelectedProductsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Selected value)?  selected,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Selected() when selected != null:
return selected(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Selected value)  selected,}){
final _that = this;
switch (_that) {
case _Selected():
return selected(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Selected value)?  selected,}){
final _that = this;
switch (_that) {
case _Selected() when selected != null:
return selected(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( List<ProductSelectedModel> selectedProductsWithAmount)?  selected,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Selected() when selected != null:
return selected(_that.selectedProductsWithAmount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( List<ProductSelectedModel> selectedProductsWithAmount)  selected,}) {final _that = this;
switch (_that) {
case _Selected():
return selected(_that.selectedProductsWithAmount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( List<ProductSelectedModel> selectedProductsWithAmount)?  selected,}) {final _that = this;
switch (_that) {
case _Selected() when selected != null:
return selected(_that.selectedProductsWithAmount);case _:
  return null;

}
}

}

/// @nodoc


class _Selected implements SelectedProductsState {
  const _Selected(final  List<ProductSelectedModel> selectedProductsWithAmount): _selectedProductsWithAmount = selectedProductsWithAmount;
  

 final  List<ProductSelectedModel> _selectedProductsWithAmount;
@override List<ProductSelectedModel> get selectedProductsWithAmount {
  if (_selectedProductsWithAmount is EqualUnmodifiableListView) return _selectedProductsWithAmount;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedProductsWithAmount);
}


/// Create a copy of SelectedProductsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelectedCopyWith<_Selected> get copyWith => __$SelectedCopyWithImpl<_Selected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Selected&&const DeepCollectionEquality().equals(other._selectedProductsWithAmount, _selectedProductsWithAmount));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_selectedProductsWithAmount));

@override
String toString() {
  return 'SelectedProductsState.selected(selectedProductsWithAmount: $selectedProductsWithAmount)';
}


}

/// @nodoc
abstract mixin class _$SelectedCopyWith<$Res> implements $SelectedProductsStateCopyWith<$Res> {
  factory _$SelectedCopyWith(_Selected value, $Res Function(_Selected) _then) = __$SelectedCopyWithImpl;
@override @useResult
$Res call({
 List<ProductSelectedModel> selectedProductsWithAmount
});




}
/// @nodoc
class __$SelectedCopyWithImpl<$Res>
    implements _$SelectedCopyWith<$Res> {
  __$SelectedCopyWithImpl(this._self, this._then);

  final _Selected _self;
  final $Res Function(_Selected) _then;

/// Create a copy of SelectedProductsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selectedProductsWithAmount = null,}) {
  return _then(_Selected(
null == selectedProductsWithAmount ? _self._selectedProductsWithAmount : selectedProductsWithAmount // ignore: cast_nullable_to_non_nullable
as List<ProductSelectedModel>,
  ));
}


}

// dart format on
