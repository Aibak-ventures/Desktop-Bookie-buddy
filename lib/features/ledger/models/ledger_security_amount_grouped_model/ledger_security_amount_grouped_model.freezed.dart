// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ledger_security_amount_grouped_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LedgerSecurityAmountGroupedModel _$LedgerSecurityAmountGroupedModelFromJson(
  Map<String, dynamic> json,
) {
  return _LedgerSecurityAmountGroupedModel.fromJson(json);
}

/// @nodoc
mixin _$LedgerSecurityAmountGroupedModel {
  List<LedgerSecurityAmountDailyModel> get dailySecurityAmounts =>
      throw _privateConstructorUsedError;

  /// Serializes this LedgerSecurityAmountGroupedModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LedgerSecurityAmountGroupedModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LedgerSecurityAmountGroupedModelCopyWith<LedgerSecurityAmountGroupedModel>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LedgerSecurityAmountGroupedModelCopyWith<$Res> {
  factory $LedgerSecurityAmountGroupedModelCopyWith(
    LedgerSecurityAmountGroupedModel value,
    $Res Function(LedgerSecurityAmountGroupedModel) then,
  ) =
      _$LedgerSecurityAmountGroupedModelCopyWithImpl<
        $Res,
        LedgerSecurityAmountGroupedModel
      >;
  @useResult
  $Res call({List<LedgerSecurityAmountDailyModel> dailySecurityAmounts});
}

/// @nodoc
class _$LedgerSecurityAmountGroupedModelCopyWithImpl<
  $Res,
  $Val extends LedgerSecurityAmountGroupedModel
