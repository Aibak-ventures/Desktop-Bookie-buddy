import 'package:freezed_annotation/freezed_annotation.dart';

part 'sale_entity.freezed.dart';

@freezed
abstract class SaleEntity with _$SaleEntity {
  const factory SaleEntity({
    required int id,
    String? shopSaleId,
    String? clientName,
    dynamic clientPhone,
    required int totalAmount,
    required int paidAmount,
    required int discountAmount,
    required String saleDate,
    required String createdAt,
    required String products,
    String? staffColor,
    String? staffName,
  }) = _SaleEntity;
}
