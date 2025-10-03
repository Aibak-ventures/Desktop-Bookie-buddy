// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transfer_product_history_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TransferProductHistoryModel _$TransferProductHistoryModelFromJson(
  Map<String, dynamic> json,
) {
  return _TransferProductHistoryModel.fromJson(json);
}

/// @nodoc
mixin _$TransferProductHistoryModel {
  int get id =>
      throw _privateConstructorUsedError; // @JsonKey(name: 'transfer_id') required String transferId,
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'quantity_transferred')
  int get quantityTransferred => throw _privateConstructorUsedError;
  @JsonKey(name: 'transfer_mode', fromJson: _isIncomingFromJson)
  bool get isIncoming => throw _privateConstructorUsedError;
  @JsonKey(name: 'transfer_type')
  String get transferType => throw _privateConstructorUsedError;
  @JsonKey(name: 'image', readValue: _readProduct)
  String? get productImage => throw _privateConstructorUsedError;
  @JsonKey(name: 'color', readValue: _readProduct)
  String? get productColor => throw _privateConstructorUsedError;
  @JsonKey(name: 'model', readValue: _readProduct)
  String? get productModel => throw _privateConstructorUsedError;
  @JsonKey(name: 'category', readValue: _readProduct)
  String? get productCategory => throw _privateConstructorUsedError;
  @JsonKey(readValue: _readSourceShopAddress)
  String get sourceShopAddress => throw _privateConstructorUsedError;
  @JsonKey(readValue: _readDestinationShopAddress)
  String get destinationShopAddress => throw _privateConstructorUsedError;
  @JsonKey(name: 'transfer_date')
  String get transferDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'source_shop_name')
  String get sourceShopName => throw _privateConstructorUsedError;
  @JsonKey(name: 'destination_shop_name')
  String get destinationShopName => throw _privateConstructorUsedError;
  @JsonKey(name: 'source_product_name')
  String get sourceProductName => throw _privateConstructorUsedError;
  @JsonKey(name: 'destination_product_name')
  String get destinationProductName => throw _privateConstructorUsedError;
  @JsonKey(name: 'initiated_by_name')
  String get initiatedByName => throw _privateConstructorUsedError;
  @JsonKey(name: 'source_variant_attribute')
  String get sourceVariantAttribute => throw _privateConstructorUsedError;
  @JsonKey(name: 'destination_variant_attribute')
  String get destinationVariantAttribute => throw _privateConstructorUsedError;

  /// Serializes this TransferProductHistoryModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TransferProductHistoryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransferProductHistoryModelCopyWith<TransferProductHistoryModel>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransferProductHistoryModelCopyWith<$Res> {
  factory $TransferProductHistoryModelCopyWith(
    TransferProductHistoryModel value,
    $Res Function(TransferProductHistoryModel) then,
  ) =
      _$TransferProductHistoryModelCopyWithImpl<
        $Res,
        TransferProductHistoryModel
      >;
  @useResult
  $Res call({
    int id,
    String status,
    @JsonKey(name: 'quantity_transferred') int quantityTransferred,
    @JsonKey(name: 'transfer_mode', fromJson: _isIncomingFromJson)
    bool isIncoming,
    @JsonKey(name: 'transfer_type') String transferType,
    @JsonKey(name: 'image', readValue: _readProduct) String? productImage,
    @JsonKey(name: 'color', readValue: _readProduct) String? productColor,
    @JsonKey(name: 'model', readValue: _readProduct) String? productModel,
    @JsonKey(name: 'category', readValue: _readProduct) String? productCategory,
    @JsonKey(readValue: _readSourceShopAddress) String sourceShopAddress,
    @JsonKey(readValue: _readDestinationShopAddress)
    String destinationShopAddress,
    @JsonKey(name: 'transfer_date') String transferDate,
    @JsonKey(name: 'source_shop_name') String sourceShopName,
    @JsonKey(name: 'destination_shop_name') String destinationShopName,
    @JsonKey(name: 'source_product_name') String sourceProductName,
    @JsonKey(name: 'destination_product_name') String destinationProductName,
    @JsonKey(name: 'initiated_by_name') String initiatedByName,
    @JsonKey(name: 'source_variant_attribute') String sourceVariantAttribute,
    @JsonKey(name: 'destination_variant_attribute')
    String destinationVariantAttribute,
  });
}

