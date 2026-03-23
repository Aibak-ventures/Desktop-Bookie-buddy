// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'select_product_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SelectProductEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectProductEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SelectProductEvent()';
}


}

/// @nodoc
class $SelectProductEventCopyWith<$Res>  {
$SelectProductEventCopyWith(SelectProductEvent _, $Res Function(SelectProductEvent) __);
}


/// Adds pattern-matching-related methods to [SelectProductEvent].
extension SelectProductEventPatterns on SelectProductEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _LoadProducts value)?  loadProducts,TResult Function( _LoadNextPageProducts value)?  loadNextPageProducts,TResult Function( _SearchProducts value)?  searchProducts,TResult Function( _LoadNextSearchResults value)?  loadNextSearchResults,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoadProducts() when loadProducts != null:
return loadProducts(_that);case _LoadNextPageProducts() when loadNextPageProducts != null:
return loadNextPageProducts(_that);case _SearchProducts() when searchProducts != null:
return searchProducts(_that);case _LoadNextSearchResults() when loadNextSearchResults != null:
return loadNextSearchResults(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _LoadProducts value)  loadProducts,required TResult Function( _LoadNextPageProducts value)  loadNextPageProducts,required TResult Function( _SearchProducts value)  searchProducts,required TResult Function( _LoadNextSearchResults value)  loadNextSearchResults,}){
final _that = this;
switch (_that) {
case _LoadProducts():
return loadProducts(_that);case _LoadNextPageProducts():
return loadNextPageProducts(_that);case _SearchProducts():
return searchProducts(_that);case _LoadNextSearchResults():
return loadNextSearchResults(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _LoadProducts value)?  loadProducts,TResult? Function( _LoadNextPageProducts value)?  loadNextPageProducts,TResult? Function( _SearchProducts value)?  searchProducts,TResult? Function( _LoadNextSearchResults value)?  loadNextSearchResults,}){
final _that = this;
switch (_that) {
case _LoadProducts() when loadProducts != null:
return loadProducts(_that);case _LoadNextPageProducts() when loadNextPageProducts != null:
return loadNextPageProducts(_that);case _SearchProducts() when searchProducts != null:
return searchProducts(_that);case _LoadNextSearchResults() when loadNextSearchResults != null:
return loadNextSearchResults(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int? serviceId,  String pickupDate,  String returnDate,  TimeOfDay? pickupTime,  TimeOfDay? returnTime,  bool useAvailableProductsApi,  bool isSales,  int? bookingId,  List<int>? variantIds)?  loadProducts,TResult Function()?  loadNextPageProducts,TResult Function( int? serviceId,  String pickupDate,  String returnDate,  String? query,  String? type,  int? startPrice,  int? endPrice,  TimeOfDay? pickupTime,  TimeOfDay? returnTime,  bool useAvailableProductsApi,  bool isSales,  int? bookingId,  List<int>? variantIds)?  searchProducts,TResult Function()?  loadNextSearchResults,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoadProducts() when loadProducts != null:
return loadProducts(_that.serviceId,_that.pickupDate,_that.returnDate,_that.pickupTime,_that.returnTime,_that.useAvailableProductsApi,_that.isSales,_that.bookingId,_that.variantIds);case _LoadNextPageProducts() when loadNextPageProducts != null:
return loadNextPageProducts();case _SearchProducts() when searchProducts != null:
return searchProducts(_that.serviceId,_that.pickupDate,_that.returnDate,_that.query,_that.type,_that.startPrice,_that.endPrice,_that.pickupTime,_that.returnTime,_that.useAvailableProductsApi,_that.isSales,_that.bookingId,_that.variantIds);case _LoadNextSearchResults() when loadNextSearchResults != null:
return loadNextSearchResults();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int? serviceId,  String pickupDate,  String returnDate,  TimeOfDay? pickupTime,  TimeOfDay? returnTime,  bool useAvailableProductsApi,  bool isSales,  int? bookingId,  List<int>? variantIds)  loadProducts,required TResult Function()  loadNextPageProducts,required TResult Function( int? serviceId,  String pickupDate,  String returnDate,  String? query,  String? type,  int? startPrice,  int? endPrice,  TimeOfDay? pickupTime,  TimeOfDay? returnTime,  bool useAvailableProductsApi,  bool isSales,  int? bookingId,  List<int>? variantIds)  searchProducts,required TResult Function()  loadNextSearchResults,}) {final _that = this;
switch (_that) {
case _LoadProducts():
return loadProducts(_that.serviceId,_that.pickupDate,_that.returnDate,_that.pickupTime,_that.returnTime,_that.useAvailableProductsApi,_that.isSales,_that.bookingId,_that.variantIds);case _LoadNextPageProducts():
return loadNextPageProducts();case _SearchProducts():
return searchProducts(_that.serviceId,_that.pickupDate,_that.returnDate,_that.query,_that.type,_that.startPrice,_that.endPrice,_that.pickupTime,_that.returnTime,_that.useAvailableProductsApi,_that.isSales,_that.bookingId,_that.variantIds);case _LoadNextSearchResults():
return loadNextSearchResults();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int? serviceId,  String pickupDate,  String returnDate,  TimeOfDay? pickupTime,  TimeOfDay? returnTime,  bool useAvailableProductsApi,  bool isSales,  int? bookingId,  List<int>? variantIds)?  loadProducts,TResult? Function()?  loadNextPageProducts,TResult? Function( int? serviceId,  String pickupDate,  String returnDate,  String? query,  String? type,  int? startPrice,  int? endPrice,  TimeOfDay? pickupTime,  TimeOfDay? returnTime,  bool useAvailableProductsApi,  bool isSales,  int? bookingId,  List<int>? variantIds)?  searchProducts,TResult? Function()?  loadNextSearchResults,}) {final _that = this;
switch (_that) {
case _LoadProducts() when loadProducts != null:
return loadProducts(_that.serviceId,_that.pickupDate,_that.returnDate,_that.pickupTime,_that.returnTime,_that.useAvailableProductsApi,_that.isSales,_that.bookingId,_that.variantIds);case _LoadNextPageProducts() when loadNextPageProducts != null:
return loadNextPageProducts();case _SearchProducts() when searchProducts != null:
return searchProducts(_that.serviceId,_that.pickupDate,_that.returnDate,_that.query,_that.type,_that.startPrice,_that.endPrice,_that.pickupTime,_that.returnTime,_that.useAvailableProductsApi,_that.isSales,_that.bookingId,_that.variantIds);case _LoadNextSearchResults() when loadNextSearchResults != null:
return loadNextSearchResults();case _:
  return null;

}
}

}

