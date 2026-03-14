part of 'sale_details_bloc.dart';

@freezed
class SaleDetailsEvent with _$SaleDetailsEvent {
  const factory SaleDetailsEvent.getSaleDetails({required int saleId}) =
      _GetSaleDetails;
  const factory SaleDetailsEvent.deleteSale({required int saleId}) =
      _DeleteSale;
}
