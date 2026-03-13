// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DashboardEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UserModel? activeShop, bool useOldState)
        loadDashboardData,
    required TResult Function() loadDashboardNextPageData,
    required TResult Function(
            BookingsModel? updateBooking, bool shouldRefresh, bool isDeleted)
        updateData,
    required TResult Function() loadIfNot,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UserModel? activeShop, bool useOldState)?
        loadDashboardData,
    TResult? Function()? loadDashboardNextPageData,
    TResult? Function(
            BookingsModel? updateBooking, bool shouldRefresh, bool isDeleted)?
        updateData,
    TResult? Function()? loadIfNot,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UserModel? activeShop, bool useOldState)?
        loadDashboardData,
    TResult Function()? loadDashboardNextPageData,
    TResult Function(
            BookingsModel? updateBooking, bool shouldRefresh, bool isDeleted)?
        updateData,
    TResult Function()? loadIfNot,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadDashboardData value) loadDashboardData,
    required TResult Function(_LoadDashboardNextPageData value)
        loadDashboardNextPageData,
    required TResult Function(_UpdateData value) updateData,
    required TResult Function(_LoadIfNot value) loadIfNot,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadDashboardData value)? loadDashboardData,
    TResult? Function(_LoadDashboardNextPageData value)?
        loadDashboardNextPageData,
    TResult? Function(_UpdateData value)? updateData,
    TResult? Function(_LoadIfNot value)? loadIfNot,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadDashboardData value)? loadDashboardData,
    TResult Function(_LoadDashboardNextPageData value)?
        loadDashboardNextPageData,
    TResult Function(_UpdateData value)? updateData,
    TResult Function(_LoadIfNot value)? loadIfNot,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardEventCopyWith<$Res> {
  factory $DashboardEventCopyWith(
          DashboardEvent value, $Res Function(DashboardEvent) then) =
      _$DashboardEventCopyWithImpl<$Res, DashboardEvent>;
}

