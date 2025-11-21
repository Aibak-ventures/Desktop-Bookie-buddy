// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'staff_list_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$StaffListEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadStaffs,
    required TResult Function() loadNextPageStaffs,
    required TResult Function(int staffId) deleteStaff,
    required TResult Function(StaffRequestModel staff) editStaff,
    required TResult Function(StaffRequestModel staff) addStaff,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadStaffs,
    TResult? Function()? loadNextPageStaffs,
    TResult? Function(int staffId)? deleteStaff,
    TResult? Function(StaffRequestModel staff)? editStaff,
    TResult? Function(StaffRequestModel staff)? addStaff,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadStaffs,
    TResult Function()? loadNextPageStaffs,
    TResult Function(int staffId)? deleteStaff,
    TResult Function(StaffRequestModel staff)? editStaff,
    TResult Function(StaffRequestModel staff)? addStaff,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadStaffs value) loadStaffs,
    required TResult Function(_LoadNextPageStaffs value) loadNextPageStaffs,
    required TResult Function(_DeleteStaff value) deleteStaff,
    required TResult Function(_EditStaff value) editStaff,
    required TResult Function(_AddStaff value) addStaff,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadStaffs value)? loadStaffs,
    TResult? Function(_LoadNextPageStaffs value)? loadNextPageStaffs,
    TResult? Function(_DeleteStaff value)? deleteStaff,
    TResult? Function(_EditStaff value)? editStaff,
    TResult? Function(_AddStaff value)? addStaff,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadStaffs value)? loadStaffs,
    TResult Function(_LoadNextPageStaffs value)? loadNextPageStaffs,
    TResult Function(_DeleteStaff value)? deleteStaff,
    TResult Function(_EditStaff value)? editStaff,
    TResult Function(_AddStaff value)? addStaff,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StaffListEventCopyWith<$Res> {
  factory $StaffListEventCopyWith(
    StaffListEvent value,
    $Res Function(StaffListEvent) then,
  ) = _$StaffListEventCopyWithImpl<$Res, StaffListEvent>;
}

/// @nodoc
class _$StaffListEventCopyWithImpl<$Res, $Val extends StaffListEvent>
    implements $StaffListEventCopyWith<$Res> {
  _$StaffListEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StaffListEvent
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
    extends _$StaffListEventCopyWithImpl<$Res, _$LoadStaffsImpl>
    implements _$$LoadStaffsImplCopyWith<$Res> {
  __$$LoadStaffsImplCopyWithImpl(
    _$LoadStaffsImpl _value,
    $Res Function(_$LoadStaffsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StaffListEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadStaffsImpl implements _LoadStaffs {
  const _$LoadStaffsImpl();

  @override
  String toString() {
    return 'StaffListEvent.loadStaffs()';
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
    required TResult Function(int staffId) deleteStaff,
    required TResult Function(StaffRequestModel staff) editStaff,
    required TResult Function(StaffRequestModel staff) addStaff,
  }) {
    return loadStaffs();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadStaffs,
    TResult? Function()? loadNextPageStaffs,
    TResult? Function(int staffId)? deleteStaff,
    TResult? Function(StaffRequestModel staff)? editStaff,
    TResult? Function(StaffRequestModel staff)? addStaff,
  }) {
    return loadStaffs?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadStaffs,
    TResult Function()? loadNextPageStaffs,
    TResult Function(int staffId)? deleteStaff,
    TResult Function(StaffRequestModel staff)? editStaff,
    TResult Function(StaffRequestModel staff)? addStaff,
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
    required TResult Function(_DeleteStaff value) deleteStaff,
    required TResult Function(_EditStaff value) editStaff,
    required TResult Function(_AddStaff value) addStaff,
  }) {
    return loadStaffs(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadStaffs value)? loadStaffs,
    TResult? Function(_LoadNextPageStaffs value)? loadNextPageStaffs,
    TResult? Function(_DeleteStaff value)? deleteStaff,
    TResult? Function(_EditStaff value)? editStaff,
    TResult? Function(_AddStaff value)? addStaff,
  }) {
    return loadStaffs?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadStaffs value)? loadStaffs,
    TResult Function(_LoadNextPageStaffs value)? loadNextPageStaffs,
    TResult Function(_DeleteStaff value)? deleteStaff,
    TResult Function(_EditStaff value)? editStaff,
    TResult Function(_AddStaff value)? addStaff,
    required TResult orElse(),
  }) {
    if (loadStaffs != null) {
      return loadStaffs(this);
    }
    return orElse();
  }
}

