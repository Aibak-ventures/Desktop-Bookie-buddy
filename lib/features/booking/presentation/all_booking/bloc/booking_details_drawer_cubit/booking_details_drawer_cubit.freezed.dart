// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_details_drawer_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BookingDetailsDrawerState {
  bool get isOpen => throw _privateConstructorUsedError;
  int? get selectedBookingId => throw _privateConstructorUsedError;

  /// Create a copy of BookingDetailsDrawerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookingDetailsDrawerStateCopyWith<BookingDetailsDrawerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingDetailsDrawerStateCopyWith<$Res> {
  factory $BookingDetailsDrawerStateCopyWith(BookingDetailsDrawerState value,
          $Res Function(BookingDetailsDrawerState) then) =
      _$BookingDetailsDrawerStateCopyWithImpl<$Res, BookingDetailsDrawerState>;
  @useResult
  $Res call({bool isOpen, int? selectedBookingId});
}

/// @nodoc
class _$BookingDetailsDrawerStateCopyWithImpl<$Res,
        $Val extends BookingDetailsDrawerState>
    implements $BookingDetailsDrawerStateCopyWith<$Res> {
  _$BookingDetailsDrawerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookingDetailsDrawerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isOpen = null,
    Object? selectedBookingId = freezed,
  }) {
    return _then(_value.copyWith(
      isOpen: null == isOpen
          ? _value.isOpen
          : isOpen // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedBookingId: freezed == selectedBookingId
          ? _value.selectedBookingId
          : selectedBookingId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BookingDetailsDrawerStateImplCopyWith<$Res>
    implements $BookingDetailsDrawerStateCopyWith<$Res> {
  factory _$$BookingDetailsDrawerStateImplCopyWith(
          _$BookingDetailsDrawerStateImpl value,
          $Res Function(_$BookingDetailsDrawerStateImpl) then) =
      __$$BookingDetailsDrawerStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isOpen, int? selectedBookingId});
}

/// @nodoc
class __$$BookingDetailsDrawerStateImplCopyWithImpl<$Res>
    extends _$BookingDetailsDrawerStateCopyWithImpl<$Res,
        _$BookingDetailsDrawerStateImpl>
    implements _$$BookingDetailsDrawerStateImplCopyWith<$Res> {
  __$$BookingDetailsDrawerStateImplCopyWithImpl(
      _$BookingDetailsDrawerStateImpl _value,
      $Res Function(_$BookingDetailsDrawerStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookingDetailsDrawerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isOpen = null,
    Object? selectedBookingId = freezed,
  }) {
    return _then(_$BookingDetailsDrawerStateImpl(
      isOpen: null == isOpen
          ? _value.isOpen
          : isOpen // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedBookingId: freezed == selectedBookingId
          ? _value.selectedBookingId
          : selectedBookingId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$BookingDetailsDrawerStateImpl implements _BookingDetailsDrawerState {
  const _$BookingDetailsDrawerStateImpl(
      {this.isOpen = false, this.selectedBookingId});

  @override
  @JsonKey()
  final bool isOpen;
  @override
  final int? selectedBookingId;

  @override
  String toString() {
    return 'BookingDetailsDrawerState(isOpen: $isOpen, selectedBookingId: $selectedBookingId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingDetailsDrawerStateImpl &&
            (identical(other.isOpen, isOpen) || other.isOpen == isOpen) &&
            (identical(other.selectedBookingId, selectedBookingId) ||
                other.selectedBookingId == selectedBookingId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isOpen, selectedBookingId);

  /// Create a copy of BookingDetailsDrawerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookingDetailsDrawerStateImplCopyWith<_$BookingDetailsDrawerStateImpl>
      get copyWith => __$$BookingDetailsDrawerStateImplCopyWithImpl<
          _$BookingDetailsDrawerStateImpl>(this, _$identity);
}

abstract class _BookingDetailsDrawerState implements BookingDetailsDrawerState {
  const factory _BookingDetailsDrawerState(
      {final bool isOpen,
      final int? selectedBookingId}) = _$BookingDetailsDrawerStateImpl;

  @override
  bool get isOpen;
  @override
  int? get selectedBookingId;

  /// Create a copy of BookingDetailsDrawerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookingDetailsDrawerStateImplCopyWith<_$BookingDetailsDrawerStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
