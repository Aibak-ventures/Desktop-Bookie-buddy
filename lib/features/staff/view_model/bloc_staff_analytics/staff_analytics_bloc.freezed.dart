// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'staff_analytics_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$StaffAnalyticsEvent {
  int get year => throw _privateConstructorUsedError;
  int get month => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int staffId, int year, int month)
        getStaffAnalytics,
    required TResult Function(int year, int month) changeMonth,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int staffId, int year, int month)? getStaffAnalytics,
    TResult? Function(int year, int month)? changeMonth,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int staffId, int year, int month)? getStaffAnalytics,
    TResult Function(int year, int month)? changeMonth,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetStaffAnalytics value) getStaffAnalytics,
    required TResult Function(_ChangeMonth value) changeMonth,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetStaffAnalytics value)? getStaffAnalytics,
    TResult? Function(_ChangeMonth value)? changeMonth,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetStaffAnalytics value)? getStaffAnalytics,
    TResult Function(_ChangeMonth value)? changeMonth,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of StaffAnalyticsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StaffAnalyticsEventCopyWith<StaffAnalyticsEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StaffAnalyticsEventCopyWith<$Res> {
  factory $StaffAnalyticsEventCopyWith(
    StaffAnalyticsEvent value,
    $Res Function(StaffAnalyticsEvent) then,
  ) = _$StaffAnalyticsEventCopyWithImpl<$Res, StaffAnalyticsEvent>;
  @useResult
  $Res call({int year, int month});
}

/// @nodoc
class _$StaffAnalyticsEventCopyWithImpl<$Res, $Val extends StaffAnalyticsEvent>
    implements $StaffAnalyticsEventCopyWith<$Res> {
  _$StaffAnalyticsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StaffAnalyticsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? year = null, Object? month = null}) {
    return _then(
      _value.copyWith(
        year: null == year
            ? _value.year
            : year // ignore: cast_nullable_to_non_nullable
                as int,
        month: null == month
            ? _value.month
            : month // ignore: cast_nullable_to_non_nullable
                as int,
      ) as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GetStaffAnalyticsImplCopyWith<$Res>
    implements $StaffAnalyticsEventCopyWith<$Res> {
  factory _$$GetStaffAnalyticsImplCopyWith(
    _$GetStaffAnalyticsImpl value,
    $Res Function(_$GetStaffAnalyticsImpl) then,
  ) = __$$GetStaffAnalyticsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int staffId, int year, int month});
}

/// @nodoc
class __$$GetStaffAnalyticsImplCopyWithImpl<$Res>
    extends _$StaffAnalyticsEventCopyWithImpl<$Res, _$GetStaffAnalyticsImpl>
    implements _$$GetStaffAnalyticsImplCopyWith<$Res> {
  __$$GetStaffAnalyticsImplCopyWithImpl(
    _$GetStaffAnalyticsImpl _value,
    $Res Function(_$GetStaffAnalyticsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StaffAnalyticsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? staffId = null,
    Object? year = null,
    Object? month = null,
  }) {
    return _then(
      _$GetStaffAnalyticsImpl(
        staffId: null == staffId
            ? _value.staffId
            : staffId // ignore: cast_nullable_to_non_nullable
                as int,
        year: null == year
            ? _value.year
            : year // ignore: cast_nullable_to_non_nullable
                as int,
        month: null == month
            ? _value.month
            : month // ignore: cast_nullable_to_non_nullable
                as int,
      ),
    );
  }
}

/// @nodoc

class _$GetStaffAnalyticsImpl implements _GetStaffAnalytics {
  const _$GetStaffAnalyticsImpl({
    required this.staffId,
    required this.year,
    required this.month,
  });

  @override
  final int staffId;
  @override
  final int year;
  @override
  final int month;

