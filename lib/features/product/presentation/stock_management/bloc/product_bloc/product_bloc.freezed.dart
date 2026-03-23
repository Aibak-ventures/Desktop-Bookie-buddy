// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductEvent {

 int get serviceId;
/// Create a copy of ProductEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductEventCopyWith<ProductEvent> get copyWith => _$ProductEventCopyWithImpl<ProductEvent>(this as ProductEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductEvent&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId));
}


@override
int get hashCode => Object.hash(runtimeType,serviceId);

@override
String toString() {
  return 'ProductEvent(serviceId: $serviceId)';
}


}

/// @nodoc
abstract mixin class $ProductEventCopyWith<$Res>  {
  factory $ProductEventCopyWith(ProductEvent value, $Res Function(ProductEvent) _then) = _$ProductEventCopyWithImpl;
@useResult
$Res call({
 int serviceId
});




}
/// @nodoc
class _$ProductEventCopyWithImpl<$Res>
    implements $ProductEventCopyWith<$Res> {
  _$ProductEventCopyWithImpl(this._self, this._then);

  final ProductEvent _self;
  final $Res Function(ProductEvent) _then;

/// Create a copy of ProductEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? serviceId = null,}) {
  return _then(_self.copyWith(
serviceId: null == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductEvent].
extension ProductEventPatterns on ProductEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _LoadProducts value)?  loadProducts,TResult Function( _LoadNextPageProducts value)?  loadNextPageProducts,TResult Function( _SearchProducts value)?  searchProducts,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoadProducts() when loadProducts != null:
return loadProducts(_that);case _LoadNextPageProducts() when loadNextPageProducts != null:
return loadNextPageProducts(_that);case _SearchProducts() when searchProducts != null:
return searchProducts(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _LoadProducts value)  loadProducts,required TResult Function( _LoadNextPageProducts value)  loadNextPageProducts,required TResult Function( _SearchProducts value)  searchProducts,}){
final _that = this;
switch (_that) {
case _LoadProducts():
return loadProducts(_that);case _LoadNextPageProducts():
return loadNextPageProducts(_that);case _SearchProducts():
return searchProducts(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _LoadProducts value)?  loadProducts,TResult? Function( _LoadNextPageProducts value)?  loadNextPageProducts,TResult? Function( _SearchProducts value)?  searchProducts,}){
final _that = this;
switch (_that) {
case _LoadProducts() when loadProducts != null:
return loadProducts(_that);case _LoadNextPageProducts() when loadNextPageProducts != null:
return loadNextPageProducts(_that);case _SearchProducts() when searchProducts != null:
return searchProducts(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int serviceId)?  loadProducts,TResult Function( int serviceId)?  loadNextPageProducts,TResult Function( int serviceId,  String? query,  String? type,  int? startPrice,  int? endPrice)?  searchProducts,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoadProducts() when loadProducts != null:
return loadProducts(_that.serviceId);case _LoadNextPageProducts() when loadNextPageProducts != null:
return loadNextPageProducts(_that.serviceId);case _SearchProducts() when searchProducts != null:
return searchProducts(_that.serviceId,_that.query,_that.type,_that.startPrice,_that.endPrice);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int serviceId)  loadProducts,required TResult Function( int serviceId)  loadNextPageProducts,required TResult Function( int serviceId,  String? query,  String? type,  int? startPrice,  int? endPrice)  searchProducts,}) {final _that = this;
switch (_that) {
case _LoadProducts():
return loadProducts(_that.serviceId);case _LoadNextPageProducts():
return loadNextPageProducts(_that.serviceId);case _SearchProducts():
return searchProducts(_that.serviceId,_that.query,_that.type,_that.startPrice,_that.endPrice);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int serviceId)?  loadProducts,TResult? Function( int serviceId)?  loadNextPageProducts,TResult? Function( int serviceId,  String? query,  String? type,  int? startPrice,  int? endPrice)?  searchProducts,}) {final _that = this;
switch (_that) {
case _LoadProducts() when loadProducts != null:
return loadProducts(_that.serviceId);case _LoadNextPageProducts() when loadNextPageProducts != null:
return loadNextPageProducts(_that.serviceId);case _SearchProducts() when searchProducts != null:
return searchProducts(_that.serviceId,_that.query,_that.type,_that.startPrice,_that.endPrice);case _:
  return null;

}
}

}

/// @nodoc


class _LoadProducts implements ProductEvent {
  const _LoadProducts(this.serviceId);
  

@override final  int serviceId;

/// Create a copy of ProductEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadProductsCopyWith<_LoadProducts> get copyWith => __$LoadProductsCopyWithImpl<_LoadProducts>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadProducts&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId));
}


