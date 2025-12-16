// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'manage_password_settings_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ManagePasswordSettingsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<UserPasswordSettingsModel> settings) load,
    required TResult Function(String newRole, UserPasswordSettingsModel target)
        updateRole,
    required TResult Function() save,
    required TResult Function() resetChanges,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<UserPasswordSettingsModel> settings)? load,
    TResult? Function(String newRole, UserPasswordSettingsModel target)?
        updateRole,
    TResult? Function()? save,
    TResult? Function()? resetChanges,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<UserPasswordSettingsModel> settings)? load,
    TResult Function(String newRole, UserPasswordSettingsModel target)?
        updateRole,
    TResult Function()? save,
    TResult Function()? resetChanges,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_UpdateRole value) updateRole,
    required TResult Function(_Save value) save,
    required TResult Function(_ResetChanges value) resetChanges,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_UpdateRole value)? updateRole,
    TResult? Function(_Save value)? save,
    TResult? Function(_ResetChanges value)? resetChanges,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_UpdateRole value)? updateRole,
    TResult Function(_Save value)? save,
    TResult Function(_ResetChanges value)? resetChanges,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ManagePasswordSettingsEventCopyWith<$Res> {
  factory $ManagePasswordSettingsEventCopyWith(
          ManagePasswordSettingsEvent value,
          $Res Function(ManagePasswordSettingsEvent) then) =
      _$ManagePasswordSettingsEventCopyWithImpl<$Res,
          ManagePasswordSettingsEvent>;
}

/// @nodoc
class _$ManagePasswordSettingsEventCopyWithImpl<$Res,
        $Val extends ManagePasswordSettingsEvent>
    implements $ManagePasswordSettingsEventCopyWith<$Res> {
  _$ManagePasswordSettingsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ManagePasswordSettingsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadImplCopyWith<$Res> {
  factory _$$LoadImplCopyWith(
          _$LoadImpl value, $Res Function(_$LoadImpl) then) =
      __$$LoadImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<UserPasswordSettingsModel> settings});
}

/// @nodoc
class __$$LoadImplCopyWithImpl<$Res>
    extends _$ManagePasswordSettingsEventCopyWithImpl<$Res, _$LoadImpl>
    implements _$$LoadImplCopyWith<$Res> {
  __$$LoadImplCopyWithImpl(_$LoadImpl _value, $Res Function(_$LoadImpl) _then)
      : super(_value, _then);

  /// Create a copy of ManagePasswordSettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? settings = null,
  }) {
    return _then(_$LoadImpl(
      null == settings
          ? _value._settings
          : settings // ignore: cast_nullable_to_non_nullable
              as List<UserPasswordSettingsModel>,
    ));
  }
}

/// @nodoc

class _$LoadImpl implements _Load {
  const _$LoadImpl(final List<UserPasswordSettingsModel> settings)
      : _settings = settings;

  final List<UserPasswordSettingsModel> _settings;
  @override
  List<UserPasswordSettingsModel> get settings {
    if (_settings is EqualUnmodifiableListView) return _settings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_settings);
  }

  @override
  String toString() {
    return 'ManagePasswordSettingsEvent.load(settings: $settings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadImpl &&
            const DeepCollectionEquality().equals(other._settings, _settings));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_settings));

  /// Create a copy of ManagePasswordSettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadImplCopyWith<_$LoadImpl> get copyWith =>
      __$$LoadImplCopyWithImpl<_$LoadImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<UserPasswordSettingsModel> settings) load,
    required TResult Function(String newRole, UserPasswordSettingsModel target)
        updateRole,
    required TResult Function() save,
    required TResult Function() resetChanges,
  }) {
    return load(settings);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<UserPasswordSettingsModel> settings)? load,
    TResult? Function(String newRole, UserPasswordSettingsModel target)?
        updateRole,
    TResult? Function()? save,
    TResult? Function()? resetChanges,
  }) {
    return load?.call(settings);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<UserPasswordSettingsModel> settings)? load,
    TResult Function(String newRole, UserPasswordSettingsModel target)?
        updateRole,
    TResult Function()? save,
    TResult Function()? resetChanges,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(settings);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_UpdateRole value) updateRole,
    required TResult Function(_Save value) save,
    required TResult Function(_ResetChanges value) resetChanges,
  }) {
    return load(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_UpdateRole value)? updateRole,
    TResult? Function(_Save value)? save,
    TResult? Function(_ResetChanges value)? resetChanges,
  }) {
    return load?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_UpdateRole value)? updateRole,
    TResult Function(_Save value)? save,
    TResult Function(_ResetChanges value)? resetChanges,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(this);
    }
    return orElse();
  }
}

