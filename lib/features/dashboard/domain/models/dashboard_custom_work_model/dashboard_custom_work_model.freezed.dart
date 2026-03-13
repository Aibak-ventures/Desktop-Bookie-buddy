// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_custom_work_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DashboardCustomWorkModel _$DashboardCustomWorkModelFromJson(
    Map<String, dynamic> json) {
  return _DashboardCustomWorkModel.fromJson(json);
}

/// @nodoc
mixin _$DashboardCustomWorkModel {
  int get id => throw _privateConstructorUsedError;
  String get tailorName => throw _privateConstructorUsedError;
  String get pickupDate => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: CustomizationWorkStatus.fromString,
      toJson: CustomizationWorkStatus.toJson)
  CustomizationWorkStatus get status => throw _privateConstructorUsedError;
  String get products => throw _privateConstructorUsedError;
  @JsonKey(name: 'staff_color')
  String? get staffColor => throw _privateConstructorUsedError;

  /// Serializes this DashboardCustomWorkModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DashboardCustomWorkModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DashboardCustomWorkModelCopyWith<DashboardCustomWorkModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardCustomWorkModelCopyWith<$Res> {
  factory $DashboardCustomWorkModelCopyWith(DashboardCustomWorkModel value,
          $Res Function(DashboardCustomWorkModel) then) =
      _$DashboardCustomWorkModelCopyWithImpl<$Res, DashboardCustomWorkModel>;
  @useResult
  $Res call(
      {int id,
      String tailorName,
      String pickupDate,
      @JsonKey(
          fromJson: CustomizationWorkStatus.fromString,
          toJson: CustomizationWorkStatus.toJson)
      CustomizationWorkStatus status,
      String products,
      @JsonKey(name: 'staff_color') String? staffColor});
}

/// @nodoc
class _$DashboardCustomWorkModelCopyWithImpl<$Res,
        $Val extends DashboardCustomWorkModel>
    implements $DashboardCustomWorkModelCopyWith<$Res> {
  _$DashboardCustomWorkModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DashboardCustomWorkModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tailorName = null,
    Object? pickupDate = null,
    Object? status = null,
    Object? products = null,
    Object? staffColor = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      tailorName: null == tailorName
          ? _value.tailorName
          : tailorName // ignore: cast_nullable_to_non_nullable
              as String,
      pickupDate: null == pickupDate
          ? _value.pickupDate
          : pickupDate // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CustomizationWorkStatus,
      products: null == products
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as String,
      staffColor: freezed == staffColor
          ? _value.staffColor
          : staffColor // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DashboardCustomWorkModelImplCopyWith<$Res>
    implements $DashboardCustomWorkModelCopyWith<$Res> {
  factory _$$DashboardCustomWorkModelImplCopyWith(
          _$DashboardCustomWorkModelImpl value,
          $Res Function(_$DashboardCustomWorkModelImpl) then) =
      __$$DashboardCustomWorkModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String tailorName,
      String pickupDate,
      @JsonKey(
          fromJson: CustomizationWorkStatus.fromString,
          toJson: CustomizationWorkStatus.toJson)
      CustomizationWorkStatus status,
      String products,
      @JsonKey(name: 'staff_color') String? staffColor});
}

/// @nodoc
class __$$DashboardCustomWorkModelImplCopyWithImpl<$Res>
    extends _$DashboardCustomWorkModelCopyWithImpl<$Res,
        _$DashboardCustomWorkModelImpl>
    implements _$$DashboardCustomWorkModelImplCopyWith<$Res> {
  __$$DashboardCustomWorkModelImplCopyWithImpl(
      _$DashboardCustomWorkModelImpl _value,
      $Res Function(_$DashboardCustomWorkModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of DashboardCustomWorkModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tailorName = null,
    Object? pickupDate = null,
    Object? status = null,
    Object? products = null,
    Object? staffColor = freezed,
  }) {
    return _then(_$DashboardCustomWorkModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      tailorName: null == tailorName
          ? _value.tailorName
          : tailorName // ignore: cast_nullable_to_non_nullable
              as String,
      pickupDate: null == pickupDate
          ? _value.pickupDate
          : pickupDate // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CustomizationWorkStatus,
      products: null == products
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as String,
      staffColor: freezed == staffColor
          ? _value.staffColor
          : staffColor // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$DashboardCustomWorkModelImpl implements _DashboardCustomWorkModel {
  const _$DashboardCustomWorkModelImpl(
      {required this.id,
      required this.tailorName,
      required this.pickupDate,
      @JsonKey(
          fromJson: CustomizationWorkStatus.fromString,
          toJson: CustomizationWorkStatus.toJson)
      required this.status,
      required this.products,
      @JsonKey(name: 'staff_color') this.staffColor});

  factory _$DashboardCustomWorkModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DashboardCustomWorkModelImplFromJson(json);

  @override
  final int id;
  @override
  final String tailorName;
  @override
  final String pickupDate;
  @override
  @JsonKey(
      fromJson: CustomizationWorkStatus.fromString,
      toJson: CustomizationWorkStatus.toJson)
  final CustomizationWorkStatus status;
  @override
  final String products;
  @override
  @JsonKey(name: 'staff_color')
  final String? staffColor;

  @override
  String toString() {
    return 'DashboardCustomWorkModel(id: $id, tailorName: $tailorName, pickupDate: $pickupDate, status: $status, products: $products, staffColor: $staffColor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardCustomWorkModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.tailorName, tailorName) ||
                other.tailorName == tailorName) &&
            (identical(other.pickupDate, pickupDate) ||
                other.pickupDate == pickupDate) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.products, products) ||
                other.products == products) &&
            (identical(other.staffColor, staffColor) ||
                other.staffColor == staffColor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, tailorName, pickupDate, status, products, staffColor);

  /// Create a copy of DashboardCustomWorkModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardCustomWorkModelImplCopyWith<_$DashboardCustomWorkModelImpl>
      get copyWith => __$$DashboardCustomWorkModelImplCopyWithImpl<
          _$DashboardCustomWorkModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DashboardCustomWorkModelImplToJson(
      this,
    );
  }
}

abstract class _DashboardCustomWorkModel implements DashboardCustomWorkModel {
  const factory _DashboardCustomWorkModel(
          {required final int id,
          required final String tailorName,
          required final String pickupDate,
          @JsonKey(
              fromJson: CustomizationWorkStatus.fromString,
              toJson: CustomizationWorkStatus.toJson)
          required final CustomizationWorkStatus status,
          required final String products,
          @JsonKey(name: 'staff_color') final String? staffColor}) =
      _$DashboardCustomWorkModelImpl;

  factory _DashboardCustomWorkModel.fromJson(Map<String, dynamic> json) =
      _$DashboardCustomWorkModelImpl.fromJson;

  @override
  int get id;
  @override
  String get tailorName;
  @override
  String get pickupDate;
  @override
  @JsonKey(
      fromJson: CustomizationWorkStatus.fromString,
      toJson: CustomizationWorkStatus.toJson)
  CustomizationWorkStatus get status;
  @override
  String get products;
  @override
  @JsonKey(name: 'staff_color')
  String? get staffColor;

  /// Create a copy of DashboardCustomWorkModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DashboardCustomWorkModelImplCopyWith<_$DashboardCustomWorkModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