abstract class _LoadStaffs implements StaffListEvent {
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
    extends _$StaffListEventCopyWithImpl<$Res, _$LoadNextPageStaffsImpl>
    implements _$$LoadNextPageStaffsImplCopyWith<$Res> {
  __$$LoadNextPageStaffsImplCopyWithImpl(
    _$LoadNextPageStaffsImpl _value,
    $Res Function(_$LoadNextPageStaffsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StaffListEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadNextPageStaffsImpl implements _LoadNextPageStaffs {
  const _$LoadNextPageStaffsImpl();

  @override
  String toString() {
    return 'StaffListEvent.loadNextPageStaffs()';
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
    required TResult Function(int staffId) deleteStaff,
    required TResult Function(StaffRequestModel staff) editStaff,
    required TResult Function(StaffRequestModel staff) addStaff,
  }) {
    return loadNextPageStaffs();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadStaffs,
    TResult? Function()? loadNextPageStaffs,
    TResult? Function(int staffId)? deleteStaff,
    TResult? Function(StaffRequestModel staff)? editStaff,
    TResult? Function(StaffRequestModel staff)? addStaff,
  }) {
    return loadNextPageStaffs?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadStaffs,
    TResult Function()? loadNextPageStaffs,
    TResult Function(int staffId)? deleteStaff,
    TResult Function(StaffRequestModel staff)? editStaff,
    TResult Function(StaffRequestModel staff)? addStaff,
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
    required TResult Function(_DeleteStaff value) deleteStaff,
    required TResult Function(_EditStaff value) editStaff,
    required TResult Function(_AddStaff value) addStaff,
  }) {
    return loadNextPageStaffs(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadStaffs value)? loadStaffs,
    TResult? Function(_LoadNextPageStaffs value)? loadNextPageStaffs,
    TResult? Function(_DeleteStaff value)? deleteStaff,
    TResult? Function(_EditStaff value)? editStaff,
    TResult? Function(_AddStaff value)? addStaff,
  }) {
    return loadNextPageStaffs?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadStaffs value)? loadStaffs,
    TResult Function(_LoadNextPageStaffs value)? loadNextPageStaffs,
    TResult Function(_DeleteStaff value)? deleteStaff,
    TResult Function(_EditStaff value)? editStaff,
    TResult Function(_AddStaff value)? addStaff,
    required TResult orElse(),
  }) {
    if (loadNextPageStaffs != null) {
      return loadNextPageStaffs(this);
    }
    return orElse();
  }
}

abstract class _LoadNextPageStaffs implements StaffListEvent {
  const factory _LoadNextPageStaffs() = _$LoadNextPageStaffsImpl;
}

/// @nodoc
abstract class _$$DeleteStaffImplCopyWith<$Res> {
  factory _$$DeleteStaffImplCopyWith(
    _$DeleteStaffImpl value,
    $Res Function(_$DeleteStaffImpl) then,
  ) = __$$DeleteStaffImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int staffId});
}

/// @nodoc
class __$$DeleteStaffImplCopyWithImpl<$Res>
    extends _$StaffListEventCopyWithImpl<$Res, _$DeleteStaffImpl>
    implements _$$DeleteStaffImplCopyWith<$Res> {
  __$$DeleteStaffImplCopyWithImpl(
    _$DeleteStaffImpl _value,
    $Res Function(_$DeleteStaffImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StaffListEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? staffId = null}) {
    return _then(
      _$DeleteStaffImpl(
        null == staffId
            ? _value.staffId
            : staffId // ignore: cast_nullable_to_non_nullable
                as int,
      ),
    );
  }
}

/// @nodoc

class _$DeleteStaffImpl implements _DeleteStaff {
  const _$DeleteStaffImpl(this.staffId);

  @override
  final int staffId;

