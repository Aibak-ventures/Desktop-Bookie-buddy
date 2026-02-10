// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shop_settings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ShopSettingsModel _$ShopSettingsModelFromJson(Map<String, dynamic> json) {
  return _ShopSettingsModel.fromJson(json);
}

/// @nodoc
mixin _$ShopSettingsModel {
  @JsonKey(name: 'cooling_days', defaultValue: 0)
  int get coolingPeriodDuration => throw _privateConstructorUsedError;
  @JsonKey(
      name: 'cooling_period_mode',
      fromJson: CoolingPeriodMode.fromJson,
      defaultValue: CoolingPeriodMode.after)
  CoolingPeriodMode get coolingPeriodMode => throw _privateConstructorUsedError;
  @JsonKey(
      name: 'default_action',
      fromJson: AddButtonDefaultAction.fromString,
      defaultValue: AddButtonDefaultAction.booking)
  AddButtonDefaultAction get addButtonDefaultAction =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'search_client', defaultValue: false)
  bool get searchClient => throw _privateConstructorUsedError;

  /// Serializes this ShopSettingsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ShopSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShopSettingsModelCopyWith<ShopSettingsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShopSettingsModelCopyWith<$Res> {
  factory $ShopSettingsModelCopyWith(
          ShopSettingsModel value, $Res Function(ShopSettingsModel) then) =
      _$ShopSettingsModelCopyWithImpl<$Res, ShopSettingsModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'cooling_days', defaultValue: 0)
      int coolingPeriodDuration,
      @JsonKey(
          name: 'cooling_period_mode',
          fromJson: CoolingPeriodMode.fromJson,
          defaultValue: CoolingPeriodMode.after)
      CoolingPeriodMode coolingPeriodMode,
      @JsonKey(
          name: 'default_action',
          fromJson: AddButtonDefaultAction.fromString,
          defaultValue: AddButtonDefaultAction.booking)
      AddButtonDefaultAction addButtonDefaultAction,
      @JsonKey(name: 'search_client', defaultValue: false) bool searchClient});
}

/// @nodoc
class _$ShopSettingsModelCopyWithImpl<$Res, $Val extends ShopSettingsModel>
    implements $ShopSettingsModelCopyWith<$Res> {
  _$ShopSettingsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShopSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? coolingPeriodDuration = null,
    Object? coolingPeriodMode = null,
    Object? addButtonDefaultAction = null,
    Object? searchClient = null,
  }) {
    return _then(_value.copyWith(
      coolingPeriodDuration: null == coolingPeriodDuration
          ? _value.coolingPeriodDuration
          : coolingPeriodDuration // ignore: cast_nullable_to_non_nullable
              as int,
      coolingPeriodMode: null == coolingPeriodMode
          ? _value.coolingPeriodMode
          : coolingPeriodMode // ignore: cast_nullable_to_non_nullable
              as CoolingPeriodMode,
      addButtonDefaultAction: null == addButtonDefaultAction
          ? _value.addButtonDefaultAction
          : addButtonDefaultAction // ignore: cast_nullable_to_non_nullable
              as AddButtonDefaultAction,
      searchClient: null == searchClient
          ? _value.searchClient
          : searchClient // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ShopSettingsModelImplCopyWith<$Res>
    implements $ShopSettingsModelCopyWith<$Res> {
  factory _$$ShopSettingsModelImplCopyWith(_$ShopSettingsModelImpl value,
          $Res Function(_$ShopSettingsModelImpl) then) =
      __$$ShopSettingsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'cooling_days', defaultValue: 0)
      int coolingPeriodDuration,
      @JsonKey(
          name: 'cooling_period_mode',
          fromJson: CoolingPeriodMode.fromJson,
          defaultValue: CoolingPeriodMode.after)
      CoolingPeriodMode coolingPeriodMode,
      @JsonKey(
          name: 'default_action',
          fromJson: AddButtonDefaultAction.fromString,
          defaultValue: AddButtonDefaultAction.booking)
      AddButtonDefaultAction addButtonDefaultAction,
      @JsonKey(name: 'search_client', defaultValue: false) bool searchClient});
}