/// @nodoc


class _LoadProducts implements SelectProductEvent {
  const _LoadProducts({this.serviceId, required this.pickupDate, required this.returnDate, this.pickupTime, this.returnTime, this.useAvailableProductsApi = true, this.isSales = false, this.bookingId, final  List<int>? variantIds}): _variantIds = variantIds;
  

 final  int? serviceId;
 final  String pickupDate;
 final  String returnDate;
 final  TimeOfDay? pickupTime;
 final  TimeOfDay? returnTime;
@JsonKey() final  bool useAvailableProductsApi;
@JsonKey() final  bool isSales;
 final  int? bookingId;
// For edit mode - to check availability excluding current booking
 final  List<int>? _variantIds;
// For edit mode - to check availability excluding current booking
 List<int>? get variantIds {
  final value = _variantIds;
  if (value == null) return null;
  if (_variantIds is EqualUnmodifiableListView) return _variantIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of SelectProductEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadProductsCopyWith<_LoadProducts> get copyWith => __$LoadProductsCopyWithImpl<_LoadProducts>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadProducts&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.pickupDate, pickupDate) || other.pickupDate == pickupDate)&&(identical(other.returnDate, returnDate) || other.returnDate == returnDate)&&(identical(other.pickupTime, pickupTime) || other.pickupTime == pickupTime)&&(identical(other.returnTime, returnTime) || other.returnTime == returnTime)&&(identical(other.useAvailableProductsApi, useAvailableProductsApi) || other.useAvailableProductsApi == useAvailableProductsApi)&&(identical(other.isSales, isSales) || other.isSales == isSales)&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId)&&const DeepCollectionEquality().equals(other._variantIds, _variantIds));
}


@override
int get hashCode => Object.hash(runtimeType,serviceId,pickupDate,returnDate,pickupTime,returnTime,useAvailableProductsApi,isSales,bookingId,const DeepCollectionEquality().hash(_variantIds));

