// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bug_report_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BugReportModel _$BugReportModelFromJson(Map<String, dynamic> json) {
  return _BugReportModel.fromJson(json);
}

/// @nodoc
mixin _$BugReportModel {
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  Map<String, dynamic> get moreDetails => throw _privateConstructorUsedError;
  String? get image1 => throw _privateConstructorUsedError;
  String? get image2 => throw _privateConstructorUsedError;

  /// Serializes this BugReportModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BugReportModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BugReportModelCopyWith<BugReportModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BugReportModelCopyWith<$Res> {
  factory $BugReportModelCopyWith(
          BugReportModel value, $Res Function(BugReportModel) then) =
      _$BugReportModelCopyWithImpl<$Res, BugReportModel>;
  @useResult
  $Res call(
      {String title,
      String description,
      Map<String, dynamic> moreDetails,
      String? image1,
      String? image2});
}

/// @nodoc
class _$BugReportModelCopyWithImpl<$Res, $Val extends BugReportModel>
    implements $BugReportModelCopyWith<$Res> {
  _$BugReportModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BugReportModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = null,
    Object? moreDetails = null,
    Object? image1 = freezed,
    Object? image2 = freezed,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      moreDetails: null == moreDetails
          ? _value.moreDetails
          : moreDetails // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      image1: freezed == image1
          ? _value.image1
          : image1 // ignore: cast_nullable_to_non_nullable
              as String?,
      image2: freezed == image2
          ? _value.image2
          : image2 // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BugReportModelImplCopyWith<$Res>
    implements $BugReportModelCopyWith<$Res> {
  factory _$$BugReportModelImplCopyWith(_$BugReportModelImpl value,
          $Res Function(_$BugReportModelImpl) then) =
      __$$BugReportModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String description,
      Map<String, dynamic> moreDetails,
      String? image1,
      String? image2});
}

/// @nodoc
class __$$BugReportModelImplCopyWithImpl<$Res>
    extends _$BugReportModelCopyWithImpl<$Res, _$BugReportModelImpl>
    implements _$$BugReportModelImplCopyWith<$Res> {
  __$$BugReportModelImplCopyWithImpl(
      _$BugReportModelImpl _value, $Res Function(_$BugReportModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of BugReportModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = null,
    Object? moreDetails = null,
    Object? image1 = freezed,
    Object? image2 = freezed,
  }) {
    return _then(_$BugReportModelImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      moreDetails: null == moreDetails
          ? _value._moreDetails
          : moreDetails // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      image1: freezed == image1
          ? _value.image1
          : image1 // ignore: cast_nullable_to_non_nullable
              as String?,
      image2: freezed == image2
          ? _value.image2
          : image2 // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BugReportModelImpl implements _BugReportModel {
  const _$BugReportModelImpl(
      {required this.title,
      required this.description,
      final Map<String, dynamic> moreDetails = const {},
      this.image1,
      this.image2})
      : _moreDetails = moreDetails;

  factory _$BugReportModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BugReportModelImplFromJson(json);

  @override
  final String title;
  @override
  final String description;
  final Map<String, dynamic> _moreDetails;
  @override
  @JsonKey()
  Map<String, dynamic> get moreDetails {
    if (_moreDetails is EqualUnmodifiableMapView) return _moreDetails;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_moreDetails);
  }

  @override
  final String? image1;
  @override
  final String? image2;

  @override
  String toString() {
    return 'BugReportModel(title: $title, description: $description, moreDetails: $moreDetails, image1: $image1, image2: $image2)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BugReportModelImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._moreDetails, _moreDetails) &&
            (identical(other.image1, image1) || other.image1 == image1) &&
            (identical(other.image2, image2) || other.image2 == image2));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, description,
      const DeepCollectionEquality().hash(_moreDetails), image1, image2);

  /// Create a copy of BugReportModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BugReportModelImplCopyWith<_$BugReportModelImpl> get copyWith =>
      __$$BugReportModelImplCopyWithImpl<_$BugReportModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BugReportModelImplToJson(
      this,
    );
  }
}

abstract class _BugReportModel implements BugReportModel {
  const factory _BugReportModel(
      {required final String title,
      required final String description,
      final Map<String, dynamic> moreDetails,
      final String? image1,
      final String? image2}) = _$BugReportModelImpl;

  factory _BugReportModel.fromJson(Map<String, dynamic> json) =
      _$BugReportModelImpl.fromJson;

  @override
  String get title;
  @override
  String get description;
  @override
  Map<String, dynamic> get moreDetails;
  @override
  String? get image1;
  @override
  String? get image2;

  /// Create a copy of BugReportModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BugReportModelImplCopyWith<_$BugReportModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