  @override
  String toString() {
    return 'StaffAnalyticsEvent.getStaffAnalytics(staffId: $staffId, year: $year, month: $month)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetStaffAnalyticsImpl &&
            (identical(other.staffId, staffId) || other.staffId == staffId) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.month, month) || other.month == month));
  }

  @override
  int get hashCode => Object.hash(runtimeType, staffId, year, month);

  /// Create a copy of StaffAnalyticsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetStaffAnalyticsImplCopyWith<_$GetStaffAnalyticsImpl> get copyWith =>
      __$$GetStaffAnalyticsImplCopyWithImpl<_$GetStaffAnalyticsImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int staffId, int year, int month)
        getStaffAnalytics,
    required TResult Function(int year, int month) changeMonth,
  }) {
    return getStaffAnalytics(staffId, year, month);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int staffId, int year, int month)? getStaffAnalytics,
    TResult? Function(int year, int month)? changeMonth,
  }) {
    return getStaffAnalytics?.call(staffId, year, month);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int staffId, int year, int month)? getStaffAnalytics,
    TResult Function(int year, int month)? changeMonth,
    required TResult orElse(),
  }) {
    if (getStaffAnalytics != null) {
      return getStaffAnalytics(staffId, year, month);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetStaffAnalytics value) getStaffAnalytics,
    required TResult Function(_ChangeMonth value) changeMonth,
  }) {
    return getStaffAnalytics(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetStaffAnalytics value)? getStaffAnalytics,
    TResult? Function(_ChangeMonth value)? changeMonth,
  }) {
    return getStaffAnalytics?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetStaffAnalytics value)? getStaffAnalytics,
    TResult Function(_ChangeMonth value)? changeMonth,
    required TResult orElse(),
  }) {
    if (getStaffAnalytics != null) {
      return getStaffAnalytics(this);
    }
    return orElse();
  }
}

abstract class _GetStaffAnalytics implements StaffAnalyticsEvent {
  const factory _GetStaffAnalytics({
    required final int staffId,
    required final int year,
    required final int month,
  }) = _$GetStaffAnalyticsImpl;

  int get staffId;
  @override
  int get year;
  @override
  int get month;

  /// Create a copy of StaffAnalyticsEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetStaffAnalyticsImplCopyWith<_$GetStaffAnalyticsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ChangeMonthImplCopyWith<$Res>
    implements $StaffAnalyticsEventCopyWith<$Res> {
  factory _$$ChangeMonthImplCopyWith(
    _$ChangeMonthImpl value,
    $Res Function(_$ChangeMonthImpl) then,
  ) = __$$ChangeMonthImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int year, int month});
}

/// @nodoc
class __$$ChangeMonthImplCopyWithImpl<$Res>
    extends _$StaffAnalyticsEventCopyWithImpl<$Res, _$ChangeMonthImpl>
    implements _$$ChangeMonthImplCopyWith<$Res> {
  __$$ChangeMonthImplCopyWithImpl(
    _$ChangeMonthImpl _value,
    $Res Function(_$ChangeMonthImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StaffAnalyticsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? year = null, Object? month = null}) {
    return _then(
      _$ChangeMonthImpl(
        year: null == year
            ? _value.year
            : year // ignore: cast_nullable_to_non_nullable
                as int,
        month: null == month
            ? _value.month
            : month // ignore: cast_nullable_to_non_nullable
                as int,
      ),
    );
  }
}

/// @nodoc

class _$ChangeMonthImpl implements _ChangeMonth {
  const _$ChangeMonthImpl({required this.year, required this.month});

  @override
  final int year;
  @override
  final int month;

  @override
  String toString() {
    return 'StaffAnalyticsEvent.changeMonth(year: $year, month: $month)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangeMonthImpl &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.month, month) || other.month == month));
  }

  @override
  int get hashCode => Object.hash(runtimeType, year, month);

