// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shop_list_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ShopListEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShopListEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ShopListEvent()';
}


}

/// @nodoc
class $ShopListEventCopyWith<$Res>  {
$ShopListEventCopyWith(ShopListEvent _, $Res Function(ShopListEvent) __);
}


/// Adds pattern-matching-related methods to [ShopListEvent].
extension ShopListEventPatterns on ShopListEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _LoadShops value)?  loadShops,TResult Function( _ChangeAccount value)?  changeAccount,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoadShops() when loadShops != null:
return loadShops(_that);case _ChangeAccount() when changeAccount != null:
return changeAccount(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _LoadShops value)  loadShops,required TResult Function( _ChangeAccount value)  changeAccount,}){
final _that = this;
switch (_that) {
case _LoadShops():
return loadShops(_that);case _ChangeAccount():
return changeAccount(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _LoadShops value)?  loadShops,TResult? Function( _ChangeAccount value)?  changeAccount,}){
final _that = this;
switch (_that) {
case _LoadShops() when loadShops != null:
return loadShops(_that);case _ChangeAccount() when changeAccount != null:
return changeAccount(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadShops,TResult Function( ShopEntity newShop)?  changeAccount,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoadShops() when loadShops != null:
return loadShops();case _ChangeAccount() when changeAccount != null:
return changeAccount(_that.newShop);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadShops,required TResult Function( ShopEntity newShop)  changeAccount,}) {final _that = this;
switch (_that) {
case _LoadShops():
return loadShops();case _ChangeAccount():
return changeAccount(_that.newShop);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadShops,TResult? Function( ShopEntity newShop)?  changeAccount,}) {final _that = this;
switch (_that) {
case _LoadShops() when loadShops != null:
return loadShops();case _ChangeAccount() when changeAccount != null:
return changeAccount(_that.newShop);case _:
  return null;

}
}

}

/// @nodoc


class _LoadShops implements ShopListEvent {
  const _LoadShops();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadShops);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ShopListEvent.loadShops()';
}


}




/// @nodoc


class _ChangeAccount implements ShopListEvent {
  const _ChangeAccount(this.newShop);
  

 final  ShopEntity newShop;

/// Create a copy of ShopListEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChangeAccountCopyWith<_ChangeAccount> get copyWith => __$ChangeAccountCopyWithImpl<_ChangeAccount>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChangeAccount&&(identical(other.newShop, newShop) || other.newShop == newShop));
}


@override
int get hashCode => Object.hash(runtimeType,newShop);

@override
String toString() {
  return 'ShopListEvent.changeAccount(newShop: $newShop)';
}


}

/// @nodoc
abstract mixin class _$ChangeAccountCopyWith<$Res> implements $ShopListEventCopyWith<$Res> {
  factory _$ChangeAccountCopyWith(_ChangeAccount value, $Res Function(_ChangeAccount) _then) = __$ChangeAccountCopyWithImpl;
@useResult
$Res call({
 ShopEntity newShop
});


$ShopEntityCopyWith<$Res> get newShop;

}
/// @nodoc
class __$ChangeAccountCopyWithImpl<$Res>
    implements _$ChangeAccountCopyWith<$Res> {
  __$ChangeAccountCopyWithImpl(this._self, this._then);

  final _ChangeAccount _self;
  final $Res Function(_ChangeAccount) _then;

/// Create a copy of ShopListEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? newShop = null,}) {
  return _then(_ChangeAccount(
null == newShop ? _self.newShop : newShop // ignore: cast_nullable_to_non_nullable
as ShopEntity,
  ));
}

/// Create a copy of ShopListEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShopEntityCopyWith<$Res> get newShop {
  
  return $ShopEntityCopyWith<$Res>(_self.newShop, (value) {
    return _then(_self.copyWith(newShop: value));
  });
}
}

/// @nodoc
mixin _$ShopListState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShopListState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ShopListState()';
}


}

/// @nodoc
class $ShopListStateCopyWith<$Res>  {
$ShopListStateCopyWith(ShopListState _, $Res Function(ShopListState) __);
}


