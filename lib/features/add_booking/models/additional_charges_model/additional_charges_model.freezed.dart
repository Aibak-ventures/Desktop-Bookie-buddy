// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'additional_charges_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AdditionalChargesModel _$AdditionalChargesModelFromJson(
  Map<String, dynamic> json,
) {
  return _AdditionalChargesModel.fromJson(json);
}

/// @nodoc
mixin _$AdditionalChargesModel {
  @JsonKey(includeIfNull: false)
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _amountFromJson)
  int? get amount => throw _privateConstructorUsedError;

  /// Serializes this AdditionalChargesModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdditionalChargesModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdditionalChargesModelCopyWith<AdditionalChargesModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdditionalChargesModelCopyWith<$Res> {
  factory $AdditionalChargesModelCopyWith(
    AdditionalChargesModel value,
    $Res Function(AdditionalChargesModel) then,
  ) = _$AdditionalChargesModelCopyWithImpl<$Res, AdditionalChargesModel>;
  @useResult
  $Res call({
    @JsonKey(includeIfNull: false) int? id,
    String? name,
    @JsonKey(fromJson: _amountFromJson) int? amount,
  });
}

/// @nodoc
class _$AdditionalChargesModelCopyWithImpl<
  $Res,
  $Val extends AdditionalChargesModel
>
    implements $AdditionalChargesModelCopyWith<$Res> {
  _$AdditionalChargesModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdditionalChargesModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? amount = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int?,
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String?,
            amount: freezed == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AdditionalChargesModelImplCopyWith<$Res>
    implements $AdditionalChargesModelCopyWith<$Res> {
  factory _$$AdditionalChargesModelImplCopyWith(
    _$AdditionalChargesModelImpl value,
    $Res Function(_$AdditionalChargesModelImpl) then,
  ) = __$$AdditionalChargesModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(includeIfNull: false) int? id,
    String? name,
    @JsonKey(fromJson: _amountFromJson) int? amount,
  });
}

/// @nodoc
class __$$AdditionalChargesModelImplCopyWithImpl<$Res>
    extends
        _$AdditionalChargesModelCopyWithImpl<$Res, _$AdditionalChargesModelImpl>
    implements _$$AdditionalChargesModelImplCopyWith<$Res> {
  __$$AdditionalChargesModelImplCopyWithImpl(
    _$AdditionalChargesModelImpl _value,
    $Res Function(_$AdditionalChargesModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdditionalChargesModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? amount = freezed,
  }) {
    return _then(
      _$AdditionalChargesModelImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int?,
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
        amount: freezed == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AdditionalChargesModelImpl implements _AdditionalChargesModel {
  const _$AdditionalChargesModelImpl({
    @JsonKey(includeIfNull: false) this.id,
    this.name,
    @JsonKey(fromJson: _amountFromJson) this.amount,
  });

  factory _$AdditionalChargesModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdditionalChargesModelImplFromJson(json);

  @override
  @JsonKey(includeIfNull: false)
  final int? id;
  @override
  final String? name;
  @override
  @JsonKey(fromJson: _amountFromJson)
  final int? amount;

  @override
  String toString() {
    return 'AdditionalChargesModel(id: $id, name: $name, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdditionalChargesModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, amount);

  /// Create a copy of AdditionalChargesModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdditionalChargesModelImplCopyWith<_$AdditionalChargesModelImpl>
  get copyWith =>
      __$$AdditionalChargesModelImplCopyWithImpl<_$AdditionalChargesModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AdditionalChargesModelImplToJson(this);
  }
}

abstract class _AdditionalChargesModel implements AdditionalChargesModel {
  const factory _AdditionalChargesModel({
    @JsonKey(includeIfNull: false) final int? id,
    final String? name,
    @JsonKey(fromJson: _amountFromJson) final int? amount,
  }) = _$AdditionalChargesModelImpl;

  factory _AdditionalChargesModel.fromJson(Map<String, dynamic> json) =
      _$AdditionalChargesModelImpl.fromJson;

  @override
  @JsonKey(includeIfNull: false)
  int? get id;
  @override
  String? get name;
  @override
  @JsonKey(fromJson: _amountFromJson)
  int? get amount;

  /// Create a copy of AdditionalChargesModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdditionalChargesModelImplCopyWith<_$AdditionalChargesModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
