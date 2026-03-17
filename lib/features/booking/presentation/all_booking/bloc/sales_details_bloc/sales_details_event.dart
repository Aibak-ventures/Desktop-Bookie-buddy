part of 'sales_details_bloc.dart';

@freezed
class SalesDetailsEvent with _$SalesDetailsEvent {
  const factory SalesDetailsEvent.fetchSaleDetails(int saleId) =
      _FetchSaleDetails;

  const factory SalesDetailsEvent.deleteSale(int saleId) = _DeleteSale;
}