/// @nodoc
class _$DashboardEventCopyWithImpl<$Res, $Val extends DashboardEvent>
    implements $DashboardEventCopyWith<$Res> {
  _$DashboardEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DashboardEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadDashboardDataImplCopyWith<$Res> {
  factory _$$LoadDashboardDataImplCopyWith(_$LoadDashboardDataImpl value,
          $Res Function(_$LoadDashboardDataImpl) then) =
      __$$LoadDashboardDataImplCopyWithImpl<$Res>;
  @useResult
  $Res call({UserModel? activeShop, bool useOldState});

  $UserModelCopyWith<$Res>? get activeShop;
}

/// @nodoc
class __$$LoadDashboardDataImplCopyWithImpl<$Res>
    extends _$DashboardEventCopyWithImpl<$Res, _$LoadDashboardDataImpl>
    implements _$$LoadDashboardDataImplCopyWith<$Res> {
  __$$LoadDashboardDataImplCopyWithImpl(_$LoadDashboardDataImpl _value,
      $Res Function(_$LoadDashboardDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of DashboardEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activeShop = freezed,
    Object? useOldState = null,
  }) {
    return _then(_$LoadDashboardDataImpl(
      activeShop: freezed == activeShop
          ? _value.activeShop
          : activeShop // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      useOldState: null == useOldState
          ? _value.useOldState
          : useOldState // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  /// Create a copy of DashboardEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res>? get activeShop {
    if (_value.activeShop == null) {
      return null;
    }

    return $UserModelCopyWith<$Res>(_value.activeShop!, (value) {
      return _then(_value.copyWith(activeShop: value));
    });
  }
}

/// @nodoc

class _$LoadDashboardDataImpl implements _LoadDashboardData {
  const _$LoadDashboardDataImpl({this.activeShop, this.useOldState = false});

  @override
  final UserModel? activeShop;
  @override
  @JsonKey()
  final bool useOldState;

  @override
  String toString() {
    return 'DashboardEvent.loadDashboardData(activeShop: $activeShop, useOldState: $useOldState)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadDashboardDataImpl &&
            (identical(other.activeShop, activeShop) ||
                other.activeShop == activeShop) &&
            (identical(other.useOldState, useOldState) ||
                other.useOldState == useOldState));
  }

  @override
  int get hashCode => Object.hash(runtimeType, activeShop, useOldState);

  /// Create a copy of DashboardEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadDashboardDataImplCopyWith<_$LoadDashboardDataImpl> get copyWith =>
      __$$LoadDashboardDataImplCopyWithImpl<_$LoadDashboardDataImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UserModel? activeShop, bool useOldState)
        loadDashboardData,
    required TResult Function() loadDashboardNextPageData,
    required TResult Function(
            BookingsModel? updateBooking, bool shouldRefresh, bool isDeleted)
        updateData,
    required TResult Function() loadIfNot,
  }) {
    return loadDashboardData(activeShop, useOldState);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UserModel? activeShop, bool useOldState)?
        loadDashboardData,
    TResult? Function()? loadDashboardNextPageData,
    TResult? Function(
            BookingsModel? updateBooking, bool shouldRefresh, bool isDeleted)?
        updateData,
    TResult? Function()? loadIfNot,
  }) {
    return loadDashboardData?.call(activeShop, useOldState);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UserModel? activeShop, bool useOldState)?
        loadDashboardData,
    TResult Function()? loadDashboardNextPageData,
    TResult Function(
            BookingsModel? updateBooking, bool shouldRefresh, bool isDeleted)?
        updateData,
    TResult Function()? loadIfNot,
    required TResult orElse(),
  }) {
    if (loadDashboardData != null) {
      return loadDashboardData(activeShop, useOldState);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadDashboardData value) loadDashboardData,
    required TResult Function(_LoadDashboardNextPageData value)
        loadDashboardNextPageData,
    required TResult Function(_UpdateData value) updateData,
    required TResult Function(_LoadIfNot value) loadIfNot,
  }) {
    return loadDashboardData(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadDashboardData value)? loadDashboardData,
    TResult? Function(_LoadDashboardNextPageData value)?
        loadDashboardNextPageData,
    TResult? Function(_UpdateData value)? updateData,
    TResult? Function(_LoadIfNot value)? loadIfNot,
  }) {
    return loadDashboardData?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadDashboardData value)? loadDashboardData,
    TResult Function(_LoadDashboardNextPageData value)?
        loadDashboardNextPageData,
    TResult Function(_UpdateData value)? updateData,
    TResult Function(_LoadIfNot value)? loadIfNot,
    required TResult orElse(),
  }) {
    if (loadDashboardData != null) {
      return loadDashboardData(this);
    }
    return orElse();
  }
}

abstract class _LoadDashboardData implements DashboardEvent {
  const factory _LoadDashboardData(
      {final UserModel? activeShop,
      final bool useOldState}) = _$LoadDashboardDataImpl;

  UserModel? get activeShop;
  bool get useOldState;

