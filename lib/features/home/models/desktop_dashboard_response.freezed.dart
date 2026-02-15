// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'desktop_dashboard_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DesktopDashboardResponse _$DesktopDashboardResponseFromJson(
    Map<String, dynamic> json) {
  return _DesktopDashboardResponse.fromJson(json);
}

/// @nodoc
mixin _$DesktopDashboardResponse {
  @JsonKey(name: 'upcoming')
  List<BookingsModel> get upcoming => throw _privateConstructorUsedError;
  @JsonKey(name: 'ongoing_bookings')
  List<BookingsModel> get ongoingBookings => throw _privateConstructorUsedError;
  @JsonKey(name: 'upcoming_count')
  int get upcomingCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'alteration_booking_count')
  int get alterationBookingCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'completed_count')
  int get completedCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'expired_count')
  int get expiredCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'pagination')
  DesktopDashboardPagination get pagination =>
      throw _privateConstructorUsedError;

  /// Serializes this DesktopDashboardResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DesktopDashboardResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DesktopDashboardResponseCopyWith<DesktopDashboardResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DesktopDashboardResponseCopyWith<$Res> {
  factory $DesktopDashboardResponseCopyWith(DesktopDashboardResponse value,
          $Res Function(DesktopDashboardResponse) then) =
      _$DesktopDashboardResponseCopyWithImpl<$Res, DesktopDashboardResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'upcoming') List<BookingsModel> upcoming,
      @JsonKey(name: 'ongoing_bookings') List<BookingsModel> ongoingBookings,
      @JsonKey(name: 'upcoming_count') int upcomingCount,
      @JsonKey(name: 'alteration_booking_count') int alterationBookingCount,
      @JsonKey(name: 'completed_count') int completedCount,
      @JsonKey(name: 'expired_count') int expiredCount,
      @JsonKey(name: 'pagination') DesktopDashboardPagination pagination});

  $DesktopDashboardPaginationCopyWith<$Res> get pagination;
}

