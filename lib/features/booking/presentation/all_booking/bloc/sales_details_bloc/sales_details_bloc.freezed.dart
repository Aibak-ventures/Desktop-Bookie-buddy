// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sales_details_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SalesDetailsEvent {

 int get saleId;
/// Create a copy of SalesDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SalesDetailsEventCopyWith<SalesDetailsEvent> get copyWith => _$SalesDetailsEventCopyWithImpl<SalesDetailsEvent>(this as SalesDetailsEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SalesDetailsEvent&&(identical(other.saleId, saleId) || other.saleId == saleId));
}


@override
int get hashCode => Object.hash(runtimeType,saleId);

@override
String toString() {
  return 'SalesDetailsEvent(saleId: $saleId)';
}


}

/// @nodoc
abstract mixin class $SalesDetailsEventCopyWith<$Res>  {
  factory $SalesDetailsEventCopyWith(SalesDetailsEvent value, $Res Function(SalesDetailsEvent) _then) = _$SalesDetailsEventCopyWithImpl;
@useResult
$Res call({
 int saleId
});




}
/// @nodoc
class _$SalesDetailsEventCopyWithImpl<$Res>
    implements $SalesDetailsEventCopyWith<$Res> {
  _$SalesDetailsEventCopyWithImpl(this._self, this._then);

  final SalesDetailsEvent _self;
  final $Res Function(SalesDetailsEvent) _then;

/// Create a copy of SalesDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? saleId = null,}) {
  return _then(_self.copyWith(
saleId: null == saleId ? _self.saleId : saleId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SalesDetailsEvent].
extension SalesDetailsEventPatterns on SalesDetailsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _FetchSaleDetails value)?  fetchSaleDetails,TResult Function( _DeleteSale value)?  deleteSale,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FetchSaleDetails() when fetchSaleDetails != null:
return fetchSaleDetails(_that);case _DeleteSale() when deleteSale != null:
return deleteSale(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _FetchSaleDetails value)  fetchSaleDetails,required TResult Function( _DeleteSale value)  deleteSale,}){
final _that = this;
switch (_that) {
case _FetchSaleDetails():
return fetchSaleDetails(_that);case _DeleteSale():
return deleteSale(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _FetchSaleDetails value)?  fetchSaleDetails,TResult? Function( _DeleteSale value)?  deleteSale,}){
final _that = this;
switch (_that) {
case _FetchSaleDetails() when fetchSaleDetails != null:
return fetchSaleDetails(_that);case _DeleteSale() when deleteSale != null:
return deleteSale(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int saleId)?  fetchSaleDetails,TResult Function( int saleId)?  deleteSale,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FetchSaleDetails() when fetchSaleDetails != null:
return fetchSaleDetails(_that.saleId);case _DeleteSale() when deleteSale != null:
return deleteSale(_that.saleId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int saleId)  fetchSaleDetails,required TResult Function( int saleId)  deleteSale,}) {final _that = this;
switch (_that) {
case _FetchSaleDetails():
return fetchSaleDetails(_that.saleId);case _DeleteSale():
return deleteSale(_that.saleId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int saleId)?  fetchSaleDetails,TResult? Function( int saleId)?  deleteSale,}) {final _that = this;
switch (_that) {
case _FetchSaleDetails() when fetchSaleDetails != null:
return fetchSaleDetails(_that.saleId);case _DeleteSale() when deleteSale != null:
return deleteSale(_that.saleId);case _:
  return null;

}
}

}

/// @nodoc


class _FetchSaleDetails implements SalesDetailsEvent {
  const _FetchSaleDetails(this.saleId);
  

@override final  int saleId;

/// Create a copy of SalesDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FetchSaleDetailsCopyWith<_FetchSaleDetails> get copyWith => __$FetchSaleDetailsCopyWithImpl<_FetchSaleDetails>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FetchSaleDetails&&(identical(other.saleId, saleId) || other.saleId == saleId));
}


@override
int get hashCode => Object.hash(runtimeType,saleId);

@override
String toString() {
  return 'SalesDetailsEvent.fetchSaleDetails(saleId: $saleId)';
}


}

