import 'dart:typed_data';

import 'package:bookie_buddy_web/features/sales/domain/repositories/i_sales_repository.dart';

class GetSaleInvoicePdfUseCase {
  final ISalesRepository _repository;

  GetSaleInvoicePdfUseCase(this._repository);

  Future<Uint8List> call(int saleId) => _repository.getInvoicePdfBytes(saleId);
}
