// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ledger_bookings_grouped_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LedgerBookingsGroupedModel _$LedgerBookingsGroupedModelFromJson(
  Map<String, dynamic> json,
) {
  return _LedgerBookingsGroupedModel.fromJson(json);
}

/// @nodoc
mixin _$LedgerBookingsGroupedModel {
  List<LedgerBookingDailyModel> get dailyBookings =>
      throw _privateConstructorUsedError;

  /// Serializes this LedgerBookingsGroupedModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LedgerBookingsGroupedModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LedgerBookingsGroupedModelCopyWith<LedgerBookingsGroupedModel>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LedgerBookingsGroupedModelCopyWith<$Res> {
  factory $LedgerBookingsGroupedModelCopyWith(
    LedgerBookingsGroupedModel value,
    $Res Function(LedgerBookingsGroupedModel) then,
  ) =
      _$LedgerBookingsGroupedModelCopyWithImpl<
        $Res,
        LedgerBookingsGroupedModel
      >;
  @useResult
  $Res call({List<LedgerBookingDailyModel> dailyBookings});
}

/// @nodoc
class _$LedgerBookingsGroupedModelCopyWithImpl<
  $Res,
  $Val extends LedgerBookingsGroupedModel
>
    implements $LedgerBookingsGroupedModelCopyWith<$Res> {
  _$LedgerBookingsGroupedModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LedgerBookingsGroupedModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? dailyBookings = null}) {
    return _then(
      _value.copyWith(
            dailyBookings: null == dailyBookings
                ? _value.dailyBookings
                : dailyBookings // ignore: cast_nullable_to_non_nullable
                      as List<LedgerBookingDailyModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LedgerBookingsGroupedModelImplCopyWith<$Res>
    implements $LedgerBookingsGroupedModelCopyWith<$Res> {
  factory _$$LedgerBookingsGroupedModelImplCopyWith(
    _$LedgerBookingsGroupedModelImpl value,
    $Res Function(_$LedgerBookingsGroupedModelImpl) then,
  ) = __$$LedgerBookingsGroupedModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<LedgerBookingDailyModel> dailyBookings});
}

/// @nodoc
class __$$LedgerBookingsGroupedModelImplCopyWithImpl<$Res>
    extends
        _$LedgerBookingsGroupedModelCopyWithImpl<
          $Res,
          _$LedgerBookingsGroupedModelImpl
        >
    implements _$$LedgerBookingsGroupedModelImplCopyWith<$Res> {
  __$$LedgerBookingsGroupedModelImplCopyWithImpl(
    _$LedgerBookingsGroupedModelImpl _value,
    $Res Function(_$LedgerBookingsGroupedModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LedgerBookingsGroupedModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? dailyBookings = null}) {
    return _then(
      _$LedgerBookingsGroupedModelImpl(
        dailyBookings: null == dailyBookings
            ? _value._dailyBookings
            : dailyBookings // ignore: cast_nullable_to_non_nullable
                  as List<LedgerBookingDailyModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LedgerBookingsGroupedModelImpl implements _LedgerBookingsGroupedModel {
  const _$LedgerBookingsGroupedModelImpl({
    required final List<LedgerBookingDailyModel> dailyBookings,
  }) : _dailyBookings = dailyBookings;

  factory _$LedgerBookingsGroupedModelImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$LedgerBookingsGroupedModelImplFromJson(json);

  final List<LedgerBookingDailyModel> _dailyBookings;
  @override
  List<LedgerBookingDailyModel> get dailyBookings {
    if (_dailyBookings is EqualUnmodifiableListView) return _dailyBookings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dailyBookings);
  }

  @override
  String toString() {
    return 'LedgerBookingsGroupedModel(dailyBookings: $dailyBookings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LedgerBookingsGroupedModelImpl &&
            const DeepCollectionEquality().equals(
              other._dailyBookings,
              _dailyBookings,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_dailyBookings),
  );

  /// Create a copy of LedgerBookingsGroupedModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LedgerBookingsGroupedModelImplCopyWith<_$LedgerBookingsGroupedModelImpl>
  get copyWith =>
      __$$LedgerBookingsGroupedModelImplCopyWithImpl<
        _$LedgerBookingsGroupedModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LedgerBookingsGroupedModelImplToJson(this);
  }
}

abstract class _LedgerBookingsGroupedModel
    implements LedgerBookingsGroupedModel {
  const factory _LedgerBookingsGroupedModel({
    required final List<LedgerBookingDailyModel> dailyBookings,
  }) = _$LedgerBookingsGroupedModelImpl;

  factory _LedgerBookingsGroupedModel.fromJson(Map<String, dynamic> json) =
      _$LedgerBookingsGroupedModelImpl.fromJson;

  @override
  List<LedgerBookingDailyModel> get dailyBookings;

  /// Create a copy of LedgerBookingsGroupedModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LedgerBookingsGroupedModelImplCopyWith<_$LedgerBookingsGroupedModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

LedgerBookingDailyModel _$LedgerBookingDailyModelFromJson(
  Map<String, dynamic> json,
) {
  return _LedgerBookingDailyModel.fromJson(json);
}

/// @nodoc
mixin _$LedgerBookingDailyModel {
  String get date => throw _privateConstructorUsedError;
  @JsonKey(name: 'total', defaultValue: 0)
  int get total => throw _privateConstructorUsedError;
  List<LedgerBookingModel> get bookings => throw _privateConstructorUsedError;

  /// Serializes this LedgerBookingDailyModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LedgerBookingDailyModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LedgerBookingDailyModelCopyWith<LedgerBookingDailyModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LedgerBookingDailyModelCopyWith<$Res> {
  factory $LedgerBookingDailyModelCopyWith(
    LedgerBookingDailyModel value,
    $Res Function(LedgerBookingDailyModel) then,
  ) = _$LedgerBookingDailyModelCopyWithImpl<$Res, LedgerBookingDailyModel>;
  @useResult
  $Res call({
    String date,
    @JsonKey(name: 'total', defaultValue: 0) int total,
    List<LedgerBookingModel> bookings,
  });
}

/// @nodoc
class _$LedgerBookingDailyModelCopyWithImpl<
  $Res,
  $Val extends LedgerBookingDailyModel
>
    implements $LedgerBookingDailyModelCopyWith<$Res> {
  _$LedgerBookingDailyModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LedgerBookingDailyModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? total = null,
    Object? bookings = null,
  }) {
    return _then(
      _value.copyWith(
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as String,
            total: null == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                      as int,
            bookings: null == bookings
                ? _value.bookings
                : bookings // ignore: cast_nullable_to_non_nullable
                      as List<LedgerBookingModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LedgerBookingDailyModelImplCopyWith<$Res>
    implements $LedgerBookingDailyModelCopyWith<$Res> {
  factory _$$LedgerBookingDailyModelImplCopyWith(
    _$LedgerBookingDailyModelImpl value,
    $Res Function(_$LedgerBookingDailyModelImpl) then,
  ) = __$$LedgerBookingDailyModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String date,
    @JsonKey(name: 'total', defaultValue: 0) int total,
    List<LedgerBookingModel> bookings,
  });
}

/// @nodoc
class __$$LedgerBookingDailyModelImplCopyWithImpl<$Res>
    extends
        _$LedgerBookingDailyModelCopyWithImpl<
          $Res,
          _$LedgerBookingDailyModelImpl
        >
    implements _$$LedgerBookingDailyModelImplCopyWith<$Res> {
  __$$LedgerBookingDailyModelImplCopyWithImpl(
    _$LedgerBookingDailyModelImpl _value,
    $Res Function(_$LedgerBookingDailyModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LedgerBookingDailyModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? total = null,
    Object? bookings = null,
  }) {
    return _then(
      _$LedgerBookingDailyModelImpl(
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as String,
        total: null == total
            ? _value.total
            : total // ignore: cast_nullable_to_non_nullable
                  as int,
        bookings: null == bookings
            ? _value._bookings
            : bookings // ignore: cast_nullable_to_non_nullable
                  as List<LedgerBookingModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LedgerBookingDailyModelImpl implements _LedgerBookingDailyModel {
  const _$LedgerBookingDailyModelImpl({
    required this.date,
    @JsonKey(name: 'total', defaultValue: 0) required this.total,
    required final List<LedgerBookingModel> bookings,
  }) : _bookings = bookings;

  factory _$LedgerBookingDailyModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LedgerBookingDailyModelImplFromJson(json);

  @override
  final String date;
  @override
  @JsonKey(name: 'total', defaultValue: 0)
  final int total;
  final List<LedgerBookingModel> _bookings;
  @override
  List<LedgerBookingModel> get bookings {
    if (_bookings is EqualUnmodifiableListView) return _bookings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bookings);
  }

  @override
  String toString() {
    return 'LedgerBookingDailyModel(date: $date, total: $total, bookings: $bookings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LedgerBookingDailyModelImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.total, total) || other.total == total) &&
            const DeepCollectionEquality().equals(other._bookings, _bookings));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    date,
    total,
    const DeepCollectionEquality().hash(_bookings),
  );

  /// Create a copy of LedgerBookingDailyModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LedgerBookingDailyModelImplCopyWith<_$LedgerBookingDailyModelImpl>
  get copyWith =>
      __$$LedgerBookingDailyModelImplCopyWithImpl<
        _$LedgerBookingDailyModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LedgerBookingDailyModelImplToJson(this);
  }
}

abstract class _LedgerBookingDailyModel implements LedgerBookingDailyModel {
  const factory _LedgerBookingDailyModel({
    required final String date,
    @JsonKey(name: 'total', defaultValue: 0) required final int total,
    required final List<LedgerBookingModel> bookings,
  }) = _$LedgerBookingDailyModelImpl;

  factory _LedgerBookingDailyModel.fromJson(Map<String, dynamic> json) =
      _$LedgerBookingDailyModelImpl.fromJson;

  @override
  String get date;
  @override
  @JsonKey(name: 'total', defaultValue: 0)
  int get total;
  @override
  List<LedgerBookingModel> get bookings;

  /// Create a copy of LedgerBookingDailyModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LedgerBookingDailyModelImplCopyWith<_$LedgerBookingDailyModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