  @override
  String toString() {
    return 'StaffListEvent.deleteStaff(staffId: $staffId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteStaffImpl &&
            (identical(other.staffId, staffId) || other.staffId == staffId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, staffId);

  /// Create a copy of StaffListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteStaffImplCopyWith<_$DeleteStaffImpl> get copyWith =>
      __$$DeleteStaffImplCopyWithImpl<_$DeleteStaffImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadStaffs,
    required TResult Function() loadNextPageStaffs,
    required TResult Function(int staffId) deleteStaff,
    required TResult Function(StaffRequestModel staff) editStaff,
    required TResult Function(StaffRequestModel staff) addStaff,
  }) {
    return deleteStaff(staffId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadStaffs,
    TResult? Function()? loadNextPageStaffs,
    TResult? Function(int staffId)? deleteStaff,
    TResult? Function(StaffRequestModel staff)? editStaff,
    TResult? Function(StaffRequestModel staff)? addStaff,
  }) {
    return deleteStaff?.call(staffId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadStaffs,
    TResult Function()? loadNextPageStaffs,
    TResult Function(int staffId)? deleteStaff,
    TResult Function(StaffRequestModel staff)? editStaff,
    TResult Function(StaffRequestModel staff)? addStaff,
    required TResult orElse(),
  }) {
    if (deleteStaff != null) {
      return deleteStaff(staffId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadStaffs value) loadStaffs,
    required TResult Function(_LoadNextPageStaffs value) loadNextPageStaffs,
    required TResult Function(_DeleteStaff value) deleteStaff,
    required TResult Function(_EditStaff value) editStaff,
    required TResult Function(_AddStaff value) addStaff,
  }) {
    return deleteStaff(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadStaffs value)? loadStaffs,
    TResult? Function(_LoadNextPageStaffs value)? loadNextPageStaffs,
    TResult? Function(_DeleteStaff value)? deleteStaff,
    TResult? Function(_EditStaff value)? editStaff,
    TResult? Function(_AddStaff value)? addStaff,
  }) {
    return deleteStaff?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadStaffs value)? loadStaffs,
    TResult Function(_LoadNextPageStaffs value)? loadNextPageStaffs,
    TResult Function(_DeleteStaff value)? deleteStaff,
    TResult Function(_EditStaff value)? editStaff,
    TResult Function(_AddStaff value)? addStaff,
    required TResult orElse(),
  }) {
    if (deleteStaff != null) {
      return deleteStaff(this);
    }
    return orElse();
  }
}

abstract class _DeleteStaff implements StaffListEvent {
  const factory _DeleteStaff(final int staffId) = _$DeleteStaffImpl;

  int get staffId;

  /// Create a copy of StaffListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteStaffImplCopyWith<_$DeleteStaffImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EditStaffImplCopyWith<$Res> {
  factory _$$EditStaffImplCopyWith(
    _$EditStaffImpl value,
    $Res Function(_$EditStaffImpl) then,
  ) = __$$EditStaffImplCopyWithImpl<$Res>;
  @useResult
  $Res call({StaffRequestModel staff});

  $StaffRequestModelCopyWith<$Res> get staff;
}

/// @nodoc
class __$$EditStaffImplCopyWithImpl<$Res>
    extends _$StaffListEventCopyWithImpl<$Res, _$EditStaffImpl>
    implements _$$EditStaffImplCopyWith<$Res> {
  __$$EditStaffImplCopyWithImpl(
    _$EditStaffImpl _value,
    $Res Function(_$EditStaffImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StaffListEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? staff = null}) {
    return _then(
      _$EditStaffImpl(
        null == staff
            ? _value.staff
            : staff // ignore: cast_nullable_to_non_nullable
                as StaffRequestModel,
      ),
    );
  }

  /// Create a copy of StaffListEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StaffRequestModelCopyWith<$Res> get staff {
    return $StaffRequestModelCopyWith<$Res>(_value.staff, (value) {
      return _then(_value.copyWith(staff: value));
    });
  }
}

/// @nodoc

class _$EditStaffImpl implements _EditStaff {
  const _$EditStaffImpl(this.staff);

  @override
  final StaffRequestModel staff;

