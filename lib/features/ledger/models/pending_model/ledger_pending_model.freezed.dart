// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ledger_pending_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LedgerPendingModel _$LedgerPendingModelFromJson(Map<String, dynamic> json) {
  return _LedgerPendingModel.fromJson(json);
}

/// @nodoc
mixin _$LedgerPendingModel {
  @JsonKey(name: 'booking_id')
  int get bookingId => throw _privateConstructorUsedError;
  @JsonKey(name: 'client_name', defaultValue: 'Unknown')
  String get clientName => throw _privateConstructorUsedError;
  @JsonKey(name: 'remaining_amount')
  int get remainingAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'return_date')
  String get returnDate => throw _privateConstructorUsedError;

  /// Serializes this LedgerPendingModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LedgerPendingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LedgerPendingModelCopyWith<LedgerPendingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LedgerPendingModelCopyWith<$Res> {
  factory $LedgerPendingModelCopyWith(
    LedgerPendingModel value,
    $Res Function(LedgerPendingModel) then,
  ) = _$LedgerPendingModelCopyWithImpl<$Res, LedgerPendingModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'booking_id') int bookingId,
    @JsonKey(name: 'client_name', defaultValue: 'Unknown') String clientName,
    @JsonKey(name: 'remaining_amount') int remainingAmount,
    @JsonKey(name: 'return_date') String returnDate,
  });
}

/// @nodoc
class _$LedgerPendingModelCopyWithImpl<$Res, $Val extends LedgerPendingModel>
    implements $LedgerPendingModelCopyWith<$Res> {
  _$LedgerPendingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LedgerPendingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookingId = null,
    Object? clientName = null,
    Object? remainingAmount = null,
    Object? returnDate = null,
  }) {
    return _then(
      _value.copyWith(
            bookingId: null == bookingId
                ? _value.bookingId
                : bookingId // ignore: cast_nullable_to_non_nullable
                      as int,
            clientName: null == clientName
                ? _value.clientName
                : clientName // ignore: cast_nullable_to_non_nullable
                      as String,
            remainingAmount: null == remainingAmount
                ? _value.remainingAmount
                : remainingAmount // ignore: cast_nullable_to_non_nullable
                      as int,
            returnDate: null == returnDate
                ? _value.returnDate
                : returnDate // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LedgerPendingModelImplCopyWith<$Res>
    implements $LedgerPendingModelCopyWith<$Res> {
  factory _$$LedgerPendingModelImplCopyWith(
    _$LedgerPendingModelImpl value,
    $Res Function(_$LedgerPendingModelImpl) then,
  ) = __$$LedgerPendingModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'booking_id') int bookingId,
    @JsonKey(name: 'client_name', defaultValue: 'Unknown') String clientName,
    @JsonKey(name: 'remaining_amount') int remainingAmount,
    @JsonKey(name: 'return_date') String returnDate,
  });
}

/// @nodoc
class __$$LedgerPendingModelImplCopyWithImpl<$Res>
    extends _$LedgerPendingModelCopyWithImpl<$Res, _$LedgerPendingModelImpl>
    implements _$$LedgerPendingModelImplCopyWith<$Res> {
  __$$LedgerPendingModelImplCopyWithImpl(
    _$LedgerPendingModelImpl _value,
    $Res Function(_$LedgerPendingModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LedgerPendingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookingId = null,
    Object? clientName = null,
    Object? remainingAmount = null,
    Object? returnDate = null,
  }) {
    return _then(
      _$LedgerPendingModelImpl(
        bookingId: null == bookingId
            ? _value.bookingId
            : bookingId // ignore: cast_nullable_to_non_nullable
                  as int,
        clientName: null == clientName
            ? _value.clientName
            : clientName // ignore: cast_nullable_to_non_nullable
                  as String,
        remainingAmount: null == remainingAmount
            ? _value.remainingAmount
            : remainingAmount // ignore: cast_nullable_to_non_nullable
                  as int,
        returnDate: null == returnDate
            ? _value.returnDate
            : returnDate // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LedgerPendingModelImpl implements _LedgerPendingModel {
  const _$LedgerPendingModelImpl({
    @JsonKey(name: 'booking_id') required this.bookingId,
    @JsonKey(name: 'client_name', defaultValue: 'Unknown')
    required this.clientName,
    @JsonKey(name: 'remaining_amount') required this.remainingAmount,
    @JsonKey(name: 'return_date') required this.returnDate,
  });

  factory _$LedgerPendingModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LedgerPendingModelImplFromJson(json);

  @override
  @JsonKey(name: 'booking_id')
  final int bookingId;
  @override
  @JsonKey(name: 'client_name', defaultValue: 'Unknown')
  final String clientName;
  @override
  @JsonKey(name: 'remaining_amount')
  final int remainingAmount;
  @override
  @JsonKey(name: 'return_date')
  final String returnDate;

  @override
  String toString() {
    return 'LedgerPendingModel(bookingId: $bookingId, clientName: $clientName, remainingAmount: $remainingAmount, returnDate: $returnDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LedgerPendingModelImpl &&
            (identical(other.bookingId, bookingId) ||
                other.bookingId == bookingId) &&
            (identical(other.clientName, clientName) ||
                other.clientName == clientName) &&
            (identical(other.remainingAmount, remainingAmount) ||
                other.remainingAmount == remainingAmount) &&
            (identical(other.returnDate, returnDate) ||
                other.returnDate == returnDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    bookingId,
    clientName,
    remainingAmount,
    returnDate,
  );

  /// Create a copy of LedgerPendingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LedgerPendingModelImplCopyWith<_$LedgerPendingModelImpl> get copyWith =>
      __$$LedgerPendingModelImplCopyWithImpl<_$LedgerPendingModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LedgerPendingModelImplToJson(this);
  }
}

abstract class _LedgerPendingModel implements LedgerPendingModel {
  const factory _LedgerPendingModel({
    @JsonKey(name: 'booking_id') required final int bookingId,
    @JsonKey(name: 'client_name', defaultValue: 'Unknown')
    required final String clientName,
    @JsonKey(name: 'remaining_amount') required final int remainingAmount,
    @JsonKey(name: 'return_date') required final String returnDate,
  }) = _$LedgerPendingModelImpl;

  factory _LedgerPendingModel.fromJson(Map<String, dynamic> json) =
      _$LedgerPendingModelImpl.fromJson;

  @override
  @JsonKey(name: 'booking_id')
  int get bookingId;
  @override
  @JsonKey(name: 'client_name', defaultValue: 'Unknown')
  String get clientName;
  @override
  @JsonKey(name: 'remaining_amount')
  int get remainingAmount;
  @override
  @JsonKey(name: 'return_date')
  String get returnDate;

  /// Create a copy of LedgerPendingModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LedgerPendingModelImplCopyWith<_$LedgerPendingModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
