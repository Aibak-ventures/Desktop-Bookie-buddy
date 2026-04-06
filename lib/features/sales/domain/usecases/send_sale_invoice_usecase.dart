import 'package:bookie_buddy_web/features/sales/domain/repositories/i_sales_repository.dart';

class SendSaleInvoiceUsecase {
  final ISalesRepository _repository;

  SendSaleInvoiceUsecase(this._repository);

  Future<void> call(int saleId, {required bool sendWhatsApp}) =>
      _repository.sendInvoice(saleId: saleId, sendWhatsApp: sendWhatsApp);
}