@override
int get hashCode => Object.hash(runtimeType,serviceId);

@override
String toString() {
  return 'ProductEvent.loadProducts(serviceId: $serviceId)';
}


}

/// @nodoc
abstract mixin class _$LoadProductsCopyWith<$Res> implements $ProductEventCopyWith<$Res> {
  factory _$LoadProductsCopyWith(_LoadProducts value, $Res Function(_LoadProducts) _then) = __$LoadProductsCopyWithImpl;
@override @useResult
$Res call({
 int serviceId
});




}
/// @nodoc
class __$LoadProductsCopyWithImpl<$Res>
    implements _$LoadProductsCopyWith<$Res> {
  __$LoadProductsCopyWithImpl(this._self, this._then);

  final _LoadProducts _self;
  final $Res Function(_LoadProducts) _then;

/// Create a copy of ProductEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? serviceId = null,}) {
  return _then(_LoadProducts(
null == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _LoadNextPageProducts implements ProductEvent {
  const _LoadNextPageProducts(this.serviceId);
  

@override final  int serviceId;

/// Create a copy of ProductEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadNextPageProductsCopyWith<_LoadNextPageProducts> get copyWith => __$LoadNextPageProductsCopyWithImpl<_LoadNextPageProducts>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadNextPageProducts&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId));
}


@override
int get hashCode => Object.hash(runtimeType,serviceId);

@override
String toString() {
  return 'ProductEvent.loadNextPageProducts(serviceId: $serviceId)';
}


}

/// @nodoc
abstract mixin class _$LoadNextPageProductsCopyWith<$Res> implements $ProductEventCopyWith<$Res> {
  factory _$LoadNextPageProductsCopyWith(_LoadNextPageProducts value, $Res Function(_LoadNextPageProducts) _then) = __$LoadNextPageProductsCopyWithImpl;
@override @useResult
$Res call({
 int serviceId
});




}
/// @nodoc
class __$LoadNextPageProductsCopyWithImpl<$Res>
    implements _$LoadNextPageProductsCopyWith<$Res> {
  __$LoadNextPageProductsCopyWithImpl(this._self, this._then);

  final _LoadNextPageProducts _self;
  final $Res Function(_LoadNextPageProducts) _then;

/// Create a copy of ProductEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? serviceId = null,}) {
  return _then(_LoadNextPageProducts(
null == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _SearchProducts implements ProductEvent {
  const _SearchProducts({required this.serviceId, this.query, this.type = 'name', this.startPrice, this.endPrice});
  

@override final  int serviceId;
 final  String? query;
@JsonKey() final  String? type;
 final  int? startPrice;
 final  int? endPrice;

/// Create a copy of ProductEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchProductsCopyWith<_SearchProducts> get copyWith => __$SearchProductsCopyWithImpl<_SearchProducts>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchProducts&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.query, query) || other.query == query)&&(identical(other.type, type) || other.type == type)&&(identical(other.startPrice, startPrice) || other.startPrice == startPrice)&&(identical(other.endPrice, endPrice) || other.endPrice == endPrice));
}


@override
int get hashCode => Object.hash(runtimeType,serviceId,query,type,startPrice,endPrice);

@override
String toString() {
  return 'ProductEvent.searchProducts(serviceId: $serviceId, query: $query, type: $type, startPrice: $startPrice, endPrice: $endPrice)';
}


}

/// @nodoc
abstract mixin class _$SearchProductsCopyWith<$Res> implements $ProductEventCopyWith<$Res> {
  factory _$SearchProductsCopyWith(_SearchProducts value, $Res Function(_SearchProducts) _then) = __$SearchProductsCopyWithImpl;
@override @useResult
$Res call({
 int serviceId, String? query, String? type, int? startPrice, int? endPrice
});




}
/// @nodoc
class __$SearchProductsCopyWithImpl<$Res>
    implements _$SearchProductsCopyWith<$Res> {
  __$SearchProductsCopyWithImpl(this._self, this._then);

  final _SearchProducts _self;
  final $Res Function(_SearchProducts) _then;

/// Create a copy of ProductEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? serviceId = null,Object? query = freezed,Object? type = freezed,Object? startPrice = freezed,Object? endPrice = freezed,}) {
  return _then(_SearchProducts(
serviceId: null == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as int,query: freezed == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,startPrice: freezed == startPrice ? _self.startPrice : startPrice // ignore: cast_nullable_to_non_nullable
as int?,endPrice: freezed == endPrice ? _self.endPrice : endPrice // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
mixin _$ProductState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductState()';
}


}

/// @nodoc
class $ProductStateCopyWith<$Res>  {
$ProductStateCopyWith(ProductState _, $Res Function(ProductState) __);
}


/// Adds pattern-matching-related methods to [ProductState].
extension ProductStatePatterns on ProductState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Loaded value)?  loaded,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Loaded value)  loaded,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Loaded():
return loaded(_that);case _Error():
return error(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Loaded value)?  loaded,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<ProductModel> products,  String? nextPageUrl,  bool isPaginating,  bool isSearching,  String? searchQuery,  String? searchType,  int? startPrice,  int? endPrice)?  loaded,TResult Function( String error)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.products,_that.nextPageUrl,_that.isPaginating,_that.isSearching,_that.searchQuery,_that.searchType,_that.startPrice,_that.endPrice);case _Error() when error != null:
return error(_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<ProductModel> products,  String? nextPageUrl,  bool isPaginating,  bool isSearching,  String? searchQuery,  String? searchType,  int? startPrice,  int? endPrice)  loaded,required TResult Function( String error)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Loaded():
return loaded(_that.products,_that.nextPageUrl,_that.isPaginating,_that.isSearching,_that.searchQuery,_that.searchType,_that.startPrice,_that.endPrice);case _Error():
return error(_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<ProductModel> products,  String? nextPageUrl,  bool isPaginating,  bool isSearching,  String? searchQuery,  String? searchType,  int? startPrice,  int? endPrice)?  loaded,TResult? Function( String error)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.products,_that.nextPageUrl,_that.isPaginating,_that.isSearching,_that.searchQuery,_that.searchType,_that.startPrice,_that.endPrice);case _Error() when error != null:
return error(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements ProductState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductState.initial()';
}


}




