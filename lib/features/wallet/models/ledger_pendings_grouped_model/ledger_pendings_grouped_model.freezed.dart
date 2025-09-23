// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ledger_pendings_grouped_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LedgerPendingsGroupedModel _$LedgerPendingsGroupedModelFromJson(
    Map<String, dynamic> json) {
  return _LedgerPendingsGroupedModel.fromJson(json);
}

/// @nodoc
mixin _$LedgerPendingsGroupedModel {
  String get date => throw _privateConstructorUsedError;
  List<LedgerPendingModel> get pendings => throw _privateConstructorUsedError;

  /// Serializes this LedgerPendingsGroupedModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LedgerPendingsGroupedModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LedgerPendingsGroupedModelCopyWith<LedgerPendingsGroupedModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LedgerPendingsGroupedModelCopyWith<$Res> {
  factory $LedgerPendingsGroupedModelCopyWith(LedgerPendingsGroupedModel value,
          $Res Function(LedgerPendingsGroupedModel) then) =
      _$LedgerPendingsGroupedModelCopyWithImpl<$Res,
          LedgerPendingsGroupedModel>;
  @useResult
  $Res call({String date, List<LedgerPendingModel> pendings});
}

/// @nodoc
class _$LedgerPendingsGroupedModelCopyWithImpl<$Res,
        $Val extends LedgerPendingsGroupedModel>
    implements $LedgerPendingsGroupedModelCopyWith<$Res> {
  _$LedgerPendingsGroupedModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LedgerPendingsGroupedModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? pendings = null,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      pendings: null == pendings
          ? _value.pendings
          : pendings // ignore: cast_nullable_to_non_nullable
              as List<LedgerPendingModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LedgerPendingsGroupedModelImplCopyWith<$Res>
    implements $LedgerPendingsGroupedModelCopyWith<$Res> {
  factory _$$LedgerPendingsGroupedModelImplCopyWith(
          _$LedgerPendingsGroupedModelImpl value,
          $Res Function(_$LedgerPendingsGroupedModelImpl) then) =
      __$$LedgerPendingsGroupedModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String date, List<LedgerPendingModel> pendings});
}

/// @nodoc
class __$$LedgerPendingsGroupedModelImplCopyWithImpl<$Res>
    extends _$LedgerPendingsGroupedModelCopyWithImpl<$Res,
        _$LedgerPendingsGroupedModelImpl>
    implements _$$LedgerPendingsGroupedModelImplCopyWith<$Res> {
  __$$LedgerPendingsGroupedModelImplCopyWithImpl(
      _$LedgerPendingsGroupedModelImpl _value,
      $Res Function(_$LedgerPendingsGroupedModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of LedgerPendingsGroupedModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? pendings = null,
  }) {
    return _then(_$LedgerPendingsGroupedModelImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      pendings: null == pendings
          ? _value._pendings
          : pendings // ignore: cast_nullable_to_non_nullable
              as List<LedgerPendingModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LedgerPendingsGroupedModelImpl implements _LedgerPendingsGroupedModel {
  const _$LedgerPendingsGroupedModelImpl(
      {required this.date, required final List<LedgerPendingModel> pendings})
      : _pendings = pendings;

  factory _$LedgerPendingsGroupedModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$LedgerPendingsGroupedModelImplFromJson(json);

  @override
  final String date;
  final List<LedgerPendingModel> _pendings;
  @override
  List<LedgerPendingModel> get pendings {
    if (_pendings is EqualUnmodifiableListView) return _pendings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pendings);
  }

  @override
  String toString() {
    return 'LedgerPendingsGroupedModel(date: $date, pendings: $pendings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LedgerPendingsGroupedModelImpl &&
            (identical(other.date, date) || other.date == date) &&
            const DeepCollectionEquality().equals(other._pendings, _pendings));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, date, const DeepCollectionEquality().hash(_pendings));

  /// Create a copy of LedgerPendingsGroupedModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LedgerPendingsGroupedModelImplCopyWith<_$LedgerPendingsGroupedModelImpl>
      get copyWith => __$$LedgerPendingsGroupedModelImplCopyWithImpl<
          _$LedgerPendingsGroupedModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LedgerPendingsGroupedModelImplToJson(
      this,
    );
  }
}

abstract class _LedgerPendingsGroupedModel
    implements LedgerPendingsGroupedModel {
  const factory _LedgerPendingsGroupedModel(
          {required final String date,
          required final List<LedgerPendingModel> pendings}) =
      _$LedgerPendingsGroupedModelImpl;

  factory _LedgerPendingsGroupedModel.fromJson(Map<String, dynamic> json) =
      _$LedgerPendingsGroupedModelImpl.fromJson;

  @override
  String get date;
  @override
  List<LedgerPendingModel> get pendings;

  /// Create a copy of LedgerPendingsGroupedModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LedgerPendingsGroupedModelImplCopyWith<_$LedgerPendingsGroupedModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