  @override
  String toString() {
    return 'StaffListEvent.editStaff(staff: $staff)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditStaffImpl &&
            (identical(other.staff, staff) || other.staff == staff));
  }

  @override
  int get hashCode => Object.hash(runtimeType, staff);

  /// Create a copy of StaffListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EditStaffImplCopyWith<_$EditStaffImpl> get copyWith =>
      __$$EditStaffImplCopyWithImpl<_$EditStaffImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadStaffs,
    required TResult Function() loadNextPageStaffs,
    required TResult Function(int staffId) deleteStaff,
    required TResult Function(StaffRequestModel staff) editStaff,
    required TResult Function(StaffRequestModel staff) addStaff,
  }) {
    return editStaff(staff);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadStaffs,
    TResult? Function()? loadNextPageStaffs,
    TResult? Function(int staffId)? deleteStaff,
    TResult? Function(StaffRequestModel staff)? editStaff,
    TResult? Function(StaffRequestModel staff)? addStaff,
  }) {
    return editStaff?.call(staff);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadStaffs,
    TResult Function()? loadNextPageStaffs,
    TResult Function(int staffId)? deleteStaff,
    TResult Function(StaffRequestModel staff)? editStaff,
    TResult Function(StaffRequestModel staff)? addStaff,
    required TResult orElse(),
  }) {
    if (editStaff != null) {
      return editStaff(staff);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadStaffs value) loadStaffs,
    required TResult Function(_LoadNextPageStaffs value) loadNextPageStaffs,
    required TResult Function(_DeleteStaff value) deleteStaff,
    required TResult Function(_EditStaff value) editStaff,
    required TResult Function(_AddStaff value) addStaff,
  }) {
    return editStaff(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadStaffs value)? loadStaffs,
    TResult? Function(_LoadNextPageStaffs value)? loadNextPageStaffs,
    TResult? Function(_DeleteStaff value)? deleteStaff,
    TResult? Function(_EditStaff value)? editStaff,
    TResult? Function(_AddStaff value)? addStaff,
  }) {
    return editStaff?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadStaffs value)? loadStaffs,
    TResult Function(_LoadNextPageStaffs value)? loadNextPageStaffs,
    TResult Function(_DeleteStaff value)? deleteStaff,
    TResult Function(_EditStaff value)? editStaff,
    TResult Function(_AddStaff value)? addStaff,
    required TResult orElse(),
  }) {
    if (editStaff != null) {
      return editStaff(this);
    }
    return orElse();
  }
}

abstract class _EditStaff implements StaffListEvent {
  const factory _EditStaff(final StaffRequestModel staff) = _$EditStaffImpl;

  StaffRequestModel get staff;

  /// Create a copy of StaffListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EditStaffImplCopyWith<_$EditStaffImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddStaffImplCopyWith<$Res> {
  factory _$$AddStaffImplCopyWith(
    _$AddStaffImpl value,
    $Res Function(_$AddStaffImpl) then,
  ) = __$$AddStaffImplCopyWithImpl<$Res>;
  @useResult
  $Res call({StaffRequestModel staff});

  $StaffRequestModelCopyWith<$Res> get staff;
}

/// @nodoc
class __$$AddStaffImplCopyWithImpl<$Res>
    extends _$StaffListEventCopyWithImpl<$Res, _$AddStaffImpl>
    implements _$$AddStaffImplCopyWith<$Res> {
  __$$AddStaffImplCopyWithImpl(
    _$AddStaffImpl _value,
    $Res Function(_$AddStaffImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StaffListEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? staff = null}) {
    return _then(
      _$AddStaffImpl(
        null == staff
            ? _value.staff
            : staff // ignore: cast_nullable_to_non_nullable
                as StaffRequestModel,
      ),
    );
  }

  /// Create a copy of StaffListEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StaffRequestModelCopyWith<$Res> get staff {
    return $StaffRequestModelCopyWith<$Res>(_value.staff, (value) {
      return _then(_value.copyWith(staff: value));
    });
  }
}

/// @nodoc

class _$AddStaffImpl implements _AddStaff {
  const _$AddStaffImpl(this.staff);

  @override
  final StaffRequestModel staff;

