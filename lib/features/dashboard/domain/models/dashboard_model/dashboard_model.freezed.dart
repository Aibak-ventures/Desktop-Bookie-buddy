// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DashboardModel {
  PaginationModel<DashboardListModel> get data =>
      throw _privateConstructorUsedError;
  CarouselDataModel get carousel => throw _privateConstructorUsedError;

  /// Create a copy of DashboardModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DashboardModelCopyWith<DashboardModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardModelCopyWith<$Res> {
  factory $DashboardModelCopyWith(
          DashboardModel value, $Res Function(DashboardModel) then) =
      _$DashboardModelCopyWithImpl<$Res, DashboardModel>;
  @useResult
  $Res call(
      {PaginationModel<DashboardListModel> data, CarouselDataModel carousel});

  $PaginationModelCopyWith<DashboardListModel, $Res> get data;
  $CarouselDataModelCopyWith<$Res> get carousel;
}

/// @nodoc
class _$DashboardModelCopyWithImpl<$Res, $Val extends DashboardModel>
    implements $DashboardModelCopyWith<$Res> {
  _$DashboardModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DashboardModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? carousel = null,
  }) {
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as PaginationModel<DashboardListModel>,
      carousel: null == carousel
          ? _value.carousel
          : carousel // ignore: cast_nullable_to_non_nullable
              as CarouselDataModel,
    ) as $Val);
  }

  /// Create a copy of DashboardModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaginationModelCopyWith<DashboardListModel, $Res> get data {
    return $PaginationModelCopyWith<DashboardListModel, $Res>(_value.data,
        (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }

  /// Create a copy of DashboardModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CarouselDataModelCopyWith<$Res> get carousel {
    return $CarouselDataModelCopyWith<$Res>(_value.carousel, (value) {
      return _then(_value.copyWith(carousel: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DashboardModelImplCopyWith<$Res>
    implements $DashboardModelCopyWith<$Res> {
  factory _$$DashboardModelImplCopyWith(_$DashboardModelImpl value,
          $Res Function(_$DashboardModelImpl) then) =
      __$$DashboardModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PaginationModel<DashboardListModel> data, CarouselDataModel carousel});

  @override
  $PaginationModelCopyWith<DashboardListModel, $Res> get data;
  @override
  $CarouselDataModelCopyWith<$Res> get carousel;
}

/// @nodoc
class __$$DashboardModelImplCopyWithImpl<$Res>
    extends _$DashboardModelCopyWithImpl<$Res, _$DashboardModelImpl>
    implements _$$DashboardModelImplCopyWith<$Res> {
  __$$DashboardModelImplCopyWithImpl(
      _$DashboardModelImpl _value, $Res Function(_$DashboardModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of DashboardModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? carousel = null,
  }) {
    return _then(_$DashboardModelImpl(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as PaginationModel<DashboardListModel>,
      carousel: null == carousel
          ? _value.carousel
          : carousel // ignore: cast_nullable_to_non_nullable
              as CarouselDataModel,
    ));
  }
}

/// @nodoc

class _$DashboardModelImpl implements _DashboardModel {
  const _$DashboardModelImpl({required this.data, required this.carousel});

  @override
  final PaginationModel<DashboardListModel> data;
  @override
  final CarouselDataModel carousel;

  @override
  String toString() {
    return 'DashboardModel(data: $data, carousel: $carousel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardModelImpl &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.carousel, carousel) ||
                other.carousel == carousel));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data, carousel);

  /// Create a copy of DashboardModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardModelImplCopyWith<_$DashboardModelImpl> get copyWith =>
      __$$DashboardModelImplCopyWithImpl<_$DashboardModelImpl>(
          this, _$identity);
}

abstract class _DashboardModel implements DashboardModel {
  const factory _DashboardModel(
      {required final PaginationModel<DashboardListModel> data,
      required final CarouselDataModel carousel}) = _$DashboardModelImpl;

  @override
  PaginationModel<DashboardListModel> get data;
  @override
  CarouselDataModel get carousel;

  /// Create a copy of DashboardModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DashboardModelImplCopyWith<_$DashboardModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
