// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expense_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ExpenseRequestModel _$ExpenseRequestModelFromJson(Map<String, dynamic> json) {
  return _ExpenseRequestModel.fromJson(json);
}

/// @nodoc
mixin _$ExpenseRequestModel {
  @JsonKey(includeToJson: true, includeIfNull: false)
  int? get expenseId => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_variant', includeIfNull: false)
  int? get variantId => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  String? get date => throw _privateConstructorUsedError;
  @JsonKey(name: 'expense', includeIfNull: false)
  int? get amount => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  String? get type => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_method', includeIfNull: false)
  String? get paymentMethod => throw _privateConstructorUsedError;

  /// Serializes this ExpenseRequestModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExpenseRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExpenseRequestModelCopyWith<ExpenseRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpenseRequestModelCopyWith<$Res> {
  factory $ExpenseRequestModelCopyWith(
          ExpenseRequestModel value, $Res Function(ExpenseRequestModel) then) =
      _$ExpenseRequestModelCopyWithImpl<$Res, ExpenseRequestModel>;
  @useResult
  $Res call(
      {@JsonKey(includeToJson: true, includeIfNull: false) int? expenseId,
      @JsonKey(name: 'product_variant', includeIfNull: false) int? variantId,
      @JsonKey(includeIfNull: false) String? date,
      @JsonKey(name: 'expense', includeIfNull: false) int? amount,
      @JsonKey(includeIfNull: false) String? type,
      @JsonKey(includeIfNull: false) String? description,
      @JsonKey(name: 'payment_method', includeIfNull: false)
      String? paymentMethod});
}

/// @nodoc
class _$ExpenseRequestModelCopyWithImpl<$Res, $Val extends ExpenseRequestModel>
    implements $ExpenseRequestModelCopyWith<$Res> {
  _$ExpenseRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExpenseRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? expenseId = freezed,
    Object? variantId = freezed,
    Object? date = freezed,
    Object? amount = freezed,
    Object? type = freezed,
    Object? description = freezed,
    Object? paymentMethod = freezed,
  }) {
    return _then(_value.copyWith(
      expenseId: freezed == expenseId
          ? _value.expenseId
          : expenseId // ignore: cast_nullable_to_non_nullable
              as int?,
      variantId: freezed == variantId
          ? _value.variantId
          : variantId // ignore: cast_nullable_to_non_nullable
              as int?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentMethod: freezed == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExpenseRequestModelImplCopyWith<$Res>
    implements $ExpenseRequestModelCopyWith<$Res> {
  factory _$$ExpenseRequestModelImplCopyWith(_$ExpenseRequestModelImpl value,
          $Res Function(_$ExpenseRequestModelImpl) then) =
      __$$ExpenseRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeToJson: true, includeIfNull: false) int? expenseId,
      @JsonKey(name: 'product_variant', includeIfNull: false) int? variantId,
      @JsonKey(includeIfNull: false) String? date,
      @JsonKey(name: 'expense', includeIfNull: false) int? amount,
      @JsonKey(includeIfNull: false) String? type,
      @JsonKey(includeIfNull: false) String? description,
      @JsonKey(name: 'payment_method', includeIfNull: false)
      String? paymentMethod});
}