/// @nodoc
class _$TransferProductHistoryModelCopyWithImpl<
  $Res,
  $Val extends TransferProductHistoryModel
>
    implements $TransferProductHistoryModelCopyWith<$Res> {
  _$TransferProductHistoryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransferProductHistoryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? quantityTransferred = null,
    Object? isIncoming = null,
    Object? transferType = null,
    Object? productImage = freezed,
    Object? productColor = freezed,
    Object? productModel = freezed,
    Object? productCategory = freezed,
    Object? sourceShopAddress = null,
    Object? destinationShopAddress = null,
    Object? transferDate = null,
    Object? sourceShopName = null,
    Object? destinationShopName = null,
    Object? sourceProductName = null,
    Object? destinationProductName = null,
    Object? initiatedByName = null,
    Object? sourceVariantAttribute = null,
    Object? destinationVariantAttribute = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            quantityTransferred: null == quantityTransferred
                ? _value.quantityTransferred
                : quantityTransferred // ignore: cast_nullable_to_non_nullable
                      as int,
            isIncoming: null == isIncoming
                ? _value.isIncoming
                : isIncoming // ignore: cast_nullable_to_non_nullable
                      as bool,
            transferType: null == transferType
                ? _value.transferType
                : transferType // ignore: cast_nullable_to_non_nullable
                      as String,
            productImage: freezed == productImage
                ? _value.productImage
                : productImage // ignore: cast_nullable_to_non_nullable
                      as String?,
            productColor: freezed == productColor
                ? _value.productColor
                : productColor // ignore: cast_nullable_to_non_nullable
                      as String?,
            productModel: freezed == productModel
                ? _value.productModel
                : productModel // ignore: cast_nullable_to_non_nullable
                      as String?,
            productCategory: freezed == productCategory
                ? _value.productCategory
                : productCategory // ignore: cast_nullable_to_non_nullable
                      as String?,
            sourceShopAddress: null == sourceShopAddress
                ? _value.sourceShopAddress
                : sourceShopAddress // ignore: cast_nullable_to_non_nullable
                      as String,
            destinationShopAddress: null == destinationShopAddress
                ? _value.destinationShopAddress
                : destinationShopAddress // ignore: cast_nullable_to_non_nullable
                      as String,
            transferDate: null == transferDate
                ? _value.transferDate
                : transferDate // ignore: cast_nullable_to_non_nullable
                      as String,
            sourceShopName: null == sourceShopName
                ? _value.sourceShopName
                : sourceShopName // ignore: cast_nullable_to_non_nullable
                      as String,
            destinationShopName: null == destinationShopName
                ? _value.destinationShopName
                : destinationShopName // ignore: cast_nullable_to_non_nullable
                      as String,
            sourceProductName: null == sourceProductName
                ? _value.sourceProductName
                : sourceProductName // ignore: cast_nullable_to_non_nullable
                      as String,
            destinationProductName: null == destinationProductName
                ? _value.destinationProductName
                : destinationProductName // ignore: cast_nullable_to_non_nullable
                      as String,
            initiatedByName: null == initiatedByName
                ? _value.initiatedByName
                : initiatedByName // ignore: cast_nullable_to_non_nullable
                      as String,
            sourceVariantAttribute: null == sourceVariantAttribute
                ? _value.sourceVariantAttribute
                : sourceVariantAttribute // ignore: cast_nullable_to_non_nullable
                      as String,
            destinationVariantAttribute: null == destinationVariantAttribute
                ? _value.destinationVariantAttribute
                : destinationVariantAttribute // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TransferProductHistoryModelImplCopyWith<$Res>
    implements $TransferProductHistoryModelCopyWith<$Res> {
  factory _$$TransferProductHistoryModelImplCopyWith(
    _$TransferProductHistoryModelImpl value,
    $Res Function(_$TransferProductHistoryModelImpl) then,
  ) = __$$TransferProductHistoryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String status,
    @JsonKey(name: 'quantity_transferred') int quantityTransferred,
    @JsonKey(name: 'transfer_mode', fromJson: _isIncomingFromJson)
    bool isIncoming,
    @JsonKey(name: 'transfer_type') String transferType,
    @JsonKey(name: 'image', readValue: _readProduct) String? productImage,
    @JsonKey(name: 'color', readValue: _readProduct) String? productColor,
    @JsonKey(name: 'model', readValue: _readProduct) String? productModel,
    @JsonKey(name: 'category', readValue: _readProduct) String? productCategory,
    @JsonKey(readValue: _readSourceShopAddress) String sourceShopAddress,
    @JsonKey(readValue: _readDestinationShopAddress)
    String destinationShopAddress,
    @JsonKey(name: 'transfer_date') String transferDate,
    @JsonKey(name: 'source_shop_name') String sourceShopName,
    @JsonKey(name: 'destination_shop_name') String destinationShopName,
    @JsonKey(name: 'source_product_name') String sourceProductName,
    @JsonKey(name: 'destination_product_name') String destinationProductName,
    @JsonKey(name: 'initiated_by_name') String initiatedByName,
    @JsonKey(name: 'source_variant_attribute') String sourceVariantAttribute,
    @JsonKey(name: 'destination_variant_attribute')
    String destinationVariantAttribute,
  });
}

