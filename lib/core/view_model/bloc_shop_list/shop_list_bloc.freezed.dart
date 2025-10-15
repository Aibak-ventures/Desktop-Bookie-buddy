// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shop_list_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ShopListEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadShops,
    required TResult Function(ShopModel newShop) changeAccount,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadShops,
    TResult? Function(ShopModel newShop)? changeAccount,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadShops,
    TResult Function(ShopModel newShop)? changeAccount,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadShops value) loadShops,
    required TResult Function(_ChangeAccount value) changeAccount,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadShops value)? loadShops,
    TResult? Function(_ChangeAccount value)? changeAccount,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadShops value)? loadShops,
    TResult Function(_ChangeAccount value)? changeAccount,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShopListEventCopyWith<$Res> {
  factory $ShopListEventCopyWith(
          ShopListEvent value, $Res Function(ShopListEvent) then) =
      _$ShopListEventCopyWithImpl<$Res, ShopListEvent>;
}

/// @nodoc
class _$ShopListEventCopyWithImpl<$Res, $Val extends ShopListEvent>
    implements $ShopListEventCopyWith<$Res> {
  _$ShopListEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShopListEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadShopsImplCopyWith<$Res> {
  factory _$$LoadShopsImplCopyWith(
          _$LoadShopsImpl value, $Res Function(_$LoadShopsImpl) then) =
      __$$LoadShopsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadShopsImplCopyWithImpl<$Res>
    extends _$ShopListEventCopyWithImpl<$Res, _$LoadShopsImpl>
    implements _$$LoadShopsImplCopyWith<$Res> {
  __$$LoadShopsImplCopyWithImpl(
      _$LoadShopsImpl _value, $Res Function(_$LoadShopsImpl) _then)
      : super(_value, _then);

  /// Create a copy of ShopListEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadShopsImpl implements _LoadShops {
  const _$LoadShopsImpl();

  @override
  String toString() {
    return 'ShopListEvent.loadShops()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadShopsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadShops,
    required TResult Function(ShopModel newShop) changeAccount,
  }) {
    return loadShops();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadShops,
    TResult? Function(ShopModel newShop)? changeAccount,
  }) {
    return loadShops?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadShops,
    TResult Function(ShopModel newShop)? changeAccount,
    required TResult orElse(),
  }) {
    if (loadShops != null) {
      return loadShops();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadShops value) loadShops,
    required TResult Function(_ChangeAccount value) changeAccount,
  }) {
    return loadShops(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadShops value)? loadShops,
    TResult? Function(_ChangeAccount value)? changeAccount,
  }) {
    return loadShops?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadShops value)? loadShops,
    TResult Function(_ChangeAccount value)? changeAccount,
    required TResult orElse(),
  }) {
    if (loadShops != null) {
      return loadShops(this);
    }
    return orElse();
  }
}

abstract class _LoadShops implements ShopListEvent {
  const factory _LoadShops() = _$LoadShopsImpl;
}

/// @nodoc
abstract class _$$ChangeAccountImplCopyWith<$Res> {
  factory _$$ChangeAccountImplCopyWith(
          _$ChangeAccountImpl value, $Res Function(_$ChangeAccountImpl) then) =
      __$$ChangeAccountImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ShopModel newShop});

  $ShopModelCopyWith<$Res> get newShop;
}

/// @nodoc
class __$$ChangeAccountImplCopyWithImpl<$Res>
    extends _$ShopListEventCopyWithImpl<$Res, _$ChangeAccountImpl>
    implements _$$ChangeAccountImplCopyWith<$Res> {
  __$$ChangeAccountImplCopyWithImpl(
      _$ChangeAccountImpl _value, $Res Function(_$ChangeAccountImpl) _then)
      : super(_value, _then);

  /// Create a copy of ShopListEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newShop = null,
  }) {
    return _then(_$ChangeAccountImpl(
      null == newShop
          ? _value.newShop
          : newShop // ignore: cast_nullable_to_non_nullable
              as ShopModel,
    ));
  }

  /// Create a copy of ShopListEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ShopModelCopyWith<$Res> get newShop {
    return $ShopModelCopyWith<$Res>(_value.newShop, (value) {
      return _then(_value.copyWith(newShop: value));
    });
  }
}

/// @nodoc

class _$ChangeAccountImpl implements _ChangeAccount {
  const _$ChangeAccountImpl(this.newShop);

  @override
  final ShopModel newShop;

