import 'dart:typed_data';

import 'package:bookie_buddy_web/core/common/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/sales/domain/entities/sale_details_entity/sale_details_entity.dart';
import 'package:bookie_buddy_web/features/sales/domain/entities/sale_entity/sale_entity.dart';
import 'package:bookie_buddy_web/features/sales/domain/entities/sales_request_entity/sales_request_entity.dart';

abstract class ISalesRepository {
  Future<PaginationModel<SaleEntity>> getSalesPagination({
    required int page,
    String? search,
    String? fromDate,
    String? toDate,
  });

  Future<SaleDetailsEntity> getSaleDetails(int saleId);

  Future<void> createSale(SalesRequestEntity salesRequest);

  Future<void> updateSale(SalesRequestEntity salesRequest);

  Future<void> deleteSale(int saleId);

  Future<Uint8List> getInvoicePdfBytes(int saleId);

  Future<void> sendInvoice({required int saleId, required bool sendWhatsApp});
}