@override
String toString() {
  return 'SelectProductEvent.loadProducts(serviceId: $serviceId, pickupDate: $pickupDate, returnDate: $returnDate, pickupTime: $pickupTime, returnTime: $returnTime, useAvailableProductsApi: $useAvailableProductsApi, isSales: $isSales, bookingId: $bookingId, variantIds: $variantIds)';
}


}

/// @nodoc
abstract mixin class _$LoadProductsCopyWith<$Res> implements $SelectProductEventCopyWith<$Res> {
  factory _$LoadProductsCopyWith(_LoadProducts value, $Res Function(_LoadProducts) _then) = __$LoadProductsCopyWithImpl;
@useResult
$Res call({
 int? serviceId, String pickupDate, String returnDate, TimeOfDay? pickupTime, TimeOfDay? returnTime, bool useAvailableProductsApi, bool isSales, int? bookingId, List<int>? variantIds
});




}
/// @nodoc
class __$LoadProductsCopyWithImpl<$Res>
    implements _$LoadProductsCopyWith<$Res> {
  __$LoadProductsCopyWithImpl(this._self, this._then);

  final _LoadProducts _self;
  final $Res Function(_LoadProducts) _then;

/// Create a copy of SelectProductEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? serviceId = freezed,Object? pickupDate = null,Object? returnDate = null,Object? pickupTime = freezed,Object? returnTime = freezed,Object? useAvailableProductsApi = null,Object? isSales = null,Object? bookingId = freezed,Object? variantIds = freezed,}) {
  return _then(_LoadProducts(
serviceId: freezed == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as int?,pickupDate: null == pickupDate ? _self.pickupDate : pickupDate // ignore: cast_nullable_to_non_nullable
as String,returnDate: null == returnDate ? _self.returnDate : returnDate // ignore: cast_nullable_to_non_nullable
as String,pickupTime: freezed == pickupTime ? _self.pickupTime : pickupTime // ignore: cast_nullable_to_non_nullable
as TimeOfDay?,returnTime: freezed == returnTime ? _self.returnTime : returnTime // ignore: cast_nullable_to_non_nullable
as TimeOfDay?,useAvailableProductsApi: null == useAvailableProductsApi ? _self.useAvailableProductsApi : useAvailableProductsApi // ignore: cast_nullable_to_non_nullable
as bool,isSales: null == isSales ? _self.isSales : isSales // ignore: cast_nullable_to_non_nullable
as bool,bookingId: freezed == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as int?,variantIds: freezed == variantIds ? _self._variantIds : variantIds // ignore: cast_nullable_to_non_nullable
as List<int>?,
  ));
}


}

/// @nodoc


class _LoadNextPageProducts implements SelectProductEvent {
  const _LoadNextPageProducts();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadNextPageProducts);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SelectProductEvent.loadNextPageProducts()';
}


}




/// @nodoc


class _SearchProducts implements SelectProductEvent {
  const _SearchProducts({this.serviceId, required this.pickupDate, required this.returnDate, this.query, this.type = 'name', this.startPrice, this.endPrice, this.pickupTime, this.returnTime, this.useAvailableProductsApi = true, this.isSales = false, this.bookingId, final  List<int>? variantIds}): _variantIds = variantIds;
  

 final  int? serviceId;
 final  String pickupDate;
 final  String returnDate;
 final  String? query;
@JsonKey() final  String? type;
 final  int? startPrice;
 final  int? endPrice;
 final  TimeOfDay? pickupTime;
 final  TimeOfDay? returnTime;
@JsonKey() final  bool useAvailableProductsApi;
@JsonKey() final  bool isSales;
 final  int? bookingId;
// For edit mode
 final  List<int>? _variantIds;
// For edit mode
 List<int>? get variantIds {
  final value = _variantIds;
  if (value == null) return null;
  if (_variantIds is EqualUnmodifiableListView) return _variantIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of SelectProductEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchProductsCopyWith<_SearchProducts> get copyWith => __$SearchProductsCopyWithImpl<_SearchProducts>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchProducts&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.pickupDate, pickupDate) || other.pickupDate == pickupDate)&&(identical(other.returnDate, returnDate) || other.returnDate == returnDate)&&(identical(other.query, query) || other.query == query)&&(identical(other.type, type) || other.type == type)&&(identical(other.startPrice, startPrice) || other.startPrice == startPrice)&&(identical(other.endPrice, endPrice) || other.endPrice == endPrice)&&(identical(other.pickupTime, pickupTime) || other.pickupTime == pickupTime)&&(identical(other.returnTime, returnTime) || other.returnTime == returnTime)&&(identical(other.useAvailableProductsApi, useAvailableProductsApi) || other.useAvailableProductsApi == useAvailableProductsApi)&&(identical(other.isSales, isSales) || other.isSales == isSales)&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId)&&const DeepCollectionEquality().equals(other._variantIds, _variantIds));
}