  @override
  String toString() {
    return 'StaffListEvent.addStaff(staff: $staff)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddStaffImpl &&
            (identical(other.staff, staff) || other.staff == staff));
  }

  @override
  int get hashCode => Object.hash(runtimeType, staff);

  /// Create a copy of StaffListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddStaffImplCopyWith<_$AddStaffImpl> get copyWith =>
      __$$AddStaffImplCopyWithImpl<_$AddStaffImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadStaffs,
    required TResult Function() loadNextPageStaffs,
    required TResult Function(int staffId) deleteStaff,
    required TResult Function(StaffRequestModel staff) editStaff,
    required TResult Function(StaffRequestModel staff) addStaff,
  }) {
    return addStaff(staff);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadStaffs,
    TResult? Function()? loadNextPageStaffs,
    TResult? Function(int staffId)? deleteStaff,
    TResult? Function(StaffRequestModel staff)? editStaff,
    TResult? Function(StaffRequestModel staff)? addStaff,
  }) {
    return addStaff?.call(staff);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadStaffs,
    TResult Function()? loadNextPageStaffs,
    TResult Function(int staffId)? deleteStaff,
    TResult Function(StaffRequestModel staff)? editStaff,
    TResult Function(StaffRequestModel staff)? addStaff,
    required TResult orElse(),
  }) {
    if (addStaff != null) {
      return addStaff(staff);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadStaffs value) loadStaffs,
    required TResult Function(_LoadNextPageStaffs value) loadNextPageStaffs,
    required TResult Function(_DeleteStaff value) deleteStaff,
    required TResult Function(_EditStaff value) editStaff,
    required TResult Function(_AddStaff value) addStaff,
  }) {
    return addStaff(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadStaffs value)? loadStaffs,
    TResult? Function(_LoadNextPageStaffs value)? loadNextPageStaffs,
    TResult? Function(_DeleteStaff value)? deleteStaff,
    TResult? Function(_EditStaff value)? editStaff,
    TResult? Function(_AddStaff value)? addStaff,
  }) {
    return addStaff?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadStaffs value)? loadStaffs,
    TResult Function(_LoadNextPageStaffs value)? loadNextPageStaffs,
    TResult Function(_DeleteStaff value)? deleteStaff,
    TResult Function(_EditStaff value)? editStaff,
    TResult Function(_AddStaff value)? addStaff,
    required TResult orElse(),
  }) {
    if (addStaff != null) {
      return addStaff(this);
    }
    return orElse();
  }
}

abstract class _AddStaff implements StaffListEvent {
  const factory _AddStaff(final StaffRequestModel staff) = _$AddStaffImpl;

  StaffRequestModel get staff;

  /// Create a copy of StaffListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddStaffImplCopyWith<_$AddStaffImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$StaffListState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
      List<StaffModel> staffs,
      String? nextPageUrl,
      bool isPaginating,
      StaffListStatus status,
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
      StaffListStatus status,
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
      StaffListStatus status,
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
abstract class $StaffListStateCopyWith<$Res> {
  factory $StaffListStateCopyWith(
    StaffListState value,
    $Res Function(StaffListState) then,
  ) = _$StaffListStateCopyWithImpl<$Res, StaffListState>;
}

/// @nodoc
class _$StaffListStateCopyWithImpl<$Res, $Val extends StaffListState>
    implements $StaffListStateCopyWith<$Res> {
  _$StaffListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StaffListState
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
    extends _$StaffListStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
    _$LoadingImpl _value,
    $Res Function(_$LoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StaffListState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'StaffListState.loading()';
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
      StaffListStatus status,
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
      StaffListStatus status,
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
      StaffListStatus status,
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

abstract class _Loading implements StaffListState {
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
    StaffListStatus status,
    String? message,
  });
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$StaffListStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
    _$LoadedImpl _value,
    $Res Function(_$LoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StaffListState
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
                as StaffListStatus,
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
    this.status = StaffListStatus.loaded,
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
  final StaffListStatus status;
  @override
  final String? message;

  @override
  String toString() {
    return 'StaffListState.loaded(staffs: $staffs, nextPageUrl: $nextPageUrl, isPaginating: $isPaginating, status: $status, message: $message)';
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

  /// Create a copy of StaffListState
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
      StaffListStatus status,
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
      StaffListStatus status,
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
      StaffListStatus status,
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

abstract class _Loaded implements StaffListState {
  const factory _Loaded({
    required final List<StaffModel> staffs,
    final String? nextPageUrl,
    final bool isPaginating,
    final StaffListStatus status,
    final String? message,
  }) = _$LoadedImpl;

  List<StaffModel> get staffs;
  String? get nextPageUrl;
  bool get isPaginating;
  StaffListStatus get status;
  String? get message;

  /// Create a copy of StaffListState
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
    extends _$StaffListStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
    _$ErrorImpl _value,
    $Res Function(_$ErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StaffListState
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
    return 'StaffListState.error(message: $message)';
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

  /// Create a copy of StaffListState
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
      StaffListStatus status,
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
      StaffListStatus status,
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
      StaffListStatus status,
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

abstract class _Error implements StaffListState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;

  /// Create a copy of StaffListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