abstract class _Load implements ManagePasswordSettingsEvent {
  const factory _Load(final List<UserPasswordSettingsModel> settings) =
      _$LoadImpl;

  List<UserPasswordSettingsModel> get settings;

  /// Create a copy of ManagePasswordSettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadImplCopyWith<_$LoadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateRoleImplCopyWith<$Res> {
  factory _$$UpdateRoleImplCopyWith(
          _$UpdateRoleImpl value, $Res Function(_$UpdateRoleImpl) then) =
      __$$UpdateRoleImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String newRole, UserPasswordSettingsModel target});

  $UserPasswordSettingsModelCopyWith<$Res> get target;
}

/// @nodoc
class __$$UpdateRoleImplCopyWithImpl<$Res>
    extends _$ManagePasswordSettingsEventCopyWithImpl<$Res, _$UpdateRoleImpl>
    implements _$$UpdateRoleImplCopyWith<$Res> {
  __$$UpdateRoleImplCopyWithImpl(
      _$UpdateRoleImpl _value, $Res Function(_$UpdateRoleImpl) _then)
      : super(_value, _then);

  /// Create a copy of ManagePasswordSettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newRole = null,
    Object? target = null,
  }) {
    return _then(_$UpdateRoleImpl(
      newRole: null == newRole
          ? _value.newRole
          : newRole // ignore: cast_nullable_to_non_nullable
              as String,
      target: null == target
          ? _value.target
          : target // ignore: cast_nullable_to_non_nullable
              as UserPasswordSettingsModel,
    ));
  }

  /// Create a copy of ManagePasswordSettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserPasswordSettingsModelCopyWith<$Res> get target {
    return $UserPasswordSettingsModelCopyWith<$Res>(_value.target, (value) {
      return _then(_value.copyWith(target: value));
    });
  }
}

/// @nodoc

class _$UpdateRoleImpl implements _UpdateRole {
  const _$UpdateRoleImpl({required this.newRole, required this.target});

  @override
  final String newRole;
  @override
  final UserPasswordSettingsModel target;

  @override
  String toString() {
    return 'ManagePasswordSettingsEvent.updateRole(newRole: $newRole, target: $target)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateRoleImpl &&
            (identical(other.newRole, newRole) || other.newRole == newRole) &&
            (identical(other.target, target) || other.target == target));
  }

  @override
  int get hashCode => Object.hash(runtimeType, newRole, target);

  /// Create a copy of ManagePasswordSettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateRoleImplCopyWith<_$UpdateRoleImpl> get copyWith =>
      __$$UpdateRoleImplCopyWithImpl<_$UpdateRoleImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<UserPasswordSettingsModel> settings) load,
    required TResult Function(String newRole, UserPasswordSettingsModel target)
        updateRole,
    required TResult Function() save,
    required TResult Function() resetChanges,
  }) {
    return updateRole(newRole, target);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<UserPasswordSettingsModel> settings)? load,
    TResult? Function(String newRole, UserPasswordSettingsModel target)?
        updateRole,
    TResult? Function()? save,
    TResult? Function()? resetChanges,
  }) {
    return updateRole?.call(newRole, target);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<UserPasswordSettingsModel> settings)? load,
    TResult Function(String newRole, UserPasswordSettingsModel target)?
        updateRole,
    TResult Function()? save,
    TResult Function()? resetChanges,
    required TResult orElse(),
  }) {
    if (updateRole != null) {
      return updateRole(newRole, target);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_UpdateRole value) updateRole,
    required TResult Function(_Save value) save,
    required TResult Function(_ResetChanges value) resetChanges,
  }) {
    return updateRole(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_UpdateRole value)? updateRole,
    TResult? Function(_Save value)? save,
    TResult? Function(_ResetChanges value)? resetChanges,
  }) {
    return updateRole?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_UpdateRole value)? updateRole,
    TResult Function(_Save value)? save,
    TResult Function(_ResetChanges value)? resetChanges,
    required TResult orElse(),
  }) {
    if (updateRole != null) {
      return updateRole(this);
    }
    return orElse();
  }
}

