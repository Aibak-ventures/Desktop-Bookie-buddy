// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_search_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductSearchState {

 List<ProductModel> get suggestions; ProductModel? get selectedProduct; String get searchQuery; String? get nextPageUrl; bool get isLoading;
/// Create a copy of ProductSearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductSearchStateCopyWith<ProductSearchState> get copyWith => _$ProductSearchStateCopyWithImpl<ProductSearchState>(this as ProductSearchState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductSearchState&&const DeepCollectionEquality().equals(other.suggestions, suggestions)&&(identical(other.selectedProduct, selectedProduct) || other.selectedProduct == selectedProduct)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.nextPageUrl, nextPageUrl) || other.nextPageUrl == nextPageUrl)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(suggestions),selectedProduct,searchQuery,nextPageUrl,isLoading);

@override
String toString() {
  return 'ProductSearchState(suggestions: $suggestions, selectedProduct: $selectedProduct, searchQuery: $searchQuery, nextPageUrl: $nextPageUrl, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class $ProductSearchStateCopyWith<$Res>  {
  factory $ProductSearchStateCopyWith(ProductSearchState value, $Res Function(ProductSearchState) _then) = _$ProductSearchStateCopyWithImpl;
@useResult
$Res call({
 List<ProductModel> suggestions, ProductModel? selectedProduct, String searchQuery, String? nextPageUrl, bool isLoading
});


$ProductModelCopyWith<$Res>? get selectedProduct;

}
/// @nodoc
class _$ProductSearchStateCopyWithImpl<$Res>
    implements $ProductSearchStateCopyWith<$Res> {
  _$ProductSearchStateCopyWithImpl(this._self, this._then);

  final ProductSearchState _self;
  final $Res Function(ProductSearchState) _then;

/// Create a copy of ProductSearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? suggestions = null,Object? selectedProduct = freezed,Object? searchQuery = null,Object? nextPageUrl = freezed,Object? isLoading = null,}) {
  return _then(_self.copyWith(
suggestions: null == suggestions ? _self.suggestions : suggestions // ignore: cast_nullable_to_non_nullable
as List<ProductModel>,selectedProduct: freezed == selectedProduct ? _self.selectedProduct : selectedProduct // ignore: cast_nullable_to_non_nullable
as ProductModel?,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,nextPageUrl: freezed == nextPageUrl ? _self.nextPageUrl : nextPageUrl // ignore: cast_nullable_to_non_nullable
as String?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of ProductSearchState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProductModelCopyWith<$Res>? get selectedProduct {
    if (_self.selectedProduct == null) {
    return null;
  }

  return $ProductModelCopyWith<$Res>(_self.selectedProduct!, (value) {
    return _then(_self.copyWith(selectedProduct: value));
  });
}
}


/// Adds pattern-matching-related methods to [ProductSearchState].
extension ProductSearchStatePatterns on ProductSearchState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductSearchState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductSearchState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductSearchState value)  $default,){
final _that = this;
switch (_that) {
case _ProductSearchState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductSearchState value)?  $default,){
final _that = this;
switch (_that) {
case _ProductSearchState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ProductModel> suggestions,  ProductModel? selectedProduct,  String searchQuery,  String? nextPageUrl,  bool isLoading)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductSearchState() when $default != null:
return $default(_that.suggestions,_that.selectedProduct,_that.searchQuery,_that.nextPageUrl,_that.isLoading);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ProductModel> suggestions,  ProductModel? selectedProduct,  String searchQuery,  String? nextPageUrl,  bool isLoading)  $default,) {final _that = this;
switch (_that) {
case _ProductSearchState():
return $default(_that.suggestions,_that.selectedProduct,_that.searchQuery,_that.nextPageUrl,_that.isLoading);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ProductModel> suggestions,  ProductModel? selectedProduct,  String searchQuery,  String? nextPageUrl,  bool isLoading)?  $default,) {final _that = this;
switch (_that) {
case _ProductSearchState() when $default != null:
return $default(_that.suggestions,_that.selectedProduct,_that.searchQuery,_that.nextPageUrl,_that.isLoading);case _:
  return null;

}
}

}

/// @nodoc


class _ProductSearchState implements ProductSearchState {
  const _ProductSearchState({required final  List<ProductModel> suggestions, required this.selectedProduct, required this.searchQuery, this.nextPageUrl, this.isLoading = false}): _suggestions = suggestions;
  

 final  List<ProductModel> _suggestions;
@override List<ProductModel> get suggestions {
  if (_suggestions is EqualUnmodifiableListView) return _suggestions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_suggestions);
}

@override final  ProductModel? selectedProduct;
@override final  String searchQuery;
@override final  String? nextPageUrl;
@override@JsonKey() final  bool isLoading;

/// Create a copy of ProductSearchState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductSearchStateCopyWith<_ProductSearchState> get copyWith => __$ProductSearchStateCopyWithImpl<_ProductSearchState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductSearchState&&const DeepCollectionEquality().equals(other._suggestions, _suggestions)&&(identical(other.selectedProduct, selectedProduct) || other.selectedProduct == selectedProduct)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.nextPageUrl, nextPageUrl) || other.nextPageUrl == nextPageUrl)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_suggestions),selectedProduct,searchQuery,nextPageUrl,isLoading);

@override
String toString() {
  return 'ProductSearchState(suggestions: $suggestions, selectedProduct: $selectedProduct, searchQuery: $searchQuery, nextPageUrl: $nextPageUrl, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class _$ProductSearchStateCopyWith<$Res> implements $ProductSearchStateCopyWith<$Res> {
  factory _$ProductSearchStateCopyWith(_ProductSearchState value, $Res Function(_ProductSearchState) _then) = __$ProductSearchStateCopyWithImpl;
@override @useResult
$Res call({
 List<ProductModel> suggestions, ProductModel? selectedProduct, String searchQuery, String? nextPageUrl, bool isLoading
});


@override $ProductModelCopyWith<$Res>? get selectedProduct;

}
/// @nodoc
class __$ProductSearchStateCopyWithImpl<$Res>
    implements _$ProductSearchStateCopyWith<$Res> {
  __$ProductSearchStateCopyWithImpl(this._self, this._then);

  final _ProductSearchState _self;
  final $Res Function(_ProductSearchState) _then;

/// Create a copy of ProductSearchState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? suggestions = null,Object? selectedProduct = freezed,Object? searchQuery = null,Object? nextPageUrl = freezed,Object? isLoading = null,}) {
  return _then(_ProductSearchState(
suggestions: null == suggestions ? _self._suggestions : suggestions // ignore: cast_nullable_to_non_nullable
as List<ProductModel>,selectedProduct: freezed == selectedProduct ? _self.selectedProduct : selectedProduct // ignore: cast_nullable_to_non_nullable
as ProductModel?,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,nextPageUrl: freezed == nextPageUrl ? _self.nextPageUrl : nextPageUrl // ignore: cast_nullable_to_non_nullable
as String?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of ProductSearchState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProductModelCopyWith<$Res>? get selectedProduct {
    if (_self.selectedProduct == null) {
    return null;
  }

  return $ProductModelCopyWith<$Res>(_self.selectedProduct!, (value) {
    return _then(_self.copyWith(selectedProduct: value));
  });
}
}

// dart format on