/// @nodoc
class __$$TransferProductHistoryModelImplCopyWithImpl<$Res>
    extends
        _$TransferProductHistoryModelCopyWithImpl<
          $Res,
          _$TransferProductHistoryModelImpl
        >
    implements _$$TransferProductHistoryModelImplCopyWith<$Res> {
  __$$TransferProductHistoryModelImplCopyWithImpl(
    _$TransferProductHistoryModelImpl _value,
    $Res Function(_$TransferProductHistoryModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransferProductHistoryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? quantityTransferred = null,
    Object? isIncoming = null,
    Object? transferType = null,
    Object? productImage = freezed,
    Object? productColor = freezed,
    Object? productModel = freezed,
    Object? productCategory = freezed,
    Object? sourceShopAddress = null,
    Object? destinationShopAddress = null,
    Object? transferDate = null,
    Object? sourceShopName = null,
    Object? destinationShopName = null,
    Object? sourceProductName = null,
    Object? destinationProductName = null,
    Object? initiatedByName = null,
    Object? sourceVariantAttribute = null,
    Object? destinationVariantAttribute = null,
  }) {
    return _then(
      _$TransferProductHistoryModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        quantityTransferred: null == quantityTransferred
            ? _value.quantityTransferred
            : quantityTransferred // ignore: cast_nullable_to_non_nullable
                  as int,
        isIncoming: null == isIncoming
            ? _value.isIncoming
            : isIncoming // ignore: cast_nullable_to_non_nullable
                  as bool,
        transferType: null == transferType
            ? _value.transferType
            : transferType // ignore: cast_nullable_to_non_nullable
                  as String,
        productImage: freezed == productImage
            ? _value.productImage
            : productImage // ignore: cast_nullable_to_non_nullable
                  as String?,
        productColor: freezed == productColor
            ? _value.productColor
            : productColor // ignore: cast_nullable_to_non_nullable
                  as String?,
        productModel: freezed == productModel
            ? _value.productModel
            : productModel // ignore: cast_nullable_to_non_nullable
                  as String?,
        productCategory: freezed == productCategory
            ? _value.productCategory
            : productCategory // ignore: cast_nullable_to_non_nullable
                  as String?,
        sourceShopAddress: null == sourceShopAddress
            ? _value.sourceShopAddress
            : sourceShopAddress // ignore: cast_nullable_to_non_nullable
                  as String,
        destinationShopAddress: null == destinationShopAddress
            ? _value.destinationShopAddress
            : destinationShopAddress // ignore: cast_nullable_to_non_nullable
                  as String,
        transferDate: null == transferDate
            ? _value.transferDate
            : transferDate // ignore: cast_nullable_to_non_nullable
                  as String,
        sourceShopName: null == sourceShopName
            ? _value.sourceShopName
            : sourceShopName // ignore: cast_nullable_to_non_nullable
                  as String,
        destinationShopName: null == destinationShopName
            ? _value.destinationShopName
            : destinationShopName // ignore: cast_nullable_to_non_nullable
                  as String,
        sourceProductName: null == sourceProductName
            ? _value.sourceProductName
            : sourceProductName // ignore: cast_nullable_to_non_nullable
                  as String,
        destinationProductName: null == destinationProductName
            ? _value.destinationProductName
            : destinationProductName // ignore: cast_nullable_to_non_nullable
                  as String,
        initiatedByName: null == initiatedByName
            ? _value.initiatedByName
            : initiatedByName // ignore: cast_nullable_to_non_nullable
                  as String,
        sourceVariantAttribute: null == sourceVariantAttribute
            ? _value.sourceVariantAttribute
            : sourceVariantAttribute // ignore: cast_nullable_to_non_nullable
                  as String,
        destinationVariantAttribute: null == destinationVariantAttribute
            ? _value.destinationVariantAttribute
            : destinationVariantAttribute // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TransferProductHistoryModelImpl
    implements _TransferProductHistoryModel {
  const _$TransferProductHistoryModelImpl({
    required this.id,
    required this.status,
    @JsonKey(name: 'quantity_transferred') required this.quantityTransferred,
    @JsonKey(name: 'transfer_mode', fromJson: _isIncomingFromJson)
    required this.isIncoming,
    @JsonKey(name: 'transfer_type') required this.transferType,
    @JsonKey(name: 'image', readValue: _readProduct) this.productImage,
    @JsonKey(name: 'color', readValue: _readProduct) this.productColor,
    @JsonKey(name: 'model', readValue: _readProduct) this.productModel,
    @JsonKey(name: 'category', readValue: _readProduct) this.productCategory,
    @JsonKey(readValue: _readSourceShopAddress) required this.sourceShopAddress,
    @JsonKey(readValue: _readDestinationShopAddress)
    required this.destinationShopAddress,
    @JsonKey(name: 'transfer_date') required this.transferDate,
    @JsonKey(name: 'source_shop_name') required this.sourceShopName,
    @JsonKey(name: 'destination_shop_name') required this.destinationShopName,
    @JsonKey(name: 'source_product_name') required this.sourceProductName,
    @JsonKey(name: 'destination_product_name')
    required this.destinationProductName,
    @JsonKey(name: 'initiated_by_name') required this.initiatedByName,
    @JsonKey(name: 'source_variant_attribute')
    required this.sourceVariantAttribute,
    @JsonKey(name: 'destination_variant_attribute')
    required this.destinationVariantAttribute,
  });

  factory _$TransferProductHistoryModelImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$TransferProductHistoryModelImplFromJson(json);

  @override
  final int id;
  // @JsonKey(name: 'transfer_id') required String transferId,
  @override
  final String status;
  @override
  @JsonKey(name: 'quantity_transferred')
  final int quantityTransferred;
  @override
  @JsonKey(name: 'transfer_mode', fromJson: _isIncomingFromJson)
  final bool isIncoming;
  @override
  @JsonKey(name: 'transfer_type')
  final String transferType;
  @override
  @JsonKey(name: 'image', readValue: _readProduct)
  final String? productImage;
  @override
  @JsonKey(name: 'color', readValue: _readProduct)
  final String? productColor;
  @override
  @JsonKey(name: 'model', readValue: _readProduct)
  final String? productModel;
  @override
  @JsonKey(name: 'category', readValue: _readProduct)
  final String? productCategory;
  @override
  @JsonKey(readValue: _readSourceShopAddress)
  final String sourceShopAddress;
  @override
  @JsonKey(readValue: _readDestinationShopAddress)
  final String destinationShopAddress;
  @override
  @JsonKey(name: 'transfer_date')
  final String transferDate;
  @override
  @JsonKey(name: 'source_shop_name')
  final String sourceShopName;
  @override
  @JsonKey(name: 'destination_shop_name')
  final String destinationShopName;
  @override
  @JsonKey(name: 'source_product_name')
  final String sourceProductName;
  @override
  @JsonKey(name: 'destination_product_name')
  final String destinationProductName;
  @override
  @JsonKey(name: 'initiated_by_name')
  final String initiatedByName;
  @override
  @JsonKey(name: 'source_variant_attribute')
  final String sourceVariantAttribute;
  @override
  @JsonKey(name: 'destination_variant_attribute')
  final String destinationVariantAttribute;

  @override
  String toString() {
    return 'TransferProductHistoryModel(id: $id, status: $status, quantityTransferred: $quantityTransferred, isIncoming: $isIncoming, transferType: $transferType, productImage: $productImage, productColor: $productColor, productModel: $productModel, productCategory: $productCategory, sourceShopAddress: $sourceShopAddress, destinationShopAddress: $destinationShopAddress, transferDate: $transferDate, sourceShopName: $sourceShopName, destinationShopName: $destinationShopName, sourceProductName: $sourceProductName, destinationProductName: $destinationProductName, initiatedByName: $initiatedByName, sourceVariantAttribute: $sourceVariantAttribute, destinationVariantAttribute: $destinationVariantAttribute)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransferProductHistoryModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.quantityTransferred, quantityTransferred) ||
                other.quantityTransferred == quantityTransferred) &&
            (identical(other.isIncoming, isIncoming) ||
                other.isIncoming == isIncoming) &&
            (identical(other.transferType, transferType) ||
                other.transferType == transferType) &&
            (identical(other.productImage, productImage) ||
                other.productImage == productImage) &&
            (identical(other.productColor, productColor) ||
                other.productColor == productColor) &&
            (identical(other.productModel, productModel) ||
                other.productModel == productModel) &&
            (identical(other.productCategory, productCategory) ||
                other.productCategory == productCategory) &&
            (identical(other.sourceShopAddress, sourceShopAddress) ||
                other.sourceShopAddress == sourceShopAddress) &&
            (identical(other.destinationShopAddress, destinationShopAddress) ||
                other.destinationShopAddress == destinationShopAddress) &&
            (identical(other.transferDate, transferDate) ||
                other.transferDate == transferDate) &&
            (identical(other.sourceShopName, sourceShopName) ||
                other.sourceShopName == sourceShopName) &&
            (identical(other.destinationShopName, destinationShopName) ||
                other.destinationShopName == destinationShopName) &&
            (identical(other.sourceProductName, sourceProductName) ||
                other.sourceProductName == sourceProductName) &&
            (identical(other.destinationProductName, destinationProductName) ||
                other.destinationProductName == destinationProductName) &&
            (identical(other.initiatedByName, initiatedByName) ||
                other.initiatedByName == initiatedByName) &&
            (identical(other.sourceVariantAttribute, sourceVariantAttribute) ||
                other.sourceVariantAttribute == sourceVariantAttribute) &&
            (identical(
                  other.destinationVariantAttribute,
                  destinationVariantAttribute,
                ) ||
                other.destinationVariantAttribute ==
                    destinationVariantAttribute));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    status,
    quantityTransferred,
    isIncoming,
    transferType,
    productImage,
    productColor,
    productModel,
    productCategory,
    sourceShopAddress,
    destinationShopAddress,
    transferDate,
    sourceShopName,
    destinationShopName,
    sourceProductName,
    destinationProductName,
    initiatedByName,
    sourceVariantAttribute,
    destinationVariantAttribute,
  ]);

  /// Create a copy of TransferProductHistoryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransferProductHistoryModelImplCopyWith<_$TransferProductHistoryModelImpl>
  get copyWith =>
      __$$TransferProductHistoryModelImplCopyWithImpl<
        _$TransferProductHistoryModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransferProductHistoryModelImplToJson(this);
  }
}

