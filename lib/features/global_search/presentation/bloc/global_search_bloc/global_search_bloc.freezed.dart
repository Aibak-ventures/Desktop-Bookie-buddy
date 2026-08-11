// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'global_search_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GlobalSearchEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GlobalSearchEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GlobalSearchEvent()';
}


}

/// @nodoc
class $GlobalSearchEventCopyWith<$Res>  {
$GlobalSearchEventCopyWith(GlobalSearchEvent _, $Res Function(GlobalSearchEvent) __);
}


/// Adds pattern-matching-related methods to [GlobalSearchEvent].
extension GlobalSearchEventPatterns on GlobalSearchEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Search value)?  search,TResult Function( _LoadNextSearchResults value)?  loadNextSearchResults,TResult Function( _Reset value)?  reset,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Search() when search != null:
return search(_that);case _LoadNextSearchResults() when loadNextSearchResults != null:
return loadNextSearchResults(_that);case _Reset() when reset != null:
return reset(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Search value)  search,required TResult Function( _LoadNextSearchResults value)  loadNextSearchResults,required TResult Function( _Reset value)  reset,}){
final _that = this;
switch (_that) {
case _Search():
return search(_that);case _LoadNextSearchResults():
return loadNextSearchResults(_that);case _Reset():
return reset(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Search value)?  search,TResult? Function( _LoadNextSearchResults value)?  loadNextSearchResults,TResult? Function( _Reset value)?  reset,}){
final _that = this;
switch (_that) {
case _Search() when search != null:
return search(_that);case _LoadNextSearchResults() when loadNextSearchResults != null:
return loadNextSearchResults(_that);case _Reset() when reset != null:
return reset(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String query,  String? startDate,  String? endDate)?  search,TResult Function( String query,  String? startDate,  String? endDate)?  loadNextSearchResults,TResult Function()?  reset,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Search() when search != null:
return search(_that.query,_that.startDate,_that.endDate);case _LoadNextSearchResults() when loadNextSearchResults != null:
return loadNextSearchResults(_that.query,_that.startDate,_that.endDate);case _Reset() when reset != null:
return reset();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String query,  String? startDate,  String? endDate)  search,required TResult Function( String query,  String? startDate,  String? endDate)  loadNextSearchResults,required TResult Function()  reset,}) {final _that = this;
switch (_that) {
case _Search():
return search(_that.query,_that.startDate,_that.endDate);case _LoadNextSearchResults():
return loadNextSearchResults(_that.query,_that.startDate,_that.endDate);case _Reset():
return reset();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String query,  String? startDate,  String? endDate)?  search,TResult? Function( String query,  String? startDate,  String? endDate)?  loadNextSearchResults,TResult? Function()?  reset,}) {final _that = this;
switch (_that) {
case _Search() when search != null:
return search(_that.query,_that.startDate,_that.endDate);case _LoadNextSearchResults() when loadNextSearchResults != null:
return loadNextSearchResults(_that.query,_that.startDate,_that.endDate);case _Reset() when reset != null:
return reset();case _:
  return null;

}
}

}

/// @nodoc


class _Search implements GlobalSearchEvent {
  const _Search(this.query, {this.startDate, this.endDate});
  

 final  String query;
 final  String? startDate;
 final  String? endDate;

/// Create a copy of GlobalSearchEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchCopyWith<_Search> get copyWith => __$SearchCopyWithImpl<_Search>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Search&&(identical(other.query, query) || other.query == query)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate));
}


@override
int get hashCode => Object.hash(runtimeType,query,startDate,endDate);

@override
String toString() {
  return 'GlobalSearchEvent.search(query: $query, startDate: $startDate, endDate: $endDate)';
}


}

