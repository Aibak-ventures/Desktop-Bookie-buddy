// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shop_activity_list_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ShopActivityListModel _$ShopActivityListModelFromJson(
    Map<String, dynamic> json) {
  return _ShopActivityListModel.fromJson(json);
}

/// @nodoc
mixin _$ShopActivityListModel {
  List<ShopActivityModel> get activities => throw _privateConstructorUsedError;
  @JsonKey(name: 'next')
  String? get nextPageUrl => throw _privateConstructorUsedError;
  int? get count => throw _privateConstructorUsedError;

  /// Serializes this ShopActivityListModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ShopActivityListModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShopActivityListModelCopyWith<ShopActivityListModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShopActivityListModelCopyWith<$Res> {
  factory $ShopActivityListModelCopyWith(ShopActivityListModel value,
          $Res Function(ShopActivityListModel) then) =
      _$ShopActivityListModelCopyWithImpl<$Res, ShopActivityListModel>;
  @useResult
  $Res call(
      {List<ShopActivityModel> activities,
      @JsonKey(name: 'next') String? nextPageUrl,
      int? count});
}

/// @nodoc
class _$ShopActivityListModelCopyWithImpl<$Res,
        $Val extends ShopActivityListModel>
    implements $ShopActivityListModelCopyWith<$Res> {
  _$ShopActivityListModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShopActivityListModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activities = null,
    Object? nextPageUrl = freezed,
    Object? count = freezed,
  }) {
    return _then(_value.copyWith(
      activities: null == activities
          ? _value.activities
          : activities // ignore: cast_nullable_to_non_nullable
              as List<ShopActivityModel>,
      nextPageUrl: freezed == nextPageUrl
          ? _value.nextPageUrl
          : nextPageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      count: freezed == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ShopActivityListModelImplCopyWith<$Res>
    implements $ShopActivityListModelCopyWith<$Res> {
  factory _$$ShopActivityListModelImplCopyWith(
          _$ShopActivityListModelImpl value,
          $Res Function(_$ShopActivityListModelImpl) then) =
      __$$ShopActivityListModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<ShopActivityModel> activities,
      @JsonKey(name: 'next') String? nextPageUrl,
      int? count});
}

/// @nodoc
class __$$ShopActivityListModelImplCopyWithImpl<$Res>
    extends _$ShopActivityListModelCopyWithImpl<$Res,
        _$ShopActivityListModelImpl>
    implements _$$ShopActivityListModelImplCopyWith<$Res> {
  __$$ShopActivityListModelImplCopyWithImpl(_$ShopActivityListModelImpl _value,
      $Res Function(_$ShopActivityListModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ShopActivityListModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activities = null,
    Object? nextPageUrl = freezed,
    Object? count = freezed,
  }) {
    return _then(_$ShopActivityListModelImpl(
      activities: null == activities
          ? _value._activities
          : activities // ignore: cast_nullable_to_non_nullable
              as List<ShopActivityModel>,
      nextPageUrl: freezed == nextPageUrl
          ? _value.nextPageUrl
          : nextPageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      count: freezed == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ShopActivityListModelImpl implements _ShopActivityListModel {
  const _$ShopActivityListModelImpl(
      {required final List<ShopActivityModel> activities,
      @JsonKey(name: 'next') this.nextPageUrl,
      this.count})
      : _activities = activities;

  factory _$ShopActivityListModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShopActivityListModelImplFromJson(json);

  final List<ShopActivityModel> _activities;
  @override
  List<ShopActivityModel> get activities {
    if (_activities is EqualUnmodifiableListView) return _activities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_activities);
  }

  @override
  @JsonKey(name: 'next')
  final String? nextPageUrl;
  @override
  final int? count;

  @override
  String toString() {
    return 'ShopActivityListModel(activities: $activities, nextPageUrl: $nextPageUrl, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShopActivityListModelImpl &&
            const DeepCollectionEquality()
                .equals(other._activities, _activities) &&
            (identical(other.nextPageUrl, nextPageUrl) ||
                other.nextPageUrl == nextPageUrl) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_activities), nextPageUrl, count);

  /// Create a copy of ShopActivityListModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShopActivityListModelImplCopyWith<_$ShopActivityListModelImpl>
      get copyWith => __$$ShopActivityListModelImplCopyWithImpl<
          _$ShopActivityListModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShopActivityListModelImplToJson(
      this,
    );
  }
}

abstract class _ShopActivityListModel implements ShopActivityListModel {
  const factory _ShopActivityListModel(
      {required final List<ShopActivityModel> activities,
      @JsonKey(name: 'next') final String? nextPageUrl,
      final int? count}) = _$ShopActivityListModelImpl;

  factory _ShopActivityListModel.fromJson(Map<String, dynamic> json) =
      _$ShopActivityListModelImpl.fromJson;

  @override
  List<ShopActivityModel> get activities;
  @override
  @JsonKey(name: 'next')
  String? get nextPageUrl;
  @override
  int? get count;

  /// Create a copy of ShopActivityListModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShopActivityListModelImplCopyWith<_$ShopActivityListModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
