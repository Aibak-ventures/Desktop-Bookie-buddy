// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expense_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ExpenseModel _$ExpenseModelFromJson(Map<String, dynamic> json) {
  return _ExpenseModel.fromJson(json);
}

/// @nodoc
mixin _$ExpenseModel {
  @JsonKey(name: 'id', includeToJson: false)
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'service_id')
  int? get serviceId => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_id')
  int? get productId => throw _privateConstructorUsedError;
  @JsonKey(name: 'variant_id')
  int? get variantId => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at', defaultValue: '')
  String get date => throw _privateConstructorUsedError;
  @JsonKey(name: 'user', defaultValue: 'Unknown')
  String get userName => throw _privateConstructorUsedError;
  @JsonKey(name: 'expense', defaultValue: 0)
  int get expense => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_deleted', defaultValue: false)
  bool? get isDeleted =>
      throw _privateConstructorUsedError; // 🔥 ADD THIS FIELD
  @JsonKey(name: 'payment_method')
  String? get paymentMethod => throw _privateConstructorUsedError;

  /// Serializes this ExpenseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExpenseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExpenseModelCopyWith<ExpenseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpenseModelCopyWith<$Res> {
  factory $ExpenseModelCopyWith(
          ExpenseModel value, $Res Function(ExpenseModel) then) =
      _$ExpenseModelCopyWithImpl<$Res, ExpenseModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id', includeToJson: false) int id,
      @JsonKey(name: 'service_id') int? serviceId,
      @JsonKey(name: 'product_id') int? productId,
      @JsonKey(name: 'variant_id') int? variantId,
      @JsonKey(name: 'created_at', defaultValue: '') String date,
      @JsonKey(name: 'user', defaultValue: 'Unknown') String userName,
      @JsonKey(name: 'expense', defaultValue: 0) int expense,
      String? type,
      String? description,
      @JsonKey(name: 'is_deleted', defaultValue: false) bool? isDeleted,
      @JsonKey(name: 'payment_method') String? paymentMethod});
}

/// @nodoc
class _$ExpenseModelCopyWithImpl<$Res, $Val extends ExpenseModel>
    implements $ExpenseModelCopyWith<$Res> {
  _$ExpenseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExpenseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? serviceId = freezed,
    Object? productId = freezed,
    Object? variantId = freezed,
    Object? date = null,
    Object? userName = null,
    Object? expense = null,
    Object? type = freezed,
    Object? description = freezed,
    Object? isDeleted = freezed,
    Object? paymentMethod = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      serviceId: freezed == serviceId
          ? _value.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as int?,
      productId: freezed == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int?,
      variantId: freezed == variantId
          ? _value.variantId
          : variantId // ignore: cast_nullable_to_non_nullable
              as int?,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      expense: null == expense
          ? _value.expense
          : expense // ignore: cast_nullable_to_non_nullable
              as int,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      isDeleted: freezed == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool?,
      paymentMethod: freezed == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExpenseModelImplCopyWith<$Res>
    implements $ExpenseModelCopyWith<$Res> {
  factory _$$ExpenseModelImplCopyWith(
          _$ExpenseModelImpl value, $Res Function(_$ExpenseModelImpl) then) =
      __$$ExpenseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id', includeToJson: false) int id,
      @JsonKey(name: 'service_id') int? serviceId,
      @JsonKey(name: 'product_id') int? productId,
      @JsonKey(name: 'variant_id') int? variantId,
      @JsonKey(name: 'created_at', defaultValue: '') String date,
      @JsonKey(name: 'user', defaultValue: 'Unknown') String userName,
      @JsonKey(name: 'expense', defaultValue: 0) int expense,
      String? type,
      String? description,
      @JsonKey(name: 'is_deleted', defaultValue: false) bool? isDeleted,
      @JsonKey(name: 'payment_method') String? paymentMethod});
}