/// @nodoc
abstract mixin class _$FetchSaleDetailsCopyWith<$Res> implements $SalesDetailsEventCopyWith<$Res> {
  factory _$FetchSaleDetailsCopyWith(_FetchSaleDetails value, $Res Function(_FetchSaleDetails) _then) = __$FetchSaleDetailsCopyWithImpl;
@override @useResult
$Res call({
 int saleId
});




}
/// @nodoc
class __$FetchSaleDetailsCopyWithImpl<$Res>
    implements _$FetchSaleDetailsCopyWith<$Res> {
  __$FetchSaleDetailsCopyWithImpl(this._self, this._then);

  final _FetchSaleDetails _self;
  final $Res Function(_FetchSaleDetails) _then;

/// Create a copy of SalesDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? saleId = null,}) {
  return _then(_FetchSaleDetails(
null == saleId ? _self.saleId : saleId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _DeleteSale implements SalesDetailsEvent {
  const _DeleteSale(this.saleId);
  

@override final  int saleId;

/// Create a copy of SalesDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeleteSaleCopyWith<_DeleteSale> get copyWith => __$DeleteSaleCopyWithImpl<_DeleteSale>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeleteSale&&(identical(other.saleId, saleId) || other.saleId == saleId));
}


@override
int get hashCode => Object.hash(runtimeType,saleId);

@override
String toString() {
  return 'SalesDetailsEvent.deleteSale(saleId: $saleId)';
}


}

/// @nodoc
abstract mixin class _$DeleteSaleCopyWith<$Res> implements $SalesDetailsEventCopyWith<$Res> {
  factory _$DeleteSaleCopyWith(_DeleteSale value, $Res Function(_DeleteSale) _then) = __$DeleteSaleCopyWithImpl;
@override @useResult
$Res call({
 int saleId
});




}
/// @nodoc
class __$DeleteSaleCopyWithImpl<$Res>
    implements _$DeleteSaleCopyWith<$Res> {
  __$DeleteSaleCopyWithImpl(this._self, this._then);

  final _DeleteSale _self;
  final $Res Function(_DeleteSale) _then;

/// Create a copy of SalesDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? saleId = null,}) {
  return _then(_DeleteSale(
null == saleId ? _self.saleId : saleId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$SalesDetailsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SalesDetailsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SalesDetailsState()';
}


}

/// @nodoc
class $SalesDetailsStateCopyWith<$Res>  {
$SalesDetailsStateCopyWith(SalesDetailsState _, $Res Function(SalesDetailsState) __);
}


/// Adds pattern-matching-related methods to [SalesDetailsState].
extension SalesDetailsStatePatterns on SalesDetailsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Loaded value)?  loaded,TResult Function( _Error value)?  error,TResult Function( _Success value)?  success,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
return error(_that);case _Success() when success != null:
return success(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Loaded value)  loaded,required TResult Function( _Error value)  error,required TResult Function( _Success value)  success,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Loaded():
return loaded(_that);case _Error():
return error(_that);case _Success():
return success(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Loaded value)?  loaded,TResult? Function( _Error value)?  error,TResult? Function( _Success value)?  success,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
return error(_that);case _Success() when success != null:
return success(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( SaleDetailsModel sale)?  loaded,TResult Function( String message)?  error,TResult Function( String message,  bool didPop,  bool needRefresh)?  success,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.sale);case _Error() when error != null:
return error(_that.message);case _Success() when success != null:
return success(_that.message,_that.didPop,_that.needRefresh);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( SaleDetailsModel sale)  loaded,required TResult Function( String message)  error,required TResult Function( String message,  bool didPop,  bool needRefresh)  success,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Loaded():
return loaded(_that.sale);case _Error():
return error(_that.message);case _Success():
return success(_that.message,_that.didPop,_that.needRefresh);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( SaleDetailsModel sale)?  loaded,TResult? Function( String message)?  error,TResult? Function( String message,  bool didPop,  bool needRefresh)?  success,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.sale);case _Error() when error != null:
return error(_that.message);case _Success() when success != null:
return success(_that.message,_that.didPop,_that.needRefresh);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements SalesDetailsState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SalesDetailsState.initial()';
}


}




/// @nodoc


class _Loading implements SalesDetailsState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SalesDetailsState.loading()';
}


}




/// @nodoc


class _Loaded implements SalesDetailsState {
  const _Loaded({required this.sale});
  

 final  SaleDetailsModel sale;

/// Create a copy of SalesDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&(identical(other.sale, sale) || other.sale == sale));
}


@override
int get hashCode => Object.hash(runtimeType,sale);

@override
String toString() {
  return 'SalesDetailsState.loaded(sale: $sale)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $SalesDetailsStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 SaleDetailsModel sale
});


$SaleDetailsModelCopyWith<$Res> get sale;

}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of SalesDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? sale = null,}) {
  return _then(_Loaded(
sale: null == sale ? _self.sale : sale // ignore: cast_nullable_to_non_nullable
as SaleDetailsModel,
  ));
}

/// Create a copy of SalesDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SaleDetailsModelCopyWith<$Res> get sale {
  
  return $SaleDetailsModelCopyWith<$Res>(_self.sale, (value) {
    return _then(_self.copyWith(sale: value));
  });
}
}

/// @nodoc


class _Error implements SalesDetailsState {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of SalesDetailsState
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
  return 'SalesDetailsState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $SalesDetailsStateCopyWith<$Res> {
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

/// Create a copy of SalesDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _Success implements SalesDetailsState {
  const _Success({required this.message, this.didPop = false, this.needRefresh = false});
  

 final  String message;
@JsonKey() final  bool didPop;
@JsonKey() final  bool needRefresh;

/// Create a copy of SalesDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuccessCopyWith<_Success> get copyWith => __$SuccessCopyWithImpl<_Success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Success&&(identical(other.message, message) || other.message == message)&&(identical(other.didPop, didPop) || other.didPop == didPop)&&(identical(other.needRefresh, needRefresh) || other.needRefresh == needRefresh));
}


@override
int get hashCode => Object.hash(runtimeType,message,didPop,needRefresh);

@override
String toString() {
  return 'SalesDetailsState.success(message: $message, didPop: $didPop, needRefresh: $needRefresh)';
}


}

/// @nodoc
abstract mixin class _$SuccessCopyWith<$Res> implements $SalesDetailsStateCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) _then) = __$SuccessCopyWithImpl;
@useResult
$Res call({
 String message, bool didPop, bool needRefresh
});




}
/// @nodoc
class __$SuccessCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(this._self, this._then);

  final _Success _self;
  final $Res Function(_Success) _then;

/// Create a copy of SalesDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? didPop = null,Object? needRefresh = null,}) {
  return _then(_Success(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,didPop: null == didPop ? _self.didPop : didPop // ignore: cast_nullable_to_non_nullable
as bool,needRefresh: null == needRefresh ? _self.needRefresh : needRefresh // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
