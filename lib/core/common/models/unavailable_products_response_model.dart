import 'package:bookie_buddy_core/core/common/entities/unavailable_products_entity/unavailable_products_entity.dart';

/// Parses the insufficient-stock payload the API returns in `data` — the shape
/// is flat rather than a list, so a single conflicting variant comes back per
/// response.
class UnavailableProductsResponseModel {
  final String? message;
  final String? dateFrom;
  final String? dateTo;
  final List<int> unavailableProducts;
  final String? bookingInvoiceId;
  final int? bookingId;

  UnavailableProductsResponseModel({
    required this.message,
    required this.dateFrom,
    required this.dateTo,
    required this.unavailableProducts,
    required this.bookingInvoiceId,
    required this.bookingId,
  });

  factory UnavailableProductsResponseModel.fromJson(Map<String, dynamic> json) {
    final stockBetween = json['out_of_stock_between'] as Map<String, dynamic>?;
    final variantId = json['variant_id'] as int? ?? 0;

    return UnavailableProductsResponseModel(
      message: json['message'] as String?,
      dateFrom: stockBetween?['from'] as String?,
      dateTo: stockBetween?['to'] as String?,
      unavailableProducts: [variantId],
      bookingInvoiceId: json['shop_booking_id'] as String?,
      bookingId: json['booking_id'] as int?,
    );
  }
}

extension UnavailableProductsResponseModelMapper
    on UnavailableProductsResponseModel {
  UnavailableProductsEntity toEntity() => UnavailableProductsEntity(
    message: message,
    dateFrom: dateFrom,
    dateTo: dateTo,
    unavailableProducts: unavailableProducts,
    bookingInvoiceId: bookingInvoiceId,
    bookingId: bookingId,
  );
}