  /// Create a copy of DashboardEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadDashboardDataImplCopyWith<_$LoadDashboardDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadDashboardNextPageDataImplCopyWith<$Res> {
  factory _$$LoadDashboardNextPageDataImplCopyWith(
          _$LoadDashboardNextPageDataImpl value,
          $Res Function(_$LoadDashboardNextPageDataImpl) then) =
      __$$LoadDashboardNextPageDataImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadDashboardNextPageDataImplCopyWithImpl<$Res>
    extends _$DashboardEventCopyWithImpl<$Res, _$LoadDashboardNextPageDataImpl>
    implements _$$LoadDashboardNextPageDataImplCopyWith<$Res> {
  __$$LoadDashboardNextPageDataImplCopyWithImpl(
      _$LoadDashboardNextPageDataImpl _value,
      $Res Function(_$LoadDashboardNextPageDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of DashboardEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadDashboardNextPageDataImpl implements _LoadDashboardNextPageData {
  const _$LoadDashboardNextPageDataImpl();

  @override
  String toString() {
    return 'DashboardEvent.loadDashboardNextPageData()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadDashboardNextPageDataImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UserModel? activeShop, bool useOldState)
        loadDashboardData,
    required TResult Function() loadDashboardNextPageData,
    required TResult Function(
            BookingsModel? updateBooking, bool shouldRefresh, bool isDeleted)
        updateData,
    required TResult Function() loadIfNot,
  }) {
    return loadDashboardNextPageData();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UserModel? activeShop, bool useOldState)?
        loadDashboardData,
    TResult? Function()? loadDashboardNextPageData,
    TResult? Function(
            BookingsModel? updateBooking, bool shouldRefresh, bool isDeleted)?
        updateData,
    TResult? Function()? loadIfNot,
  }) {
    return loadDashboardNextPageData?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UserModel? activeShop, bool useOldState)?
        loadDashboardData,
    TResult Function()? loadDashboardNextPageData,
    TResult Function(
            BookingsModel? updateBooking, bool shouldRefresh, bool isDeleted)?
        updateData,
    TResult Function()? loadIfNot,
    required TResult orElse(),
  }) {
    if (loadDashboardNextPageData != null) {
      return loadDashboardNextPageData();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadDashboardData value) loadDashboardData,
    required TResult Function(_LoadDashboardNextPageData value)
        loadDashboardNextPageData,
    required TResult Function(_UpdateData value) updateData,
    required TResult Function(_LoadIfNot value) loadIfNot,
  }) {
    return loadDashboardNextPageData(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadDashboardData value)? loadDashboardData,
    TResult? Function(_LoadDashboardNextPageData value)?
        loadDashboardNextPageData,
    TResult? Function(_UpdateData value)? updateData,
    TResult? Function(_LoadIfNot value)? loadIfNot,
  }) {
    return loadDashboardNextPageData?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadDashboardData value)? loadDashboardData,
    TResult Function(_LoadDashboardNextPageData value)?
        loadDashboardNextPageData,
    TResult Function(_UpdateData value)? updateData,
    TResult Function(_LoadIfNot value)? loadIfNot,
    required TResult orElse(),
  }) {
    if (loadDashboardNextPageData != null) {
      return loadDashboardNextPageData(this);
    }
    return orElse();
  }
}

abstract class _LoadDashboardNextPageData implements DashboardEvent {
  const factory _LoadDashboardNextPageData() = _$LoadDashboardNextPageDataImpl;
}

/// @nodoc
abstract class _$$UpdateDataImplCopyWith<$Res> {
  factory _$$UpdateDataImplCopyWith(
          _$UpdateDataImpl value, $Res Function(_$UpdateDataImpl) then) =
      __$$UpdateDataImplCopyWithImpl<$Res>;
  @useResult
  $Res call({BookingsModel? updateBooking, bool shouldRefresh, bool isDeleted});

  $BookingsModelCopyWith<$Res>? get updateBooking;
}