  /// Create a copy of StaffAnalyticsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangeMonthImplCopyWith<_$ChangeMonthImpl> get copyWith =>
      __$$ChangeMonthImplCopyWithImpl<_$ChangeMonthImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int staffId, int year, int month)
        getStaffAnalytics,
    required TResult Function(int year, int month) changeMonth,
  }) {
    return changeMonth(year, month);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int staffId, int year, int month)? getStaffAnalytics,
    TResult? Function(int year, int month)? changeMonth,
  }) {
    return changeMonth?.call(year, month);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int staffId, int year, int month)? getStaffAnalytics,
    TResult Function(int year, int month)? changeMonth,
    required TResult orElse(),
  }) {
    if (changeMonth != null) {
      return changeMonth(year, month);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GetStaffAnalytics value) getStaffAnalytics,
    required TResult Function(_ChangeMonth value) changeMonth,
  }) {
    return changeMonth(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GetStaffAnalytics value)? getStaffAnalytics,
    TResult? Function(_ChangeMonth value)? changeMonth,
  }) {
    return changeMonth?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GetStaffAnalytics value)? getStaffAnalytics,
    TResult Function(_ChangeMonth value)? changeMonth,
    required TResult orElse(),
  }) {
    if (changeMonth != null) {
      return changeMonth(this);
    }
    return orElse();
  }
}

abstract class _ChangeMonth implements StaffAnalyticsEvent {
  const factory _ChangeMonth({
    required final int year,
    required final int month,
  }) = _$ChangeMonthImpl;

  @override
  int get year;
  @override
  int get month;

  /// Create a copy of StaffAnalyticsEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChangeMonthImplCopyWith<_$ChangeMonthImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$StaffAnalyticsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int year, int month) loading,
    required TResult Function(StaffAnalyticsModel staffReport) loaded,
    required TResult Function(String message, int? month, int? year) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int year, int month)? loading,
    TResult? Function(StaffAnalyticsModel staffReport)? loaded,
    TResult? Function(String message, int? month, int? year)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int year, int month)? loading,
    TResult Function(StaffAnalyticsModel staffReport)? loaded,
    TResult Function(String message, int? month, int? year)? error,
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
abstract class $StaffAnalyticsStateCopyWith<$Res> {
  factory $StaffAnalyticsStateCopyWith(
    StaffAnalyticsState value,
    $Res Function(StaffAnalyticsState) then,
  ) = _$StaffAnalyticsStateCopyWithImpl<$Res, StaffAnalyticsState>;
}

/// @nodoc
class _$StaffAnalyticsStateCopyWithImpl<$Res, $Val extends StaffAnalyticsState>
    implements $StaffAnalyticsStateCopyWith<$Res> {
  _$StaffAnalyticsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StaffAnalyticsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
    _$LoadingImpl value,
    $Res Function(_$LoadingImpl) then,
  ) = __$$LoadingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int year, int month});
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$StaffAnalyticsStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
    _$LoadingImpl _value,
    $Res Function(_$LoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StaffAnalyticsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? year = null, Object? month = null}) {
    return _then(
      _$LoadingImpl(
        year: null == year
            ? _value.year
            : year // ignore: cast_nullable_to_non_nullable
                as int,
        month: null == month
            ? _value.month
            : month // ignore: cast_nullable_to_non_nullable
                as int,
      ),
    );
  }
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl({required this.year, required this.month});

  @override
  final int year;
  @override
  final int month;

  @override
  String toString() {
    return 'StaffAnalyticsState.loading(year: $year, month: $month)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingImpl &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.month, month) || other.month == month));
  }

  @override
  int get hashCode => Object.hash(runtimeType, year, month);

  /// Create a copy of StaffAnalyticsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      __$$LoadingImplCopyWithImpl<_$LoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int year, int month) loading,
    required TResult Function(StaffAnalyticsModel staffReport) loaded,
    required TResult Function(String message, int? month, int? year) error,
  }) {
    return loading(year, month);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int year, int month)? loading,
    TResult? Function(StaffAnalyticsModel staffReport)? loaded,
    TResult? Function(String message, int? month, int? year)? error,
  }) {
    return loading?.call(year, month);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int year, int month)? loading,
    TResult Function(StaffAnalyticsModel staffReport)? loaded,
    TResult Function(String message, int? month, int? year)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(year, month);
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

