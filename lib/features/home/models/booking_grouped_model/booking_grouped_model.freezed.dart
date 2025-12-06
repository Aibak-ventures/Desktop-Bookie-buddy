// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_grouped_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BookingGroupedModel {
  String get date => throw _privateConstructorUsedError;
  List<DashboardListModel> get bookings => throw _privateConstructorUsedError;

  /// Create a copy of BookingGroupedModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookingGroupedModelCopyWith<BookingGroupedModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingGroupedModelCopyWith<$Res> {
  factory $BookingGroupedModelCopyWith(
          BookingGroupedModel value, $Res Function(BookingGroupedModel) then) =
      _$BookingGroupedModelCopyWithImpl<$Res, BookingGroupedModel>;
  @useResult
  $Res call({String date, List<DashboardListModel> bookings});
}

/// @nodoc
class _$BookingGroupedModelCopyWithImpl<$Res, $Val extends BookingGroupedModel>
    implements $BookingGroupedModelCopyWith<$Res> {
  _$BookingGroupedModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookingGroupedModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? bookings = null,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      bookings: null == bookings
          ? _value.bookings
          : bookings // ignore: cast_nullable_to_non_nullable
              as List<DashboardListModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BookingGroupedModelImplCopyWith<$Res>
    implements $BookingGroupedModelCopyWith<$Res> {
  factory _$$BookingGroupedModelImplCopyWith(_$BookingGroupedModelImpl value,
          $Res Function(_$BookingGroupedModelImpl) then) =
      __$$BookingGroupedModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String date, List<DashboardListModel> bookings});
}

/// @nodoc
class __$$BookingGroupedModelImplCopyWithImpl<$Res>
    extends _$BookingGroupedModelCopyWithImpl<$Res, _$BookingGroupedModelImpl>
    implements _$$BookingGroupedModelImplCopyWith<$Res> {
  __$$BookingGroupedModelImplCopyWithImpl(_$BookingGroupedModelImpl _value,
      $Res Function(_$BookingGroupedModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookingGroupedModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? bookings = null,
  }) {
    return _then(_$BookingGroupedModelImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      bookings: null == bookings
          ? _value._bookings
          : bookings // ignore: cast_nullable_to_non_nullable
              as List<DashboardListModel>,
    ));
  }
}

/// @nodoc

class _$BookingGroupedModelImpl implements _BookingGroupedModel {
  const _$BookingGroupedModelImpl(
      {required this.date, required final List<DashboardListModel> bookings})
      : _bookings = bookings;

  @override
  final String date;
  final List<DashboardListModel> _bookings;
  @override
  List<DashboardListModel> get bookings {
    if (_bookings is EqualUnmodifiableListView) return _bookings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bookings);
  }

  @override
  String toString() {
    return 'BookingGroupedModel(date: $date, bookings: $bookings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingGroupedModelImpl &&
            (identical(other.date, date) || other.date == date) &&
            const DeepCollectionEquality().equals(other._bookings, _bookings));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, date, const DeepCollectionEquality().hash(_bookings));

  /// Create a copy of BookingGroupedModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookingGroupedModelImplCopyWith<_$BookingGroupedModelImpl> get copyWith =>
      __$$BookingGroupedModelImplCopyWithImpl<_$BookingGroupedModelImpl>(
          this, _$identity);
}

abstract class _BookingGroupedModel implements BookingGroupedModel {
  const factory _BookingGroupedModel(
          {required final String date,
          required final List<DashboardListModel> bookings}) =
      _$BookingGroupedModelImpl;

  @override
  String get date;
  @override
  List<DashboardListModel> get bookings;

  /// Create a copy of BookingGroupedModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookingGroupedModelImplCopyWith<_$BookingGroupedModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
