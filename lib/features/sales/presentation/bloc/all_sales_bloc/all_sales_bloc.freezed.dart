// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'all_sales_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AllSalesEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AllSalesEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AllSalesEvent()';
}


}

/// @nodoc
class $AllSalesEventCopyWith<$Res>  {
$AllSalesEventCopyWith(AllSalesEvent _, $Res Function(AllSalesEvent) __);
}


/// Adds pattern-matching-related methods to [AllSalesEvent].
extension AllSalesEventPatterns on AllSalesEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _LoadSales value)?  loadSales,TResult Function( _LoadMoreSales value)?  loadMoreSales,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoadSales() when loadSales != null:
return loadSales(_that);case _LoadMoreSales() when loadMoreSales != null:
return loadMoreSales(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _LoadSales value)  loadSales,required TResult Function( _LoadMoreSales value)  loadMoreSales,}){
final _that = this;
switch (_that) {
case _LoadSales():
return loadSales(_that);case _LoadMoreSales():
return loadMoreSales(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _LoadSales value)?  loadSales,TResult? Function( _LoadMoreSales value)?  loadMoreSales,}){
final _that = this;
switch (_that) {
case _LoadSales() when loadSales != null:
return loadSales(_that);case _LoadMoreSales() when loadMoreSales != null:
return loadMoreSales(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int? page,  String? searchQuery,  String? fromDate,  String? toDate)?  loadSales,TResult Function()?  loadMoreSales,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoadSales() when loadSales != null:
return loadSales(_that.page,_that.searchQuery,_that.fromDate,_that.toDate);case _LoadMoreSales() when loadMoreSales != null:
return loadMoreSales();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int? page,  String? searchQuery,  String? fromDate,  String? toDate)  loadSales,required TResult Function()  loadMoreSales,}) {final _that = this;
switch (_that) {
case _LoadSales():
return loadSales(_that.page,_that.searchQuery,_that.fromDate,_that.toDate);case _LoadMoreSales():
return loadMoreSales();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int? page,  String? searchQuery,  String? fromDate,  String? toDate)?  loadSales,TResult? Function()?  loadMoreSales,}) {final _that = this;
switch (_that) {
case _LoadSales() when loadSales != null:
return loadSales(_that.page,_that.searchQuery,_that.fromDate,_that.toDate);case _LoadMoreSales() when loadMoreSales != null:
return loadMoreSales();case _:
  return null;

}
}

}

/// @nodoc


class _LoadSales implements AllSalesEvent {
  const _LoadSales({this.page, this.searchQuery, this.fromDate, this.toDate});
  

 final  int? page;
 final  String? searchQuery;
 final  String? fromDate;
 final  String? toDate;

/// Create a copy of AllSalesEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadSalesCopyWith<_LoadSales> get copyWith => __$LoadSalesCopyWithImpl<_LoadSales>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadSales&&(identical(other.page, page) || other.page == page)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate));
}


@override
int get hashCode => Object.hash(runtimeType,page,searchQuery,fromDate,toDate);

@override
String toString() {
  return 'AllSalesEvent.loadSales(page: $page, searchQuery: $searchQuery, fromDate: $fromDate, toDate: $toDate)';
}


}

/// @nodoc
abstract mixin class _$LoadSalesCopyWith<$Res> implements $AllSalesEventCopyWith<$Res> {
  factory _$LoadSalesCopyWith(_LoadSales value, $Res Function(_LoadSales) _then) = __$LoadSalesCopyWithImpl;
@useResult
$Res call({
 int? page, String? searchQuery, String? fromDate, String? toDate
});




}
/// @nodoc
class __$LoadSalesCopyWithImpl<$Res>
    implements _$LoadSalesCopyWith<$Res> {
  __$LoadSalesCopyWithImpl(this._self, this._then);

  final _LoadSales _self;
  final $Res Function(_LoadSales) _then;

/// Create a copy of AllSalesEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? page = freezed,Object? searchQuery = freezed,Object? fromDate = freezed,Object? toDate = freezed,}) {
  return _then(_LoadSales(
page: freezed == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int?,searchQuery: freezed == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String?,fromDate: freezed == fromDate ? _self.fromDate : fromDate // ignore: cast_nullable_to_non_nullable
as String?,toDate: freezed == toDate ? _self.toDate : toDate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _LoadMoreSales implements AllSalesEvent {
  const _LoadMoreSales();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadMoreSales);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AllSalesEvent.loadMoreSales()';
}


}




/// @nodoc
mixin _$AllSalesState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AllSalesState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AllSalesState()';
}


}

