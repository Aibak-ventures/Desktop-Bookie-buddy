import 'package:bookie_buddy_web/features/product/domain/repositories/i_product_repository.dart';
import 'package:flutter/material.dart';

class CheckVariantAvailabilityUseCase {
  final IProductRepository _repository;
  CheckVariantAvailabilityUseCase(this._repository);

  Future<List<int>> call({
    required String pickupDate,
    required String returnDate,
    required List<int> variantIds,
    int? bookingId,
    TimeOfDay? pickupTime,
    TimeOfDay? returnTime,
  }) =>
      _repository.checkVariantAvailability(
        pickupDate: pickupDate,
        returnDate: returnDate,
        variantIds: variantIds,
        bookingId: bookingId,
        pickupTime: pickupTime,
        returnTime: returnTime,
      );
}