/// @nodoc
class __$$ExpenseRequestModelImplCopyWithImpl<$Res>
    extends _$ExpenseRequestModelCopyWithImpl<$Res, _$ExpenseRequestModelImpl>
    implements _$$ExpenseRequestModelImplCopyWith<$Res> {
  __$$ExpenseRequestModelImplCopyWithImpl(_$ExpenseRequestModelImpl _value,
      $Res Function(_$ExpenseRequestModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExpenseRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? expenseId = freezed,
    Object? variantId = freezed,
    Object? date = freezed,
    Object? amount = freezed,
    Object? type = freezed,
    Object? description = freezed,
    Object? paymentMethod = freezed,
  }) {
    return _then(_$ExpenseRequestModelImpl(
      expenseId: freezed == expenseId
          ? _value.expenseId
          : expenseId // ignore: cast_nullable_to_non_nullable
              as int?,
      variantId: freezed == variantId
          ? _value.variantId
          : variantId // ignore: cast_nullable_to_non_nullable
              as int?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentMethod: freezed == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExpenseRequestModelImpl implements _ExpenseRequestModel {
  const _$ExpenseRequestModelImpl(
      {@JsonKey(includeToJson: true, includeIfNull: false) this.expenseId,
      @JsonKey(name: 'product_variant', includeIfNull: false) this.variantId,
      @JsonKey(includeIfNull: false) this.date,
      @JsonKey(name: 'expense', includeIfNull: false) this.amount,
      @JsonKey(includeIfNull: false) this.type,
      @JsonKey(includeIfNull: false) this.description,
      @JsonKey(name: 'payment_method', includeIfNull: false)
      this.paymentMethod});

  factory _$ExpenseRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExpenseRequestModelImplFromJson(json);

  @override
  @JsonKey(includeToJson: true, includeIfNull: false)
  final int? expenseId;
  @override
  @JsonKey(name: 'product_variant', includeIfNull: false)
  final int? variantId;
  @override
  @JsonKey(includeIfNull: false)
  final String? date;
  @override
  @JsonKey(name: 'expense', includeIfNull: false)
  final int? amount;
  @override
  @JsonKey(includeIfNull: false)
  final String? type;
  @override
  @JsonKey(includeIfNull: false)
  final String? description;
  @override
  @JsonKey(name: 'payment_method', includeIfNull: false)
  final String? paymentMethod;

  @override
  String toString() {
    return 'ExpenseRequestModel(expenseId: $expenseId, variantId: $variantId, date: $date, amount: $amount, type: $type, description: $description, paymentMethod: $paymentMethod)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExpenseRequestModelImpl &&
            (identical(other.expenseId, expenseId) ||
                other.expenseId == expenseId) &&
            (identical(other.variantId, variantId) ||
                other.variantId == variantId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, expenseId, variantId, date,
      amount, type, description, paymentMethod);

  /// Create a copy of ExpenseRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExpenseRequestModelImplCopyWith<_$ExpenseRequestModelImpl> get copyWith =>
      __$$ExpenseRequestModelImplCopyWithImpl<_$ExpenseRequestModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExpenseRequestModelImplToJson(
      this,
    );
  }
}

abstract class _ExpenseRequestModel implements ExpenseRequestModel {
  const factory _ExpenseRequestModel(
      {@JsonKey(includeToJson: true, includeIfNull: false) final int? expenseId,
      @JsonKey(name: 'product_variant', includeIfNull: false)
      final int? variantId,
      @JsonKey(includeIfNull: false) final String? date,
      @JsonKey(name: 'expense', includeIfNull: false) final int? amount,
      @JsonKey(includeIfNull: false) final String? type,
      @JsonKey(includeIfNull: false) final String? description,
      @JsonKey(name: 'payment_method', includeIfNull: false)
      final String? paymentMethod}) = _$ExpenseRequestModelImpl;

  factory _ExpenseRequestModel.fromJson(Map<String, dynamic> json) =
      _$ExpenseRequestModelImpl.fromJson;

  @override
  @JsonKey(includeToJson: true, includeIfNull: false)
  int? get expenseId;
  @override
  @JsonKey(name: 'product_variant', includeIfNull: false)
  int? get variantId;
  @override
  @JsonKey(includeIfNull: false)
  String? get date;
  @override
  @JsonKey(name: 'expense', includeIfNull: false)
  int? get amount;
  @override
  @JsonKey(includeIfNull: false)
  String? get type;
  @override
  @JsonKey(includeIfNull: false)
  String? get description;
  @override
  @JsonKey(name: 'payment_method', includeIfNull: false)
  String? get paymentMethod;

  /// Create a copy of ExpenseRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExpenseRequestModelImplCopyWith<_$ExpenseRequestModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
