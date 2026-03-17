import 'package:bookie_buddy_web/core/constants/enums/ledger_enums.dart';
import 'package:bookie_buddy_web/features/ledger/domain/repositories/i_ledger_repository.dart';

class DownloadLedgerInvoiceUseCase {
  final ILedgerRepository _repository;
  DownloadLedgerInvoiceUseCase(this._repository);

  Future<String> call({
    required String fromDate,
    required String toDate,
    String type = 'all',
    LedgerType ledgerType = LedgerType.all,
    int? clientId,
  }) =>
      _repository.downloadLedgerInvoice(
        fromDate: fromDate,
        toDate: toDate,
        type: type,
        ledgerType: ledgerType,
        clientId: clientId,
      );
}