  @override
  String toString() {
    return 'ShopListEvent.changeAccount(newShop: $newShop)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangeAccountImpl &&
            (identical(other.newShop, newShop) || other.newShop == newShop));
  }

  @override
  int get hashCode => Object.hash(runtimeType, newShop);

  /// Create a copy of ShopListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangeAccountImplCopyWith<_$ChangeAccountImpl> get copyWith =>
      __$$ChangeAccountImplCopyWithImpl<_$ChangeAccountImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadShops,
    required TResult Function(ShopModel newShop) changeAccount,
  }) {
    return changeAccount(newShop);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadShops,
    TResult? Function(ShopModel newShop)? changeAccount,
  }) {
    return changeAccount?.call(newShop);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadShops,
    TResult Function(ShopModel newShop)? changeAccount,
    required TResult orElse(),
  }) {
    if (changeAccount != null) {
      return changeAccount(newShop);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadShops value) loadShops,
    required TResult Function(_ChangeAccount value) changeAccount,
  }) {
    return changeAccount(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadShops value)? loadShops,
    TResult? Function(_ChangeAccount value)? changeAccount,
  }) {
    return changeAccount?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadShops value)? loadShops,
    TResult Function(_ChangeAccount value)? changeAccount,
    required TResult orElse(),
  }) {
    if (changeAccount != null) {
      return changeAccount(this);
    }
    return orElse();
  }
}

abstract class _ChangeAccount implements ShopListEvent {
  const factory _ChangeAccount(final ShopModel newShop) = _$ChangeAccountImpl;

  ShopModel get newShop;

  /// Create a copy of ShopListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChangeAccountImplCopyWith<_$ChangeAccountImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ShopListState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<ShopModel> shops, int? currentShopId) loaded,
    required TResult Function(ShopModel newShop) changeSuccess,
    required TResult Function(String error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<ShopModel> shops, int? currentShopId)? loaded,
    TResult? Function(ShopModel newShop)? changeSuccess,
    TResult? Function(String error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<ShopModel> shops, int? currentShopId)? loaded,
    TResult Function(ShopModel newShop)? changeSuccess,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_ChangeSuccess value) changeSuccess,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_ChangeSuccess value)? changeSuccess,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_ChangeSuccess value)? changeSuccess,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShopListStateCopyWith<$Res> {
  factory $ShopListStateCopyWith(
          ShopListState value, $Res Function(ShopListState) then) =
      _$ShopListStateCopyWithImpl<$Res, ShopListState>;
}

/// @nodoc
class _$ShopListStateCopyWithImpl<$Res, $Val extends ShopListState>
    implements $ShopListStateCopyWith<$Res> {
  _$ShopListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShopListState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$ShopListStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of ShopListState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'ShopListState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<ShopModel> shops, int? currentShopId) loaded,
    required TResult Function(ShopModel newShop) changeSuccess,
    required TResult Function(String error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<ShopModel> shops, int? currentShopId)? loaded,
    TResult? Function(ShopModel newShop)? changeSuccess,
    TResult? Function(String error)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<ShopModel> shops, int? currentShopId)? loaded,
    TResult Function(ShopModel newShop)? changeSuccess,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_ChangeSuccess value) changeSuccess,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_ChangeSuccess value)? changeSuccess,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_ChangeSuccess value)? changeSuccess,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements ShopListState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<ShopModel> shops, int? currentShopId});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$ShopListStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of ShopListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shops = null,
    Object? currentShopId = freezed,
  }) {
    return _then(_$LoadedImpl(
      shops: null == shops
          ? _value._shops
          : shops // ignore: cast_nullable_to_non_nullable
              as List<ShopModel>,
      currentShopId: freezed == currentShopId
          ? _value.currentShopId
          : currentShopId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(
      {required final List<ShopModel> shops, required this.currentShopId})
      : _shops = shops;

  final List<ShopModel> _shops;
  @override
  List<ShopModel> get shops {
    if (_shops is EqualUnmodifiableListView) return _shops;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_shops);
  }

  @override
  final int? currentShopId;

  @override
  String toString() {
    return 'ShopListState.loaded(shops: $shops, currentShopId: $currentShopId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            const DeepCollectionEquality().equals(other._shops, _shops) &&
            (identical(other.currentShopId, currentShopId) ||
                other.currentShopId == currentShopId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_shops), currentShopId);

  /// Create a copy of ShopListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<ShopModel> shops, int? currentShopId) loaded,
    required TResult Function(ShopModel newShop) changeSuccess,
    required TResult Function(String error) error,
  }) {
    return loaded(shops, currentShopId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<ShopModel> shops, int? currentShopId)? loaded,
    TResult? Function(ShopModel newShop)? changeSuccess,
    TResult? Function(String error)? error,
  }) {
    return loaded?.call(shops, currentShopId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<ShopModel> shops, int? currentShopId)? loaded,
    TResult Function(ShopModel newShop)? changeSuccess,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(shops, currentShopId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_ChangeSuccess value) changeSuccess,
    required TResult Function(_Error value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_ChangeSuccess value)? changeSuccess,
    TResult? Function(_Error value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_ChangeSuccess value)? changeSuccess,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements ShopListState {
  const factory _Loaded(
      {required final List<ShopModel> shops,
      required final int? currentShopId}) = _$LoadedImpl;

  List<ShopModel> get shops;
  int? get currentShopId;

  /// Create a copy of ShopListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ChangeSuccessImplCopyWith<$Res> {
  factory _$$ChangeSuccessImplCopyWith(
          _$ChangeSuccessImpl value, $Res Function(_$ChangeSuccessImpl) then) =
      __$$ChangeSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ShopModel newShop});

  $ShopModelCopyWith<$Res> get newShop;
}