/// Adds pattern-matching-related methods to [ShopListState].
extension ShopListStatePatterns on ShopListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Loading value)?  loading,TResult Function( _Loaded value)?  loaded,TResult Function( _ChangeSuccess value)?  changeSuccess,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _ChangeSuccess() when changeSuccess != null:
return changeSuccess(_that);case _Error() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Loading value)  loading,required TResult Function( _Loaded value)  loaded,required TResult Function( _ChangeSuccess value)  changeSuccess,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Loading():
return loading(_that);case _Loaded():
return loaded(_that);case _ChangeSuccess():
return changeSuccess(_that);case _Error():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Loading value)?  loading,TResult? Function( _Loaded value)?  loaded,TResult? Function( _ChangeSuccess value)?  changeSuccess,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _ChangeSuccess() when changeSuccess != null:
return changeSuccess(_that);case _Error() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( List<ShopEntity> shops,  int? currentShopId)?  loaded,TResult Function( ShopEntity newShop)?  changeSuccess,TResult Function( String error)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.shops,_that.currentShopId);case _ChangeSuccess() when changeSuccess != null:
return changeSuccess(_that.newShop);case _Error() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( List<ShopEntity> shops,  int? currentShopId)  loaded,required TResult Function( ShopEntity newShop)  changeSuccess,required TResult Function( String error)  error,}) {final _that = this;
switch (_that) {
case _Loading():
return loading();case _Loaded():
return loaded(_that.shops,_that.currentShopId);case _ChangeSuccess():
return changeSuccess(_that.newShop);case _Error():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( List<ShopEntity> shops,  int? currentShopId)?  loaded,TResult? Function( ShopEntity newShop)?  changeSuccess,TResult? Function( String error)?  error,}) {final _that = this;
switch (_that) {
case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.shops,_that.currentShopId);case _ChangeSuccess() when changeSuccess != null:
return changeSuccess(_that.newShop);case _Error() when error != null:
return error(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _Loading implements ShopListState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ShopListState.loading()';
}


}




/// @nodoc


class _Loaded implements ShopListState {
  const _Loaded({required final  List<ShopEntity> shops, required this.currentShopId}): _shops = shops;
  

 final  List<ShopEntity> _shops;
 List<ShopEntity> get shops {
  if (_shops is EqualUnmodifiableListView) return _shops;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_shops);
}

 final  int? currentShopId;

/// Create a copy of ShopListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&const DeepCollectionEquality().equals(other._shops, _shops)&&(identical(other.currentShopId, currentShopId) || other.currentShopId == currentShopId));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_shops),currentShopId);

@override
String toString() {
  return 'ShopListState.loaded(shops: $shops, currentShopId: $currentShopId)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $ShopListStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 List<ShopEntity> shops, int? currentShopId
});




}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of ShopListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? shops = null,Object? currentShopId = freezed,}) {
  return _then(_Loaded(
shops: null == shops ? _self._shops : shops // ignore: cast_nullable_to_non_nullable
as List<ShopEntity>,currentShopId: freezed == currentShopId ? _self.currentShopId : currentShopId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class _ChangeSuccess implements ShopListState {
  const _ChangeSuccess(this.newShop);
  

 final  ShopEntity newShop;

/// Create a copy of ShopListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChangeSuccessCopyWith<_ChangeSuccess> get copyWith => __$ChangeSuccessCopyWithImpl<_ChangeSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChangeSuccess&&(identical(other.newShop, newShop) || other.newShop == newShop));
}


@override
int get hashCode => Object.hash(runtimeType,newShop);

@override
String toString() {
  return 'ShopListState.changeSuccess(newShop: $newShop)';
}


}

/// @nodoc
abstract mixin class _$ChangeSuccessCopyWith<$Res> implements $ShopListStateCopyWith<$Res> {
  factory _$ChangeSuccessCopyWith(_ChangeSuccess value, $Res Function(_ChangeSuccess) _then) = __$ChangeSuccessCopyWithImpl;
@useResult
$Res call({
 ShopEntity newShop
});


$ShopEntityCopyWith<$Res> get newShop;

}
/// @nodoc
class __$ChangeSuccessCopyWithImpl<$Res>
    implements _$ChangeSuccessCopyWith<$Res> {
  __$ChangeSuccessCopyWithImpl(this._self, this._then);

  final _ChangeSuccess _self;
  final $Res Function(_ChangeSuccess) _then;

/// Create a copy of ShopListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? newShop = null,}) {
  return _then(_ChangeSuccess(
null == newShop ? _self.newShop : newShop // ignore: cast_nullable_to_non_nullable
as ShopEntity,
  ));
}

/// Create a copy of ShopListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShopEntityCopyWith<$Res> get newShop {
  
  return $ShopEntityCopyWith<$Res>(_self.newShop, (value) {
    return _then(_self.copyWith(newShop: value));
  });
}
}

/// @nodoc


class _Error implements ShopListState {
  const _Error(this.error);
  

 final  String error;

/// Create a copy of ShopListState
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
  return 'ShopListState.error(error: $error)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $ShopListStateCopyWith<$Res> {
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

/// Create a copy of ShopListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(_Error(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