abstract class _UpdateRole implements ManagePasswordSettingsEvent {
  const factory _UpdateRole(
      {required final String newRole,
      required final UserPasswordSettingsModel target}) = _$UpdateRoleImpl;

  String get newRole;
  UserPasswordSettingsModel get target;

  /// Create a copy of ManagePasswordSettingsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateRoleImplCopyWith<_$UpdateRoleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SaveImplCopyWith<$Res> {
  factory _$$SaveImplCopyWith(
          _$SaveImpl value, $Res Function(_$SaveImpl) then) =
      __$$SaveImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SaveImplCopyWithImpl<$Res>
    extends _$ManagePasswordSettingsEventCopyWithImpl<$Res, _$SaveImpl>
    implements _$$SaveImplCopyWith<$Res> {
  __$$SaveImplCopyWithImpl(_$SaveImpl _value, $Res Function(_$SaveImpl) _then)
      : super(_value, _then);

  /// Create a copy of ManagePasswordSettingsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SaveImpl implements _Save {
  const _$SaveImpl();

  @override
  String toString() {
    return 'ManagePasswordSettingsEvent.save()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SaveImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<UserPasswordSettingsModel> settings) load,
    required TResult Function(String newRole, UserPasswordSettingsModel target)
        updateRole,
    required TResult Function() save,
    required TResult Function() resetChanges,
  }) {
    return save();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<UserPasswordSettingsModel> settings)? load,
    TResult? Function(String newRole, UserPasswordSettingsModel target)?
        updateRole,
    TResult? Function()? save,
    TResult? Function()? resetChanges,
  }) {
    return save?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<UserPasswordSettingsModel> settings)? load,
    TResult Function(String newRole, UserPasswordSettingsModel target)?
        updateRole,
    TResult Function()? save,
    TResult Function()? resetChanges,
    required TResult orElse(),
  }) {
    if (save != null) {
      return save();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_UpdateRole value) updateRole,
    required TResult Function(_Save value) save,
    required TResult Function(_ResetChanges value) resetChanges,
  }) {
    return save(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_UpdateRole value)? updateRole,
    TResult? Function(_Save value)? save,
    TResult? Function(_ResetChanges value)? resetChanges,
  }) {
    return save?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_UpdateRole value)? updateRole,
    TResult Function(_Save value)? save,
    TResult Function(_ResetChanges value)? resetChanges,
    required TResult orElse(),
  }) {
    if (save != null) {
      return save(this);
    }
    return orElse();
  }
}

abstract class _Save implements ManagePasswordSettingsEvent {
  const factory _Save() = _$SaveImpl;
}