/// @nodoc
class __$$ExpenseModelImplCopyWithImpl<$Res>
    extends _$ExpenseModelCopyWithImpl<$Res, _$ExpenseModelImpl>
    implements _$$ExpenseModelImplCopyWith<$Res> {
  __$$ExpenseModelImplCopyWithImpl(
      _$ExpenseModelImpl _value, $Res Function(_$ExpenseModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExpenseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? serviceId = freezed,
    Object? productId = freezed,
    Object? variantId = freezed,
    Object? date = null,
    Object? userName = null,
    Object? expense = null,
    Object? type = freezed,
    Object? description = freezed,
    Object? isDeleted = freezed,
    Object? paymentMethod = freezed,
  }) {
    return _then(_$ExpenseModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      serviceId: freezed == serviceId
          ? _value.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as int?,
      productId: freezed == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int?,
      variantId: freezed == variantId
          ? _value.variantId
          : variantId // ignore: cast_nullable_to_non_nullable
              as int?,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      expense: null == expense
          ? _value.expense
          : expense // ignore: cast_nullable_to_non_nullable
              as int,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      isDeleted: freezed == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool?,
      paymentMethod: freezed == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExpenseModelImpl implements _ExpenseModel {
  const _$ExpenseModelImpl(
      {@JsonKey(name: 'id', includeToJson: false) required this.id,
      @JsonKey(name: 'service_id') this.serviceId,
      @JsonKey(name: 'product_id') this.productId,
      @JsonKey(name: 'variant_id') this.variantId,
      @JsonKey(name: 'created_at', defaultValue: '') required this.date,
      @JsonKey(name: 'user', defaultValue: 'Unknown') required this.userName,
      @JsonKey(name: 'expense', defaultValue: 0) required this.expense,
      this.type,
      this.description,
      @JsonKey(name: 'is_deleted', defaultValue: false) required this.isDeleted,
      @JsonKey(name: 'payment_method') this.paymentMethod});

  factory _$ExpenseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExpenseModelImplFromJson(json);

  @override
  @JsonKey(name: 'id', includeToJson: false)
  final int id;
  @override
  @JsonKey(name: 'service_id')
  final int? serviceId;
  @override
  @JsonKey(name: 'product_id')
  final int? productId;
  @override
  @JsonKey(name: 'variant_id')
  final int? variantId;
  @override
  @JsonKey(name: 'created_at', defaultValue: '')
  final String date;
  @override
  @JsonKey(name: 'user', defaultValue: 'Unknown')
  final String userName;
  @override
  @JsonKey(name: 'expense', defaultValue: 0)
  final int expense;
  @override
  final String? type;
  @override
  final String? description;
  @override
  @JsonKey(name: 'is_deleted', defaultValue: false)
  final bool? isDeleted;
// 🔥 ADD THIS FIELD
  @override
  @JsonKey(name: 'payment_method')
  final String? paymentMethod;

  @override
  String toString() {
    return 'ExpenseModel(id: $id, serviceId: $serviceId, productId: $productId, variantId: $variantId, date: $date, userName: $userName, expense: $expense, type: $type, description: $description, isDeleted: $isDeleted, paymentMethod: $paymentMethod)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExpenseModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.serviceId, serviceId) ||
                other.serviceId == serviceId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.variantId, variantId) ||
                other.variantId == variantId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.expense, expense) || other.expense == expense) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      serviceId,
      productId,
      variantId,
      date,
      userName,
      expense,
      type,
      description,
      isDeleted,
      paymentMethod);

  /// Create a copy of ExpenseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExpenseModelImplCopyWith<_$ExpenseModelImpl> get copyWith =>
      __$$ExpenseModelImplCopyWithImpl<_$ExpenseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExpenseModelImplToJson(
      this,
    );
  }
}

abstract class _ExpenseModel implements ExpenseModel {
  const factory _ExpenseModel(
      {@JsonKey(name: 'id', includeToJson: false) required final int id,
      @JsonKey(name: 'service_id') final int? serviceId,
      @JsonKey(name: 'product_id') final int? productId,
      @JsonKey(name: 'variant_id') final int? variantId,
      @JsonKey(name: 'created_at', defaultValue: '') required final String date,
      @JsonKey(name: 'user', defaultValue: 'Unknown')
      required final String userName,
      @JsonKey(name: 'expense', defaultValue: 0) required final int expense,
      final String? type,
      final String? description,
      @JsonKey(name: 'is_deleted', defaultValue: false)
      required final bool? isDeleted,
      @JsonKey(name: 'payment_method')
      final String? paymentMethod}) = _$ExpenseModelImpl;

  factory _ExpenseModel.fromJson(Map<String, dynamic> json) =
      _$ExpenseModelImpl.fromJson;

  @override
  @JsonKey(name: 'id', includeToJson: false)
  int get id;
  @override
  @JsonKey(name: 'service_id')
  int? get serviceId;
  @override
  @JsonKey(name: 'product_id')
  int? get productId;
  @override
  @JsonKey(name: 'variant_id')
  int? get variantId;
  @override
  @JsonKey(name: 'created_at', defaultValue: '')
  String get date;
  @override
  @JsonKey(name: 'user', defaultValue: 'Unknown')
  String get userName;
  @override
  @JsonKey(name: 'expense', defaultValue: 0)
  int get expense;
  @override
  String? get type;
  @override
  String? get description;
  @override
  @JsonKey(name: 'is_deleted', defaultValue: false)
  bool? get isDeleted; // 🔥 ADD THIS FIELD
  @override
  @JsonKey(name: 'payment_method')
  String? get paymentMethod;

  /// Create a copy of ExpenseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExpenseModelImplCopyWith<_$ExpenseModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
