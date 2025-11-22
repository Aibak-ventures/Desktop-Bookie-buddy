// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'carousel_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CarouselDataModel _$CarouselDataModelFromJson(Map<String, dynamic> json) {
  return _CarouselDataModel.fromJson(json);
}

/// @nodoc
mixin _$CarouselDataModel {
  @JsonKey(name: 'upcoming_count', defaultValue: 0)
  int get upComingCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'completed_count', defaultValue: 0)
  int get completedCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'expired_count', defaultValue: 0)
  int get expiredCount => throw _privateConstructorUsedError;

  /// Serializes this CarouselDataModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CarouselDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CarouselDataModelCopyWith<CarouselDataModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CarouselDataModelCopyWith<$Res> {
  factory $CarouselDataModelCopyWith(
          CarouselDataModel value, $Res Function(CarouselDataModel) then) =
      _$CarouselDataModelCopyWithImpl<$Res, CarouselDataModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'upcoming_count', defaultValue: 0) int upComingCount,
      @JsonKey(name: 'completed_count', defaultValue: 0) int completedCount,
      @JsonKey(name: 'expired_count', defaultValue: 0) int expiredCount});
}

/// @nodoc
class _$CarouselDataModelCopyWithImpl<$Res, $Val extends CarouselDataModel>
    implements $CarouselDataModelCopyWith<$Res> {
  _$CarouselDataModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CarouselDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? upComingCount = null,
    Object? completedCount = null,
    Object? expiredCount = null,
  }) {
    return _then(_value.copyWith(
      upComingCount: null == upComingCount
          ? _value.upComingCount
          : upComingCount // ignore: cast_nullable_to_non_nullable
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
abstract class _$$CarouselDataModelImplCopyWith<$Res>
    implements $CarouselDataModelCopyWith<$Res> {
  factory _$$CarouselDataModelImplCopyWith(_$CarouselDataModelImpl value,
          $Res Function(_$CarouselDataModelImpl) then) =
      __$$CarouselDataModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'upcoming_count', defaultValue: 0) int upComingCount,
      @JsonKey(name: 'completed_count', defaultValue: 0) int completedCount,
      @JsonKey(name: 'expired_count', defaultValue: 0) int expiredCount});
}

/// @nodoc
class __$$CarouselDataModelImplCopyWithImpl<$Res>
    extends _$CarouselDataModelCopyWithImpl<$Res, _$CarouselDataModelImpl>
    implements _$$CarouselDataModelImplCopyWith<$Res> {
  __$$CarouselDataModelImplCopyWithImpl(_$CarouselDataModelImpl _value,
      $Res Function(_$CarouselDataModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of CarouselDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? upComingCount = null,
    Object? completedCount = null,
    Object? expiredCount = null,
  }) {
    return _then(_$CarouselDataModelImpl(
      upComingCount: null == upComingCount
          ? _value.upComingCount
          : upComingCount // ignore: cast_nullable_to_non_nullable
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
class _$CarouselDataModelImpl implements _CarouselDataModel {
  _$CarouselDataModelImpl(
      {@JsonKey(name: 'upcoming_count', defaultValue: 0)
      required this.upComingCount,
      @JsonKey(name: 'completed_count', defaultValue: 0)
      required this.completedCount,
      @JsonKey(name: 'expired_count', defaultValue: 0)
      required this.expiredCount});

  factory _$CarouselDataModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CarouselDataModelImplFromJson(json);

  @override
  @JsonKey(name: 'upcoming_count', defaultValue: 0)
  final int upComingCount;
  @override
  @JsonKey(name: 'completed_count', defaultValue: 0)
  final int completedCount;
  @override
  @JsonKey(name: 'expired_count', defaultValue: 0)
  final int expiredCount;

  @override
  String toString() {
    return 'CarouselDataModel(upComingCount: $upComingCount, completedCount: $completedCount, expiredCount: $expiredCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CarouselDataModelImpl &&
            (identical(other.upComingCount, upComingCount) ||
                other.upComingCount == upComingCount) &&
            (identical(other.completedCount, completedCount) ||
                other.completedCount == completedCount) &&
            (identical(other.expiredCount, expiredCount) ||
                other.expiredCount == expiredCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, upComingCount, completedCount, expiredCount);

  /// Create a copy of CarouselDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CarouselDataModelImplCopyWith<_$CarouselDataModelImpl> get copyWith =>
      __$$CarouselDataModelImplCopyWithImpl<_$CarouselDataModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CarouselDataModelImplToJson(
      this,
    );
  }
}

abstract class _CarouselDataModel implements CarouselDataModel {
  factory _CarouselDataModel(
      {@JsonKey(name: 'upcoming_count', defaultValue: 0)
      required final int upComingCount,
      @JsonKey(name: 'completed_count', defaultValue: 0)
      required final int completedCount,
      @JsonKey(name: 'expired_count', defaultValue: 0)
      required final int expiredCount}) = _$CarouselDataModelImpl;

  factory _CarouselDataModel.fromJson(Map<String, dynamic> json) =
      _$CarouselDataModelImpl.fromJson;

  @override
  @JsonKey(name: 'upcoming_count', defaultValue: 0)
  int get upComingCount;
  @override
  @JsonKey(name: 'completed_count', defaultValue: 0)
  int get completedCount;
  @override
  @JsonKey(name: 'expired_count', defaultValue: 0)
  int get expiredCount;

  /// Create a copy of CarouselDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CarouselDataModelImplCopyWith<_$CarouselDataModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
