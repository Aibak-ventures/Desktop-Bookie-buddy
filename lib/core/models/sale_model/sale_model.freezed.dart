// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sale_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SaleModel _$SaleModelFromJson(Map<String, dynamic> json) {
  return _SaleModel.fromJson(json);
}

/// @nodoc
mixin _$SaleModel {
  @JsonKey(name: 'id')
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'client_name')
  String? get clientName => throw _privateConstructorUsedError;
  @JsonKey(name: 'client_phone')
  dynamic get clientPhone =>
      throw _privateConstructorUsedError; // Can be String or int
  @JsonKey(name: 'total_amount')
  int get totalAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'paid_amount')
  int get paidAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'discount')
  int get discountAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'sale_date')
  String get saleDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'products')
  String get products =>
      throw _privateConstructorUsedError; // Changed from List<String> to String
  @JsonKey(name: 'staff_color')
  String? get staffColor => throw _privateConstructorUsedError;

  /// Serializes this SaleModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SaleModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SaleModelCopyWith<SaleModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SaleModelCopyWith<$Res> {
  factory $SaleModelCopyWith(SaleModel value, $Res Function(SaleModel) then) =
      _$SaleModelCopyWithImpl<$Res, SaleModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') int id,
      @JsonKey(name: 'client_name') String? clientName,
      @JsonKey(name: 'client_phone') dynamic clientPhone,
      @JsonKey(name: 'total_amount') int totalAmount,
      @JsonKey(name: 'paid_amount') int paidAmount,
      @JsonKey(name: 'discount') int discountAmount,
      @JsonKey(name: 'sale_date') String saleDate,
      @JsonKey(name: 'created_at') String createdAt,
      @JsonKey(name: 'products') String products,
      @JsonKey(name: 'staff_color') String? staffColor});
}

/// @nodoc
class _$SaleModelCopyWithImpl<$Res, $Val extends SaleModel>
    implements $SaleModelCopyWith<$Res> {
  _$SaleModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SaleModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clientName = freezed,
    Object? clientPhone = freezed,
    Object? totalAmount = null,
    Object? paidAmount = null,
    Object? discountAmount = null,
    Object? saleDate = null,
    Object? createdAt = null,
    Object? products = null,
    Object? staffColor = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      clientName: freezed == clientName
          ? _value.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String?,
      clientPhone: freezed == clientPhone
          ? _value.clientPhone
          : clientPhone // ignore: cast_nullable_to_non_nullable
              as dynamic,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as int,
      paidAmount: null == paidAmount
          ? _value.paidAmount
          : paidAmount // ignore: cast_nullable_to_non_nullable
              as int,
      discountAmount: null == discountAmount
          ? _value.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as int,
      saleDate: null == saleDate
          ? _value.saleDate
          : saleDate // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      products: null == products
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as String,
      staffColor: freezed == staffColor
          ? _value.staffColor
          : staffColor // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SaleModelImplCopyWith<$Res>
    implements $SaleModelCopyWith<$Res> {
  factory _$$SaleModelImplCopyWith(
          _$SaleModelImpl value, $Res Function(_$SaleModelImpl) then) =
      __$$SaleModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') int id,
      @JsonKey(name: 'client_name') String? clientName,
      @JsonKey(name: 'client_phone') dynamic clientPhone,
      @JsonKey(name: 'total_amount') int totalAmount,
      @JsonKey(name: 'paid_amount') int paidAmount,
      @JsonKey(name: 'discount') int discountAmount,
      @JsonKey(name: 'sale_date') String saleDate,
      @JsonKey(name: 'created_at') String createdAt,
      @JsonKey(name: 'products') String products,
      @JsonKey(name: 'staff_color') String? staffColor});
}

