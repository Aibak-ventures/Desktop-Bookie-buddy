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
  @JsonKey(name: 'total_upcoming')
  int get totalUpcoming => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_ongoing')
  int get totalOngoing => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_completed')
  int get totalCompleted => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_expired')
  int get totalExpired => throw _privateConstructorUsedError;
  @JsonKey(name: 'current_page')
  int get currentPage => throw _privateConstructorUsedError;
  @JsonKey(name: 'per_page')
  int get perPage => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_pages')
  int get totalPages => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_records')
  int get totalRecords => throw _privateConstructorUsedError;
  @JsonKey(name: 'prev_page_url')
  String? get prevPageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'next_page_url')
  String? get nextPageUrl => throw _privateConstructorUsedError;

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
      @JsonKey(name: 'total_upcoming') int totalUpcoming,
      @JsonKey(name: 'total_ongoing') int totalOngoing,
      @JsonKey(name: 'total_completed') int totalCompleted,
      @JsonKey(name: 'total_expired') int totalExpired,
      @JsonKey(name: 'current_page') int currentPage,
      @JsonKey(name: 'per_page') int perPage,
      @JsonKey(name: 'total_pages') int totalPages,
      @JsonKey(name: 'total_records') int totalRecords,
      @JsonKey(name: 'prev_page_url') String? prevPageUrl,
      @JsonKey(name: 'next_page_url') String? nextPageUrl});
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
    Object? totalUpcoming = null,
    Object? totalOngoing = null,
    Object? totalCompleted = null,
    Object? totalExpired = null,
    Object? currentPage = null,
    Object? perPage = null,
    Object? totalPages = null,
    Object? totalRecords = null,
    Object? prevPageUrl = freezed,
    Object? nextPageUrl = freezed,
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
      totalUpcoming: null == totalUpcoming
          ? _value.totalUpcoming
          : totalUpcoming // ignore: cast_nullable_to_non_nullable
              as int,
      totalOngoing: null == totalOngoing
          ? _value.totalOngoing
          : totalOngoing // ignore: cast_nullable_to_non_nullable
              as int,
      totalCompleted: null == totalCompleted
          ? _value.totalCompleted
          : totalCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      totalExpired: null == totalExpired
          ? _value.totalExpired
          : totalExpired // ignore: cast_nullable_to_non_nullable
              as int,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      perPage: null == perPage
          ? _value.perPage
          : perPage // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      totalRecords: null == totalRecords
          ? _value.totalRecords
          : totalRecords // ignore: cast_nullable_to_non_nullable
              as int,
      prevPageUrl: freezed == prevPageUrl
          ? _value.prevPageUrl
          : prevPageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      nextPageUrl: freezed == nextPageUrl
          ? _value.nextPageUrl
          : nextPageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
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
      @JsonKey(name: 'total_upcoming') int totalUpcoming,
      @JsonKey(name: 'total_ongoing') int totalOngoing,
      @JsonKey(name: 'total_completed') int totalCompleted,
      @JsonKey(name: 'total_expired') int totalExpired,
      @JsonKey(name: 'current_page') int currentPage,
      @JsonKey(name: 'per_page') int perPage,
      @JsonKey(name: 'total_pages') int totalPages,
      @JsonKey(name: 'total_records') int totalRecords,
      @JsonKey(name: 'prev_page_url') String? prevPageUrl,
      @JsonKey(name: 'next_page_url') String? nextPageUrl});
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
    Object? totalUpcoming = null,
    Object? totalOngoing = null,
    Object? totalCompleted = null,
    Object? totalExpired = null,
    Object? currentPage = null,
    Object? perPage = null,
    Object? totalPages = null,
    Object? totalRecords = null,
    Object? prevPageUrl = freezed,
    Object? nextPageUrl = freezed,
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
      totalUpcoming: null == totalUpcoming
          ? _value.totalUpcoming
          : totalUpcoming // ignore: cast_nullable_to_non_nullable
              as int,
      totalOngoing: null == totalOngoing
          ? _value.totalOngoing
          : totalOngoing // ignore: cast_nullable_to_non_nullable
              as int,
      totalCompleted: null == totalCompleted
          ? _value.totalCompleted
          : totalCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      totalExpired: null == totalExpired
          ? _value.totalExpired
          : totalExpired // ignore: cast_nullable_to_non_nullable
              as int,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      perPage: null == perPage
          ? _value.perPage
          : perPage // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      totalRecords: null == totalRecords
          ? _value.totalRecords
          : totalRecords // ignore: cast_nullable_to_non_nullable
              as int,
      prevPageUrl: freezed == prevPageUrl
          ? _value.prevPageUrl
          : prevPageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      nextPageUrl: freezed == nextPageUrl
          ? _value.nextPageUrl
          : nextPageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
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
      @JsonKey(name: 'total_upcoming') required this.totalUpcoming,
      @JsonKey(name: 'total_ongoing') required this.totalOngoing,
      @JsonKey(name: 'total_completed') required this.totalCompleted,
      @JsonKey(name: 'total_expired') required this.totalExpired,
      @JsonKey(name: 'current_page') required this.currentPage,
      @JsonKey(name: 'per_page') required this.perPage,
      @JsonKey(name: 'total_pages') required this.totalPages,
      @JsonKey(name: 'total_records') required this.totalRecords,
      @JsonKey(name: 'prev_page_url') this.prevPageUrl,
      @JsonKey(name: 'next_page_url') this.nextPageUrl})
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
  @JsonKey(name: 'total_upcoming')
  final int totalUpcoming;
  @override
  @JsonKey(name: 'total_ongoing')
  final int totalOngoing;
  @override
  @JsonKey(name: 'total_completed')
  final int totalCompleted;
  @override
  @JsonKey(name: 'total_expired')
  final int totalExpired;
  @override
  @JsonKey(name: 'current_page')
  final int currentPage;
  @override
  @JsonKey(name: 'per_page')
  final int perPage;
  @override
  @JsonKey(name: 'total_pages')
  final int totalPages;
  @override
  @JsonKey(name: 'total_records')
  final int totalRecords;
  @override
  @JsonKey(name: 'prev_page_url')
  final String? prevPageUrl;
  @override
  @JsonKey(name: 'next_page_url')
  final String? nextPageUrl;

  @override
  String toString() {
    return 'DesktopDashboardResponse(upcoming: $upcoming, ongoingBookings: $ongoingBookings, totalUpcoming: $totalUpcoming, totalOngoing: $totalOngoing, totalCompleted: $totalCompleted, totalExpired: $totalExpired, currentPage: $currentPage, perPage: $perPage, totalPages: $totalPages, totalRecords: $totalRecords, prevPageUrl: $prevPageUrl, nextPageUrl: $nextPageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DesktopDashboardResponseImpl &&
            const DeepCollectionEquality().equals(other._upcoming, _upcoming) &&
            const DeepCollectionEquality()
                .equals(other._ongoingBookings, _ongoingBookings) &&
            (identical(other.totalUpcoming, totalUpcoming) ||
                other.totalUpcoming == totalUpcoming) &&
            (identical(other.totalOngoing, totalOngoing) ||
                other.totalOngoing == totalOngoing) &&
            (identical(other.totalCompleted, totalCompleted) ||
                other.totalCompleted == totalCompleted) &&
            (identical(other.totalExpired, totalExpired) ||
                other.totalExpired == totalExpired) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.perPage, perPage) || other.perPage == perPage) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            (identical(other.totalRecords, totalRecords) ||
                other.totalRecords == totalRecords) &&
            (identical(other.prevPageUrl, prevPageUrl) ||
                other.prevPageUrl == prevPageUrl) &&
            (identical(other.nextPageUrl, nextPageUrl) ||
                other.nextPageUrl == nextPageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_upcoming),
      const DeepCollectionEquality().hash(_ongoingBookings),
      totalUpcoming,
      totalOngoing,
      totalCompleted,
      totalExpired,
      currentPage,
      perPage,
      totalPages,
      totalRecords,
      prevPageUrl,
      nextPageUrl);

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
      @JsonKey(name: 'total_upcoming') required final int totalUpcoming,
      @JsonKey(name: 'total_ongoing') required final int totalOngoing,
      @JsonKey(name: 'total_completed') required final int totalCompleted,
      @JsonKey(name: 'total_expired') required final int totalExpired,
      @JsonKey(name: 'current_page') required final int currentPage,
      @JsonKey(name: 'per_page') required final int perPage,
      @JsonKey(name: 'total_pages') required final int totalPages,
      @JsonKey(name: 'total_records') required final int totalRecords,
      @JsonKey(name: 'prev_page_url') final String? prevPageUrl,
      @JsonKey(name: 'next_page_url')
      final String? nextPageUrl}) = _$DesktopDashboardResponseImpl;

  factory _DesktopDashboardResponse.fromJson(Map<String, dynamic> json) =
      _$DesktopDashboardResponseImpl.fromJson;

  @override
  @JsonKey(name: 'upcoming')
  List<BookingsModel> get upcoming;
  @override
  @JsonKey(name: 'ongoing_bookings')
  List<BookingsModel> get ongoingBookings;
  @override
  @JsonKey(name: 'total_upcoming')
  int get totalUpcoming;
  @override
  @JsonKey(name: 'total_ongoing')
  int get totalOngoing;
  @override
  @JsonKey(name: 'total_completed')
  int get totalCompleted;
  @override
  @JsonKey(name: 'total_expired')
  int get totalExpired;
  @override
  @JsonKey(name: 'current_page')
  int get currentPage;
  @override
  @JsonKey(name: 'per_page')
  int get perPage;
  @override
  @JsonKey(name: 'total_pages')
  int get totalPages;
  @override
  @JsonKey(name: 'total_records')
  int get totalRecords;
  @override
  @JsonKey(name: 'prev_page_url')
  String? get prevPageUrl;
  @override
  @JsonKey(name: 'next_page_url')
  String? get nextPageUrl;

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
  @JsonKey(name: 'total_upcoming')
  int get totalUpcoming => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_ongoing')
  int get totalOngoing => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_completed')
  int get totalCompleted => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_expired')
  int get totalExpired => throw _privateConstructorUsedError;

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
      {@JsonKey(name: 'total_upcoming') int totalUpcoming,
      @JsonKey(name: 'total_ongoing') int totalOngoing,
      @JsonKey(name: 'total_completed') int totalCompleted,
      @JsonKey(name: 'total_expired') int totalExpired});
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
    Object? totalUpcoming = null,
    Object? totalOngoing = null,
    Object? totalCompleted = null,
    Object? totalExpired = null,
  }) {
    return _then(_value.copyWith(
      totalUpcoming: null == totalUpcoming
          ? _value.totalUpcoming
          : totalUpcoming // ignore: cast_nullable_to_non_nullable
              as int,
      totalOngoing: null == totalOngoing
          ? _value.totalOngoing
          : totalOngoing // ignore: cast_nullable_to_non_nullable
              as int,
      totalCompleted: null == totalCompleted
          ? _value.totalCompleted
          : totalCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      totalExpired: null == totalExpired
          ? _value.totalExpired
          : totalExpired // ignore: cast_nullable_to_non_nullable
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
      {@JsonKey(name: 'total_upcoming') int totalUpcoming,
      @JsonKey(name: 'total_ongoing') int totalOngoing,
      @JsonKey(name: 'total_completed') int totalCompleted,
      @JsonKey(name: 'total_expired') int totalExpired});
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
    Object? totalUpcoming = null,
    Object? totalOngoing = null,
    Object? totalCompleted = null,
    Object? totalExpired = null,
  }) {
    return _then(_$DesktopDashboardCarouselDataImpl(
      totalUpcoming: null == totalUpcoming
          ? _value.totalUpcoming
          : totalUpcoming // ignore: cast_nullable_to_non_nullable
              as int,
      totalOngoing: null == totalOngoing
          ? _value.totalOngoing
          : totalOngoing // ignore: cast_nullable_to_non_nullable
              as int,
      totalCompleted: null == totalCompleted
          ? _value.totalCompleted
          : totalCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      totalExpired: null == totalExpired
          ? _value.totalExpired
          : totalExpired // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DesktopDashboardCarouselDataImpl
    implements _DesktopDashboardCarouselData {
  const _$DesktopDashboardCarouselDataImpl(
      {@JsonKey(name: 'total_upcoming') required this.totalUpcoming,
      @JsonKey(name: 'total_ongoing') required this.totalOngoing,
      @JsonKey(name: 'total_completed') required this.totalCompleted,
      @JsonKey(name: 'total_expired') required this.totalExpired});

  factory _$DesktopDashboardCarouselDataImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$DesktopDashboardCarouselDataImplFromJson(json);

  @override
  @JsonKey(name: 'total_upcoming')
  final int totalUpcoming;
  @override
  @JsonKey(name: 'total_ongoing')
  final int totalOngoing;
  @override
  @JsonKey(name: 'total_completed')
  final int totalCompleted;
  @override
  @JsonKey(name: 'total_expired')
  final int totalExpired;

  @override
  String toString() {
    return 'DesktopDashboardCarouselData(totalUpcoming: $totalUpcoming, totalOngoing: $totalOngoing, totalCompleted: $totalCompleted, totalExpired: $totalExpired)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DesktopDashboardCarouselDataImpl &&
            (identical(other.totalUpcoming, totalUpcoming) ||
                other.totalUpcoming == totalUpcoming) &&
            (identical(other.totalOngoing, totalOngoing) ||
                other.totalOngoing == totalOngoing) &&
            (identical(other.totalCompleted, totalCompleted) ||
                other.totalCompleted == totalCompleted) &&
            (identical(other.totalExpired, totalExpired) ||
                other.totalExpired == totalExpired));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, totalUpcoming, totalOngoing, totalCompleted, totalExpired);

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
          {@JsonKey(name: 'total_upcoming') required final int totalUpcoming,
          @JsonKey(name: 'total_ongoing') required final int totalOngoing,
          @JsonKey(name: 'total_completed') required final int totalCompleted,
          @JsonKey(name: 'total_expired') required final int totalExpired}) =
      _$DesktopDashboardCarouselDataImpl;

  factory _DesktopDashboardCarouselData.fromJson(Map<String, dynamic> json) =
      _$DesktopDashboardCarouselDataImpl.fromJson;

  @override
  @JsonKey(name: 'total_upcoming')
  int get totalUpcoming;
  @override
  @JsonKey(name: 'total_ongoing')
  int get totalOngoing;
  @override
  @JsonKey(name: 'total_completed')
  int get totalCompleted;
  @override
  @JsonKey(name: 'total_expired')
  int get totalExpired;

  /// Create a copy of DesktopDashboardCarouselData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DesktopDashboardCarouselDataImplCopyWith<
          _$DesktopDashboardCarouselDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
