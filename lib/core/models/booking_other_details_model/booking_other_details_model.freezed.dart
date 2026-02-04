// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_other_details_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BookingOtherDetailsModel _$BookingOtherDetailsModelFromJson(
    Map<String, dynamic> json) {
  return _BookingOtherDetailsModel.fromJson(json);
}

/// @nodoc
mixin _$BookingOtherDetailsModel {
  @JsonKey(name: 'location_start')
  String? get locationStart => throw _privateConstructorUsedError;
  @JsonKey(name: 'location_from')
  String? get locationFrom => throw _privateConstructorUsedError;
  @JsonKey(name: 'location_to')
  String? get locationTo => throw _privateConstructorUsedError;
  @JsonKey(name: 'end')
  String? get end => throw _privateConstructorUsedError;

  /// Serializes this BookingOtherDetailsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BookingOtherDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookingOtherDetailsModelCopyWith<BookingOtherDetailsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingOtherDetailsModelCopyWith<$Res> {
  factory $BookingOtherDetailsModelCopyWith(BookingOtherDetailsModel value,
          $Res Function(BookingOtherDetailsModel) then) =
      _$BookingOtherDetailsModelCopyWithImpl<$Res, BookingOtherDetailsModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'location_start') String? locationStart,
      @JsonKey(name: 'location_from') String? locationFrom,
      @JsonKey(name: 'location_to') String? locationTo,
      @JsonKey(name: 'end') String? end});
}

/// @nodoc
class _$BookingOtherDetailsModelCopyWithImpl<$Res,
        $Val extends BookingOtherDetailsModel>
    implements $BookingOtherDetailsModelCopyWith<$Res> {
  _$BookingOtherDetailsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookingOtherDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? locationStart = freezed,
    Object? locationFrom = freezed,
    Object? locationTo = freezed,
    Object? end = freezed,
  }) {
    return _then(_value.copyWith(
      locationStart: freezed == locationStart
          ? _value.locationStart
          : locationStart // ignore: cast_nullable_to_non_nullable
              as String?,
      locationFrom: freezed == locationFrom
          ? _value.locationFrom
          : locationFrom // ignore: cast_nullable_to_non_nullable
              as String?,
      locationTo: freezed == locationTo
          ? _value.locationTo
          : locationTo // ignore: cast_nullable_to_non_nullable
              as String?,
      end: freezed == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BookingOtherDetailsModelImplCopyWith<$Res>
    implements $BookingOtherDetailsModelCopyWith<$Res> {
  factory _$$BookingOtherDetailsModelImplCopyWith(
          _$BookingOtherDetailsModelImpl value,
          $Res Function(_$BookingOtherDetailsModelImpl) then) =
      __$$BookingOtherDetailsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'location_start') String? locationStart,
      @JsonKey(name: 'location_from') String? locationFrom,
      @JsonKey(name: 'location_to') String? locationTo,
      @JsonKey(name: 'end') String? end});
}

/// @nodoc
class __$$BookingOtherDetailsModelImplCopyWithImpl<$Res>
    extends _$BookingOtherDetailsModelCopyWithImpl<$Res,
        _$BookingOtherDetailsModelImpl>
    implements _$$BookingOtherDetailsModelImplCopyWith<$Res> {
  __$$BookingOtherDetailsModelImplCopyWithImpl(
      _$BookingOtherDetailsModelImpl _value,
      $Res Function(_$BookingOtherDetailsModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookingOtherDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? locationStart = freezed,
    Object? locationFrom = freezed,
    Object? locationTo = freezed,
    Object? end = freezed,
  }) {
    return _then(_$BookingOtherDetailsModelImpl(
      locationStart: freezed == locationStart
          ? _value.locationStart
          : locationStart // ignore: cast_nullable_to_non_nullable
              as String?,
      locationFrom: freezed == locationFrom
          ? _value.locationFrom
          : locationFrom // ignore: cast_nullable_to_non_nullable
              as String?,
      locationTo: freezed == locationTo
          ? _value.locationTo
          : locationTo // ignore: cast_nullable_to_non_nullable
              as String?,
      end: freezed == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(
    fieldRename: FieldRename.snake, includeIfNull: false, createToJson: true)
class _$BookingOtherDetailsModelImpl implements _BookingOtherDetailsModel {
  const _$BookingOtherDetailsModelImpl(
      {@JsonKey(name: 'location_start') this.locationStart,
      @JsonKey(name: 'location_from') this.locationFrom,
      @JsonKey(name: 'location_to') this.locationTo,
      @JsonKey(name: 'end') this.end});

  factory _$BookingOtherDetailsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookingOtherDetailsModelImplFromJson(json);

  @override
  @JsonKey(name: 'location_start')
  final String? locationStart;
  @override
  @JsonKey(name: 'location_from')
  final String? locationFrom;
  @override
  @JsonKey(name: 'location_to')
  final String? locationTo;
  @override
  @JsonKey(name: 'end')
  final String? end;

  @override
  String toString() {
    return 'BookingOtherDetailsModel(locationStart: $locationStart, locationFrom: $locationFrom, locationTo: $locationTo, end: $end)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingOtherDetailsModelImpl &&
            (identical(other.locationStart, locationStart) ||
                other.locationStart == locationStart) &&
            (identical(other.locationFrom, locationFrom) ||
                other.locationFrom == locationFrom) &&
            (identical(other.locationTo, locationTo) ||
                other.locationTo == locationTo) &&
            (identical(other.end, end) || other.end == end));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, locationStart, locationFrom, locationTo, end);

  /// Create a copy of BookingOtherDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookingOtherDetailsModelImplCopyWith<_$BookingOtherDetailsModelImpl>
      get copyWith => __$$BookingOtherDetailsModelImplCopyWithImpl<
          _$BookingOtherDetailsModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookingOtherDetailsModelImplToJson(
      this,
    );
  }
}

abstract class _BookingOtherDetailsModel implements BookingOtherDetailsModel {
  const factory _BookingOtherDetailsModel(
          {@JsonKey(name: 'location_start') final String? locationStart,
          @JsonKey(name: 'location_from') final String? locationFrom,
          @JsonKey(name: 'location_to') final String? locationTo,
          @JsonKey(name: 'end') final String? end}) =
      _$BookingOtherDetailsModelImpl;

  factory _BookingOtherDetailsModel.fromJson(Map<String, dynamic> json) =
      _$BookingOtherDetailsModelImpl.fromJson;

  @override
  @JsonKey(name: 'location_start')
  String? get locationStart;
  @override
  @JsonKey(name: 'location_from')
  String? get locationFrom;
  @override
  @JsonKey(name: 'location_to')
  String? get locationTo;
  @override
  @JsonKey(name: 'end')
  String? get end;

  /// Create a copy of BookingOtherDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookingOtherDetailsModelImplCopyWith<_$BookingOtherDetailsModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
