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
    required TResult Function(bool isOngoing, bool useOldState)
        loadDashboardData,
    required TResult Function() loadDashboardNextPageData,
    required TResult Function(
            DashboardListModel? updateData, bool shouldRefresh, bool isDeleted)
        updateData,
    required TResult Function() loadIfNot,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool isOngoing, bool useOldState)? loadDashboardData,
    TResult? Function()? loadDashboardNextPageData,
    TResult? Function(
            DashboardListModel? updateData, bool shouldRefresh, bool isDeleted)?
        updateData,
    TResult? Function()? loadIfNot,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool isOngoing, bool useOldState)? loadDashboardData,
    TResult Function()? loadDashboardNextPageData,
    TResult Function(
            DashboardListModel? updateData, bool shouldRefresh, bool isDeleted)?
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
  $Res call({bool isOngoing, bool useOldState});
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
    Object? isOngoing = null,
    Object? useOldState = null,
  }) {
    return _then(_$LoadDashboardDataImpl(
      isOngoing: null == isOngoing
          ? _value.isOngoing
          : isOngoing // ignore: cast_nullable_to_non_nullable
              as bool,
      useOldState: null == useOldState
          ? _value.useOldState
          : useOldState // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$LoadDashboardDataImpl implements _LoadDashboardData {
  const _$LoadDashboardDataImpl(
      {this.isOngoing = false, this.useOldState = false});

  @override
  @JsonKey()
  final bool isOngoing;
  @override
  @JsonKey()
  final bool useOldState;

  @override
  String toString() {
    return 'DashboardEvent.loadDashboardData(isOngoing: $isOngoing, useOldState: $useOldState)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadDashboardDataImpl &&
            (identical(other.isOngoing, isOngoing) ||
                other.isOngoing == isOngoing) &&
            (identical(other.useOldState, useOldState) ||
                other.useOldState == useOldState));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isOngoing, useOldState);

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
    required TResult Function(bool isOngoing, bool useOldState)
        loadDashboardData,
    required TResult Function() loadDashboardNextPageData,
    required TResult Function(
            DashboardListModel? updateData, bool shouldRefresh, bool isDeleted)
        updateData,
    required TResult Function() loadIfNot,
  }) {
    return loadDashboardData(isOngoing, useOldState);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool isOngoing, bool useOldState)? loadDashboardData,
    TResult? Function()? loadDashboardNextPageData,
    TResult? Function(
            DashboardListModel? updateData, bool shouldRefresh, bool isDeleted)?
        updateData,
    TResult? Function()? loadIfNot,
  }) {
    return loadDashboardData?.call(isOngoing, useOldState);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool isOngoing, bool useOldState)? loadDashboardData,
    TResult Function()? loadDashboardNextPageData,
    TResult Function(
            DashboardListModel? updateData, bool shouldRefresh, bool isDeleted)?
        updateData,
    TResult Function()? loadIfNot,
    required TResult orElse(),
  }) {
    if (loadDashboardData != null) {
      return loadDashboardData(isOngoing, useOldState);
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
      {final bool isOngoing, final bool useOldState}) = _$LoadDashboardDataImpl;

  bool get isOngoing;
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
    required TResult Function(bool isOngoing, bool useOldState)
        loadDashboardData,
    required TResult Function() loadDashboardNextPageData,
    required TResult Function(
            DashboardListModel? updateData, bool shouldRefresh, bool isDeleted)
        updateData,
    required TResult Function() loadIfNot,
  }) {
    return loadDashboardNextPageData();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool isOngoing, bool useOldState)? loadDashboardData,
    TResult? Function()? loadDashboardNextPageData,
    TResult? Function(
            DashboardListModel? updateData, bool shouldRefresh, bool isDeleted)?
        updateData,
    TResult? Function()? loadIfNot,
  }) {
    return loadDashboardNextPageData?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool isOngoing, bool useOldState)? loadDashboardData,
    TResult Function()? loadDashboardNextPageData,
    TResult Function(
            DashboardListModel? updateData, bool shouldRefresh, bool isDeleted)?
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
  $Res call(
      {DashboardListModel? updateData, bool shouldRefresh, bool isDeleted});
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
    Object? updateData = freezed,
    Object? shouldRefresh = null,
    Object? isDeleted = null,
  }) {
    return _then(_$UpdateDataImpl(
      freezed == updateData
          ? _value.updateData
          : updateData // ignore: cast_nullable_to_non_nullable
              as DashboardListModel?,
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
}

/// @nodoc

class _$UpdateDataImpl implements _UpdateData {
  const _$UpdateDataImpl(this.updateData,
      {this.shouldRefresh = false, this.isDeleted = false});

  @override
  final DashboardListModel? updateData;
  @override
  @JsonKey()
  final bool shouldRefresh;
  @override
  @JsonKey()
  final bool isDeleted;

  @override
  String toString() {
    return 'DashboardEvent.updateData(updateData: $updateData, shouldRefresh: $shouldRefresh, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateDataImpl &&
            (identical(other.updateData, updateData) ||
                other.updateData == updateData) &&
            (identical(other.shouldRefresh, shouldRefresh) ||
                other.shouldRefresh == shouldRefresh) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, updateData, shouldRefresh, isDeleted);

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
    required TResult Function(bool isOngoing, bool useOldState)
        loadDashboardData,
    required TResult Function() loadDashboardNextPageData,
    required TResult Function(
            DashboardListModel? updateData, bool shouldRefresh, bool isDeleted)
        updateData,
    required TResult Function() loadIfNot,
  }) {
    return updateData(this.updateData, shouldRefresh, isDeleted);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool isOngoing, bool useOldState)? loadDashboardData,
    TResult? Function()? loadDashboardNextPageData,
    TResult? Function(
            DashboardListModel? updateData, bool shouldRefresh, bool isDeleted)?
        updateData,
    TResult? Function()? loadIfNot,
  }) {
    return updateData?.call(this.updateData, shouldRefresh, isDeleted);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool isOngoing, bool useOldState)? loadDashboardData,
    TResult Function()? loadDashboardNextPageData,
    TResult Function(
            DashboardListModel? updateData, bool shouldRefresh, bool isDeleted)?
        updateData,
    TResult Function()? loadIfNot,
    required TResult orElse(),
  }) {
    if (updateData != null) {
      return updateData(this.updateData, shouldRefresh, isDeleted);
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
  const factory _UpdateData(final DashboardListModel? updateData,
      {final bool shouldRefresh, final bool isDeleted}) = _$UpdateDataImpl;

  DashboardListModel? get updateData;
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
    required TResult Function(bool isOngoing, bool useOldState)
        loadDashboardData,
    required TResult Function() loadDashboardNextPageData,
    required TResult Function(
            DashboardListModel? updateData, bool shouldRefresh, bool isDeleted)
        updateData,
    required TResult Function() loadIfNot,
  }) {
    return loadIfNot();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool isOngoing, bool useOldState)? loadDashboardData,
    TResult? Function()? loadDashboardNextPageData,
    TResult? Function(
            DashboardListModel? updateData, bool shouldRefresh, bool isDeleted)?
        updateData,
    TResult? Function()? loadIfNot,
  }) {
    return loadIfNot?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool isOngoing, bool useOldState)? loadDashboardData,
    TResult Function()? loadDashboardNextPageData,
    TResult Function(
            DashboardListModel? updateData, bool shouldRefresh, bool isDeleted)?
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
            Map<String, List<DashboardListModel>> dataGrouped,
            CarouselDataModel carouselData,
            String? nextPageUrl,
            bool isPaginating,
            bool isOngoing)
        loaded,
    required TResult Function(String error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
            Map<String, List<DashboardListModel>> dataGrouped,
            CarouselDataModel carouselData,
            String? nextPageUrl,
            bool isPaginating,
            bool isOngoing)?
        loaded,
    TResult? Function(String error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            Map<String, List<DashboardListModel>> dataGrouped,
            CarouselDataModel carouselData,
            String? nextPageUrl,
            bool isPaginating,
            bool isOngoing)?
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
            Map<String, List<DashboardListModel>> dataGrouped,
            CarouselDataModel carouselData,
            String? nextPageUrl,
            bool isPaginating,
            bool isOngoing)
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
            Map<String, List<DashboardListModel>> dataGrouped,
            CarouselDataModel carouselData,
            String? nextPageUrl,
            bool isPaginating,
            bool isOngoing)?
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
            Map<String, List<DashboardListModel>> dataGrouped,
            CarouselDataModel carouselData,
            String? nextPageUrl,
            bool isPaginating,
            bool isOngoing)?
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
      {Map<String, List<DashboardListModel>> dataGrouped,
      CarouselDataModel carouselData,
      String? nextPageUrl,
      bool isPaginating,
      bool isOngoing});

  $CarouselDataModelCopyWith<$Res> get carouselData;
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
    Object? dataGrouped = null,
    Object? carouselData = null,
    Object? nextPageUrl = freezed,
    Object? isPaginating = null,
    Object? isOngoing = null,
  }) {
    return _then(_$LoadedImpl(
      dataGrouped: null == dataGrouped
          ? _value._dataGrouped
          : dataGrouped // ignore: cast_nullable_to_non_nullable
              as Map<String, List<DashboardListModel>>,
      carouselData: null == carouselData
          ? _value.carouselData
          : carouselData // ignore: cast_nullable_to_non_nullable
              as CarouselDataModel,
      nextPageUrl: freezed == nextPageUrl
          ? _value.nextPageUrl
          : nextPageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isPaginating: null == isPaginating
          ? _value.isPaginating
          : isPaginating // ignore: cast_nullable_to_non_nullable
              as bool,
      isOngoing: null == isOngoing
          ? _value.isOngoing
          : isOngoing // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  /// Create a copy of DashboardState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CarouselDataModelCopyWith<$Res> get carouselData {
    return $CarouselDataModelCopyWith<$Res>(_value.carouselData, (value) {
      return _then(_value.copyWith(carouselData: value));
    });
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(
      {required final Map<String, List<DashboardListModel>> dataGrouped,
      required this.carouselData,
      required this.nextPageUrl,
      this.isPaginating = false,
      this.isOngoing = false})
      : _dataGrouped = dataGrouped;

  final Map<String, List<DashboardListModel>> _dataGrouped;
  @override
  Map<String, List<DashboardListModel>> get dataGrouped {
    if (_dataGrouped is EqualUnmodifiableMapView) return _dataGrouped;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_dataGrouped);
  }

  @override
  final CarouselDataModel carouselData;
  @override
  final String? nextPageUrl;
  @override
  @JsonKey()
  final bool isPaginating;
  @override
  @JsonKey()
  final bool isOngoing;

  @override
  String toString() {
    return 'DashboardState.loaded(dataGrouped: $dataGrouped, carouselData: $carouselData, nextPageUrl: $nextPageUrl, isPaginating: $isPaginating, isOngoing: $isOngoing)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            const DeepCollectionEquality()
                .equals(other._dataGrouped, _dataGrouped) &&
            (identical(other.carouselData, carouselData) ||
                other.carouselData == carouselData) &&
            (identical(other.nextPageUrl, nextPageUrl) ||
                other.nextPageUrl == nextPageUrl) &&
            (identical(other.isPaginating, isPaginating) ||
                other.isPaginating == isPaginating) &&
            (identical(other.isOngoing, isOngoing) ||
                other.isOngoing == isOngoing));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_dataGrouped),
      carouselData,
      nextPageUrl,
      isPaginating,
      isOngoing);

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
            Map<String, List<DashboardListModel>> dataGrouped,
            CarouselDataModel carouselData,
            String? nextPageUrl,
            bool isPaginating,
            bool isOngoing)
        loaded,
    required TResult Function(String error) error,
  }) {
    return loaded(
        dataGrouped, carouselData, nextPageUrl, isPaginating, isOngoing);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
            Map<String, List<DashboardListModel>> dataGrouped,
            CarouselDataModel carouselData,
            String? nextPageUrl,
            bool isPaginating,
            bool isOngoing)?
        loaded,
    TResult? Function(String error)? error,
  }) {
    return loaded?.call(
        dataGrouped, carouselData, nextPageUrl, isPaginating, isOngoing);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
            Map<String, List<DashboardListModel>> dataGrouped,
            CarouselDataModel carouselData,
            String? nextPageUrl,
            bool isPaginating,
            bool isOngoing)?
        loaded,
    TResult Function(String error)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(
          dataGrouped, carouselData, nextPageUrl, isPaginating, isOngoing);
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
      {required final Map<String, List<DashboardListModel>> dataGrouped,
      required final CarouselDataModel carouselData,
      required final String? nextPageUrl,
      final bool isPaginating,
      final bool isOngoing}) = _$LoadedImpl;

  Map<String, List<DashboardListModel>> get dataGrouped;
  CarouselDataModel get carouselData;
  String? get nextPageUrl;
  bool get isPaginating;
  bool get isOngoing;

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
            Map<String, List<DashboardListModel>> dataGrouped,
            CarouselDataModel carouselData,
            String? nextPageUrl,
            bool isPaginating,
            bool isOngoing)
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
            Map<String, List<DashboardListModel>> dataGrouped,
            CarouselDataModel carouselData,
            String? nextPageUrl,
            bool isPaginating,
            bool isOngoing)?
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
            Map<String, List<DashboardListModel>> dataGrouped,
            CarouselDataModel carouselData,
            String? nextPageUrl,
            bool isPaginating,
            bool isOngoing)?
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
