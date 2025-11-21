// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'staff_deleted_list_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$StaffDeletedListEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadStaffs,
    required TResult Function() loadNextPageStaffs,
    required TResult Function(int staffId) restoreStaff,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadStaffs,
    TResult? Function()? loadNextPageStaffs,
    TResult? Function(int staffId)? restoreStaff,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadStaffs,
    TResult Function()? loadNextPageStaffs,
    TResult Function(int staffId)? restoreStaff,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadStaffs value) loadStaffs,
    required TResult Function(_LoadNextPageStaffs value) loadNextPageStaffs,
    required TResult Function(_RestoreStaff value) restoreStaff,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadStaffs value)? loadStaffs,
    TResult? Function(_LoadNextPageStaffs value)? loadNextPageStaffs,
    TResult? Function(_RestoreStaff value)? restoreStaff,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadStaffs value)? loadStaffs,
    TResult Function(_LoadNextPageStaffs value)? loadNextPageStaffs,
    TResult Function(_RestoreStaff value)? restoreStaff,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StaffDeletedListEventCopyWith<$Res> {
  factory $StaffDeletedListEventCopyWith(
    StaffDeletedListEvent value,
    $Res Function(StaffDeletedListEvent) then,
  ) = _$StaffDeletedListEventCopyWithImpl<$Res, StaffDeletedListEvent>;
}

/// @nodoc
class _$StaffDeletedListEventCopyWithImpl<$Res,
        $Val extends StaffDeletedListEvent>
    implements $StaffDeletedListEventCopyWith<$Res> {
  _$StaffDeletedListEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StaffDeletedListEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadStaffsImplCopyWith<$Res> {
  factory _$$LoadStaffsImplCopyWith(
    _$LoadStaffsImpl value,
    $Res Function(_$LoadStaffsImpl) then,
  ) = __$$LoadStaffsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadStaffsImplCopyWithImpl<$Res>
    extends _$StaffDeletedListEventCopyWithImpl<$Res, _$LoadStaffsImpl>
    implements _$$LoadStaffsImplCopyWith<$Res> {
  __$$LoadStaffsImplCopyWithImpl(
    _$LoadStaffsImpl _value,
    $Res Function(_$LoadStaffsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StaffDeletedListEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadStaffsImpl implements _LoadStaffs {
  const _$LoadStaffsImpl();

  @override
  String toString() {
    return 'StaffDeletedListEvent.loadStaffs()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadStaffsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadStaffs,
    required TResult Function() loadNextPageStaffs,
    required TResult Function(int staffId) restoreStaff,
  }) {
    return loadStaffs();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadStaffs,
    TResult? Function()? loadNextPageStaffs,
    TResult? Function(int staffId)? restoreStaff,
  }) {
    return loadStaffs?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadStaffs,
    TResult Function()? loadNextPageStaffs,
    TResult Function(int staffId)? restoreStaff,
    required TResult orElse(),
  }) {
    if (loadStaffs != null) {
      return loadStaffs();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadStaffs value) loadStaffs,
    required TResult Function(_LoadNextPageStaffs value) loadNextPageStaffs,
    required TResult Function(_RestoreStaff value) restoreStaff,
  }) {
    return loadStaffs(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadStaffs value)? loadStaffs,
    TResult? Function(_LoadNextPageStaffs value)? loadNextPageStaffs,
    TResult? Function(_RestoreStaff value)? restoreStaff,
  }) {
    return loadStaffs?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadStaffs value)? loadStaffs,
    TResult Function(_LoadNextPageStaffs value)? loadNextPageStaffs,
    TResult Function(_RestoreStaff value)? restoreStaff,
    required TResult orElse(),
  }) {
    if (loadStaffs != null) {
      return loadStaffs(this);
    }
    return orElse();
  }
}

abstract class _LoadStaffs implements StaffDeletedListEvent {
  const factory _LoadStaffs() = _$LoadStaffsImpl;
}