/// @nodoc
class __$$UpdateDataImplCopyWithImpl<$Res>
    extends _$DashboardEventCopyWithImpl<$Res, _$UpdateDataImpl>
    implements _$$UpdateDataImplCopyWith<$Res> {
  __$$UpdateDataImplCopyWithImpl(
      _$UpdateDataImpl _value, $Res Function(_$UpdateDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of DashboardEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? updateBooking = freezed,
    Object? shouldRefresh = null,
    Object? isDeleted = null,
  }) {
    return _then(_$UpdateDataImpl(
      freezed == updateBooking
          ? _value.updateBooking
          : updateBooking // ignore: cast_nullable_to_non_nullable
              as BookingsModel?,
      shouldRefresh: null == shouldRefresh
          ? _value.shouldRefresh
          : shouldRefresh // ignore: cast_nullable_to_non_nullable
              as bool,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  /// Create a copy of DashboardEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BookingsModelCopyWith<$Res>? get updateBooking {
    if (_value.updateBooking == null) {
      return null;
    }

    return $BookingsModelCopyWith<$Res>(_value.updateBooking!, (value) {
      return _then(_value.copyWith(updateBooking: value));
    });
  }
}

/// @nodoc

class _$UpdateDataImpl implements _UpdateData {
  const _$UpdateDataImpl(this.updateBooking,
      {this.shouldRefresh = false, this.isDeleted = false});

  @override
  final BookingsModel? updateBooking;
  @override
  @JsonKey()
  final bool shouldRefresh;
  @override
  @JsonKey()
  final bool isDeleted;

  @override
  String toString() {
    return 'DashboardEvent.updateData(updateBooking: $updateBooking, shouldRefresh: $shouldRefresh, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateDataImpl &&
            (identical(other.updateBooking, updateBooking) ||
                other.updateBooking == updateBooking) &&
            (identical(other.shouldRefresh, shouldRefresh) ||
                other.shouldRefresh == shouldRefresh) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, updateBooking, shouldRefresh, isDeleted);

  /// Create a copy of DashboardEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateDataImplCopyWith<_$UpdateDataImpl> get copyWith =>
      __$$UpdateDataImplCopyWithImpl<_$UpdateDataImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UserModel? activeShop, bool useOldState)
        loadDashboardData,
    required TResult Function() loadDashboardNextPageData,
    required TResult Function(
            BookingsModel? updateBooking, bool shouldRefresh, bool isDeleted)
        updateData,
    required TResult Function() loadIfNot,
  }) {
    return updateData(updateBooking, shouldRefresh, isDeleted);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UserModel? activeShop, bool useOldState)?
        loadDashboardData,
    TResult? Function()? loadDashboardNextPageData,
    TResult? Function(
            BookingsModel? updateBooking, bool shouldRefresh, bool isDeleted)?
        updateData,
    TResult? Function()? loadIfNot,
  }) {
    return updateData?.call(updateBooking, shouldRefresh, isDeleted);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UserModel? activeShop, bool useOldState)?
        loadDashboardData,
    TResult Function()? loadDashboardNextPageData,
    TResult Function(
            BookingsModel? updateBooking, bool shouldRefresh, bool isDeleted)?
        updateData,
    TResult Function()? loadIfNot,
    required TResult orElse(),
  }) {
    if (updateData != null) {
      return updateData(updateBooking, shouldRefresh, isDeleted);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadDashboardData value) loadDashboardData,
    required TResult Function(_LoadDashboardNextPageData value)
        loadDashboardNextPageData,
    required TResult Function(_UpdateData value) updateData,
    required TResult Function(_LoadIfNot value) loadIfNot,
  }) {
    return updateData(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadDashboardData value)? loadDashboardData,
    TResult? Function(_LoadDashboardNextPageData value)?
        loadDashboardNextPageData,
    TResult? Function(_UpdateData value)? updateData,
    TResult? Function(_LoadIfNot value)? loadIfNot,
  }) {
    return updateData?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadDashboardData value)? loadDashboardData,
    TResult Function(_LoadDashboardNextPageData value)?
        loadDashboardNextPageData,
    TResult Function(_UpdateData value)? updateData,
    TResult Function(_LoadIfNot value)? loadIfNot,
    required TResult orElse(),
  }) {
    if (updateData != null) {
      return updateData(this);
    }
    return orElse();
  }
}

abstract class _UpdateData implements DashboardEvent {
  const factory _UpdateData(final BookingsModel? updateBooking,
      {final bool shouldRefresh, final bool isDeleted}) = _$UpdateDataImpl;

  BookingsModel? get updateBooking;
  bool get shouldRefresh;
  bool get isDeleted;

