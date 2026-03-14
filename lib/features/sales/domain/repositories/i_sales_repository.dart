import 'dart:typed_data';

import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/sales/domain/models/sale_details_model/sale_details_model.dart';
import 'package:bookie_buddy_web/features/sales/domain/models/sale_model/sale_model.dart';
import 'package:bookie_buddy_web/features/sales/domain/models/sales_request_model/sales_request_model.dart';

abstract class ISalesRepository {
  Future<PaginationModel<SaleModel>> getSalesPagination({
    required int page,
    String? search,
    String? fromDate,
    String? toDate,
  });

  Future<SaleDetailsModel> getSaleDetails(int saleId);

  Future<void> createSale(SalesRequestModel salesRequest);

  Future<void> updateSale(SalesRequestModel salesRequest);

  Future<void> deleteSale(int saleId);

  Future<Uint8List> getInvoicePdfBytes(int saleId);
}