@override
int get hashCode => Object.hash(runtimeType,serviceId,pickupDate,returnDate,query,type,startPrice,endPrice,pickupTime,returnTime,useAvailableProductsApi,isSales,bookingId,const DeepCollectionEquality().hash(_variantIds));

@override
String toString() {
  return 'SelectProductEvent.searchProducts(serviceId: $serviceId, pickupDate: $pickupDate, returnDate: $returnDate, query: $query, type: $type, startPrice: $startPrice, endPrice: $endPrice, pickupTime: $pickupTime, returnTime: $returnTime, useAvailableProductsApi: $useAvailableProductsApi, isSales: $isSales, bookingId: $bookingId, variantIds: $variantIds)';
}


}

/// @nodoc
abstract mixin class _$SearchProductsCopyWith<$Res> implements $SelectProductEventCopyWith<$Res> {
  factory _$SearchProductsCopyWith(_SearchProducts value, $Res Function(_SearchProducts) _then) = __$SearchProductsCopyWithImpl;
@useResult
$Res call({
 int? serviceId, String pickupDate, String returnDate, String? query, String? type, int? startPrice, int? endPrice, TimeOfDay? pickupTime, TimeOfDay? returnTime, bool useAvailableProductsApi, bool isSales, int? bookingId, List<int>? variantIds
});




}
/// @nodoc
class __$SearchProductsCopyWithImpl<$Res>
    implements _$SearchProductsCopyWith<$Res> {
  __$SearchProductsCopyWithImpl(this._self, this._then);

  final _SearchProducts _self;
  final $Res Function(_SearchProducts) _then;

/// Create a copy of SelectProductEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? serviceId = freezed,Object? pickupDate = null,Object? returnDate = null,Object? query = freezed,Object? type = freezed,Object? startPrice = freezed,Object? endPrice = freezed,Object? pickupTime = freezed,Object? returnTime = freezed,Object? useAvailableProductsApi = null,Object? isSales = null,Object? bookingId = freezed,Object? variantIds = freezed,}) {
  return _then(_SearchProducts(
serviceId: freezed == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as int?,pickupDate: null == pickupDate ? _self.pickupDate : pickupDate // ignore: cast_nullable_to_non_nullable
as String,returnDate: null == returnDate ? _self.returnDate : returnDate // ignore: cast_nullable_to_non_nullable
as String,query: freezed == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,startPrice: freezed == startPrice ? _self.startPrice : startPrice // ignore: cast_nullable_to_non_nullable
as int?,endPrice: freezed == endPrice ? _self.endPrice : endPrice // ignore: cast_nullable_to_non_nullable
as int?,pickupTime: freezed == pickupTime ? _self.pickupTime : pickupTime // ignore: cast_nullable_to_non_nullable
as TimeOfDay?,returnTime: freezed == returnTime ? _self.returnTime : returnTime // ignore: cast_nullable_to_non_nullable
as TimeOfDay?,useAvailableProductsApi: null == useAvailableProductsApi ? _self.useAvailableProductsApi : useAvailableProductsApi // ignore: cast_nullable_to_non_nullable
as bool,isSales: null == isSales ? _self.isSales : isSales // ignore: cast_nullable_to_non_nullable
as bool,bookingId: freezed == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as int?,variantIds: freezed == variantIds ? _self._variantIds : variantIds // ignore: cast_nullable_to_non_nullable
as List<int>?,
  ));
}


}

/// @nodoc


class _LoadNextSearchResults implements SelectProductEvent {
  const _LoadNextSearchResults();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadNextSearchResults);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SelectProductEvent.loadNextSearchResults()';
}


}




/// @nodoc
mixin _$SelectProductState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectProductState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SelectProductState()';
}


}