/// @nodoc
class _$DesktopDashboardResponseCopyWithImpl<$Res,
        $Val extends DesktopDashboardResponse>
    implements $DesktopDashboardResponseCopyWith<$Res> {
  _$DesktopDashboardResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DesktopDashboardResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? upcoming = null,
    Object? ongoingBookings = null,
    Object? upcomingCount = null,
    Object? alterationBookingCount = null,
    Object? completedCount = null,
    Object? expiredCount = null,
    Object? pagination = null,
  }) {
    return _then(_value.copyWith(
      upcoming: null == upcoming
          ? _value.upcoming
          : upcoming // ignore: cast_nullable_to_non_nullable
              as List<BookingsModel>,
      ongoingBookings: null == ongoingBookings
          ? _value.ongoingBookings
          : ongoingBookings // ignore: cast_nullable_to_non_nullable
              as List<BookingsModel>,
      upcomingCount: null == upcomingCount
          ? _value.upcomingCount
          : upcomingCount // ignore: cast_nullable_to_non_nullable
              as int,
      alterationBookingCount: null == alterationBookingCount
          ? _value.alterationBookingCount
          : alterationBookingCount // ignore: cast_nullable_to_non_nullable
              as int,
      completedCount: null == completedCount
          ? _value.completedCount
          : completedCount // ignore: cast_nullable_to_non_nullable
              as int,
      expiredCount: null == expiredCount
          ? _value.expiredCount
          : expiredCount // ignore: cast_nullable_to_non_nullable
              as int,
      pagination: null == pagination
          ? _value.pagination
          : pagination // ignore: cast_nullable_to_non_nullable
              as DesktopDashboardPagination,
    ) as $Val);
  }

  /// Create a copy of DesktopDashboardResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DesktopDashboardPaginationCopyWith<$Res> get pagination {
    return $DesktopDashboardPaginationCopyWith<$Res>(_value.pagination,
        (value) {
      return _then(_value.copyWith(pagination: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DesktopDashboardResponseImplCopyWith<$Res>
    implements $DesktopDashboardResponseCopyWith<$Res> {
  factory _$$DesktopDashboardResponseImplCopyWith(
          _$DesktopDashboardResponseImpl value,
          $Res Function(_$DesktopDashboardResponseImpl) then) =
      __$$DesktopDashboardResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'upcoming') List<BookingsModel> upcoming,
      @JsonKey(name: 'ongoing_bookings') List<BookingsModel> ongoingBookings,
      @JsonKey(name: 'upcoming_count') int upcomingCount,
      @JsonKey(name: 'alteration_booking_count') int alterationBookingCount,
      @JsonKey(name: 'completed_count') int completedCount,
      @JsonKey(name: 'expired_count') int expiredCount,
      @JsonKey(name: 'pagination') DesktopDashboardPagination pagination});

  @override
  $DesktopDashboardPaginationCopyWith<$Res> get pagination;
}

/// @nodoc
class __$$DesktopDashboardResponseImplCopyWithImpl<$Res>
    extends _$DesktopDashboardResponseCopyWithImpl<$Res,
        _$DesktopDashboardResponseImpl>
    implements _$$DesktopDashboardResponseImplCopyWith<$Res> {
  __$$DesktopDashboardResponseImplCopyWithImpl(
      _$DesktopDashboardResponseImpl _value,
      $Res Function(_$DesktopDashboardResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of DesktopDashboardResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? upcoming = null,
    Object? ongoingBookings = null,
    Object? upcomingCount = null,
    Object? alterationBookingCount = null,
    Object? completedCount = null,
    Object? expiredCount = null,
    Object? pagination = null,
  }) {
    return _then(_$DesktopDashboardResponseImpl(
      upcoming: null == upcoming
          ? _value._upcoming
          : upcoming // ignore: cast_nullable_to_non_nullable
              as List<BookingsModel>,
      ongoingBookings: null == ongoingBookings
          ? _value._ongoingBookings
          : ongoingBookings // ignore: cast_nullable_to_non_nullable
              as List<BookingsModel>,
      upcomingCount: null == upcomingCount
          ? _value.upcomingCount
          : upcomingCount // ignore: cast_nullable_to_non_nullable
              as int,
      alterationBookingCount: null == alterationBookingCount
          ? _value.alterationBookingCount
          : alterationBookingCount // ignore: cast_nullable_to_non_nullable
              as int,
      completedCount: null == completedCount
          ? _value.completedCount
          : completedCount // ignore: cast_nullable_to_non_nullable
              as int,
      expiredCount: null == expiredCount
          ? _value.expiredCount
          : expiredCount // ignore: cast_nullable_to_non_nullable
              as int,
      pagination: null == pagination
          ? _value.pagination
          : pagination // ignore: cast_nullable_to_non_nullable
              as DesktopDashboardPagination,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DesktopDashboardResponseImpl implements _DesktopDashboardResponse {
  const _$DesktopDashboardResponseImpl(
      {@JsonKey(name: 'upcoming') required final List<BookingsModel> upcoming,
      @JsonKey(name: 'ongoing_bookings')
      required final List<BookingsModel> ongoingBookings,
      @JsonKey(name: 'upcoming_count') required this.upcomingCount,
      @JsonKey(name: 'alteration_booking_count')
      required this.alterationBookingCount,
      @JsonKey(name: 'completed_count') required this.completedCount,
      @JsonKey(name: 'expired_count') required this.expiredCount,
      @JsonKey(name: 'pagination') required this.pagination})
      : _upcoming = upcoming,
        _ongoingBookings = ongoingBookings;

  factory _$DesktopDashboardResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$DesktopDashboardResponseImplFromJson(json);

  final List<BookingsModel> _upcoming;
  @override
  @JsonKey(name: 'upcoming')
  List<BookingsModel> get upcoming {
    if (_upcoming is EqualUnmodifiableListView) return _upcoming;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_upcoming);
  }

  final List<BookingsModel> _ongoingBookings;
  @override
  @JsonKey(name: 'ongoing_bookings')
  List<BookingsModel> get ongoingBookings {
    if (_ongoingBookings is EqualUnmodifiableListView) return _ongoingBookings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ongoingBookings);
  }

  @override
  @JsonKey(name: 'upcoming_count')
  final int upcomingCount;
  @override
  @JsonKey(name: 'alteration_booking_count')
  final int alterationBookingCount;
  @override
  @JsonKey(name: 'completed_count')
  final int completedCount;
  @override
  @JsonKey(name: 'expired_count')
  final int expiredCount;
  @override
  @JsonKey(name: 'pagination')
  final DesktopDashboardPagination pagination;

  @override
  String toString() {
    return 'DesktopDashboardResponse(upcoming: $upcoming, ongoingBookings: $ongoingBookings, upcomingCount: $upcomingCount, alterationBookingCount: $alterationBookingCount, completedCount: $completedCount, expiredCount: $expiredCount, pagination: $pagination)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DesktopDashboardResponseImpl &&
            const DeepCollectionEquality().equals(other._upcoming, _upcoming) &&
            const DeepCollectionEquality()
                .equals(other._ongoingBookings, _ongoingBookings) &&
            (identical(other.upcomingCount, upcomingCount) ||
                other.upcomingCount == upcomingCount) &&
            (identical(other.alterationBookingCount, alterationBookingCount) ||
                other.alterationBookingCount == alterationBookingCount) &&
            (identical(other.completedCount, completedCount) ||
                other.completedCount == completedCount) &&
            (identical(other.expiredCount, expiredCount) ||
                other.expiredCount == expiredCount) &&
            (identical(other.pagination, pagination) ||
                other.pagination == pagination));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_upcoming),
      const DeepCollectionEquality().hash(_ongoingBookings),
      upcomingCount,
      alterationBookingCount,
      completedCount,
      expiredCount,
      pagination);

  /// Create a copy of DesktopDashboardResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DesktopDashboardResponseImplCopyWith<_$DesktopDashboardResponseImpl>
      get copyWith => __$$DesktopDashboardResponseImplCopyWithImpl<
          _$DesktopDashboardResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DesktopDashboardResponseImplToJson(
      this,
    );
  }
}