/// @nodoc
abstract class _$$LoadNextPageStaffsImplCopyWith<$Res> {
  factory _$$LoadNextPageStaffsImplCopyWith(
    _$LoadNextPageStaffsImpl value,
    $Res Function(_$LoadNextPageStaffsImpl) then,
  ) = __$$LoadNextPageStaffsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadNextPageStaffsImplCopyWithImpl<$Res>
    extends _$StaffDeletedListEventCopyWithImpl<$Res, _$LoadNextPageStaffsImpl>
    implements _$$LoadNextPageStaffsImplCopyWith<$Res> {
  __$$LoadNextPageStaffsImplCopyWithImpl(
    _$LoadNextPageStaffsImpl _value,
    $Res Function(_$LoadNextPageStaffsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StaffDeletedListEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadNextPageStaffsImpl implements _LoadNextPageStaffs {
  const _$LoadNextPageStaffsImpl();

  @override
  String toString() {
    return 'StaffDeletedListEvent.loadNextPageStaffs()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadNextPageStaffsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadStaffs,
    required TResult Function() loadNextPageStaffs,
    required TResult Function(int staffId) restoreStaff,
  }) {
    return loadNextPageStaffs();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadStaffs,
    TResult? Function()? loadNextPageStaffs,
    TResult? Function(int staffId)? restoreStaff,
  }) {
    return loadNextPageStaffs?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadStaffs,
    TResult Function()? loadNextPageStaffs,
    TResult Function(int staffId)? restoreStaff,
    required TResult orElse(),
  }) {
    if (loadNextPageStaffs != null) {
      return loadNextPageStaffs();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadStaffs value) loadStaffs,
    required TResult Function(_LoadNextPageStaffs value) loadNextPageStaffs,
    required TResult Function(_RestoreStaff value) restoreStaff,
  }) {
    return loadNextPageStaffs(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadStaffs value)? loadStaffs,
    TResult? Function(_LoadNextPageStaffs value)? loadNextPageStaffs,
    TResult? Function(_RestoreStaff value)? restoreStaff,
  }) {
    return loadNextPageStaffs?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadStaffs value)? loadStaffs,
    TResult Function(_LoadNextPageStaffs value)? loadNextPageStaffs,
    TResult Function(_RestoreStaff value)? restoreStaff,
    required TResult orElse(),
  }) {
    if (loadNextPageStaffs != null) {
      return loadNextPageStaffs(this);
    }
    return orElse();
  }
}

abstract class _LoadNextPageStaffs implements StaffDeletedListEvent {
  const factory _LoadNextPageStaffs() = _$LoadNextPageStaffsImpl;
}

/// @nodoc
abstract class _$$RestoreStaffImplCopyWith<$Res> {
  factory _$$RestoreStaffImplCopyWith(
    _$RestoreStaffImpl value,
    $Res Function(_$RestoreStaffImpl) then,
  ) = __$$RestoreStaffImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int staffId});
}

/// @nodoc
class __$$RestoreStaffImplCopyWithImpl<$Res>
    extends _$StaffDeletedListEventCopyWithImpl<$Res, _$RestoreStaffImpl>
    implements _$$RestoreStaffImplCopyWith<$Res> {
  __$$RestoreStaffImplCopyWithImpl(
    _$RestoreStaffImpl _value,
    $Res Function(_$RestoreStaffImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StaffDeletedListEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? staffId = null}) {
    return _then(
      _$RestoreStaffImpl(
        null == staffId
            ? _value.staffId
            : staffId // ignore: cast_nullable_to_non_nullable
                as int,
      ),
    );
  }
}

/// @nodoc

class _$RestoreStaffImpl implements _RestoreStaff {
  const _$RestoreStaffImpl(this.staffId);

  @override
  final int staffId;

