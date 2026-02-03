// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sales_details_drawer_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SalesDetailsDrawerState {
  bool get isOpen => throw _privateConstructorUsedError;
  int? get selectedSaleId => throw _privateConstructorUsedError;

  /// Create a copy of SalesDetailsDrawerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SalesDetailsDrawerStateCopyWith<SalesDetailsDrawerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SalesDetailsDrawerStateCopyWith<$Res> {
  factory $SalesDetailsDrawerStateCopyWith(SalesDetailsDrawerState value,
          $Res Function(SalesDetailsDrawerState) then) =
      _$SalesDetailsDrawerStateCopyWithImpl<$Res, SalesDetailsDrawerState>;
  @useResult
  $Res call({bool isOpen, int? selectedSaleId});
}

/// @nodoc
class _$SalesDetailsDrawerStateCopyWithImpl<$Res,
        $Val extends SalesDetailsDrawerState>
    implements $SalesDetailsDrawerStateCopyWith<$Res> {
  _$SalesDetailsDrawerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SalesDetailsDrawerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isOpen = null,
    Object? selectedSaleId = freezed,
  }) {
    return _then(_value.copyWith(
      isOpen: null == isOpen
          ? _value.isOpen
          : isOpen // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedSaleId: freezed == selectedSaleId
          ? _value.selectedSaleId
          : selectedSaleId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SalesDetailsDrawerStateImplCopyWith<$Res>
    implements $SalesDetailsDrawerStateCopyWith<$Res> {
  factory _$$SalesDetailsDrawerStateImplCopyWith(
          _$SalesDetailsDrawerStateImpl value,
          $Res Function(_$SalesDetailsDrawerStateImpl) then) =
      __$$SalesDetailsDrawerStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isOpen, int? selectedSaleId});
}

/// @nodoc
class __$$SalesDetailsDrawerStateImplCopyWithImpl<$Res>
    extends _$SalesDetailsDrawerStateCopyWithImpl<$Res,
        _$SalesDetailsDrawerStateImpl>
    implements _$$SalesDetailsDrawerStateImplCopyWith<$Res> {
  __$$SalesDetailsDrawerStateImplCopyWithImpl(
      _$SalesDetailsDrawerStateImpl _value,
      $Res Function(_$SalesDetailsDrawerStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of SalesDetailsDrawerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isOpen = null,
    Object? selectedSaleId = freezed,
  }) {
    return _then(_$SalesDetailsDrawerStateImpl(
      isOpen: null == isOpen
          ? _value.isOpen
          : isOpen // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedSaleId: freezed == selectedSaleId
          ? _value.selectedSaleId
          : selectedSaleId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$SalesDetailsDrawerStateImpl implements _SalesDetailsDrawerState {
  const _$SalesDetailsDrawerStateImpl(
      {this.isOpen = false, this.selectedSaleId});

  @override
  @JsonKey()
  final bool isOpen;
  @override
  final int? selectedSaleId;

  @override
  String toString() {
    return 'SalesDetailsDrawerState(isOpen: $isOpen, selectedSaleId: $selectedSaleId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SalesDetailsDrawerStateImpl &&
            (identical(other.isOpen, isOpen) || other.isOpen == isOpen) &&
            (identical(other.selectedSaleId, selectedSaleId) ||
                other.selectedSaleId == selectedSaleId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isOpen, selectedSaleId);

  /// Create a copy of SalesDetailsDrawerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SalesDetailsDrawerStateImplCopyWith<_$SalesDetailsDrawerStateImpl>
      get copyWith => __$$SalesDetailsDrawerStateImplCopyWithImpl<
          _$SalesDetailsDrawerStateImpl>(this, _$identity);
}

abstract class _SalesDetailsDrawerState implements SalesDetailsDrawerState {
  const factory _SalesDetailsDrawerState(
      {final bool isOpen,
      final int? selectedSaleId}) = _$SalesDetailsDrawerStateImpl;

  @override
  bool get isOpen;
  @override
  int? get selectedSaleId;

  /// Create a copy of SalesDetailsDrawerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SalesDetailsDrawerStateImplCopyWith<_$SalesDetailsDrawerStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
