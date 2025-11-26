// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ledger_booking_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LedgerBookingModel _$LedgerBookingModelFromJson(Map<String, dynamic> json) {
  return _LedgerBookingModel.fromJson(json);
}

/// @nodoc
mixin _$LedgerBookingModel {
  @JsonKey(name: 'booking_id')
  int get bookingId => throw _privateConstructorUsedError;
  @JsonKey(name: 'client_name', defaultValue: 'Unknown')
  String get clientName => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_amount', defaultValue: 0)
  int get totalAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'advance_amount', defaultValue: 0)
  int get advanceAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'booked_date')
  String get bookedDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'booked_items')
  List<String> get bookedItems => throw _privateConstructorUsedError;

  /// Serializes this LedgerBookingModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LedgerBookingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LedgerBookingModelCopyWith<LedgerBookingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LedgerBookingModelCopyWith<$Res> {
  factory $LedgerBookingModelCopyWith(
          LedgerBookingModel value, $Res Function(LedgerBookingModel) then) =
      _$LedgerBookingModelCopyWithImpl<$Res, LedgerBookingModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'booking_id') int bookingId,
      @JsonKey(name: 'client_name', defaultValue: 'Unknown') String clientName,
      @JsonKey(name: 'total_amount', defaultValue: 0) int totalAmount,
      @JsonKey(name: 'advance_amount', defaultValue: 0) int advanceAmount,
      @JsonKey(name: 'booked_date') String bookedDate,
      @JsonKey(name: 'booked_items') List<String> bookedItems});
}

/// @nodoc
class _$LedgerBookingModelCopyWithImpl<$Res, $Val extends LedgerBookingModel>
    implements $LedgerBookingModelCopyWith<$Res> {
  _$LedgerBookingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LedgerBookingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookingId = null,
    Object? clientName = null,
    Object? totalAmount = null,
    Object? advanceAmount = null,
    Object? bookedDate = null,
    Object? bookedItems = null,
  }) {
    return _then(_value.copyWith(
      bookingId: null == bookingId
          ? _value.bookingId
          : bookingId // ignore: cast_nullable_to_non_nullable
              as int,
      clientName: null == clientName
          ? _value.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as int,
      advanceAmount: null == advanceAmount
          ? _value.advanceAmount
          : advanceAmount // ignore: cast_nullable_to_non_nullable
              as int,
      bookedDate: null == bookedDate
          ? _value.bookedDate
          : bookedDate // ignore: cast_nullable_to_non_nullable
              as String,
      bookedItems: null == bookedItems
          ? _value.bookedItems
          : bookedItems // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LedgerBookingModelImplCopyWith<$Res>
    implements $LedgerBookingModelCopyWith<$Res> {
  factory _$$LedgerBookingModelImplCopyWith(_$LedgerBookingModelImpl value,
          $Res Function(_$LedgerBookingModelImpl) then) =
      __$$LedgerBookingModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'booking_id') int bookingId,
      @JsonKey(name: 'client_name', defaultValue: 'Unknown') String clientName,
      @JsonKey(name: 'total_amount', defaultValue: 0) int totalAmount,
      @JsonKey(name: 'advance_amount', defaultValue: 0) int advanceAmount,
      @JsonKey(name: 'booked_date') String bookedDate,
      @JsonKey(name: 'booked_items') List<String> bookedItems});
}

