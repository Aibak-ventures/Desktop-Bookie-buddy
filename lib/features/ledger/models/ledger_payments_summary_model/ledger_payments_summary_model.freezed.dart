// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ledger_payments_summary_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LedgerPaymentsSummaryModel _$LedgerPaymentsSummaryModelFromJson(
  Map<String, dynamic> json,
) {
  return _LedgerPaymentsSummaryModel.fromJson(json);
}

/// @nodoc
mixin _$LedgerPaymentsSummaryModel {
  int get gpay => throw _privateConstructorUsedError;
  int get cash => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;

  /// Serializes this LedgerPaymentsSummaryModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LedgerPaymentsSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LedgerPaymentsSummaryModelCopyWith<LedgerPaymentsSummaryModel>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LedgerPaymentsSummaryModelCopyWith<$Res> {
  factory $LedgerPaymentsSummaryModelCopyWith(
    LedgerPaymentsSummaryModel value,
    $Res Function(LedgerPaymentsSummaryModel) then,
  ) =
      _$LedgerPaymentsSummaryModelCopyWithImpl<
        $Res,
        LedgerPaymentsSummaryModel
      >;
  @useResult
  $Res call({int gpay, int cash, int total});
}

/// @nodoc
class _$LedgerPaymentsSummaryModelCopyWithImpl<
  $Res,
  $Val extends LedgerPaymentsSummaryModel
>
    implements $LedgerPaymentsSummaryModelCopyWith<$Res> {
  _$LedgerPaymentsSummaryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LedgerPaymentsSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? gpay = null, Object? cash = null, Object? total = null}) {
    return _then(
      _value.copyWith(
            gpay: null == gpay
                ? _value.gpay
                : gpay // ignore: cast_nullable_to_non_nullable
                      as int,
            cash: null == cash
                ? _value.cash
                : cash // ignore: cast_nullable_to_non_nullable
                      as int,
            total: null == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LedgerPaymentsSummaryModelImplCopyWith<$Res>
    implements $LedgerPaymentsSummaryModelCopyWith<$Res> {
  factory _$$LedgerPaymentsSummaryModelImplCopyWith(
    _$LedgerPaymentsSummaryModelImpl value,
    $Res Function(_$LedgerPaymentsSummaryModelImpl) then,
  ) = __$$LedgerPaymentsSummaryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int gpay, int cash, int total});
}

/// @nodoc
class __$$LedgerPaymentsSummaryModelImplCopyWithImpl<$Res>
    extends
        _$LedgerPaymentsSummaryModelCopyWithImpl<
          $Res,
          _$LedgerPaymentsSummaryModelImpl
        >
    implements _$$LedgerPaymentsSummaryModelImplCopyWith<$Res> {
  __$$LedgerPaymentsSummaryModelImplCopyWithImpl(
    _$LedgerPaymentsSummaryModelImpl _value,
    $Res Function(_$LedgerPaymentsSummaryModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LedgerPaymentsSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? gpay = null, Object? cash = null, Object? total = null}) {
    return _then(
      _$LedgerPaymentsSummaryModelImpl(
        gpay: null == gpay
            ? _value.gpay
            : gpay // ignore: cast_nullable_to_non_nullable
                  as int,
        cash: null == cash
            ? _value.cash
            : cash // ignore: cast_nullable_to_non_nullable
                  as int,
        total: null == total
            ? _value.total
            : total // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LedgerPaymentsSummaryModelImpl implements _LedgerPaymentsSummaryModel {
  const _$LedgerPaymentsSummaryModelImpl({
    required this.gpay,
    required this.cash,
    required this.total,
  });

  factory _$LedgerPaymentsSummaryModelImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$LedgerPaymentsSummaryModelImplFromJson(json);

  @override
  final int gpay;
  @override
  final int cash;
  @override
  final int total;

  @override
  String toString() {
    return 'LedgerPaymentsSummaryModel(gpay: $gpay, cash: $cash, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LedgerPaymentsSummaryModelImpl &&
            (identical(other.gpay, gpay) || other.gpay == gpay) &&
            (identical(other.cash, cash) || other.cash == cash) &&
            (identical(other.total, total) || other.total == total));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, gpay, cash, total);

  /// Create a copy of LedgerPaymentsSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LedgerPaymentsSummaryModelImplCopyWith<_$LedgerPaymentsSummaryModelImpl>
  get copyWith =>
      __$$LedgerPaymentsSummaryModelImplCopyWithImpl<
        _$LedgerPaymentsSummaryModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LedgerPaymentsSummaryModelImplToJson(this);
  }
}

abstract class _LedgerPaymentsSummaryModel
    implements LedgerPaymentsSummaryModel {
  const factory _LedgerPaymentsSummaryModel({
    required final int gpay,
    required final int cash,
    required final int total,
  }) = _$LedgerPaymentsSummaryModelImpl;

  factory _LedgerPaymentsSummaryModel.fromJson(Map<String, dynamic> json) =
      _$LedgerPaymentsSummaryModelImpl.fromJson;

  @override
  int get gpay;
  @override
  int get cash;
  @override
  int get total;

  /// Create a copy of LedgerPaymentsSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LedgerPaymentsSummaryModelImplCopyWith<_$LedgerPaymentsSummaryModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