/// @nodoc
class $SelectProductStateCopyWith<$Res>  {
$SelectProductStateCopyWith(SelectProductState _, $Res Function(SelectProductState) __);
}


/// Adds pattern-matching-related methods to [SelectProductState].
extension SelectProductStatePatterns on SelectProductState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Loading value)?  loading,TResult Function( _Loaded value)?  loaded,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Loading() when loading != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Loading value)  loading,required TResult Function( _Loaded value)  loaded,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Loading():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Loading value)?  loading,TResult? Function( _Loaded value)?  loaded,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Loading() when loading != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( List<ProductModel> products,  String? nextPageUrl,  int? serviceId,  String pickupDate,  String returnDate,  bool isPaginating,  bool isSearching,  String? searchQuery,  String? searchType,  int? startPrice,  int? endPrice,  TimeOfDay? pickupTime,  TimeOfDay? returnTime,  bool useAvailableProductsApi,  bool isSales)?  loaded,TResult Function( String error)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.products,_that.nextPageUrl,_that.serviceId,_that.pickupDate,_that.returnDate,_that.isPaginating,_that.isSearching,_that.searchQuery,_that.searchType,_that.startPrice,_that.endPrice,_that.pickupTime,_that.returnTime,_that.useAvailableProductsApi,_that.isSales);case _Error() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( List<ProductModel> products,  String? nextPageUrl,  int? serviceId,  String pickupDate,  String returnDate,  bool isPaginating,  bool isSearching,  String? searchQuery,  String? searchType,  int? startPrice,  int? endPrice,  TimeOfDay? pickupTime,  TimeOfDay? returnTime,  bool useAvailableProductsApi,  bool isSales)  loaded,required TResult Function( String error)  error,}) {final _that = this;
switch (_that) {
case _Loading():
return loading();case _Loaded():
return loaded(_that.products,_that.nextPageUrl,_that.serviceId,_that.pickupDate,_that.returnDate,_that.isPaginating,_that.isSearching,_that.searchQuery,_that.searchType,_that.startPrice,_that.endPrice,_that.pickupTime,_that.returnTime,_that.useAvailableProductsApi,_that.isSales);case _Error():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( List<ProductModel> products,  String? nextPageUrl,  int? serviceId,  String pickupDate,  String returnDate,  bool isPaginating,  bool isSearching,  String? searchQuery,  String? searchType,  int? startPrice,  int? endPrice,  TimeOfDay? pickupTime,  TimeOfDay? returnTime,  bool useAvailableProductsApi,  bool isSales)?  loaded,TResult? Function( String error)?  error,}) {final _that = this;
switch (_that) {
case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.products,_that.nextPageUrl,_that.serviceId,_that.pickupDate,_that.returnDate,_that.isPaginating,_that.isSearching,_that.searchQuery,_that.searchType,_that.startPrice,_that.endPrice,_that.pickupTime,_that.returnTime,_that.useAvailableProductsApi,_that.isSales);case _Error() when error != null:
return error(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _Loading implements SelectProductState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SelectProductState.loading()';
}


}




/// @nodoc


class _Loaded implements SelectProductState {
  const _Loaded({required final  List<ProductModel> products, required this.nextPageUrl, this.serviceId, required this.pickupDate, required this.returnDate, this.isPaginating = false, this.isSearching = false, this.searchQuery, this.searchType, this.startPrice, this.endPrice, this.pickupTime, this.returnTime, this.useAvailableProductsApi = true, this.isSales = false}): _products = products;
  

 final  List<ProductModel> _products;
 List<ProductModel> get products {
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_products);
}

 final  String? nextPageUrl;
 final  int? serviceId;
 final  String pickupDate;
 final  String returnDate;
@JsonKey() final  bool isPaginating;
@JsonKey() final  bool isSearching;
 final  String? searchQuery;
 final  String? searchType;
 final  int? startPrice;
 final  int? endPrice;
 final  TimeOfDay? pickupTime;
 final  TimeOfDay? returnTime;
@JsonKey() final  bool useAvailableProductsApi;
@JsonKey() final  bool isSales;