/// @nodoc
class $AllSalesStateCopyWith<$Res>  {
$AllSalesStateCopyWith(AllSalesState _, $Res Function(AllSalesState) __);
}


/// Adds pattern-matching-related methods to [AllSalesState].
extension AllSalesStatePatterns on AllSalesState {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( List<SaleEntity> sales,  String? nextPageUrl,  String? searchQuery,  bool isPaginating,  String? fromDate,  String? toDate)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.sales,_that.nextPageUrl,_that.searchQuery,_that.isPaginating,_that.fromDate,_that.toDate);case _Error() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( List<SaleEntity> sales,  String? nextPageUrl,  String? searchQuery,  bool isPaginating,  String? fromDate,  String? toDate)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _Loading():
return loading();case _Loaded():
return loaded(_that.sales,_that.nextPageUrl,_that.searchQuery,_that.isPaginating,_that.fromDate,_that.toDate);case _Error():
return error(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( List<SaleEntity> sales,  String? nextPageUrl,  String? searchQuery,  bool isPaginating,  String? fromDate,  String? toDate)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.sales,_that.nextPageUrl,_that.searchQuery,_that.isPaginating,_that.fromDate,_that.toDate);case _Error() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Loading implements AllSalesState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AllSalesState.loading()';
}


}




/// @nodoc


class _Loaded implements AllSalesState {
  const _Loaded({required final  List<SaleEntity> sales, this.nextPageUrl, this.searchQuery, this.isPaginating = false, this.fromDate, this.toDate}): _sales = sales;
  

 final  List<SaleEntity> _sales;
 List<SaleEntity> get sales {
  if (_sales is EqualUnmodifiableListView) return _sales;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sales);
}

 final  String? nextPageUrl;
 final  String? searchQuery;
@JsonKey() final  bool isPaginating;
 final  String? fromDate;
 final  String? toDate;

/// Create a copy of AllSalesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&const DeepCollectionEquality().equals(other._sales, _sales)&&(identical(other.nextPageUrl, nextPageUrl) || other.nextPageUrl == nextPageUrl)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.isPaginating, isPaginating) || other.isPaginating == isPaginating)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_sales),nextPageUrl,searchQuery,isPaginating,fromDate,toDate);

@override
String toString() {
  return 'AllSalesState.loaded(sales: $sales, nextPageUrl: $nextPageUrl, searchQuery: $searchQuery, isPaginating: $isPaginating, fromDate: $fromDate, toDate: $toDate)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $AllSalesStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 List<SaleEntity> sales, String? nextPageUrl, String? searchQuery, bool isPaginating, String? fromDate, String? toDate
});




}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of AllSalesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? sales = null,Object? nextPageUrl = freezed,Object? searchQuery = freezed,Object? isPaginating = null,Object? fromDate = freezed,Object? toDate = freezed,}) {
  return _then(_Loaded(
sales: null == sales ? _self._sales : sales // ignore: cast_nullable_to_non_nullable
as List<SaleEntity>,nextPageUrl: freezed == nextPageUrl ? _self.nextPageUrl : nextPageUrl // ignore: cast_nullable_to_non_nullable
as String?,searchQuery: freezed == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String?,isPaginating: null == isPaginating ? _self.isPaginating : isPaginating // ignore: cast_nullable_to_non_nullable
as bool,fromDate: freezed == fromDate ? _self.fromDate : fromDate // ignore: cast_nullable_to_non_nullable
as String?,toDate: freezed == toDate ? _self.toDate : toDate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _Error implements AllSalesState {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of AllSalesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AllSalesState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $AllSalesStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of AllSalesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
