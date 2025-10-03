// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ledger_sales_grouped_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LedgerSalesGroupedModel _$LedgerSalesGroupedModelFromJson(
  Map<String, dynamic> json,
) {
  return _LedgerSalesGroupedModel.fromJson(json);
}

/// @nodoc
mixin _$LedgerSalesGroupedModel {
  List<LedgerSaleDailyModel> get dailySales =>
      throw _privateConstructorUsedError;

  /// Serializes this LedgerSalesGroupedModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LedgerSalesGroupedModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LedgerSalesGroupedModelCopyWith<LedgerSalesGroupedModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LedgerSalesGroupedModelCopyWith<$Res> {
  factory $LedgerSalesGroupedModelCopyWith(
    LedgerSalesGroupedModel value,
    $Res Function(LedgerSalesGroupedModel) then,
  ) = _$LedgerSalesGroupedModelCopyWithImpl<$Res, LedgerSalesGroupedModel>;
  @useResult
  $Res call({List<LedgerSaleDailyModel> dailySales});
}

/// @nodoc
class _$LedgerSalesGroupedModelCopyWithImpl<
  $Res,
  $Val extends LedgerSalesGroupedModel
>
    implements $LedgerSalesGroupedModelCopyWith<$Res> {
  _$LedgerSalesGroupedModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LedgerSalesGroupedModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? dailySales = null}) {
    return _then(
      _value.copyWith(
            dailySales: null == dailySales
                ? _value.dailySales
                : dailySales // ignore: cast_nullable_to_non_nullable
                      as List<LedgerSaleDailyModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LedgerSalesGroupedModelImplCopyWith<$Res>
    implements $LedgerSalesGroupedModelCopyWith<$Res> {
  factory _$$LedgerSalesGroupedModelImplCopyWith(
    _$LedgerSalesGroupedModelImpl value,
    $Res Function(_$LedgerSalesGroupedModelImpl) then,
  ) = __$$LedgerSalesGroupedModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<LedgerSaleDailyModel> dailySales});
}

/// @nodoc
class __$$LedgerSalesGroupedModelImplCopyWithImpl<$Res>
    extends
        _$LedgerSalesGroupedModelCopyWithImpl<
          $Res,
          _$LedgerSalesGroupedModelImpl
        >
    implements _$$LedgerSalesGroupedModelImplCopyWith<$Res> {
  __$$LedgerSalesGroupedModelImplCopyWithImpl(
    _$LedgerSalesGroupedModelImpl _value,
    $Res Function(_$LedgerSalesGroupedModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LedgerSalesGroupedModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? dailySales = null}) {
    return _then(
      _$LedgerSalesGroupedModelImpl(
        dailySales: null == dailySales
            ? _value._dailySales
            : dailySales // ignore: cast_nullable_to_non_nullable
                  as List<LedgerSaleDailyModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LedgerSalesGroupedModelImpl implements _LedgerSalesGroupedModel {
  const _$LedgerSalesGroupedModelImpl({
    required final List<LedgerSaleDailyModel> dailySales,
  }) : _dailySales = dailySales;

  factory _$LedgerSalesGroupedModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LedgerSalesGroupedModelImplFromJson(json);

  final List<LedgerSaleDailyModel> _dailySales;
  @override
  List<LedgerSaleDailyModel> get dailySales {
    if (_dailySales is EqualUnmodifiableListView) return _dailySales;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dailySales);
  }

  @override
  String toString() {
    return 'LedgerSalesGroupedModel(dailySales: $dailySales)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LedgerSalesGroupedModelImpl &&
            const DeepCollectionEquality().equals(
              other._dailySales,
              _dailySales,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_dailySales),
  );

  /// Create a copy of LedgerSalesGroupedModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LedgerSalesGroupedModelImplCopyWith<_$LedgerSalesGroupedModelImpl>
  get copyWith =>
      __$$LedgerSalesGroupedModelImplCopyWithImpl<
        _$LedgerSalesGroupedModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LedgerSalesGroupedModelImplToJson(this);
  }
}

abstract class _LedgerSalesGroupedModel implements LedgerSalesGroupedModel {
  const factory _LedgerSalesGroupedModel({
    required final List<LedgerSaleDailyModel> dailySales,
  }) = _$LedgerSalesGroupedModelImpl;

  factory _LedgerSalesGroupedModel.fromJson(Map<String, dynamic> json) =
      _$LedgerSalesGroupedModelImpl.fromJson;

  @override
  List<LedgerSaleDailyModel> get dailySales;

  /// Create a copy of LedgerSalesGroupedModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LedgerSalesGroupedModelImplCopyWith<_$LedgerSalesGroupedModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

LedgerSaleDailyModel _$LedgerSaleDailyModelFromJson(Map<String, dynamic> json) {
  return _LedgerSaleDailyModel.fromJson(json);
}

/// @nodoc
mixin _$LedgerSaleDailyModel {
  String get date => throw _privateConstructorUsedError;
  @JsonKey(name: 'total', defaultValue: 0)
  int get total => throw _privateConstructorUsedError;
  List<LedgerSaleModel> get sales => throw _privateConstructorUsedError;

  /// Serializes this LedgerSaleDailyModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LedgerSaleDailyModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LedgerSaleDailyModelCopyWith<LedgerSaleDailyModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LedgerSaleDailyModelCopyWith<$Res> {
  factory $LedgerSaleDailyModelCopyWith(
    LedgerSaleDailyModel value,
    $Res Function(LedgerSaleDailyModel) then,
  ) = _$LedgerSaleDailyModelCopyWithImpl<$Res, LedgerSaleDailyModel>;
  @useResult
  $Res call({
    String date,
    @JsonKey(name: 'total', defaultValue: 0) int total,
    List<LedgerSaleModel> sales,
  });
}

/// @nodoc
class _$LedgerSaleDailyModelCopyWithImpl<
  $Res,
  $Val extends LedgerSaleDailyModel
>
    implements $LedgerSaleDailyModelCopyWith<$Res> {
  _$LedgerSaleDailyModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LedgerSaleDailyModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? date = null, Object? total = null, Object? sales = null}) {
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
            sales: null == sales
                ? _value.sales
                : sales // ignore: cast_nullable_to_non_nullable
                      as List<LedgerSaleModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LedgerSaleDailyModelImplCopyWith<$Res>
    implements $LedgerSaleDailyModelCopyWith<$Res> {
  factory _$$LedgerSaleDailyModelImplCopyWith(
    _$LedgerSaleDailyModelImpl value,
    $Res Function(_$LedgerSaleDailyModelImpl) then,
  ) = __$$LedgerSaleDailyModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String date,
    @JsonKey(name: 'total', defaultValue: 0) int total,
    List<LedgerSaleModel> sales,
  });
}

/// @nodoc
class __$$LedgerSaleDailyModelImplCopyWithImpl<$Res>
    extends _$LedgerSaleDailyModelCopyWithImpl<$Res, _$LedgerSaleDailyModelImpl>
    implements _$$LedgerSaleDailyModelImplCopyWith<$Res> {
  __$$LedgerSaleDailyModelImplCopyWithImpl(
    _$LedgerSaleDailyModelImpl _value,
    $Res Function(_$LedgerSaleDailyModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LedgerSaleDailyModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? date = null, Object? total = null, Object? sales = null}) {
    return _then(
      _$LedgerSaleDailyModelImpl(
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as String,
        total: null == total
            ? _value.total
            : total // ignore: cast_nullable_to_non_nullable
                  as int,
        sales: null == sales
            ? _value._sales
            : sales // ignore: cast_nullable_to_non_nullable
                  as List<LedgerSaleModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LedgerSaleDailyModelImpl implements _LedgerSaleDailyModel {
  const _$LedgerSaleDailyModelImpl({
    required this.date,
    @JsonKey(name: 'total', defaultValue: 0) required this.total,
    required final List<LedgerSaleModel> sales,
  }) : _sales = sales;

  factory _$LedgerSaleDailyModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LedgerSaleDailyModelImplFromJson(json);

  @override
  final String date;
  @override
  @JsonKey(name: 'total', defaultValue: 0)
  final int total;
  final List<LedgerSaleModel> _sales;
  @override
  List<LedgerSaleModel> get sales {
    if (_sales is EqualUnmodifiableListView) return _sales;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sales);
  }

  @override
  String toString() {
    return 'LedgerSaleDailyModel(date: $date, total: $total, sales: $sales)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LedgerSaleDailyModelImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.total, total) || other.total == total) &&
            const DeepCollectionEquality().equals(other._sales, _sales));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    date,
    total,
    const DeepCollectionEquality().hash(_sales),
  );

  /// Create a copy of LedgerSaleDailyModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LedgerSaleDailyModelImplCopyWith<_$LedgerSaleDailyModelImpl>
  get copyWith =>
      __$$LedgerSaleDailyModelImplCopyWithImpl<_$LedgerSaleDailyModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LedgerSaleDailyModelImplToJson(this);
  }
}

abstract class _LedgerSaleDailyModel implements LedgerSaleDailyModel {
  const factory _LedgerSaleDailyModel({
    required final String date,
    @JsonKey(name: 'total', defaultValue: 0) required final int total,
    required final List<LedgerSaleModel> sales,
  }) = _$LedgerSaleDailyModelImpl;

  factory _LedgerSaleDailyModel.fromJson(Map<String, dynamic> json) =
      _$LedgerSaleDailyModelImpl.fromJson;

  @override
  String get date;
  @override
  @JsonKey(name: 'total', defaultValue: 0)
  int get total;
  @override
  List<LedgerSaleModel> get sales;

  /// Create a copy of LedgerSaleDailyModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LedgerSaleDailyModelImplCopyWith<_$LedgerSaleDailyModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