  @override
  String toString() {
    return 'StaffDeletedListEvent.restoreStaff(staffId: $staffId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RestoreStaffImpl &&
            (identical(other.staffId, staffId) || other.staffId == staffId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, staffId);

  /// Create a copy of StaffDeletedListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RestoreStaffImplCopyWith<_$RestoreStaffImpl> get copyWith =>
      __$$RestoreStaffImplCopyWithImpl<_$RestoreStaffImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadStaffs,
    required TResult Function() loadNextPageStaffs,
    required TResult Function(int staffId) restoreStaff,
  }) {
    return restoreStaff(staffId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadStaffs,
    TResult? Function()? loadNextPageStaffs,
    TResult? Function(int staffId)? restoreStaff,
  }) {
    return restoreStaff?.call(staffId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadStaffs,
    TResult Function()? loadNextPageStaffs,
    TResult Function(int staffId)? restoreStaff,
    required TResult orElse(),
  }) {
    if (restoreStaff != null) {
      return restoreStaff(staffId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadStaffs value) loadStaffs,
    required TResult Function(_LoadNextPageStaffs value) loadNextPageStaffs,
    required TResult Function(_RestoreStaff value) restoreStaff,
  }) {
    return restoreStaff(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadStaffs value)? loadStaffs,
    TResult? Function(_LoadNextPageStaffs value)? loadNextPageStaffs,
    TResult? Function(_RestoreStaff value)? restoreStaff,
  }) {
    return restoreStaff?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadStaffs value)? loadStaffs,
    TResult Function(_LoadNextPageStaffs value)? loadNextPageStaffs,
    TResult Function(_RestoreStaff value)? restoreStaff,
    required TResult orElse(),
  }) {
    if (restoreStaff != null) {
      return restoreStaff(this);
    }
    return orElse();
  }
}

abstract class _RestoreStaff implements StaffDeletedListEvent {
  const factory _RestoreStaff(final int staffId) = _$RestoreStaffImpl;

  int get staffId;

  /// Create a copy of StaffDeletedListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RestoreStaffImplCopyWith<_$RestoreStaffImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$StaffDeletedListState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
      List<StaffModel> staffs,
      String? nextPageUrl,
      bool isPaginating,
      StaffDeletedListStatus status,
      String? message,
    ) loaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
      List<StaffModel> staffs,
      String? nextPageUrl,
      bool isPaginating,
      StaffDeletedListStatus status,
      String? message,
    )? loaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
      List<StaffModel> staffs,
      String? nextPageUrl,
      bool isPaginating,
      StaffDeletedListStatus status,
      String? message,
    )? loaded,
    TResult Function(String message)? error,
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
abstract class $StaffDeletedListStateCopyWith<$Res> {
  factory $StaffDeletedListStateCopyWith(
    StaffDeletedListState value,
    $Res Function(StaffDeletedListState) then,
  ) = _$StaffDeletedListStateCopyWithImpl<$Res, StaffDeletedListState>;
}

/// @nodoc
class _$StaffDeletedListStateCopyWithImpl<$Res,
        $Val extends StaffDeletedListState>
    implements $StaffDeletedListStateCopyWith<$Res> {
  _$StaffDeletedListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StaffDeletedListState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
    _$LoadingImpl value,
    $Res Function(_$LoadingImpl) then,
  ) = __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$StaffDeletedListStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
    _$LoadingImpl _value,
    $Res Function(_$LoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StaffDeletedListState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'StaffDeletedListState.loading()';
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
      List<StaffModel> staffs,
      String? nextPageUrl,
      bool isPaginating,
      StaffDeletedListStatus status,
      String? message,
    ) loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
      List<StaffModel> staffs,
      String? nextPageUrl,
      bool isPaginating,
      StaffDeletedListStatus status,
      String? message,
    )? loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
      List<StaffModel> staffs,
      String? nextPageUrl,
      bool isPaginating,
      StaffDeletedListStatus status,
      String? message,
    )? loaded,
    TResult Function(String message)? error,
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