/// @nodoc
class __$$LedgerBookingModelImplCopyWithImpl<$Res>
    extends _$LedgerBookingModelCopyWithImpl<$Res, _$LedgerBookingModelImpl>
    implements _$$LedgerBookingModelImplCopyWith<$Res> {
  __$$LedgerBookingModelImplCopyWithImpl(_$LedgerBookingModelImpl _value,
      $Res Function(_$LedgerBookingModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of LedgerBookingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookingId = null,
    Object? clientName = null,
    Object? totalAmount = null,
    Object? advanceAmount = null,
    Object? bookedDate = null,
    Object? bookedItems = null,
  }) {
    return _then(_$LedgerBookingModelImpl(
      bookingId: null == bookingId
          ? _value.bookingId
          : bookingId // ignore: cast_nullable_to_non_nullable
              as int,
      clientName: null == clientName
          ? _value.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as int,
      advanceAmount: null == advanceAmount
          ? _value.advanceAmount
          : advanceAmount // ignore: cast_nullable_to_non_nullable
              as int,
      bookedDate: null == bookedDate
          ? _value.bookedDate
          : bookedDate // ignore: cast_nullable_to_non_nullable
              as String,
      bookedItems: null == bookedItems
          ? _value._bookedItems
          : bookedItems // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LedgerBookingModelImpl implements _LedgerBookingModel {
  const _$LedgerBookingModelImpl(
      {@JsonKey(name: 'booking_id') required this.bookingId,
      @JsonKey(name: 'client_name', defaultValue: 'Unknown')
      required this.clientName,
      @JsonKey(name: 'total_amount', defaultValue: 0) required this.totalAmount,
      @JsonKey(name: 'advance_amount', defaultValue: 0)
      required this.advanceAmount,
      @JsonKey(name: 'booked_date') required this.bookedDate,
      @JsonKey(name: 'booked_items') final List<String> bookedItems = const []})
      : _bookedItems = bookedItems;

  factory _$LedgerBookingModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LedgerBookingModelImplFromJson(json);

  @override
  @JsonKey(name: 'booking_id')
  final int bookingId;
  @override
  @JsonKey(name: 'client_name', defaultValue: 'Unknown')
  final String clientName;
  @override
  @JsonKey(name: 'total_amount', defaultValue: 0)
  final int totalAmount;
  @override
  @JsonKey(name: 'advance_amount', defaultValue: 0)
  final int advanceAmount;
  @override
  @JsonKey(name: 'booked_date')
  final String bookedDate;
  final List<String> _bookedItems;
  @override
  @JsonKey(name: 'booked_items')
  List<String> get bookedItems {
    if (_bookedItems is EqualUnmodifiableListView) return _bookedItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bookedItems);
  }

  @override
  String toString() {
    return 'LedgerBookingModel(bookingId: $bookingId, clientName: $clientName, totalAmount: $totalAmount, advanceAmount: $advanceAmount, bookedDate: $bookedDate, bookedItems: $bookedItems)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LedgerBookingModelImpl &&
            (identical(other.bookingId, bookingId) ||
                other.bookingId == bookingId) &&
            (identical(other.clientName, clientName) ||
                other.clientName == clientName) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.advanceAmount, advanceAmount) ||
                other.advanceAmount == advanceAmount) &&
            (identical(other.bookedDate, bookedDate) ||
                other.bookedDate == bookedDate) &&
            const DeepCollectionEquality()
                .equals(other._bookedItems, _bookedItems));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      bookingId,
      clientName,
      totalAmount,
      advanceAmount,
      bookedDate,
      const DeepCollectionEquality().hash(_bookedItems));

  /// Create a copy of LedgerBookingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LedgerBookingModelImplCopyWith<_$LedgerBookingModelImpl> get copyWith =>
      __$$LedgerBookingModelImplCopyWithImpl<_$LedgerBookingModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LedgerBookingModelImplToJson(
      this,
    );
  }
}

abstract class _LedgerBookingModel implements LedgerBookingModel {
  const factory _LedgerBookingModel(
          {@JsonKey(name: 'booking_id') required final int bookingId,
          @JsonKey(name: 'client_name', defaultValue: 'Unknown')
          required final String clientName,
          @JsonKey(name: 'total_amount', defaultValue: 0)
          required final int totalAmount,
          @JsonKey(name: 'advance_amount', defaultValue: 0)
          required final int advanceAmount,
          @JsonKey(name: 'booked_date') required final String bookedDate,
          @JsonKey(name: 'booked_items') final List<String> bookedItems}) =
      _$LedgerBookingModelImpl;

  factory _LedgerBookingModel.fromJson(Map<String, dynamic> json) =
      _$LedgerBookingModelImpl.fromJson;

  @override
  @JsonKey(name: 'booking_id')
  int get bookingId;
  @override
  @JsonKey(name: 'client_name', defaultValue: 'Unknown')
  String get clientName;
  @override
  @JsonKey(name: 'total_amount', defaultValue: 0)
  int get totalAmount;
  @override
  @JsonKey(name: 'advance_amount', defaultValue: 0)
  int get advanceAmount;
  @override
  @JsonKey(name: 'booked_date')
  String get bookedDate;
  @override
  @JsonKey(name: 'booked_items')
  List<String> get bookedItems;

  /// Create a copy of LedgerBookingModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LedgerBookingModelImplCopyWith<_$LedgerBookingModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
