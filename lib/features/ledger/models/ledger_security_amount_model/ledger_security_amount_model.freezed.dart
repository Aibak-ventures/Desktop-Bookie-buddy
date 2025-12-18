// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ledger_security_amount_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LedgerSecurityAmountModel _$LedgerSecurityAmountModelFromJson(
    Map<String, dynamic> json) {
  return _LedgerSecurityAmountModel.fromJson(json);
}

/// @nodoc
mixin _$LedgerSecurityAmountModel {
  @JsonKey(name: 'id')
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'client_name', defaultValue: 'Unknown')
  String get clientName => throw _privateConstructorUsedError;
  @JsonKey(name: 'security_amount')
  int get securityAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'date')
  String get date => throw _privateConstructorUsedError;
  @JsonKey(
      name: 'type',
      fromJson: LedgerListType.fromJson,
      toJson: LedgerListType.toJson)
  LedgerListType get type => throw _privateConstructorUsedError;

  /// Serializes this LedgerSecurityAmountModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LedgerSecurityAmountModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LedgerSecurityAmountModelCopyWith<LedgerSecurityAmountModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LedgerSecurityAmountModelCopyWith<$Res> {
  factory $LedgerSecurityAmountModelCopyWith(LedgerSecurityAmountModel value,
          $Res Function(LedgerSecurityAmountModel) then) =
      _$LedgerSecurityAmountModelCopyWithImpl<$Res, LedgerSecurityAmountModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') int id,
      @JsonKey(name: 'client_name', defaultValue: 'Unknown') String clientName,
      @JsonKey(name: 'security_amount') int securityAmount,
      @JsonKey(name: 'date') String date,
      @JsonKey(
          name: 'type',
          fromJson: LedgerListType.fromJson,
          toJson: LedgerListType.toJson)
      LedgerListType type});
}

/// @nodoc
class _$LedgerSecurityAmountModelCopyWithImpl<$Res,
        $Val extends LedgerSecurityAmountModel>
    implements $LedgerSecurityAmountModelCopyWith<$Res> {
  _$LedgerSecurityAmountModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LedgerSecurityAmountModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clientName = null,
    Object? securityAmount = null,
    Object? date = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      clientName: null == clientName
          ? _value.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String,
      securityAmount: null == securityAmount
          ? _value.securityAmount
          : securityAmount // ignore: cast_nullable_to_non_nullable
              as int,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as LedgerListType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LedgerSecurityAmountModelImplCopyWith<$Res>
    implements $LedgerSecurityAmountModelCopyWith<$Res> {
  factory _$$LedgerSecurityAmountModelImplCopyWith(
          _$LedgerSecurityAmountModelImpl value,
          $Res Function(_$LedgerSecurityAmountModelImpl) then) =
      __$$LedgerSecurityAmountModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') int id,
      @JsonKey(name: 'client_name', defaultValue: 'Unknown') String clientName,
      @JsonKey(name: 'security_amount') int securityAmount,
      @JsonKey(name: 'date') String date,
      @JsonKey(
          name: 'type',
          fromJson: LedgerListType.fromJson,
          toJson: LedgerListType.toJson)
      LedgerListType type});
}

/// @nodoc
class __$$LedgerSecurityAmountModelImplCopyWithImpl<$Res>
    extends _$LedgerSecurityAmountModelCopyWithImpl<$Res,
        _$LedgerSecurityAmountModelImpl>
    implements _$$LedgerSecurityAmountModelImplCopyWith<$Res> {
  __$$LedgerSecurityAmountModelImplCopyWithImpl(
      _$LedgerSecurityAmountModelImpl _value,
      $Res Function(_$LedgerSecurityAmountModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of LedgerSecurityAmountModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clientName = null,
    Object? securityAmount = null,
    Object? date = null,
    Object? type = null,
  }) {
    return _then(_$LedgerSecurityAmountModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      clientName: null == clientName
          ? _value.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String,
      securityAmount: null == securityAmount
          ? _value.securityAmount
          : securityAmount // ignore: cast_nullable_to_non_nullable
              as int,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as LedgerListType,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LedgerSecurityAmountModelImpl implements _LedgerSecurityAmountModel {
  const _$LedgerSecurityAmountModelImpl(
      {@JsonKey(name: 'id') required this.id,
      @JsonKey(name: 'client_name', defaultValue: 'Unknown')
      required this.clientName,
      @JsonKey(name: 'security_amount') required this.securityAmount,
      @JsonKey(name: 'date') required this.date,
      @JsonKey(
          name: 'type',
          fromJson: LedgerListType.fromJson,
          toJson: LedgerListType.toJson)
      required this.type});

  factory _$LedgerSecurityAmountModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LedgerSecurityAmountModelImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int id;
  @override
  @JsonKey(name: 'client_name', defaultValue: 'Unknown')
  final String clientName;
  @override
  @JsonKey(name: 'security_amount')
  final int securityAmount;
  @override
  @JsonKey(name: 'date')
  final String date;
  @override
  @JsonKey(
      name: 'type',
      fromJson: LedgerListType.fromJson,
      toJson: LedgerListType.toJson)
  final LedgerListType type;

  @override
  String toString() {
    return 'LedgerSecurityAmountModel(id: $id, clientName: $clientName, securityAmount: $securityAmount, date: $date, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LedgerSecurityAmountModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.clientName, clientName) ||
                other.clientName == clientName) &&
            (identical(other.securityAmount, securityAmount) ||
                other.securityAmount == securityAmount) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, clientName, securityAmount, date, type);

  /// Create a copy of LedgerSecurityAmountModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LedgerSecurityAmountModelImplCopyWith<_$LedgerSecurityAmountModelImpl>
      get copyWith => __$$LedgerSecurityAmountModelImplCopyWithImpl<
          _$LedgerSecurityAmountModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LedgerSecurityAmountModelImplToJson(
      this,
    );
  }
}

abstract class _LedgerSecurityAmountModel implements LedgerSecurityAmountModel {
  const factory _LedgerSecurityAmountModel(
      {@JsonKey(name: 'id') required final int id,
      @JsonKey(name: 'client_name', defaultValue: 'Unknown')
      required final String clientName,
      @JsonKey(name: 'security_amount') required final int securityAmount,
      @JsonKey(name: 'date') required final String date,
      @JsonKey(
          name: 'type',
          fromJson: LedgerListType.fromJson,
          toJson: LedgerListType.toJson)
      required final LedgerListType type}) = _$LedgerSecurityAmountModelImpl;

  factory _LedgerSecurityAmountModel.fromJson(Map<String, dynamic> json) =
      _$LedgerSecurityAmountModelImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  int get id;
  @override
  @JsonKey(name: 'client_name', defaultValue: 'Unknown')
  String get clientName;
  @override
  @JsonKey(name: 'security_amount')
  int get securityAmount;
  @override
  @JsonKey(name: 'date')
  String get date;
  @override
  @JsonKey(
      name: 'type',
      fromJson: LedgerListType.fromJson,
      toJson: LedgerListType.toJson)
  LedgerListType get type;

  /// Create a copy of LedgerSecurityAmountModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LedgerSecurityAmountModelImplCopyWith<_$LedgerSecurityAmountModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