/// @nodoc
class __$$ShopSettingsModelImplCopyWithImpl<$Res>
    extends _$ShopSettingsModelCopyWithImpl<$Res, _$ShopSettingsModelImpl>
    implements _$$ShopSettingsModelImplCopyWith<$Res> {
  __$$ShopSettingsModelImplCopyWithImpl(_$ShopSettingsModelImpl _value,
      $Res Function(_$ShopSettingsModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ShopSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? coolingPeriodDuration = null,
    Object? coolingPeriodMode = null,
    Object? addButtonDefaultAction = null,
    Object? searchClient = null,
  }) {
    return _then(_$ShopSettingsModelImpl(
      coolingPeriodDuration: null == coolingPeriodDuration
          ? _value.coolingPeriodDuration
          : coolingPeriodDuration // ignore: cast_nullable_to_non_nullable
              as int,
      coolingPeriodMode: null == coolingPeriodMode
          ? _value.coolingPeriodMode
          : coolingPeriodMode // ignore: cast_nullable_to_non_nullable
              as CoolingPeriodMode,
      addButtonDefaultAction: null == addButtonDefaultAction
          ? _value.addButtonDefaultAction
          : addButtonDefaultAction // ignore: cast_nullable_to_non_nullable
              as AddButtonDefaultAction,
      searchClient: null == searchClient
          ? _value.searchClient
          : searchClient // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ShopSettingsModelImpl implements _ShopSettingsModel {
  const _$ShopSettingsModelImpl(
      {@JsonKey(name: 'cooling_days', defaultValue: 0)
      required this.coolingPeriodDuration,
      @JsonKey(
          name: 'cooling_period_mode',
          fromJson: CoolingPeriodMode.fromJson,
          defaultValue: CoolingPeriodMode.after)
      required this.coolingPeriodMode,
      @JsonKey(
          name: 'default_action',
          fromJson: AddButtonDefaultAction.fromString,
          defaultValue: AddButtonDefaultAction.booking)
      required this.addButtonDefaultAction,
      @JsonKey(name: 'search_client', defaultValue: false)
      required this.searchClient});

  factory _$ShopSettingsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShopSettingsModelImplFromJson(json);

  @override
  @JsonKey(name: 'cooling_days', defaultValue: 0)
  final int coolingPeriodDuration;
  @override
  @JsonKey(
      name: 'cooling_period_mode',
      fromJson: CoolingPeriodMode.fromJson,
      defaultValue: CoolingPeriodMode.after)
  final CoolingPeriodMode coolingPeriodMode;
  @override
  @JsonKey(
      name: 'default_action',
      fromJson: AddButtonDefaultAction.fromString,
      defaultValue: AddButtonDefaultAction.booking)
  final AddButtonDefaultAction addButtonDefaultAction;
  @override
  @JsonKey(name: 'search_client', defaultValue: false)
  final bool searchClient;

  @override
  String toString() {
    return 'ShopSettingsModel(coolingPeriodDuration: $coolingPeriodDuration, coolingPeriodMode: $coolingPeriodMode, addButtonDefaultAction: $addButtonDefaultAction, searchClient: $searchClient)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShopSettingsModelImpl &&
            (identical(other.coolingPeriodDuration, coolingPeriodDuration) ||
                other.coolingPeriodDuration == coolingPeriodDuration) &&
            (identical(other.coolingPeriodMode, coolingPeriodMode) ||
                other.coolingPeriodMode == coolingPeriodMode) &&
            (identical(other.addButtonDefaultAction, addButtonDefaultAction) ||
                other.addButtonDefaultAction == addButtonDefaultAction) &&
            (identical(other.searchClient, searchClient) ||
                other.searchClient == searchClient));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, coolingPeriodDuration,
      coolingPeriodMode, addButtonDefaultAction, searchClient);

  /// Create a copy of ShopSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShopSettingsModelImplCopyWith<_$ShopSettingsModelImpl> get copyWith =>
      __$$ShopSettingsModelImplCopyWithImpl<_$ShopSettingsModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShopSettingsModelImplToJson(
      this,
    );
  }
}

abstract class _ShopSettingsModel implements ShopSettingsModel {
  const factory _ShopSettingsModel(
      {@JsonKey(name: 'cooling_days', defaultValue: 0)
      required final int coolingPeriodDuration,
      @JsonKey(
          name: 'cooling_period_mode',
          fromJson: CoolingPeriodMode.fromJson,
          defaultValue: CoolingPeriodMode.after)
      required final CoolingPeriodMode coolingPeriodMode,
      @JsonKey(
          name: 'default_action',
          fromJson: AddButtonDefaultAction.fromString,
          defaultValue: AddButtonDefaultAction.booking)
      required final AddButtonDefaultAction addButtonDefaultAction,
      @JsonKey(name: 'search_client', defaultValue: false)
      required final bool searchClient}) = _$ShopSettingsModelImpl;

  factory _ShopSettingsModel.fromJson(Map<String, dynamic> json) =
      _$ShopSettingsModelImpl.fromJson;

  @override
  @JsonKey(name: 'cooling_days', defaultValue: 0)
  int get coolingPeriodDuration;
  @override
  @JsonKey(
      name: 'cooling_period_mode',
      fromJson: CoolingPeriodMode.fromJson,
      defaultValue: CoolingPeriodMode.after)
  CoolingPeriodMode get coolingPeriodMode;
  @override
  @JsonKey(
      name: 'default_action',
      fromJson: AddButtonDefaultAction.fromString,
      defaultValue: AddButtonDefaultAction.booking)
  AddButtonDefaultAction get addButtonDefaultAction;
  @override
  @JsonKey(name: 'search_client', defaultValue: false)
  bool get searchClient;

  /// Create a copy of ShopSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShopSettingsModelImplCopyWith<_$ShopSettingsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