/// @nodoc
class __$$SaleModelImplCopyWithImpl<$Res>
    extends _$SaleModelCopyWithImpl<$Res, _$SaleModelImpl>
    implements _$$SaleModelImplCopyWith<$Res> {
  __$$SaleModelImplCopyWithImpl(
      _$SaleModelImpl _value, $Res Function(_$SaleModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of SaleModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clientName = freezed,
    Object? clientPhone = freezed,
    Object? totalAmount = null,
    Object? paidAmount = null,
    Object? discountAmount = null,
    Object? saleDate = null,
    Object? createdAt = null,
    Object? products = null,
    Object? staffColor = freezed,
  }) {
    return _then(_$SaleModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      clientName: freezed == clientName
          ? _value.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String?,
      clientPhone: freezed == clientPhone
          ? _value.clientPhone
          : clientPhone // ignore: cast_nullable_to_non_nullable
              as dynamic,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as int,
      paidAmount: null == paidAmount
          ? _value.paidAmount
          : paidAmount // ignore: cast_nullable_to_non_nullable
              as int,
      discountAmount: null == discountAmount
          ? _value.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as int,
      saleDate: null == saleDate
          ? _value.saleDate
          : saleDate // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      products: null == products
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as String,
      staffColor: freezed == staffColor
          ? _value.staffColor
          : staffColor // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SaleModelImpl implements _SaleModel {
  const _$SaleModelImpl(
      {@JsonKey(name: 'id') required this.id,
      @JsonKey(name: 'client_name') this.clientName,
      @JsonKey(name: 'client_phone') this.clientPhone,
      @JsonKey(name: 'total_amount') required this.totalAmount,
      @JsonKey(name: 'paid_amount') required this.paidAmount,
      @JsonKey(name: 'discount') required this.discountAmount,
      @JsonKey(name: 'sale_date') required this.saleDate,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'products') required this.products,
      @JsonKey(name: 'staff_color') this.staffColor});

  factory _$SaleModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SaleModelImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int id;
  @override
  @JsonKey(name: 'client_name')
  final String? clientName;
  @override
  @JsonKey(name: 'client_phone')
  final dynamic clientPhone;
// Can be String or int
  @override
  @JsonKey(name: 'total_amount')
  final int totalAmount;
  @override
  @JsonKey(name: 'paid_amount')
  final int paidAmount;
  @override
  @JsonKey(name: 'discount')
  final int discountAmount;
  @override
  @JsonKey(name: 'sale_date')
  final String saleDate;
  @override
  @JsonKey(name: 'created_at')
  final String createdAt;
  @override
  @JsonKey(name: 'products')
  final String products;
// Changed from List<String> to String
  @override
  @JsonKey(name: 'staff_color')
  final String? staffColor;

  @override
  String toString() {
    return 'SaleModel(id: $id, clientName: $clientName, clientPhone: $clientPhone, totalAmount: $totalAmount, paidAmount: $paidAmount, discountAmount: $discountAmount, saleDate: $saleDate, createdAt: $createdAt, products: $products, staffColor: $staffColor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaleModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.clientName, clientName) ||
                other.clientName == clientName) &&
            const DeepCollectionEquality()
                .equals(other.clientPhone, clientPhone) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.paidAmount, paidAmount) ||
                other.paidAmount == paidAmount) &&
            (identical(other.discountAmount, discountAmount) ||
                other.discountAmount == discountAmount) &&
            (identical(other.saleDate, saleDate) ||
                other.saleDate == saleDate) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.products, products) ||
                other.products == products) &&
            (identical(other.staffColor, staffColor) ||
                other.staffColor == staffColor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      clientName,
      const DeepCollectionEquality().hash(clientPhone),
      totalAmount,
      paidAmount,
      discountAmount,
      saleDate,
      createdAt,
      products,
      staffColor);

  /// Create a copy of SaleModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SaleModelImplCopyWith<_$SaleModelImpl> get copyWith =>
      __$$SaleModelImplCopyWithImpl<_$SaleModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SaleModelImplToJson(
      this,
    );
  }
}

abstract class _SaleModel implements SaleModel {
  const factory _SaleModel(
          {@JsonKey(name: 'id') required final int id,
          @JsonKey(name: 'client_name') final String? clientName,
          @JsonKey(name: 'client_phone') final dynamic clientPhone,
          @JsonKey(name: 'total_amount') required final int totalAmount,
          @JsonKey(name: 'paid_amount') required final int paidAmount,
          @JsonKey(name: 'discount') required final int discountAmount,
          @JsonKey(name: 'sale_date') required final String saleDate,
          @JsonKey(name: 'created_at') required final String createdAt,
          @JsonKey(name: 'products') required final String products,
          @JsonKey(name: 'staff_color') final String? staffColor}) =
      _$SaleModelImpl;

  factory _SaleModel.fromJson(Map<String, dynamic> json) =
      _$SaleModelImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  int get id;
  @override
  @JsonKey(name: 'client_name')
  String? get clientName;
  @override
  @JsonKey(name: 'client_phone')
  dynamic get clientPhone; // Can be String or int
  @override
  @JsonKey(name: 'total_amount')
  int get totalAmount;
  @override
  @JsonKey(name: 'paid_amount')
  int get paidAmount;
  @override
  @JsonKey(name: 'discount')
  int get discountAmount;
  @override
  @JsonKey(name: 'sale_date')
  String get saleDate;
  @override
  @JsonKey(name: 'created_at')
  String get createdAt;
  @override
  @JsonKey(name: 'products')
  String get products; // Changed from List<String> to String
  @override
  @JsonKey(name: 'staff_color')
  String? get staffColor;

  /// Create a copy of SaleModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SaleModelImplCopyWith<_$SaleModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