abstract class _TransferProductHistoryModel
    implements TransferProductHistoryModel {
  const factory _TransferProductHistoryModel({
    required final int id,
    required final String status,
    @JsonKey(name: 'quantity_transferred')
    required final int quantityTransferred,
    @JsonKey(name: 'transfer_mode', fromJson: _isIncomingFromJson)
    required final bool isIncoming,
    @JsonKey(name: 'transfer_type') required final String transferType,
    @JsonKey(name: 'image', readValue: _readProduct) final String? productImage,
    @JsonKey(name: 'color', readValue: _readProduct) final String? productColor,
    @JsonKey(name: 'model', readValue: _readProduct) final String? productModel,
    @JsonKey(name: 'category', readValue: _readProduct)
    final String? productCategory,
    @JsonKey(readValue: _readSourceShopAddress)
    required final String sourceShopAddress,
    @JsonKey(readValue: _readDestinationShopAddress)
    required final String destinationShopAddress,
    @JsonKey(name: 'transfer_date') required final String transferDate,
    @JsonKey(name: 'source_shop_name') required final String sourceShopName,
    @JsonKey(name: 'destination_shop_name')
    required final String destinationShopName,
    @JsonKey(name: 'source_product_name')
    required final String sourceProductName,
    @JsonKey(name: 'destination_product_name')
    required final String destinationProductName,
    @JsonKey(name: 'initiated_by_name') required final String initiatedByName,
    @JsonKey(name: 'source_variant_attribute')
    required final String sourceVariantAttribute,
    @JsonKey(name: 'destination_variant_attribute')
    required final String destinationVariantAttribute,
  }) = _$TransferProductHistoryModelImpl;

  factory _TransferProductHistoryModel.fromJson(Map<String, dynamic> json) =
      _$TransferProductHistoryModelImpl.fromJson;

  @override
  int get id; // @JsonKey(name: 'transfer_id') required String transferId,
  @override
  String get status;
  @override
  @JsonKey(name: 'quantity_transferred')
  int get quantityTransferred;
  @override
  @JsonKey(name: 'transfer_mode', fromJson: _isIncomingFromJson)
  bool get isIncoming;
  @override
  @JsonKey(name: 'transfer_type')
  String get transferType;
  @override
  @JsonKey(name: 'image', readValue: _readProduct)
  String? get productImage;
  @override
  @JsonKey(name: 'color', readValue: _readProduct)
  String? get productColor;
  @override
  @JsonKey(name: 'model', readValue: _readProduct)
  String? get productModel;
  @override
  @JsonKey(name: 'category', readValue: _readProduct)
  String? get productCategory;
  @override
  @JsonKey(readValue: _readSourceShopAddress)
  String get sourceShopAddress;
  @override
  @JsonKey(readValue: _readDestinationShopAddress)
  String get destinationShopAddress;
  @override
  @JsonKey(name: 'transfer_date')
  String get transferDate;
  @override
  @JsonKey(name: 'source_shop_name')
  String get sourceShopName;
  @override
  @JsonKey(name: 'destination_shop_name')
  String get destinationShopName;
  @override
  @JsonKey(name: 'source_product_name')
  String get sourceProductName;
  @override
  @JsonKey(name: 'destination_product_name')
  String get destinationProductName;
  @override
  @JsonKey(name: 'initiated_by_name')
  String get initiatedByName;
  @override
  @JsonKey(name: 'source_variant_attribute')
  String get sourceVariantAttribute;
  @override
  @JsonKey(name: 'destination_variant_attribute')
  String get destinationVariantAttribute;

  /// Create a copy of TransferProductHistoryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransferProductHistoryModelImplCopyWith<_$TransferProductHistoryModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