abstract class _Loading implements StaffDeletedListState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
    _$LoadedImpl value,
    $Res Function(_$LoadedImpl) then,
  ) = __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    List<StaffModel> staffs,
    String? nextPageUrl,
    bool isPaginating,
    StaffDeletedListStatus status,
    String? message,
  });
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$StaffDeletedListStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
    _$LoadedImpl _value,
    $Res Function(_$LoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StaffDeletedListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? staffs = null,
    Object? nextPageUrl = freezed,
    Object? isPaginating = null,
    Object? status = null,
    Object? message = freezed,
  }) {
    return _then(
      _$LoadedImpl(
        staffs: null == staffs
            ? _value._staffs
            : staffs // ignore: cast_nullable_to_non_nullable
                as List<StaffModel>,
        nextPageUrl: freezed == nextPageUrl
            ? _value.nextPageUrl
            : nextPageUrl // ignore: cast_nullable_to_non_nullable
                as String?,
        isPaginating: null == isPaginating
            ? _value.isPaginating
            : isPaginating // ignore: cast_nullable_to_non_nullable
                as bool,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                as StaffDeletedListStatus,
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                as String?,
      ),
    );
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl({
    required final List<StaffModel> staffs,
    this.nextPageUrl,
    this.isPaginating = false,
    this.status = StaffDeletedListStatus.loaded,
    this.message,
  }) : _staffs = staffs;

  final List<StaffModel> _staffs;
  @override
  List<StaffModel> get staffs {
    if (_staffs is EqualUnmodifiableListView) return _staffs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_staffs);
  }

  @override
  final String? nextPageUrl;
  @override
  @JsonKey()
  final bool isPaginating;
  @override
  @JsonKey()
  final StaffDeletedListStatus status;
  @override
  final String? message;

  @override
  String toString() {
    return 'StaffDeletedListState.loaded(staffs: $staffs, nextPageUrl: $nextPageUrl, isPaginating: $isPaginating, status: $status, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            const DeepCollectionEquality().equals(other._staffs, _staffs) &&
            (identical(other.nextPageUrl, nextPageUrl) ||
                other.nextPageUrl == nextPageUrl) &&
            (identical(other.isPaginating, isPaginating) ||
                other.isPaginating == isPaginating) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(
        runtimeType,
        const DeepCollectionEquality().hash(_staffs),
        nextPageUrl,
        isPaginating,
        status,
        message,
      );

  /// Create a copy of StaffDeletedListState
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
      List<StaffModel> staffs,
      String? nextPageUrl,
      bool isPaginating,
      StaffDeletedListStatus status,
      String? message,
    ) loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(staffs, nextPageUrl, isPaginating, status, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
      List<StaffModel> staffs,
      String? nextPageUrl,
      bool isPaginating,
      StaffDeletedListStatus status,
      String? message,
    )? loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(staffs, nextPageUrl, isPaginating, status, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
      List<StaffModel> staffs,
      String? nextPageUrl,
      bool isPaginating,
      StaffDeletedListStatus status,
      String? message,
    )? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(staffs, nextPageUrl, isPaginating, status, message);
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

abstract class _Loaded implements StaffDeletedListState {
  const factory _Loaded({
    required final List<StaffModel> staffs,
    final String? nextPageUrl,
    final bool isPaginating,
    final StaffDeletedListStatus status,
    final String? message,
  }) = _$LoadedImpl;

  List<StaffModel> get staffs;
  String? get nextPageUrl;
  bool get isPaginating;
  StaffDeletedListStatus get status;
  String? get message;

  /// Create a copy of StaffDeletedListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
    _$ErrorImpl value,
    $Res Function(_$ErrorImpl) then,
  ) = __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$StaffDeletedListStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
    _$ErrorImpl _value,
    $Res Function(_$ErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StaffDeletedListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$ErrorImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                as String,
      ),
    );
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'StaffDeletedListState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of StaffDeletedListState
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
      List<StaffModel> staffs,
      String? nextPageUrl,
      bool isPaginating,
      StaffDeletedListStatus status,
      String? message,
    ) loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
      List<StaffModel> staffs,
      String? nextPageUrl,
      bool isPaginating,
      StaffDeletedListStatus status,
      String? message,
    )? loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
      List<StaffModel> staffs,
      String? nextPageUrl,
      bool isPaginating,
      StaffDeletedListStatus status,
      String? message,
    )? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
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

abstract class _Error implements StaffDeletedListState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;

  /// Create a copy of StaffDeletedListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
