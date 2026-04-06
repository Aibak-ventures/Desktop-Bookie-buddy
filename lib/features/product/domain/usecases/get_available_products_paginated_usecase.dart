import 'package:bookie_buddy_web/core/common/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_entity/product_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/repositories/i_product_repository.dart';
import 'package:flutter/material.dart';

class GetAvailableProductsPaginatedUseCase {
  final IProductRepository _repository;
  GetAvailableProductsPaginatedUseCase(this._repository);

  Future<PaginationModel<ProductEntity>> call({
    int? serviceId,
    required int page,
    required String pickupDate,
    required String returnDate,
    required String? nextPageUrl,
    String? query,
    String? type,
    int? startPrice,
    int? endPrice,
    TimeOfDay? pickupTime,
    TimeOfDay? returnTime,
    int? bookingId,
    List<int>? variantIds,
  }) => _repository.getAvailableProductsPaginated(
    serviceId: serviceId,
    page: page,
    pickupDate: pickupDate,
    returnDate: returnDate,
    nextPageUrl: nextPageUrl,
    query: query,
    type: type,
    startPrice: startPrice,
    endPrice: endPrice,
    pickupTime: pickupTime,
    returnTime: returnTime,
    bookingId: bookingId,
    variantIds: variantIds,
  );
}
