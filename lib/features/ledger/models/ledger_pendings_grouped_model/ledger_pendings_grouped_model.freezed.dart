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
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LedgerPendingsGroupedModel _$LedgerPendingsGroupedModelFromJson(
  Map<String, dynamic> json,
) {
  return _LedgerPendingsGroupedModel.fromJson(json);
}

/// @nodoc
mixin _$LedgerPendingsGroupedModel {
  List<LedgerPendingsDailyModel> get dailyPendings =>
      throw _privateConstructorUsedError;

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
  factory $LedgerPendingsGroupedModelCopyWith(
    LedgerPendingsGroupedModel value,
    $Res Function(LedgerPendingsGroupedModel) then,
  ) =
      _$LedgerPendingsGroupedModelCopyWithImpl<
        $Res,
        LedgerPendingsGroupedModel
      >;
  @useResult
  $Res call({List<LedgerPendingsDailyModel> dailyPendings});
}

/// @nodoc
class _$LedgerPendingsGroupedModelCopyWithImpl<
  $Res,
  $Val extends LedgerPendingsGroupedModel
>
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
  $Res call({Object? dailyPendings = null}) {
    return _then(
      _value.copyWith(
            dailyPendings: null == dailyPendings
                ? _value.dailyPendings
                : dailyPendings // ignore: cast_nullable_to_non_nullable
                      as List<LedgerPendingsDailyModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LedgerPendingsGroupedModelImplCopyWith<$Res>
    implements $LedgerPendingsGroupedModelCopyWith<$Res> {
  factory _$$LedgerPendingsGroupedModelImplCopyWith(
    _$LedgerPendingsGroupedModelImpl value,
    $Res Function(_$LedgerPendingsGroupedModelImpl) then,
  ) = __$$LedgerPendingsGroupedModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<LedgerPendingsDailyModel> dailyPendings});
}

/// @nodoc
class __$$LedgerPendingsGroupedModelImplCopyWithImpl<$Res>
    extends
        _$LedgerPendingsGroupedModelCopyWithImpl<
          $Res,
          _$LedgerPendingsGroupedModelImpl
        >
    implements _$$LedgerPendingsGroupedModelImplCopyWith<$Res> {
  __$$LedgerPendingsGroupedModelImplCopyWithImpl(
    _$LedgerPendingsGroupedModelImpl _value,
    $Res Function(_$LedgerPendingsGroupedModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LedgerPendingsGroupedModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? dailyPendings = null}) {
    return _then(
      _$LedgerPendingsGroupedModelImpl(
        dailyPendings: null == dailyPendings
            ? _value._dailyPendings
            : dailyPendings // ignore: cast_nullable_to_non_nullable
                  as List<LedgerPendingsDailyModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LedgerPendingsGroupedModelImpl implements _LedgerPendingsGroupedModel {
  const _$LedgerPendingsGroupedModelImpl({
    required final List<LedgerPendingsDailyModel> dailyPendings,
  }) : _dailyPendings = dailyPendings;

  factory _$LedgerPendingsGroupedModelImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$LedgerPendingsGroupedModelImplFromJson(json);

  final List<LedgerPendingsDailyModel> _dailyPendings;
  @override
  List<LedgerPendingsDailyModel> get dailyPendings {
    if (_dailyPendings is EqualUnmodifiableListView) return _dailyPendings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dailyPendings);
  }

  @override
  String toString() {
    return 'LedgerPendingsGroupedModel(dailyPendings: $dailyPendings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LedgerPendingsGroupedModelImpl &&
            const DeepCollectionEquality().equals(
              other._dailyPendings,
              _dailyPendings,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_dailyPendings),
  );

  /// Create a copy of LedgerPendingsGroupedModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LedgerPendingsGroupedModelImplCopyWith<_$LedgerPendingsGroupedModelImpl>
  get copyWith =>
      __$$LedgerPendingsGroupedModelImplCopyWithImpl<
        _$LedgerPendingsGroupedModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LedgerPendingsGroupedModelImplToJson(this);
  }
}

abstract class _LedgerPendingsGroupedModel
    implements LedgerPendingsGroupedModel {
  const factory _LedgerPendingsGroupedModel({
    required final List<LedgerPendingsDailyModel> dailyPendings,
  }) = _$LedgerPendingsGroupedModelImpl;

  factory _LedgerPendingsGroupedModel.fromJson(Map<String, dynamic> json) =
      _$LedgerPendingsGroupedModelImpl.fromJson;

  @override
  List<LedgerPendingsDailyModel> get dailyPendings;

  /// Create a copy of LedgerPendingsGroupedModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LedgerPendingsGroupedModelImplCopyWith<_$LedgerPendingsGroupedModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

LedgerPendingsDailyModel _$LedgerPendingsDailyModelFromJson(
  Map<String, dynamic> json,
) {
  return _LedgerPendingsDailyModel.fromJson(json);
}

/// @nodoc
mixin _$LedgerPendingsDailyModel {
  String get date => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_pending', defaultValue: 0)
  int get total => throw _privateConstructorUsedError;
  List<LedgerPendingModel> get pendings => throw _privateConstructorUsedError;

  /// Serializes this LedgerPendingsDailyModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LedgerPendingsDailyModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LedgerPendingsDailyModelCopyWith<LedgerPendingsDailyModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LedgerPendingsDailyModelCopyWith<$Res> {
  factory $LedgerPendingsDailyModelCopyWith(
    LedgerPendingsDailyModel value,
    $Res Function(LedgerPendingsDailyModel) then,
  ) = _$LedgerPendingsDailyModelCopyWithImpl<$Res, LedgerPendingsDailyModel>;
  @useResult
  $Res call({
    String date,
    @JsonKey(name: 'total_pending', defaultValue: 0) int total,
    List<LedgerPendingModel> pendings,
  });
}

/// @nodoc
class _$LedgerPendingsDailyModelCopyWithImpl<
  $Res,
  $Val extends LedgerPendingsDailyModel
>
    implements $LedgerPendingsDailyModelCopyWith<$Res> {
  _$LedgerPendingsDailyModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LedgerPendingsDailyModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? total = null,
    Object? pendings = null,
  }) {
    return _then(
      _value.copyWith(
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as String,
            total: null == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                      as int,
            pendings: null == pendings
                ? _value.pendings
                : pendings // ignore: cast_nullable_to_non_nullable
                      as List<LedgerPendingModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LedgerPendingsDailyModelImplCopyWith<$Res>
    implements $LedgerPendingsDailyModelCopyWith<$Res> {
  factory _$$LedgerPendingsDailyModelImplCopyWith(
    _$LedgerPendingsDailyModelImpl value,
    $Res Function(_$LedgerPendingsDailyModelImpl) then,
  ) = __$$LedgerPendingsDailyModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String date,
    @JsonKey(name: 'total_pending', defaultValue: 0) int total,
    List<LedgerPendingModel> pendings,
  });
}

/// @nodoc
class __$$LedgerPendingsDailyModelImplCopyWithImpl<$Res>
    extends
        _$LedgerPendingsDailyModelCopyWithImpl<
          $Res,
          _$LedgerPendingsDailyModelImpl
        >
    implements _$$LedgerPendingsDailyModelImplCopyWith<$Res> {
  __$$LedgerPendingsDailyModelImplCopyWithImpl(
    _$LedgerPendingsDailyModelImpl _value,
    $Res Function(_$LedgerPendingsDailyModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LedgerPendingsDailyModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? total = null,
    Object? pendings = null,
  }) {
    return _then(
      _$LedgerPendingsDailyModelImpl(
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as String,
        total: null == total
            ? _value.total
            : total // ignore: cast_nullable_to_non_nullable
                  as int,
        pendings: null == pendings
            ? _value._pendings
            : pendings // ignore: cast_nullable_to_non_nullable
                  as List<LedgerPendingModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LedgerPendingsDailyModelImpl implements _LedgerPendingsDailyModel {
  const _$LedgerPendingsDailyModelImpl({
    required this.date,
    @JsonKey(name: 'total_pending', defaultValue: 0) required this.total,
    required final List<LedgerPendingModel> pendings,
  }) : _pendings = pendings;

  factory _$LedgerPendingsDailyModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LedgerPendingsDailyModelImplFromJson(json);

  @override
  final String date;
  @override
  @JsonKey(name: 'total_pending', defaultValue: 0)
  final int total;
  final List<LedgerPendingModel> _pendings;
  @override
  List<LedgerPendingModel> get pendings {
    if (_pendings is EqualUnmodifiableListView) return _pendings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pendings);
  }

  @override
  String toString() {
    return 'LedgerPendingsDailyModel(date: $date, total: $total, pendings: $pendings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LedgerPendingsDailyModelImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.total, total) || other.total == total) &&
            const DeepCollectionEquality().equals(other._pendings, _pendings));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    date,
    total,
    const DeepCollectionEquality().hash(_pendings),
  );

  /// Create a copy of LedgerPendingsDailyModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LedgerPendingsDailyModelImplCopyWith<_$LedgerPendingsDailyModelImpl>
  get copyWith =>
      __$$LedgerPendingsDailyModelImplCopyWithImpl<
        _$LedgerPendingsDailyModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LedgerPendingsDailyModelImplToJson(this);
  }
}

abstract class _LedgerPendingsDailyModel implements LedgerPendingsDailyModel {
  const factory _LedgerPendingsDailyModel({
    required final String date,
    @JsonKey(name: 'total_pending', defaultValue: 0) required final int total,
    required final List<LedgerPendingModel> pendings,
  }) = _$LedgerPendingsDailyModelImpl;

  factory _LedgerPendingsDailyModel.fromJson(Map<String, dynamic> json) =
      _$LedgerPendingsDailyModelImpl.fromJson;

  @override
  String get date;
  @override
  @JsonKey(name: 'total_pending', defaultValue: 0)
  int get total;
  @override
  List<LedgerPendingModel> get pendings;

  /// Create a copy of LedgerPendingsDailyModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LedgerPendingsDailyModelImplCopyWith<_$LedgerPendingsDailyModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