abstract class _DesktopDashboardResponse implements DesktopDashboardResponse {
  const factory _DesktopDashboardResponse(
      {@JsonKey(name: 'upcoming') required final List<BookingsModel> upcoming,
      @JsonKey(name: 'ongoing_bookings')
      required final List<BookingsModel> ongoingBookings,
      @JsonKey(name: 'upcoming_count') required final int upcomingCount,
      @JsonKey(name: 'alteration_booking_count')
      required final int alterationBookingCount,
      @JsonKey(name: 'completed_count') required final int completedCount,
      @JsonKey(name: 'expired_count') required final int expiredCount,
      @JsonKey(name: 'pagination')
      required final DesktopDashboardPagination
          pagination}) = _$DesktopDashboardResponseImpl;

  factory _DesktopDashboardResponse.fromJson(Map<String, dynamic> json) =
      _$DesktopDashboardResponseImpl.fromJson;

  @override
  @JsonKey(name: 'upcoming')
  List<BookingsModel> get upcoming;
  @override
  @JsonKey(name: 'ongoing_bookings')
  List<BookingsModel> get ongoingBookings;
  @override
  @JsonKey(name: 'upcoming_count')
  int get upcomingCount;
  @override
  @JsonKey(name: 'alteration_booking_count')
  int get alterationBookingCount;
  @override
  @JsonKey(name: 'completed_count')
  int get completedCount;
  @override
  @JsonKey(name: 'expired_count')
  int get expiredCount;
  @override
  @JsonKey(name: 'pagination')
  DesktopDashboardPagination get pagination;