/// @nodoc
class __$$ChangeSuccessImplCopyWithImpl<$Res>
    extends _$ShopListStateCopyWithImpl<$Res, _$ChangeSuccessImpl>
    implements _$$ChangeSuccessImplCopyWith<$Res> {
  __$$ChangeSuccessImplCopyWithImpl(
      _$ChangeSuccessImpl _value, $Res Function(_$ChangeSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of ShopListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newShop = null,
  }) {
    return _then(_$ChangeSuccessImpl(
      null == newShop
          ? _value.newShop
          : newShop // ignore: cast_nullable_to_non_nullable
              as ShopModel,
    ));
  }

  /// Create a copy of ShopListState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ShopModelCopyWith<$Res> get newShop {
    return $ShopModelCopyWith<$Res>(_value.newShop, (value) {
      return _then(_value.copyWith(newShop: value));
    });
  }
}

/// @nodoc

class _$ChangeSuccessImpl implements _ChangeSuccess {
  const _$ChangeSuccessImpl(this.newShop);

  @override
  final ShopModel newShop;

  @override
  String toString() {
    return 'ShopListState.changeSuccess(newShop: $newShop)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangeSuccessImpl &&
            (identical(other.newShop, newShop) || other.newShop == newShop));
  }

  @override
  int get hashCode => Object.hash(runtimeType, newShop);

  /// Create a copy of ShopListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangeSuccessImplCopyWith<_$ChangeSuccessImpl> get copyWith =>
      __$$ChangeSuccessImplCopyWithImpl<_$ChangeSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<ShopModel> shops, int? currentShopId) loaded,
    required TResult Function(ShopModel newShop) changeSuccess,
    required TResult Function(String error) error,
  }) {
    return changeSuccess(newShop);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<ShopModel> shops, int? currentShopId)? loaded,
    TResult? Function(ShopModel newShop)? changeSuccess,
    TResult? Function(String error)? error,
  }) {
    return changeSuccess?.call(newShop);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<ShopModel> shops, int? currentShopId)? loaded,
    TResult Function(ShopModel newShop)? changeSuccess,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (changeSuccess != null) {
      return changeSuccess(newShop);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_ChangeSuccess value) changeSuccess,
    required TResult Function(_Error value) error,
  }) {
    return changeSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_ChangeSuccess value)? changeSuccess,
    TResult? Function(_Error value)? error,
  }) {
    return changeSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_ChangeSuccess value)? changeSuccess,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (changeSuccess != null) {
      return changeSuccess(this);
    }
    return orElse();
  }
}

abstract class _ChangeSuccess implements ShopListState {
  const factory _ChangeSuccess(final ShopModel newShop) = _$ChangeSuccessImpl;

  ShopModel get newShop;

  /// Create a copy of ShopListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChangeSuccessImplCopyWith<_$ChangeSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$ShopListStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of ShopListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$ErrorImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'ShopListState.error(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  /// Create a copy of ShopListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<ShopModel> shops, int? currentShopId) loaded,
    required TResult Function(ShopModel newShop) changeSuccess,
    required TResult Function(String error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<ShopModel> shops, int? currentShopId)? loaded,
    TResult? Function(ShopModel newShop)? changeSuccess,
    TResult? Function(String error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<ShopModel> shops, int? currentShopId)? loaded,
    TResult Function(ShopModel newShop)? changeSuccess,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_ChangeSuccess value) changeSuccess,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_ChangeSuccess value)? changeSuccess,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_ChangeSuccess value)? changeSuccess,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements ShopListState {
  const factory _Error(final String error) = _$ErrorImpl;

  String get error;

  /// Create a copy of ShopListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