/// Create a copy of SelectProductState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&const DeepCollectionEquality().equals(other._products, _products)&&(identical(other.nextPageUrl, nextPageUrl) || other.nextPageUrl == nextPageUrl)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.pickupDate, pickupDate) || other.pickupDate == pickupDate)&&(identical(other.returnDate, returnDate) || other.returnDate == returnDate)&&(identical(other.isPaginating, isPaginating) || other.isPaginating == isPaginating)&&(identical(other.isSearching, isSearching) || other.isSearching == isSearching)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.searchType, searchType) || other.searchType == searchType)&&(identical(other.startPrice, startPrice) || other.startPrice == startPrice)&&(identical(other.endPrice, endPrice) || other.endPrice == endPrice)&&(identical(other.pickupTime, pickupTime) || other.pickupTime == pickupTime)&&(identical(other.returnTime, returnTime) || other.returnTime == returnTime)&&(identical(other.useAvailableProductsApi, useAvailableProductsApi) || other.useAvailableProductsApi == useAvailableProductsApi)&&(identical(other.isSales, isSales) || other.isSales == isSales));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_products),nextPageUrl,serviceId,pickupDate,returnDate,isPaginating,isSearching,searchQuery,searchType,startPrice,endPrice,pickupTime,returnTime,useAvailableProductsApi,isSales);

@override
String toString() {
  return 'SelectProductState.loaded(products: $products, nextPageUrl: $nextPageUrl, serviceId: $serviceId, pickupDate: $pickupDate, returnDate: $returnDate, isPaginating: $isPaginating, isSearching: $isSearching, searchQuery: $searchQuery, searchType: $searchType, startPrice: $startPrice, endPrice: $endPrice, pickupTime: $pickupTime, returnTime: $returnTime, useAvailableProductsApi: $useAvailableProductsApi, isSales: $isSales)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $SelectProductStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 List<ProductModel> products, String? nextPageUrl, int? serviceId, String pickupDate, String returnDate, bool isPaginating, bool isSearching, String? searchQuery, String? searchType, int? startPrice, int? endPrice, TimeOfDay? pickupTime, TimeOfDay? returnTime, bool useAvailableProductsApi, bool isSales
});




}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of SelectProductState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? products = null,Object? nextPageUrl = freezed,Object? serviceId = freezed,Object? pickupDate = null,Object? returnDate = null,Object? isPaginating = null,Object? isSearching = null,Object? searchQuery = freezed,Object? searchType = freezed,Object? startPrice = freezed,Object? endPrice = freezed,Object? pickupTime = freezed,Object? returnTime = freezed,Object? useAvailableProductsApi = null,Object? isSales = null,}) {
  return _then(_Loaded(
products: null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<ProductModel>,nextPageUrl: freezed == nextPageUrl ? _self.nextPageUrl : nextPageUrl // ignore: cast_nullable_to_non_nullable
as String?,serviceId: freezed == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as int?,pickupDate: null == pickupDate ? _self.pickupDate : pickupDate // ignore: cast_nullable_to_non_nullable
as String,returnDate: null == returnDate ? _self.returnDate : returnDate // ignore: cast_nullable_to_non_nullable
as String,isPaginating: null == isPaginating ? _self.isPaginating : isPaginating // ignore: cast_nullable_to_non_nullable
as bool,isSearching: null == isSearching ? _self.isSearching : isSearching // ignore: cast_nullable_to_non_nullable
as bool,searchQuery: freezed == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String?,searchType: freezed == searchType ? _self.searchType : searchType // ignore: cast_nullable_to_non_nullable
as String?,startPrice: freezed == startPrice ? _self.startPrice : startPrice // ignore: cast_nullable_to_non_nullable
as int?,endPrice: freezed == endPrice ? _self.endPrice : endPrice // ignore: cast_nullable_to_non_nullable
as int?,pickupTime: freezed == pickupTime ? _self.pickupTime : pickupTime // ignore: cast_nullable_to_non_nullable
as TimeOfDay?,returnTime: freezed == returnTime ? _self.returnTime : returnTime // ignore: cast_nullable_to_non_nullable
as TimeOfDay?,useAvailableProductsApi: null == useAvailableProductsApi ? _self.useAvailableProductsApi : useAvailableProductsApi // ignore: cast_nullable_to_non_nullable
as bool,isSales: null == isSales ? _self.isSales : isSales // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _Error implements SelectProductState {
  const _Error(this.error);
  

 final  String error;

/// Create a copy of SelectProductState
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
  return 'SelectProductState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $SelectProductStateCopyWith<$Res> {
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

/// Create a copy of SelectProductState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(_Error(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
