// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pagination_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PaginationModel<T> {

 List<T> get data; String? get nextPageUrl; String? get previousPageUrl; int get totalData; int get pageSize; int get currentPage; int get totalPages; int get startIndex; int get endIndex;
/// Create a copy of PaginationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaginationModelCopyWith<T, PaginationModel<T>> get copyWith => _$PaginationModelCopyWithImpl<T, PaginationModel<T>>(this as PaginationModel<T>, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaginationModel<T>&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.nextPageUrl, nextPageUrl) || other.nextPageUrl == nextPageUrl)&&(identical(other.previousPageUrl, previousPageUrl) || other.previousPageUrl == previousPageUrl)&&(identical(other.totalData, totalData) || other.totalData == totalData)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.startIndex, startIndex) || other.startIndex == startIndex)&&(identical(other.endIndex, endIndex) || other.endIndex == endIndex));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data),nextPageUrl,previousPageUrl,totalData,pageSize,currentPage,totalPages,startIndex,endIndex);

@override
String toString() {
  return 'PaginationModel<$T>(data: $data, nextPageUrl: $nextPageUrl, previousPageUrl: $previousPageUrl, totalData: $totalData, pageSize: $pageSize, currentPage: $currentPage, totalPages: $totalPages, startIndex: $startIndex, endIndex: $endIndex)';
}


}

/// @nodoc
abstract mixin class $PaginationModelCopyWith<T,$Res>  {
  factory $PaginationModelCopyWith(PaginationModel<T> value, $Res Function(PaginationModel<T>) _then) = _$PaginationModelCopyWithImpl;
@useResult
$Res call({
 List<T> data, String? nextPageUrl, String? previousPageUrl, int totalData, int pageSize, int currentPage, int totalPages, int startIndex, int endIndex
});




}
/// @nodoc
class _$PaginationModelCopyWithImpl<T,$Res>
    implements $PaginationModelCopyWith<T, $Res> {
  _$PaginationModelCopyWithImpl(this._self, this._then);

  final PaginationModel<T> _self;
  final $Res Function(PaginationModel<T>) _then;

/// Create a copy of PaginationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,Object? nextPageUrl = freezed,Object? previousPageUrl = freezed,Object? totalData = null,Object? pageSize = null,Object? currentPage = null,Object? totalPages = null,Object? startIndex = null,Object? endIndex = null,}) {
  return _then(_self.copyWith(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as List<T>,nextPageUrl: freezed == nextPageUrl ? _self.nextPageUrl : nextPageUrl // ignore: cast_nullable_to_non_nullable
as String?,previousPageUrl: freezed == previousPageUrl ? _self.previousPageUrl : previousPageUrl // ignore: cast_nullable_to_non_nullable
as String?,totalData: null == totalData ? _self.totalData : totalData // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,startIndex: null == startIndex ? _self.startIndex : startIndex // ignore: cast_nullable_to_non_nullable
as int,endIndex: null == endIndex ? _self.endIndex : endIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PaginationModel].
extension PaginationModelPatterns<T> on PaginationModel<T> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaginationModel<T> value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaginationModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaginationModel<T> value)  $default,){
final _that = this;
switch (_that) {
case _PaginationModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaginationModel<T> value)?  $default,){
final _that = this;
switch (_that) {
case _PaginationModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<T> data,  String? nextPageUrl,  String? previousPageUrl,  int totalData,  int pageSize,  int currentPage,  int totalPages,  int startIndex,  int endIndex)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaginationModel() when $default != null:
return $default(_that.data,_that.nextPageUrl,_that.previousPageUrl,_that.totalData,_that.pageSize,_that.currentPage,_that.totalPages,_that.startIndex,_that.endIndex);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<T> data,  String? nextPageUrl,  String? previousPageUrl,  int totalData,  int pageSize,  int currentPage,  int totalPages,  int startIndex,  int endIndex)  $default,) {final _that = this;
switch (_that) {
case _PaginationModel():
return $default(_that.data,_that.nextPageUrl,_that.previousPageUrl,_that.totalData,_that.pageSize,_that.currentPage,_that.totalPages,_that.startIndex,_that.endIndex);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<T> data,  String? nextPageUrl,  String? previousPageUrl,  int totalData,  int pageSize,  int currentPage,  int totalPages,  int startIndex,  int endIndex)?  $default,) {final _that = this;
switch (_that) {
case _PaginationModel() when $default != null:
return $default(_that.data,_that.nextPageUrl,_that.previousPageUrl,_that.totalData,_that.pageSize,_that.currentPage,_that.totalPages,_that.startIndex,_that.endIndex);case _:
  return null;

}
}

}