>
    implements $LedgerSecurityAmountGroupedModelCopyWith<$Res> {
  _$LedgerSecurityAmountGroupedModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LedgerSecurityAmountGroupedModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? dailySecurityAmounts = null}) {
    return _then(
      _value.copyWith(
            dailySecurityAmounts: null == dailySecurityAmounts
                ? _value.dailySecurityAmounts
                : dailySecurityAmounts // ignore: cast_nullable_to_non_nullable
                      as List<LedgerSecurityAmountDailyModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LedgerSecurityAmountGroupedModelImplCopyWith<$Res>
    implements $LedgerSecurityAmountGroupedModelCopyWith<$Res> {
  factory _$$LedgerSecurityAmountGroupedModelImplCopyWith(
    _$LedgerSecurityAmountGroupedModelImpl value,
    $Res Function(_$LedgerSecurityAmountGroupedModelImpl) then,
  ) = __$$LedgerSecurityAmountGroupedModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<LedgerSecurityAmountDailyModel> dailySecurityAmounts});
}

/// @nodoc
class __$$LedgerSecurityAmountGroupedModelImplCopyWithImpl<$Res>
    extends
        _$LedgerSecurityAmountGroupedModelCopyWithImpl<
          $Res,
          _$LedgerSecurityAmountGroupedModelImpl
        >
    implements _$$LedgerSecurityAmountGroupedModelImplCopyWith<$Res> {
  __$$LedgerSecurityAmountGroupedModelImplCopyWithImpl(
    _$LedgerSecurityAmountGroupedModelImpl _value,
    $Res Function(_$LedgerSecurityAmountGroupedModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LedgerSecurityAmountGroupedModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? dailySecurityAmounts = null}) {
    return _then(
      _$LedgerSecurityAmountGroupedModelImpl(
        dailySecurityAmounts: null == dailySecurityAmounts
            ? _value._dailySecurityAmounts
            : dailySecurityAmounts // ignore: cast_nullable_to_non_nullable
                  as List<LedgerSecurityAmountDailyModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LedgerSecurityAmountGroupedModelImpl
    implements _LedgerSecurityAmountGroupedModel {
  const _$LedgerSecurityAmountGroupedModelImpl({
    required final List<LedgerSecurityAmountDailyModel> dailySecurityAmounts,
  }) : _dailySecurityAmounts = dailySecurityAmounts;

  factory _$LedgerSecurityAmountGroupedModelImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$LedgerSecurityAmountGroupedModelImplFromJson(json);

  final List<LedgerSecurityAmountDailyModel> _dailySecurityAmounts;
  @override
  List<LedgerSecurityAmountDailyModel> get dailySecurityAmounts {
    if (_dailySecurityAmounts is EqualUnmodifiableListView)
      return _dailySecurityAmounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dailySecurityAmounts);
  }

  @override
  String toString() {
    return 'LedgerSecurityAmountGroupedModel(dailySecurityAmounts: $dailySecurityAmounts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LedgerSecurityAmountGroupedModelImpl &&
            const DeepCollectionEquality().equals(
              other._dailySecurityAmounts,
              _dailySecurityAmounts,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_dailySecurityAmounts),
  );

  /// Create a copy of LedgerSecurityAmountGroupedModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LedgerSecurityAmountGroupedModelImplCopyWith<
    _$LedgerSecurityAmountGroupedModelImpl
  >
  get copyWith =>
      __$$LedgerSecurityAmountGroupedModelImplCopyWithImpl<
        _$LedgerSecurityAmountGroupedModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LedgerSecurityAmountGroupedModelImplToJson(this);
  }
}

abstract class _LedgerSecurityAmountGroupedModel
    implements LedgerSecurityAmountGroupedModel {
  const factory _LedgerSecurityAmountGroupedModel({
    required final List<LedgerSecurityAmountDailyModel> dailySecurityAmounts,
  }) = _$LedgerSecurityAmountGroupedModelImpl;

  factory _LedgerSecurityAmountGroupedModel.fromJson(
    Map<String, dynamic> json,
  ) = _$LedgerSecurityAmountGroupedModelImpl.fromJson;

  @override
  List<LedgerSecurityAmountDailyModel> get dailySecurityAmounts;

  /// Create a copy of LedgerSecurityAmountGroupedModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LedgerSecurityAmountGroupedModelImplCopyWith<
    _$LedgerSecurityAmountGroupedModelImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

LedgerSecurityAmountDailyModel _$LedgerSecurityAmountDailyModelFromJson(
  Map<String, dynamic> json,
) {
  return _LedgerSecurityAmountDailyModel.fromJson(json);
}

/// @nodoc
mixin _$LedgerSecurityAmountDailyModel {
  String get date => throw _privateConstructorUsedError;
  List<LedgerSecurityAmountModel> get items =>
      throw _privateConstructorUsedError;

  /// Serializes this LedgerSecurityAmountDailyModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LedgerSecurityAmountDailyModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LedgerSecurityAmountDailyModelCopyWith<LedgerSecurityAmountDailyModel>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LedgerSecurityAmountDailyModelCopyWith<$Res> {
  factory $LedgerSecurityAmountDailyModelCopyWith(
    LedgerSecurityAmountDailyModel value,
    $Res Function(LedgerSecurityAmountDailyModel) then,
  ) =
      _$LedgerSecurityAmountDailyModelCopyWithImpl<
        $Res,
        LedgerSecurityAmountDailyModel
      >;
  @useResult
  $Res call({String date, List<LedgerSecurityAmountModel> items});
}

/// @nodoc
class _$LedgerSecurityAmountDailyModelCopyWithImpl<
  $Res,
  $Val extends LedgerSecurityAmountDailyModel
>
    implements $LedgerSecurityAmountDailyModelCopyWith<$Res> {
  _$LedgerSecurityAmountDailyModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LedgerSecurityAmountDailyModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? date = null, Object? items = null}) {
    return _then(
      _value.copyWith(
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as String,
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<LedgerSecurityAmountModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LedgerSecurityAmountDailyModelImplCopyWith<$Res>
    implements $LedgerSecurityAmountDailyModelCopyWith<$Res> {
  factory _$$LedgerSecurityAmountDailyModelImplCopyWith(
    _$LedgerSecurityAmountDailyModelImpl value,
    $Res Function(_$LedgerSecurityAmountDailyModelImpl) then,
  ) = __$$LedgerSecurityAmountDailyModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String date, List<LedgerSecurityAmountModel> items});
}

/// @nodoc
class __$$LedgerSecurityAmountDailyModelImplCopyWithImpl<$Res>
    extends
        _$LedgerSecurityAmountDailyModelCopyWithImpl<
          $Res,
          _$LedgerSecurityAmountDailyModelImpl
        >
    implements _$$LedgerSecurityAmountDailyModelImplCopyWith<$Res> {
  __$$LedgerSecurityAmountDailyModelImplCopyWithImpl(
    _$LedgerSecurityAmountDailyModelImpl _value,
    $Res Function(_$LedgerSecurityAmountDailyModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LedgerSecurityAmountDailyModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? date = null, Object? items = null}) {
    return _then(
      _$LedgerSecurityAmountDailyModelImpl(
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as String,
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<LedgerSecurityAmountModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LedgerSecurityAmountDailyModelImpl
    implements _LedgerSecurityAmountDailyModel {
  const _$LedgerSecurityAmountDailyModelImpl({
    required this.date,
    required final List<LedgerSecurityAmountModel> items,
  }) : _items = items;

  factory _$LedgerSecurityAmountDailyModelImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$LedgerSecurityAmountDailyModelImplFromJson(json);

  @override
  final String date;
  final List<LedgerSecurityAmountModel> _items;
  @override
  List<LedgerSecurityAmountModel> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'LedgerSecurityAmountDailyModel(date: $date, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LedgerSecurityAmountDailyModelImpl &&
            (identical(other.date, date) || other.date == date) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    date,
    const DeepCollectionEquality().hash(_items),
  );

  /// Create a copy of LedgerSecurityAmountDailyModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LedgerSecurityAmountDailyModelImplCopyWith<
    _$LedgerSecurityAmountDailyModelImpl
  >
  get copyWith =>
      __$$LedgerSecurityAmountDailyModelImplCopyWithImpl<
        _$LedgerSecurityAmountDailyModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LedgerSecurityAmountDailyModelImplToJson(this);
  }
}

abstract class _LedgerSecurityAmountDailyModel
    implements LedgerSecurityAmountDailyModel {
  const factory _LedgerSecurityAmountDailyModel({
    required final String date,
    required final List<LedgerSecurityAmountModel> items,
  }) = _$LedgerSecurityAmountDailyModelImpl;

  factory _LedgerSecurityAmountDailyModel.fromJson(Map<String, dynamic> json) =
      _$LedgerSecurityAmountDailyModelImpl.fromJson;

  @override
  String get date;
  @override
  List<LedgerSecurityAmountModel> get items;

  /// Create a copy of LedgerSecurityAmountDailyModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LedgerSecurityAmountDailyModelImplCopyWith<
    _$LedgerSecurityAmountDailyModelImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}
