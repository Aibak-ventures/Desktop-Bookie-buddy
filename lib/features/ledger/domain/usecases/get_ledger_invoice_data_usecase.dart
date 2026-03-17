import 'package:bookie_buddy_web/features/ledger/domain/models/ledger_invoice_entry_model/ledger_invoice_entry_model.dart';
import 'package:bookie_buddy_web/features/ledger/domain/repositories/i_ledger_repository.dart';

class GetLedgerInvoiceDataUseCase {
  final ILedgerRepository _repository;
  GetLedgerInvoiceDataUseCase(this._repository);

  Future<List<LedgerInvoiceEntryModel>> call({
    required String fromDate,
    required String toDate,
    int? clientId,
    String type = 'all',
  }) =>
      _repository.getLedgerInvoiceData(
        fromDate: fromDate,
        toDate: toDate,
        clientId: clientId,
        type: type,
      );
}