/// @nodoc


class _Loading implements ProductState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductState.loading()';
}


}




/// @nodoc


class _Loaded implements ProductState {
  const _Loaded({required final  List<ProductModel> products, required this.nextPageUrl, this.isPaginating = false, this.isSearching = false, this.searchQuery, this.searchType, this.startPrice, this.endPrice}): _products = products;
  

 final  List<ProductModel> _products;
 List<ProductModel> get products {
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_products);
}

 final  String? nextPageUrl;
@JsonKey() final  bool isPaginating;
@JsonKey() final  bool isSearching;
 final  String? searchQuery;
 final  String? searchType;
 final  int? startPrice;
 final  int? endPrice;

/// Create a copy of ProductState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&const DeepCollectionEquality().equals(other._products, _products)&&(identical(other.nextPageUrl, nextPageUrl) || other.nextPageUrl == nextPageUrl)&&(identical(other.isPaginating, isPaginating) || other.isPaginating == isPaginating)&&(identical(other.isSearching, isSearching) || other.isSearching == isSearching)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.searchType, searchType) || other.searchType == searchType)&&(identical(other.startPrice, startPrice) || other.startPrice == startPrice)&&(identical(other.endPrice, endPrice) || other.endPrice == endPrice));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_products),nextPageUrl,isPaginating,isSearching,searchQuery,searchType,startPrice,endPrice);

@override
String toString() {
  return 'ProductState.loaded(products: $products, nextPageUrl: $nextPageUrl, isPaginating: $isPaginating, isSearching: $isSearching, searchQuery: $searchQuery, searchType: $searchType, startPrice: $startPrice, endPrice: $endPrice)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $ProductStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 List<ProductModel> products, String? nextPageUrl, bool isPaginating, bool isSearching, String? searchQuery, String? searchType, int? startPrice, int? endPrice
});




}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of ProductState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? products = null,Object? nextPageUrl = freezed,Object? isPaginating = null,Object? isSearching = null,Object? searchQuery = freezed,Object? searchType = freezed,Object? startPrice = freezed,Object? endPrice = freezed,}) {
  return _then(_Loaded(
products: null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<ProductModel>,nextPageUrl: freezed == nextPageUrl ? _self.nextPageUrl : nextPageUrl // ignore: cast_nullable_to_non_nullable
as String?,isPaginating: null == isPaginating ? _self.isPaginating : isPaginating // ignore: cast_nullable_to_non_nullable
as bool,isSearching: null == isSearching ? _self.isSearching : isSearching // ignore: cast_nullable_to_non_nullable
as bool,searchQuery: freezed == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String?,searchType: freezed == searchType ? _self.searchType : searchType // ignore: cast_nullable_to_non_nullable
as String?,startPrice: freezed == startPrice ? _self.startPrice : startPrice // ignore: cast_nullable_to_non_nullable
as int?,endPrice: freezed == endPrice ? _self.endPrice : endPrice // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class _Error implements ProductState {
  const _Error(this.error);
  

 final  String error;

/// Create a copy of ProductState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'ProductState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $ProductStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of ProductState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(_Error(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