/// @nodoc


class _PaginationModel<T> implements PaginationModel<T> {
  const _PaginationModel({required final  List<T> data, this.nextPageUrl, this.previousPageUrl, this.totalData = 0, this.pageSize = 0, this.currentPage = 1, this.totalPages = 0, this.startIndex = 0, this.endIndex = 0}): _data = data;
  

 final  List<T> _data;
@override List<T> get data {
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_data);
}

@override final  String? nextPageUrl;
@override final  String? previousPageUrl;
@override@JsonKey() final  int totalData;
@override@JsonKey() final  int pageSize;
@override@JsonKey() final  int currentPage;
@override@JsonKey() final  int totalPages;
@override@JsonKey() final  int startIndex;
@override@JsonKey() final  int endIndex;

/// Create a copy of PaginationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaginationModelCopyWith<T, _PaginationModel<T>> get copyWith => __$PaginationModelCopyWithImpl<T, _PaginationModel<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaginationModel<T>&&const DeepCollectionEquality().equals(other._data, _data)&&(identical(other.nextPageUrl, nextPageUrl) || other.nextPageUrl == nextPageUrl)&&(identical(other.previousPageUrl, previousPageUrl) || other.previousPageUrl == previousPageUrl)&&(identical(other.totalData, totalData) || other.totalData == totalData)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.startIndex, startIndex) || other.startIndex == startIndex)&&(identical(other.endIndex, endIndex) || other.endIndex == endIndex));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_data),nextPageUrl,previousPageUrl,totalData,pageSize,currentPage,totalPages,startIndex,endIndex);

@override
String toString() {
  return 'PaginationModel<$T>(data: $data, nextPageUrl: $nextPageUrl, previousPageUrl: $previousPageUrl, totalData: $totalData, pageSize: $pageSize, currentPage: $currentPage, totalPages: $totalPages, startIndex: $startIndex, endIndex: $endIndex)';
}


}

/// @nodoc
abstract mixin class _$PaginationModelCopyWith<T,$Res> implements $PaginationModelCopyWith<T, $Res> {
  factory _$PaginationModelCopyWith(_PaginationModel<T> value, $Res Function(_PaginationModel<T>) _then) = __$PaginationModelCopyWithImpl;
@override @useResult
$Res call({
 List<T> data, String? nextPageUrl, String? previousPageUrl, int totalData, int pageSize, int currentPage, int totalPages, int startIndex, int endIndex
});




}
/// @nodoc
class __$PaginationModelCopyWithImpl<T,$Res>
    implements _$PaginationModelCopyWith<T, $Res> {
  __$PaginationModelCopyWithImpl(this._self, this._then);

  final _PaginationModel<T> _self;
  final $Res Function(_PaginationModel<T>) _then;

/// Create a copy of PaginationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,Object? nextPageUrl = freezed,Object? previousPageUrl = freezed,Object? totalData = null,Object? pageSize = null,Object? currentPage = null,Object? totalPages = null,Object? startIndex = null,Object? endIndex = null,}) {
  return _then(_PaginationModel<T>(
data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<T>,nextPageUrl: freezed == nextPageUrl ? _self.nextPageUrl : nextPageUrl // ignore: cast_nullable_to_non_nullable
as String?,previousPageUrl: freezed == previousPageUrl ? _self.previousPageUrl : previousPageUrl // ignore: cast_nullable_to_non_nullable
as String?,totalData: null == totalData ? _self.totalData : totalData // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,startIndex: null == startIndex ? _self.startIndex : startIndex // ignore: cast_nullable_to_non_nullable
as int,endIndex: null == endIndex ? _self.endIndex : endIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