  /// Create a copy of DesktopDashboardResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DesktopDashboardResponseImplCopyWith<_$DesktopDashboardResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

DesktopDashboardCarouselData _$DesktopDashboardCarouselDataFromJson(
    Map<String, dynamic> json) {
  return _DesktopDashboardCarouselData.fromJson(json);
}

/// @nodoc
mixin _$DesktopDashboardCarouselData {
  int get upcomingCount => throw _privateConstructorUsedError;
  int get alterationBookingCount => throw _privateConstructorUsedError;
  int get completedCount => throw _privateConstructorUsedError;
  int get expiredCount => throw _privateConstructorUsedError;

  /// Serializes this DesktopDashboardCarouselData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DesktopDashboardCarouselData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DesktopDashboardCarouselDataCopyWith<DesktopDashboardCarouselData>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DesktopDashboardCarouselDataCopyWith<$Res> {
  factory $DesktopDashboardCarouselDataCopyWith(
          DesktopDashboardCarouselData value,
          $Res Function(DesktopDashboardCarouselData) then) =
      _$DesktopDashboardCarouselDataCopyWithImpl<$Res,
          DesktopDashboardCarouselData>;
  @useResult
  $Res call(
      {int upcomingCount,
      int alterationBookingCount,
      int completedCount,
      int expiredCount});
}

/// @nodoc
class _$DesktopDashboardCarouselDataCopyWithImpl<$Res,
        $Val extends DesktopDashboardCarouselData>
    implements $DesktopDashboardCarouselDataCopyWith<$Res> {
  _$DesktopDashboardCarouselDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DesktopDashboardCarouselData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? upcomingCount = null,
    Object? alterationBookingCount = null,
    Object? completedCount = null,
    Object? expiredCount = null,
  }) {
    return _then(_value.copyWith(
      upcomingCount: null == upcomingCount
          ? _value.upcomingCount
          : upcomingCount // ignore: cast_nullable_to_non_nullable
              as int,
      alterationBookingCount: null == alterationBookingCount
          ? _value.alterationBookingCount
          : alterationBookingCount // ignore: cast_nullable_to_non_nullable
              as int,
      completedCount: null == completedCount
          ? _value.completedCount
          : completedCount // ignore: cast_nullable_to_non_nullable
              as int,
      expiredCount: null == expiredCount
          ? _value.expiredCount
          : expiredCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DesktopDashboardCarouselDataImplCopyWith<$Res>
    implements $DesktopDashboardCarouselDataCopyWith<$Res> {
  factory _$$DesktopDashboardCarouselDataImplCopyWith(
          _$DesktopDashboardCarouselDataImpl value,
          $Res Function(_$DesktopDashboardCarouselDataImpl) then) =
      __$$DesktopDashboardCarouselDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int upcomingCount,
      int alterationBookingCount,
      int completedCount,
      int expiredCount});
}

/// @nodoc
class __$$DesktopDashboardCarouselDataImplCopyWithImpl<$Res>
    extends _$DesktopDashboardCarouselDataCopyWithImpl<$Res,
        _$DesktopDashboardCarouselDataImpl>
    implements _$$DesktopDashboardCarouselDataImplCopyWith<$Res> {
  __$$DesktopDashboardCarouselDataImplCopyWithImpl(
      _$DesktopDashboardCarouselDataImpl _value,
      $Res Function(_$DesktopDashboardCarouselDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of DesktopDashboardCarouselData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? upcomingCount = null,
    Object? alterationBookingCount = null,
    Object? completedCount = null,
    Object? expiredCount = null,
  }) {
    return _then(_$DesktopDashboardCarouselDataImpl(
      upcomingCount: null == upcomingCount
          ? _value.upcomingCount
          : upcomingCount // ignore: cast_nullable_to_non_nullable
              as int,
      alterationBookingCount: null == alterationBookingCount
          ? _value.alterationBookingCount
          : alterationBookingCount // ignore: cast_nullable_to_non_nullable
              as int,
      completedCount: null == completedCount
          ? _value.completedCount
          : completedCount // ignore: cast_nullable_to_non_nullable
              as int,
      expiredCount: null == expiredCount
          ? _value.expiredCount
          : expiredCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DesktopDashboardCarouselDataImpl
    implements _DesktopDashboardCarouselData {
  const _$DesktopDashboardCarouselDataImpl(
      {required this.upcomingCount,
      required this.alterationBookingCount,
      required this.completedCount,
      required this.expiredCount});

  factory _$DesktopDashboardCarouselDataImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$DesktopDashboardCarouselDataImplFromJson(json);

  @override
  final int upcomingCount;
  @override
  final int alterationBookingCount;
  @override
  final int completedCount;
  @override
  final int expiredCount;

  @override
  String toString() {
    return 'DesktopDashboardCarouselData(upcomingCount: $upcomingCount, alterationBookingCount: $alterationBookingCount, completedCount: $completedCount, expiredCount: $expiredCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DesktopDashboardCarouselDataImpl &&
            (identical(other.upcomingCount, upcomingCount) ||
                other.upcomingCount == upcomingCount) &&
            (identical(other.alterationBookingCount, alterationBookingCount) ||
                other.alterationBookingCount == alterationBookingCount) &&
            (identical(other.completedCount, completedCount) ||
                other.completedCount == completedCount) &&
            (identical(other.expiredCount, expiredCount) ||
                other.expiredCount == expiredCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, upcomingCount,
      alterationBookingCount, completedCount, expiredCount);

  /// Create a copy of DesktopDashboardCarouselData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DesktopDashboardCarouselDataImplCopyWith<
          _$DesktopDashboardCarouselDataImpl>
      get copyWith => __$$DesktopDashboardCarouselDataImplCopyWithImpl<
          _$DesktopDashboardCarouselDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DesktopDashboardCarouselDataImplToJson(
      this,
    );
  }
}

abstract class _DesktopDashboardCarouselData
    implements DesktopDashboardCarouselData {
  const factory _DesktopDashboardCarouselData(
      {required final int upcomingCount,
      required final int alterationBookingCount,
      required final int completedCount,
      required final int expiredCount}) = _$DesktopDashboardCarouselDataImpl;

  factory _DesktopDashboardCarouselData.fromJson(Map<String, dynamic> json) =
      _$DesktopDashboardCarouselDataImpl.fromJson;

  @override
  int get upcomingCount;
  @override
  int get alterationBookingCount;
  @override
  int get completedCount;
  @override
  int get expiredCount;

  /// Create a copy of DesktopDashboardCarouselData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DesktopDashboardCarouselDataImplCopyWith<
          _$DesktopDashboardCarouselDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}

DesktopDashboardPagination _$DesktopDashboardPaginationFromJson(
    Map<String, dynamic> json) {
  return _DesktopDashboardPagination.fromJson(json);
}

/// @nodoc
mixin _$DesktopDashboardPagination {
  @JsonKey(name: 'upcoming')
  PaginationInfo get upcoming => throw _privateConstructorUsedError;
  @JsonKey(name: 'ongoing')
  PaginationInfo get ongoing => throw _privateConstructorUsedError;

  /// Serializes this DesktopDashboardPagination to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DesktopDashboardPagination
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DesktopDashboardPaginationCopyWith<DesktopDashboardPagination>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DesktopDashboardPaginationCopyWith<$Res> {
  factory $DesktopDashboardPaginationCopyWith(DesktopDashboardPagination value,
          $Res Function(DesktopDashboardPagination) then) =
      _$DesktopDashboardPaginationCopyWithImpl<$Res,
          DesktopDashboardPagination>;
  @useResult
  $Res call(
      {@JsonKey(name: 'upcoming') PaginationInfo upcoming,
      @JsonKey(name: 'ongoing') PaginationInfo ongoing});

  $PaginationInfoCopyWith<$Res> get upcoming;
  $PaginationInfoCopyWith<$Res> get ongoing;
}

/// @nodoc
class _$DesktopDashboardPaginationCopyWithImpl<$Res,
        $Val extends DesktopDashboardPagination>
    implements $DesktopDashboardPaginationCopyWith<$Res> {
  _$DesktopDashboardPaginationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DesktopDashboardPagination
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? upcoming = null,
    Object? ongoing = null,
  }) {
    return _then(_value.copyWith(
      upcoming: null == upcoming
          ? _value.upcoming
          : upcoming // ignore: cast_nullable_to_non_nullable
              as PaginationInfo,
      ongoing: null == ongoing
          ? _value.ongoing
          : ongoing // ignore: cast_nullable_to_non_nullable
              as PaginationInfo,
    ) as $Val);
  }

  /// Create a copy of DesktopDashboardPagination
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaginationInfoCopyWith<$Res> get upcoming {
    return $PaginationInfoCopyWith<$Res>(_value.upcoming, (value) {
      return _then(_value.copyWith(upcoming: value) as $Val);
    });
  }

  /// Create a copy of DesktopDashboardPagination
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaginationInfoCopyWith<$Res> get ongoing {
    return $PaginationInfoCopyWith<$Res>(_value.ongoing, (value) {
      return _then(_value.copyWith(ongoing: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DesktopDashboardPaginationImplCopyWith<$Res>
    implements $DesktopDashboardPaginationCopyWith<$Res> {
  factory _$$DesktopDashboardPaginationImplCopyWith(
          _$DesktopDashboardPaginationImpl value,
          $Res Function(_$DesktopDashboardPaginationImpl) then) =
      __$$DesktopDashboardPaginationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'upcoming') PaginationInfo upcoming,
      @JsonKey(name: 'ongoing') PaginationInfo ongoing});

  @override
  $PaginationInfoCopyWith<$Res> get upcoming;
  @override
  $PaginationInfoCopyWith<$Res> get ongoing;
}

/// @nodoc
class __$$DesktopDashboardPaginationImplCopyWithImpl<$Res>
    extends _$DesktopDashboardPaginationCopyWithImpl<$Res,
        _$DesktopDashboardPaginationImpl>
    implements _$$DesktopDashboardPaginationImplCopyWith<$Res> {
  __$$DesktopDashboardPaginationImplCopyWithImpl(
      _$DesktopDashboardPaginationImpl _value,
      $Res Function(_$DesktopDashboardPaginationImpl) _then)
      : super(_value, _then);

  /// Create a copy of DesktopDashboardPagination
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? upcoming = null,
    Object? ongoing = null,
  }) {
    return _then(_$DesktopDashboardPaginationImpl(
      upcoming: null == upcoming
          ? _value.upcoming
          : upcoming // ignore: cast_nullable_to_non_nullable
              as PaginationInfo,
      ongoing: null == ongoing
          ? _value.ongoing
          : ongoing // ignore: cast_nullable_to_non_nullable
              as PaginationInfo,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DesktopDashboardPaginationImpl implements _DesktopDashboardPagination {
  const _$DesktopDashboardPaginationImpl(
      {@JsonKey(name: 'upcoming') required this.upcoming,
      @JsonKey(name: 'ongoing') required this.ongoing});

  factory _$DesktopDashboardPaginationImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$DesktopDashboardPaginationImplFromJson(json);

  @override
  @JsonKey(name: 'upcoming')
  final PaginationInfo upcoming;
  @override
  @JsonKey(name: 'ongoing')
  final PaginationInfo ongoing;

  @override
  String toString() {
    return 'DesktopDashboardPagination(upcoming: $upcoming, ongoing: $ongoing)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DesktopDashboardPaginationImpl &&
            (identical(other.upcoming, upcoming) ||
                other.upcoming == upcoming) &&
            (identical(other.ongoing, ongoing) || other.ongoing == ongoing));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, upcoming, ongoing);

  /// Create a copy of DesktopDashboardPagination
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DesktopDashboardPaginationImplCopyWith<_$DesktopDashboardPaginationImpl>
      get copyWith => __$$DesktopDashboardPaginationImplCopyWithImpl<
          _$DesktopDashboardPaginationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DesktopDashboardPaginationImplToJson(
      this,
    );
  }
}

abstract class _DesktopDashboardPagination
    implements DesktopDashboardPagination {
  const factory _DesktopDashboardPagination(
          {@JsonKey(name: 'upcoming') required final PaginationInfo upcoming,
          @JsonKey(name: 'ongoing') required final PaginationInfo ongoing}) =
      _$DesktopDashboardPaginationImpl;

  factory _DesktopDashboardPagination.fromJson(Map<String, dynamic> json) =
      _$DesktopDashboardPaginationImpl.fromJson;

  @override
  @JsonKey(name: 'upcoming')
  PaginationInfo get upcoming;
  @override
  @JsonKey(name: 'ongoing')
  PaginationInfo get ongoing;

  /// Create a copy of DesktopDashboardPagination
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DesktopDashboardPaginationImplCopyWith<_$DesktopDashboardPaginationImpl>
      get copyWith => throw _privateConstructorUsedError;
}

PaginationInfo _$PaginationInfoFromJson(Map<String, dynamic> json) {
  return _PaginationInfo.fromJson(json);
}

/// @nodoc
mixin _$PaginationInfo {
  String? get next => throw _privateConstructorUsedError;
  String? get previous => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  @JsonKey(name: 'page_size')
  int get pageSize => throw _privateConstructorUsedError;
  @JsonKey(name: 'current_page')
  int get currentPage => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_pages')
  int get totalPages => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_index')
  int get startIndex => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_index')
  int get endIndex => throw _privateConstructorUsedError;

  /// Serializes this PaginationInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaginationInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaginationInfoCopyWith<PaginationInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginationInfoCopyWith<$Res> {
  factory $PaginationInfoCopyWith(
          PaginationInfo value, $Res Function(PaginationInfo) then) =
      _$PaginationInfoCopyWithImpl<$Res, PaginationInfo>;
  @useResult
  $Res call(
      {String? next,
      String? previous,
      int count,
      @JsonKey(name: 'page_size') int pageSize,
      @JsonKey(name: 'current_page') int currentPage,
      @JsonKey(name: 'total_pages') int totalPages,
      @JsonKey(name: 'start_index') int startIndex,
      @JsonKey(name: 'end_index') int endIndex});
}

/// @nodoc
class _$PaginationInfoCopyWithImpl<$Res, $Val extends PaginationInfo>
    implements $PaginationInfoCopyWith<$Res> {
  _$PaginationInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaginationInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? next = freezed,
    Object? previous = freezed,
    Object? count = null,
    Object? pageSize = null,
    Object? currentPage = null,
    Object? totalPages = null,
    Object? startIndex = null,
    Object? endIndex = null,
  }) {
    return _then(_value.copyWith(
      next: freezed == next
          ? _value.next
          : next // ignore: cast_nullable_to_non_nullable
              as String?,
      previous: freezed == previous
          ? _value.previous
          : previous // ignore: cast_nullable_to_non_nullable
              as String?,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      startIndex: null == startIndex
          ? _value.startIndex
          : startIndex // ignore: cast_nullable_to_non_nullable
              as int,
      endIndex: null == endIndex
          ? _value.endIndex
          : endIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaginationInfoImplCopyWith<$Res>
    implements $PaginationInfoCopyWith<$Res> {
  factory _$$PaginationInfoImplCopyWith(_$PaginationInfoImpl value,
          $Res Function(_$PaginationInfoImpl) then) =
      __$$PaginationInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? next,
      String? previous,
      int count,
      @JsonKey(name: 'page_size') int pageSize,
      @JsonKey(name: 'current_page') int currentPage,
      @JsonKey(name: 'total_pages') int totalPages,
      @JsonKey(name: 'start_index') int startIndex,
      @JsonKey(name: 'end_index') int endIndex});
}

/// @nodoc
class __$$PaginationInfoImplCopyWithImpl<$Res>
    extends _$PaginationInfoCopyWithImpl<$Res, _$PaginationInfoImpl>
    implements _$$PaginationInfoImplCopyWith<$Res> {
  __$$PaginationInfoImplCopyWithImpl(
      _$PaginationInfoImpl _value, $Res Function(_$PaginationInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaginationInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? next = freezed,
    Object? previous = freezed,
    Object? count = null,
    Object? pageSize = null,
    Object? currentPage = null,
    Object? totalPages = null,
    Object? startIndex = null,
    Object? endIndex = null,
  }) {
    return _then(_$PaginationInfoImpl(
      next: freezed == next
          ? _value.next
          : next // ignore: cast_nullable_to_non_nullable
              as String?,
      previous: freezed == previous
          ? _value.previous
          : previous // ignore: cast_nullable_to_non_nullable
              as String?,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      startIndex: null == startIndex
          ? _value.startIndex
          : startIndex // ignore: cast_nullable_to_non_nullable
              as int,
      endIndex: null == endIndex
          ? _value.endIndex
          : endIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PaginationInfoImpl implements _PaginationInfo {
  const _$PaginationInfoImpl(
      {this.next,
      this.previous,
      required this.count,
      @JsonKey(name: 'page_size') required this.pageSize,
      @JsonKey(name: 'current_page') required this.currentPage,
      @JsonKey(name: 'total_pages') required this.totalPages,
      @JsonKey(name: 'start_index') required this.startIndex,
      @JsonKey(name: 'end_index') required this.endIndex});

  factory _$PaginationInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaginationInfoImplFromJson(json);

  @override
  final String? next;
  @override
  final String? previous;
  @override
  final int count;
  @override
  @JsonKey(name: 'page_size')
  final int pageSize;
  @override
  @JsonKey(name: 'current_page')
  final int currentPage;
  @override
  @JsonKey(name: 'total_pages')
  final int totalPages;
  @override
  @JsonKey(name: 'start_index')
  final int startIndex;
  @override
  @JsonKey(name: 'end_index')
  final int endIndex;

  @override
  String toString() {
    return 'PaginationInfo(next: $next, previous: $previous, count: $count, pageSize: $pageSize, currentPage: $currentPage, totalPages: $totalPages, startIndex: $startIndex, endIndex: $endIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaginationInfoImpl &&
            (identical(other.next, next) || other.next == next) &&
            (identical(other.previous, previous) ||
                other.previous == previous) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            (identical(other.startIndex, startIndex) ||
                other.startIndex == startIndex) &&
            (identical(other.endIndex, endIndex) ||
                other.endIndex == endIndex));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, next, previous, count, pageSize,
      currentPage, totalPages, startIndex, endIndex);

  /// Create a copy of PaginationInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaginationInfoImplCopyWith<_$PaginationInfoImpl> get copyWith =>
      __$$PaginationInfoImplCopyWithImpl<_$PaginationInfoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaginationInfoImplToJson(
      this,
    );
  }
}

abstract class _PaginationInfo implements PaginationInfo {
  const factory _PaginationInfo(
          {final String? next,
          final String? previous,
          required final int count,
          @JsonKey(name: 'page_size') required final int pageSize,
          @JsonKey(name: 'current_page') required final int currentPage,
          @JsonKey(name: 'total_pages') required final int totalPages,
          @JsonKey(name: 'start_index') required final int startIndex,
          @JsonKey(name: 'end_index') required final int endIndex}) =
      _$PaginationInfoImpl;

  factory _PaginationInfo.fromJson(Map<String, dynamic> json) =
      _$PaginationInfoImpl.fromJson;

  @override
  String? get next;
  @override
  String? get previous;
  @override
  int get count;
  @override
  @JsonKey(name: 'page_size')
  int get pageSize;
  @override
  @JsonKey(name: 'current_page')
  int get currentPage;
  @override
  @JsonKey(name: 'total_pages')
  int get totalPages;
  @override
  @JsonKey(name: 'start_index')
  int get startIndex;
  @override
  @JsonKey(name: 'end_index')
  int get endIndex;

  /// Create a copy of PaginationInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaginationInfoImplCopyWith<_$PaginationInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