/// @nodoc
abstract class _$$ResetChangesImplCopyWith<$Res> {
  factory _$$ResetChangesImplCopyWith(
          _$ResetChangesImpl value, $Res Function(_$ResetChangesImpl) then) =
      __$$ResetChangesImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ResetChangesImplCopyWithImpl<$Res>
    extends _$ManagePasswordSettingsEventCopyWithImpl<$Res, _$ResetChangesImpl>
    implements _$$ResetChangesImplCopyWith<$Res> {
  __$$ResetChangesImplCopyWithImpl(
      _$ResetChangesImpl _value, $Res Function(_$ResetChangesImpl) _then)
      : super(_value, _then);

  /// Create a copy of ManagePasswordSettingsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ResetChangesImpl implements _ResetChanges {
  const _$ResetChangesImpl();

  @override
  String toString() {
    return 'ManagePasswordSettingsEvent.resetChanges()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ResetChangesImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<UserPasswordSettingsModel> settings) load,
    required TResult Function(String newRole, UserPasswordSettingsModel target)
        updateRole,
    required TResult Function() save,
    required TResult Function() resetChanges,
  }) {
    return resetChanges();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<UserPasswordSettingsModel> settings)? load,
    TResult? Function(String newRole, UserPasswordSettingsModel target)?
        updateRole,
    TResult? Function()? save,
    TResult? Function()? resetChanges,
  }) {
    return resetChanges?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<UserPasswordSettingsModel> settings)? load,
    TResult Function(String newRole, UserPasswordSettingsModel target)?
        updateRole,
    TResult Function()? save,
    TResult Function()? resetChanges,
    required TResult orElse(),
  }) {
    if (resetChanges != null) {
      return resetChanges();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_UpdateRole value) updateRole,
    required TResult Function(_Save value) save,
    required TResult Function(_ResetChanges value) resetChanges,
  }) {
    return resetChanges(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_UpdateRole value)? updateRole,
    TResult? Function(_Save value)? save,
    TResult? Function(_ResetChanges value)? resetChanges,
  }) {
    return resetChanges?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_UpdateRole value)? updateRole,
    TResult Function(_Save value)? save,
    TResult Function(_ResetChanges value)? resetChanges,
    required TResult orElse(),
  }) {
    if (resetChanges != null) {
      return resetChanges(this);
    }
    return orElse();
  }
}

abstract class _ResetChanges implements ManagePasswordSettingsEvent {
  const factory _ResetChanges() = _$ResetChangesImpl;
}

/// @nodoc
mixin _$ManagePasswordSettingsState {
  ManagePwdSettingsStatus get status => throw _privateConstructorUsedError;
  List<UserPasswordSettingsModel> get settings =>
      throw _privateConstructorUsedError;
  List<UserPasswordSettingsModel> get original =>
      throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  DateTime? get lastSavedAt => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            ManagePwdSettingsStatus status,
            List<UserPasswordSettingsModel> settings,
            List<UserPasswordSettingsModel> original,
            String? error,
            String? message,
            DateTime? lastSavedAt)
        loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            ManagePwdSettingsStatus status,
            List<UserPasswordSettingsModel> settings,
            List<UserPasswordSettingsModel> original,
            String? error,
            String? message,
            DateTime? lastSavedAt)?
        loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            ManagePwdSettingsStatus status,
            List<UserPasswordSettingsModel> settings,
            List<UserPasswordSettingsModel> original,
            String? error,
            String? message,
            DateTime? lastSavedAt)?
        loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loaded value) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loaded value)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loaded value)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of ManagePasswordSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ManagePasswordSettingsStateCopyWith<ManagePasswordSettingsState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ManagePasswordSettingsStateCopyWith<$Res> {
  factory $ManagePasswordSettingsStateCopyWith(
          ManagePasswordSettingsState value,
          $Res Function(ManagePasswordSettingsState) then) =
      _$ManagePasswordSettingsStateCopyWithImpl<$Res,
          ManagePasswordSettingsState>;
  @useResult
  $Res call(
      {ManagePwdSettingsStatus status,
      List<UserPasswordSettingsModel> settings,
      List<UserPasswordSettingsModel> original,
      String? error,
      String? message,
      DateTime? lastSavedAt});
}

