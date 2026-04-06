part of 'sales_details_bloc.dart';

@freezed
abstract class SalesDetailsEvent with _$SalesDetailsEvent {
  const factory SalesDetailsEvent.fetchSaleDetails(int saleId) =
      _FetchSaleDetails;

  const factory SalesDetailsEvent.deleteSale(int saleId) = _DeleteSale;
}