  /// Create a copy of DashboardEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateDataImplCopyWith<_$UpdateDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadIfNotImplCopyWith<$Res> {
  factory _$$LoadIfNotImplCopyWith(
          _$LoadIfNotImpl value, $Res Function(_$LoadIfNotImpl) then) =
      __$$LoadIfNotImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadIfNotImplCopyWithImpl<$Res>
    extends _$DashboardEventCopyWithImpl<$Res, _$LoadIfNotImpl>
    implements _$$LoadIfNotImplCopyWith<$Res> {
  __$$LoadIfNotImplCopyWithImpl(
      _$LoadIfNotImpl _value, $Res Function(_$LoadIfNotImpl) _then)
      : super(_value, _then);

  /// Create a copy of DashboardEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadIfNotImpl implements _LoadIfNot {
  const _$LoadIfNotImpl();

  @override
  String toString() {
    return 'DashboardEvent.loadIfNot()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadIfNotImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UserModel? activeShop, bool useOldState)
        loadDashboardData,
    required TResult Function() loadDashboardNextPageData,
    required TResult Function(
            BookingsModel? updateBooking, bool shouldRefresh, bool isDeleted)
        updateData,
    required TResult Function() loadIfNot,
  }) {
    return loadIfNot();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UserModel? activeShop, bool useOldState)?
        loadDashboardData,
    TResult? Function()? loadDashboardNextPageData,
    TResult? Function(
            BookingsModel? updateBooking, bool shouldRefresh, bool isDeleted)?
        updateData,
    TResult? Function()? loadIfNot,
  }) {
    return loadIfNot?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UserModel? activeShop, bool useOldState)?
        loadDashboardData,
    TResult Function()? loadDashboardNextPageData,
    TResult Function(
            BookingsModel? updateBooking, bool shouldRefresh, bool isDeleted)?
        updateData,
    TResult Function()? loadIfNot,
    required TResult orElse(),
  }) {
    if (loadIfNot != null) {
      return loadIfNot();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadDashboardData value) loadDashboardData,
    required TResult Function(_LoadDashboardNextPageData value)
        loadDashboardNextPageData,
    required TResult Function(_UpdateData value) updateData,
    required TResult Function(_LoadIfNot value) loadIfNot,
  }) {
    return loadIfNot(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadDashboardData value)? loadDashboardData,
    TResult? Function(_LoadDashboardNextPageData value)?
        loadDashboardNextPageData,
    TResult? Function(_UpdateData value)? updateData,
    TResult? Function(_LoadIfNot value)? loadIfNot,
  }) {
    return loadIfNot?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadDashboardData value)? loadDashboardData,
    TResult Function(_LoadDashboardNextPageData value)?
        loadDashboardNextPageData,
    TResult Function(_UpdateData value)? updateData,
    TResult Function(_LoadIfNot value)? loadIfNot,
    required TResult orElse(),
  }) {
    if (loadIfNot != null) {
      return loadIfNot(this);
    }
    return orElse();
  }
}

abstract class _LoadIfNot implements DashboardEvent {
  const factory _LoadIfNot() = _$LoadIfNotImpl;
}

/// @nodoc
mixin _$DashboardState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            Map<String, List<BookingsModel>> upcomingGrouped,
            Map<String, List<BookingsModel>> returnsGrouped,
            DesktopDashboardCarouselData carouselData,
            String? nextPageUrl,
            int currentPage,
            int totalPages,
            bool isPaginating)
        loaded,
    required TResult Function(String error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
            Map<String, List<BookingsModel>> upcomingGrouped,
            Map<String, List<BookingsModel>> returnsGrouped,
            DesktopDashboardCarouselData carouselData,
            String? nextPageUrl,
            int currentPage,
            int totalPages,
            bool isPaginating)?
        loaded,
    TResult? Function(String error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            Map<String, List<BookingsModel>> upcomingGrouped,
            Map<String, List<BookingsModel>> returnsGrouped,
            DesktopDashboardCarouselData carouselData,
            String? nextPageUrl,
            int currentPage,
            int totalPages,
            bool isPaginating)?
        loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardStateCopyWith<$Res> {
  factory $DashboardStateCopyWith(
          DashboardState value, $Res Function(DashboardState) then) =
      _$DashboardStateCopyWithImpl<$Res, DashboardState>;
}