/// @nodoc
abstract mixin class _$SearchCopyWith<$Res> implements $GlobalSearchEventCopyWith<$Res> {
  factory _$SearchCopyWith(_Search value, $Res Function(_Search) _then) = __$SearchCopyWithImpl;
@useResult
$Res call({
 String query, String? startDate, String? endDate
});




}
/// @nodoc
class __$SearchCopyWithImpl<$Res>
    implements _$SearchCopyWith<$Res> {
  __$SearchCopyWithImpl(this._self, this._then);

  final _Search _self;
  final $Res Function(_Search) _then;

/// Create a copy of GlobalSearchEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,Object? startDate = freezed,Object? endDate = freezed,}) {
  return _then(_Search(
null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _LoadNextSearchResults implements GlobalSearchEvent {
  const _LoadNextSearchResults(this.query, {this.startDate, this.endDate});
  

 final  String query;
 final  String? startDate;
 final  String? endDate;

/// Create a copy of GlobalSearchEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadNextSearchResultsCopyWith<_LoadNextSearchResults> get copyWith => __$LoadNextSearchResultsCopyWithImpl<_LoadNextSearchResults>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadNextSearchResults&&(identical(other.query, query) || other.query == query)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate));
}


@override
int get hashCode => Object.hash(runtimeType,query,startDate,endDate);

@override
String toString() {
  return 'GlobalSearchEvent.loadNextSearchResults(query: $query, startDate: $startDate, endDate: $endDate)';
}


}

/// @nodoc
abstract mixin class _$LoadNextSearchResultsCopyWith<$Res> implements $GlobalSearchEventCopyWith<$Res> {
  factory _$LoadNextSearchResultsCopyWith(_LoadNextSearchResults value, $Res Function(_LoadNextSearchResults) _then) = __$LoadNextSearchResultsCopyWithImpl;
@useResult
$Res call({
 String query, String? startDate, String? endDate
});




}
/// @nodoc
class __$LoadNextSearchResultsCopyWithImpl<$Res>
    implements _$LoadNextSearchResultsCopyWith<$Res> {
  __$LoadNextSearchResultsCopyWithImpl(this._self, this._then);

  final _LoadNextSearchResults _self;
  final $Res Function(_LoadNextSearchResults) _then;

/// Create a copy of GlobalSearchEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,Object? startDate = freezed,Object? endDate = freezed,}) {
  return _then(_LoadNextSearchResults(
null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _Reset implements GlobalSearchEvent {
  const _Reset();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Reset);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GlobalSearchEvent.reset()';
}


}




/// @nodoc
mixin _$GlobalSearchState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GlobalSearchState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GlobalSearchState()';
}


}

/// @nodoc
class $GlobalSearchStateCopyWith<$Res>  {
$GlobalSearchStateCopyWith(GlobalSearchState _, $Res Function(GlobalSearchState) __);
}


/// Adds pattern-matching-related methods to [GlobalSearchState].
extension GlobalSearchStatePatterns on GlobalSearchState {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<GlobalSearchEntity> searchData,  String? nextPageUrl,  bool isPaginating)?  loaded,TResult Function( String error)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.searchData,_that.nextPageUrl,_that.isPaginating);case _Error() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<GlobalSearchEntity> searchData,  String? nextPageUrl,  bool isPaginating)  loaded,required TResult Function( String error)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Loaded():
return loaded(_that.searchData,_that.nextPageUrl,_that.isPaginating);case _Error():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<GlobalSearchEntity> searchData,  String? nextPageUrl,  bool isPaginating)?  loaded,TResult? Function( String error)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.searchData,_that.nextPageUrl,_that.isPaginating);case _Error() when error != null:
return error(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements GlobalSearchState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GlobalSearchState.initial()';
}


}




/// @nodoc


class _Loading implements GlobalSearchState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GlobalSearchState.loading()';
}


}




/// @nodoc


class _Loaded implements GlobalSearchState {
  const _Loaded({required final  List<GlobalSearchEntity> searchData, required this.nextPageUrl, this.isPaginating = false}): _searchData = searchData;
  

 final  List<GlobalSearchEntity> _searchData;
 List<GlobalSearchEntity> get searchData {
  if (_searchData is EqualUnmodifiableListView) return _searchData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_searchData);
}

 final  String? nextPageUrl;
@JsonKey() final  bool isPaginating;

/// Create a copy of GlobalSearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&const DeepCollectionEquality().equals(other._searchData, _searchData)&&(identical(other.nextPageUrl, nextPageUrl) || other.nextPageUrl == nextPageUrl)&&(identical(other.isPaginating, isPaginating) || other.isPaginating == isPaginating));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_searchData),nextPageUrl,isPaginating);

@override
String toString() {
  return 'GlobalSearchState.loaded(searchData: $searchData, nextPageUrl: $nextPageUrl, isPaginating: $isPaginating)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $GlobalSearchStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 List<GlobalSearchEntity> searchData, String? nextPageUrl, bool isPaginating
});




}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of GlobalSearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? searchData = null,Object? nextPageUrl = freezed,Object? isPaginating = null,}) {
  return _then(_Loaded(
searchData: null == searchData ? _self._searchData : searchData // ignore: cast_nullable_to_non_nullable
as List<GlobalSearchEntity>,nextPageUrl: freezed == nextPageUrl ? _self.nextPageUrl : nextPageUrl // ignore: cast_nullable_to_non_nullable
as String?,isPaginating: null == isPaginating ? _self.isPaginating : isPaginating // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _Error implements GlobalSearchState {
  const _Error(this.error);
  

 final  String error;

/// Create a copy of GlobalSearchState
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
  return 'GlobalSearchState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $GlobalSearchStateCopyWith<$Res> {
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

/// Create a copy of GlobalSearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(_Error(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
