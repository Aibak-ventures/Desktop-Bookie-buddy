part of 'ledger_sales_bloc.dart';

@freezed
class LedgerSalesEvent with _$LedgerSalesEvent {
  const factory LedgerSalesEvent.loadSales({int? clientId}) = _LoadSales;
  const factory LedgerSalesEvent.loadNextPageSales() = _LoadNextPageSales;
}
