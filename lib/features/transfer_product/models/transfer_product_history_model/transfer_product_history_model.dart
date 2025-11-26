import 'package:freezed_annotation/freezed_annotation.dart';

part 'transfer_product_history_model.freezed.dart';
part 'transfer_product_history_model.g.dart';

bool _isIncomingFromJson(String value) => value == 'incoming'; // or outgoing

String? _readProduct(Map json, String key) =>
    (json['product'] as Map<String, dynamic>?)?[key];

String _readSourceShopAddress(Map json, String key) =>
    (json['source_shop_details'] as Map<String, dynamic>?)?['address'];

String _readDestinationShopAddress(Map json, String key) =>
    (json['destination_shop_details'] as Map<String, dynamic>?)?['address'];

@freezed
class TransferProductHistoryModel with _$TransferProductHistoryModel {
  const factory TransferProductHistoryModel({
    required int id,
    // @JsonKey(name: 'transfer_id') required String transferId,
    required String status,
    @JsonKey(name: 'quantity_transferred') required int quantityTransferred,
    @JsonKey(name: 'transfer_mode', fromJson: _isIncomingFromJson)
    required bool isIncoming,
    @JsonKey(name: 'transfer_type') required String transferType,
    @JsonKey(name: 'image', readValue: _readProduct) String? productImage,
    @JsonKey(name: 'color', readValue: _readProduct) String? productColor,
    @JsonKey(name: 'model', readValue: _readProduct) String? productModel,
    @JsonKey(name: 'category', readValue: _readProduct) String? productCategory,
    @JsonKey(readValue: _readSourceShopAddress)
    required String sourceShopAddress,
    @JsonKey(readValue: _readDestinationShopAddress)
    required String destinationShopAddress,
    @JsonKey(name: 'transfer_date') required String transferDate,
    @JsonKey(name: 'source_shop_name') required String sourceShopName,
    @JsonKey(name: 'destination_shop_name') required String destinationShopName,
    @JsonKey(name: 'source_product_name') required String sourceProductName,
    @JsonKey(name: 'destination_product_name')
    required String destinationProductName,
    @JsonKey(name: 'initiated_by_name') required String initiatedByName,
    @JsonKey(name: 'source_variant_attribute')
    required String sourceVariantAttribute,
    @JsonKey(name: 'destination_variant_attribute')
    required String destinationVariantAttribute,
  }) = _TransferProductHistoryModel;

  factory TransferProductHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$TransferProductHistoryModelFromJson(json);
}