abstract class _Loading implements StaffAnalyticsState {
  const factory _Loading({required final int year, required final int month}) =
      _$LoadingImpl;

  int get year;
  int get month;

  /// Create a copy of StaffAnalyticsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
    _$LoadedImpl value,
    $Res Function(_$LoadedImpl) then,
  ) = __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({StaffAnalyticsModel staffReport});

  $StaffAnalyticsModelCopyWith<$Res> get staffReport;
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$StaffAnalyticsStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
    _$LoadedImpl _value,
    $Res Function(_$LoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StaffAnalyticsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? staffReport = null}) {
    return _then(
      _$LoadedImpl(
        null == staffReport
            ? _value.staffReport
            : staffReport // ignore: cast_nullable_to_non_nullable
                as StaffAnalyticsModel,
      ),
    );
  }

  /// Create a copy of StaffAnalyticsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StaffAnalyticsModelCopyWith<$Res> get staffReport {
    return $StaffAnalyticsModelCopyWith<$Res>(_value.staffReport, (value) {
      return _then(_value.copyWith(staffReport: value));
    });
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(this.staffReport);

  @override
  final StaffAnalyticsModel staffReport;

  @override
  String toString() {
    return 'StaffAnalyticsState.loaded(staffReport: $staffReport)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            (identical(other.staffReport, staffReport) ||
                other.staffReport == staffReport));
  }

  @override
  int get hashCode => Object.hash(runtimeType, staffReport);

  /// Create a copy of StaffAnalyticsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int year, int month) loading,
    required TResult Function(StaffAnalyticsModel staffReport) loaded,
    required TResult Function(String message, int? month, int? year) error,
  }) {
    return loaded(staffReport);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int year, int month)? loading,
    TResult? Function(StaffAnalyticsModel staffReport)? loaded,
    TResult? Function(String message, int? month, int? year)? error,
  }) {
    return loaded?.call(staffReport);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int year, int month)? loading,
    TResult Function(StaffAnalyticsModel staffReport)? loaded,
    TResult Function(String message, int? month, int? year)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(staffReport);
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

abstract class _Loaded implements StaffAnalyticsState {
  const factory _Loaded(final StaffAnalyticsModel staffReport) = _$LoadedImpl;

  StaffAnalyticsModel get staffReport;

  /// Create a copy of StaffAnalyticsState
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
  $Res call({String message, int? month, int? year});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$StaffAnalyticsStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
    _$ErrorImpl _value,
    $Res Function(_$ErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StaffAnalyticsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? month = freezed,
    Object? year = freezed,
  }) {
    return _then(
      _$ErrorImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                as String,
        freezed == month
            ? _value.month
            : month // ignore: cast_nullable_to_non_nullable
                as int?,
        freezed == year
            ? _value.year
            : year // ignore: cast_nullable_to_non_nullable
                as int?,
      ),
    );
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.message, [this.month, this.year]);

  @override
  final String message;
  @override
  final int? month;
  @override
  final int? year;

  @override
  String toString() {
    return 'StaffAnalyticsState.error(message: $message, month: $month, year: $year)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.year, year) || other.year == year));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, month, year);

  /// Create a copy of StaffAnalyticsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int year, int month) loading,
    required TResult Function(StaffAnalyticsModel staffReport) loaded,
    required TResult Function(String message, int? month, int? year) error,
  }) {
    return error(message, month, year);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int year, int month)? loading,
    TResult? Function(StaffAnalyticsModel staffReport)? loaded,
    TResult? Function(String message, int? month, int? year)? error,
  }) {
    return error?.call(message, month, year);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int year, int month)? loading,
    TResult Function(StaffAnalyticsModel staffReport)? loaded,
    TResult Function(String message, int? month, int? year)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message, month, year);
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

abstract class _Error implements StaffAnalyticsState {
  const factory _Error(
    final String message, [
    final int? month,
    final int? year,
  ]) = _$ErrorImpl;

  String get message;
  int? get month;
  int? get year;

  /// Create a copy of StaffAnalyticsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
