// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'staff_search_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$StaffSearchState {
  List<StaffEntity> get staffs => throw _privateConstructorUsedError;
  StaffEntity? get selectedStaff => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  /// Create a copy of StaffSearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StaffSearchStateCopyWith<StaffSearchState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StaffSearchStateCopyWith<$Res> {
  factory $StaffSearchStateCopyWith(
          StaffSearchState value, $Res Function(StaffSearchState) then) =
      _$StaffSearchStateCopyWithImpl<$Res, StaffSearchState>;
  @useResult
  $Res call(
      {List<StaffEntity> staffs,
      StaffEntity? selectedStaff,
      String? errorMessage,
      bool isLoading});

  $StaffEntityCopyWith<$Res>? get selectedStaff;
}

/// @nodoc
class _$StaffSearchStateCopyWithImpl<$Res, $Val extends StaffSearchState>
    implements $StaffSearchStateCopyWith<$Res> {
  _$StaffSearchStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StaffSearchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? staffs = null,
    Object? selectedStaff = freezed,
    Object? errorMessage = freezed,
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
      staffs: null == staffs
          ? _value.staffs
          : staffs // ignore: cast_nullable_to_non_nullable
              as List<StaffEntity>,
      selectedStaff: freezed == selectedStaff
          ? _value.selectedStaff
          : selectedStaff // ignore: cast_nullable_to_non_nullable
              as StaffEntity?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of StaffSearchState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StaffEntityCopyWith<$Res>? get selectedStaff {
    if (_value.selectedStaff == null) {
      return null;
    }

    return $StaffEntityCopyWith<$Res>(_value.selectedStaff!, (value) {
      return _then(_value.copyWith(selectedStaff: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$StaffSearchStateImplCopyWith<$Res>
    implements $StaffSearchStateCopyWith<$Res> {
  factory _$$StaffSearchStateImplCopyWith(_$StaffSearchStateImpl value,
          $Res Function(_$StaffSearchStateImpl) then) =
      __$$StaffSearchStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<StaffEntity> staffs,
      StaffEntity? selectedStaff,
      String? errorMessage,
      bool isLoading});

  @override
  $StaffEntityCopyWith<$Res>? get selectedStaff;
}

/// @nodoc
class __$$StaffSearchStateImplCopyWithImpl<$Res>
    extends _$StaffSearchStateCopyWithImpl<$Res, _$StaffSearchStateImpl>
    implements _$$StaffSearchStateImplCopyWith<$Res> {
  __$$StaffSearchStateImplCopyWithImpl(_$StaffSearchStateImpl _value,
      $Res Function(_$StaffSearchStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of StaffSearchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? staffs = null,
    Object? selectedStaff = freezed,
    Object? errorMessage = freezed,
    Object? isLoading = null,
  }) {
    return _then(_$StaffSearchStateImpl(
      staffs: null == staffs
          ? _value._staffs
          : staffs // ignore: cast_nullable_to_non_nullable
              as List<StaffEntity>,
      selectedStaff: freezed == selectedStaff
          ? _value.selectedStaff
          : selectedStaff // ignore: cast_nullable_to_non_nullable
              as StaffEntity?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$StaffSearchStateImpl implements _StaffSearchState {
  const _$StaffSearchStateImpl(
      {final List<StaffEntity> staffs = const [],
      this.selectedStaff,
      this.errorMessage,
      this.isLoading = false})
      : _staffs = staffs;

  final List<StaffEntity> _staffs;
  @override
  @JsonKey()
  List<StaffEntity> get staffs {
    if (_staffs is EqualUnmodifiableListView) return _staffs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_staffs);
  }

  @override
  final StaffEntity? selectedStaff;
  @override
  final String? errorMessage;
  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'StaffSearchState(staffs: $staffs, selectedStaff: $selectedStaff, errorMessage: $errorMessage, isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StaffSearchStateImpl &&
            const DeepCollectionEquality().equals(other._staffs, _staffs) &&
            (identical(other.selectedStaff, selectedStaff) ||
                other.selectedStaff == selectedStaff) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_staffs),
      selectedStaff,
      errorMessage,
      isLoading);

  /// Create a copy of StaffSearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StaffSearchStateImplCopyWith<_$StaffSearchStateImpl> get copyWith =>
      __$$StaffSearchStateImplCopyWithImpl<_$StaffSearchStateImpl>(
          this, _$identity);
}

abstract class _StaffSearchState implements StaffSearchState {
  const factory _StaffSearchState(
      {final List<StaffEntity> staffs,
      final StaffEntity? selectedStaff,
      final String? errorMessage,
      final bool isLoading}) = _$StaffSearchStateImpl;

  @override
  List<StaffEntity> get staffs;
  @override
  StaffEntity? get selectedStaff;
  @override
  String? get errorMessage;
  @override
  bool get isLoading;

  /// Create a copy of StaffSearchState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StaffSearchStateImplCopyWith<_$StaffSearchStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