/// @nodoc
class _$DashboardStateCopyWithImpl<$Res, $Val extends DashboardState>
    implements $DashboardStateCopyWith<$Res> {
  _$DashboardStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DashboardState
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
    extends _$DashboardStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of DashboardState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'DashboardState.loading()';
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
    required TResult Function(
            Map<String, List<BookingsModel>> upcomingGrouped,
            Map<String, List<BookingsModel>> returnsGrouped,
            DesktopDashboardCarouselData carouselData,
            String? nextPageUrl,
            int currentPage,
            int totalPages,
            bool isPaginating)
        loaded,
    required TResult Function(String error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
            Map<String, List<BookingsModel>> upcomingGrouped,
            Map<String, List<BookingsModel>> returnsGrouped,
            DesktopDashboardCarouselData carouselData,
            String? nextPageUrl,
            int currentPage,
            int totalPages,
            bool isPaginating)?
        loaded,
    TResult? Function(String error)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            Map<String, List<BookingsModel>> upcomingGrouped,
            Map<String, List<BookingsModel>> returnsGrouped,
            DesktopDashboardCarouselData carouselData,
            String? nextPageUrl,
            int currentPage,
            int totalPages,
            bool isPaginating)?
        loaded,
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
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements DashboardState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {Map<String, List<BookingsModel>> upcomingGrouped,
      Map<String, List<BookingsModel>> returnsGrouped,
      DesktopDashboardCarouselData carouselData,
      String? nextPageUrl,
      int currentPage,
      int totalPages,
      bool isPaginating});

  $DesktopDashboardCarouselDataCopyWith<$Res> get carouselData;
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$DashboardStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of DashboardState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? upcomingGrouped = null,
    Object? returnsGrouped = null,
    Object? carouselData = null,
    Object? nextPageUrl = freezed,
    Object? currentPage = null,
    Object? totalPages = null,
    Object? isPaginating = null,
  }) {
    return _then(_$LoadedImpl(
      upcomingGrouped: null == upcomingGrouped
          ? _value._upcomingGrouped
          : upcomingGrouped // ignore: cast_nullable_to_non_nullable
              as Map<String, List<BookingsModel>>,
      returnsGrouped: null == returnsGrouped
          ? _value._returnsGrouped
          : returnsGrouped // ignore: cast_nullable_to_non_nullable
              as Map<String, List<BookingsModel>>,
      carouselData: null == carouselData
          ? _value.carouselData
          : carouselData // ignore: cast_nullable_to_non_nullable
              as DesktopDashboardCarouselData,
      nextPageUrl: freezed == nextPageUrl
          ? _value.nextPageUrl
          : nextPageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      isPaginating: null == isPaginating
          ? _value.isPaginating
          : isPaginating // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  /// Create a copy of DashboardState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DesktopDashboardCarouselDataCopyWith<$Res> get carouselData {
    return $DesktopDashboardCarouselDataCopyWith<$Res>(_value.carouselData,
        (value) {
      return _then(_value.copyWith(carouselData: value));
    });
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(
      {required final Map<String, List<BookingsModel>> upcomingGrouped,
      required final Map<String, List<BookingsModel>> returnsGrouped,
      required this.carouselData,
      required this.nextPageUrl,
      required this.currentPage,
      required this.totalPages,
      this.isPaginating = false})
      : _upcomingGrouped = upcomingGrouped,
        _returnsGrouped = returnsGrouped;

  final Map<String, List<BookingsModel>> _upcomingGrouped;
  @override
  Map<String, List<BookingsModel>> get upcomingGrouped {
    if (_upcomingGrouped is EqualUnmodifiableMapView) return _upcomingGrouped;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_upcomingGrouped);
  }

  final Map<String, List<BookingsModel>> _returnsGrouped;
  @override
  Map<String, List<BookingsModel>> get returnsGrouped {
    if (_returnsGrouped is EqualUnmodifiableMapView) return _returnsGrouped;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_returnsGrouped);
  }

  @override
  final DesktopDashboardCarouselData carouselData;
  @override
  final String? nextPageUrl;
  @override
  final int currentPage;
  @override
  final int totalPages;
  @override
  @JsonKey()
  final bool isPaginating;

  @override
  String toString() {
    return 'DashboardState.loaded(upcomingGrouped: $upcomingGrouped, returnsGrouped: $returnsGrouped, carouselData: $carouselData, nextPageUrl: $nextPageUrl, currentPage: $currentPage, totalPages: $totalPages, isPaginating: $isPaginating)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            const DeepCollectionEquality()
                .equals(other._upcomingGrouped, _upcomingGrouped) &&
            const DeepCollectionEquality()
                .equals(other._returnsGrouped, _returnsGrouped) &&
            (identical(other.carouselData, carouselData) ||
                other.carouselData == carouselData) &&
            (identical(other.nextPageUrl, nextPageUrl) ||
                other.nextPageUrl == nextPageUrl) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            (identical(other.isPaginating, isPaginating) ||
                other.isPaginating == isPaginating));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_upcomingGrouped),
      const DeepCollectionEquality().hash(_returnsGrouped),
      carouselData,
      nextPageUrl,
      currentPage,
      totalPages,
      isPaginating);

  /// Create a copy of DashboardState
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
    required TResult Function(
            Map<String, List<BookingsModel>> upcomingGrouped,
            Map<String, List<BookingsModel>> returnsGrouped,
            DesktopDashboardCarouselData carouselData,
            String? nextPageUrl,
            int currentPage,
            int totalPages,
            bool isPaginating)
        loaded,
    required TResult Function(String error) error,
  }) {
    return loaded(upcomingGrouped, returnsGrouped, carouselData, nextPageUrl,
        currentPage, totalPages, isPaginating);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
            Map<String, List<BookingsModel>> upcomingGrouped,
            Map<String, List<BookingsModel>> returnsGrouped,
            DesktopDashboardCarouselData carouselData,
            String? nextPageUrl,
            int currentPage,
            int totalPages,
            bool isPaginating)?
        loaded,
    TResult? Function(String error)? error,
  }) {
    return loaded?.call(upcomingGrouped, returnsGrouped, carouselData,
        nextPageUrl, currentPage, totalPages, isPaginating);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            Map<String, List<BookingsModel>> upcomingGrouped,
            Map<String, List<BookingsModel>> returnsGrouped,
            DesktopDashboardCarouselData carouselData,
            String? nextPageUrl,
            int currentPage,
            int totalPages,
            bool isPaginating)?
        loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(upcomingGrouped, returnsGrouped, carouselData, nextPageUrl,
          currentPage, totalPages, isPaginating);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements DashboardState {
  const factory _Loaded(
      {required final Map<String, List<BookingsModel>> upcomingGrouped,
      required final Map<String, List<BookingsModel>> returnsGrouped,
      required final DesktopDashboardCarouselData carouselData,
      required final String? nextPageUrl,
      required final int currentPage,
      required final int totalPages,
      final bool isPaginating}) = _$LoadedImpl;

  Map<String, List<BookingsModel>> get upcomingGrouped;
  Map<String, List<BookingsModel>> get returnsGrouped;
  DesktopDashboardCarouselData get carouselData;
  String? get nextPageUrl;
  int get currentPage;
  int get totalPages;
  bool get isPaginating;

  /// Create a copy of DashboardState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
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
    extends _$DashboardStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of DashboardState
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
    return 'DashboardState.error(error: $error)';
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

  /// Create a copy of DashboardState
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
    required TResult Function(
            Map<String, List<BookingsModel>> upcomingGrouped,
            Map<String, List<BookingsModel>> returnsGrouped,
            DesktopDashboardCarouselData carouselData,
            String? nextPageUrl,
            int currentPage,
            int totalPages,
            bool isPaginating)
        loaded,
    required TResult Function(String error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
            Map<String, List<BookingsModel>> upcomingGrouped,
            Map<String, List<BookingsModel>> returnsGrouped,
            DesktopDashboardCarouselData carouselData,
            String? nextPageUrl,
            int currentPage,
            int totalPages,
            bool isPaginating)?
        loaded,
    TResult? Function(String error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            Map<String, List<BookingsModel>> upcomingGrouped,
            Map<String, List<BookingsModel>> returnsGrouped,
            DesktopDashboardCarouselData carouselData,
            String? nextPageUrl,
            int currentPage,
            int totalPages,
            bool isPaginating)?
        loaded,
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
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements DashboardState {
  const factory _Error(final String error) = _$ErrorImpl;

  String get error;

  /// Create a copy of DashboardState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