/// @nodoc
class _$ManagePasswordSettingsStateCopyWithImpl<$Res,
        $Val extends ManagePasswordSettingsState>
    implements $ManagePasswordSettingsStateCopyWith<$Res> {
  _$ManagePasswordSettingsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ManagePasswordSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? settings = null,
    Object? original = null,
    Object? error = freezed,
    Object? message = freezed,
    Object? lastSavedAt = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ManagePwdSettingsStatus,
      settings: null == settings
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as List<UserPasswordSettingsModel>,
      original: null == original
          ? _value.original
          : original // ignore: cast_nullable_to_non_nullable
              as List<UserPasswordSettingsModel>,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      lastSavedAt: freezed == lastSavedAt
          ? _value.lastSavedAt
          : lastSavedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res>
    implements $ManagePasswordSettingsStateCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ManagePwdSettingsStatus status,
      List<UserPasswordSettingsModel> settings,
      List<UserPasswordSettingsModel> original,
      String? error,
      String? message,
      DateTime? lastSavedAt});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$ManagePasswordSettingsStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of ManagePasswordSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? settings = null,
    Object? original = null,
    Object? error = freezed,
    Object? message = freezed,
    Object? lastSavedAt = freezed,
  }) {
    return _then(_$LoadedImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ManagePwdSettingsStatus,
      settings: null == settings
          ? _value._settings
          : settings // ignore: cast_nullable_to_non_nullable
              as List<UserPasswordSettingsModel>,
      original: null == original
          ? _value._original
          : original // ignore: cast_nullable_to_non_nullable
              as List<UserPasswordSettingsModel>,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      lastSavedAt: freezed == lastSavedAt
          ? _value.lastSavedAt
          : lastSavedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(
      {this.status = ManagePwdSettingsStatus.initial,
      final List<UserPasswordSettingsModel> settings =
          const <UserPasswordSettingsModel>[],
      final List<UserPasswordSettingsModel> original =
          const <UserPasswordSettingsModel>[],
      this.error,
      this.message,
      this.lastSavedAt})
      : _settings = settings,
        _original = original;

  @override
  @JsonKey()
  final ManagePwdSettingsStatus status;
  final List<UserPasswordSettingsModel> _settings;
  @override
  @JsonKey()
  List<UserPasswordSettingsModel> get settings {
    if (_settings is EqualUnmodifiableListView) return _settings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_settings);
  }

  final List<UserPasswordSettingsModel> _original;
  @override
  @JsonKey()
  List<UserPasswordSettingsModel> get original {
    if (_original is EqualUnmodifiableListView) return _original;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_original);
  }

  @override
  final String? error;
  @override
  final String? message;
  @override
  final DateTime? lastSavedAt;

  @override
  String toString() {
    return 'ManagePasswordSettingsState.loaded(status: $status, settings: $settings, original: $original, error: $error, message: $message, lastSavedAt: $lastSavedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._settings, _settings) &&
            const DeepCollectionEquality().equals(other._original, _original) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.lastSavedAt, lastSavedAt) ||
                other.lastSavedAt == lastSavedAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      const DeepCollectionEquality().hash(_settings),
      const DeepCollectionEquality().hash(_original),
      error,
      message,
      lastSavedAt);

  /// Create a copy of ManagePasswordSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            ManagePwdSettingsStatus status,
            List<UserPasswordSettingsModel> settings,
            List<UserPasswordSettingsModel> original,
            String? error,
            String? message,
            DateTime? lastSavedAt)
        loaded,
  }) {
    return loaded(status, settings, original, error, message, lastSavedAt);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            ManagePwdSettingsStatus status,
            List<UserPasswordSettingsModel> settings,
            List<UserPasswordSettingsModel> original,
            String? error,
            String? message,
            DateTime? lastSavedAt)?
        loaded,
  }) {
    return loaded?.call(
        status, settings, original, error, message, lastSavedAt);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            ManagePwdSettingsStatus status,
            List<UserPasswordSettingsModel> settings,
            List<UserPasswordSettingsModel> original,
            String? error,
            String? message,
            DateTime? lastSavedAt)?
        loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(status, settings, original, error, message, lastSavedAt);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loaded value) loaded,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loaded value)? loaded,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loaded value)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements ManagePasswordSettingsState {
  const factory _Loaded(
      {final ManagePwdSettingsStatus status,
      final List<UserPasswordSettingsModel> settings,
      final List<UserPasswordSettingsModel> original,
      final String? error,
      final String? message,
      final DateTime? lastSavedAt}) = _$LoadedImpl;

  @override
  ManagePwdSettingsStatus get status;
  @override
  List<UserPasswordSettingsModel> get settings;
  @override
  List<UserPasswordSettingsModel> get original;
  @override
  String? get error;
  @override
  String? get message;
  @override
  DateTime? get lastSavedAt;

  /// Create a copy of ManagePasswordSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
