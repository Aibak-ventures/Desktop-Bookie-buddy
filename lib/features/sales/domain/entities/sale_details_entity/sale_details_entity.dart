import 'package:bookie_buddy_web/core/constants/enums/payment_method_enums.dart';
import 'package:bookie_buddy_web/core/constants/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/features/client/domain/entities/client_entity/client_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sale_details_entity.freezed.dart';

@freezed
abstract class SaleDetailsEntity with _$SaleDetailsEntity {
  const factory SaleDetailsEntity({
    required int id,
    ClientEntity? client,
    dynamic clientPhone,
    required String address,
    required String description,
    required String saleDate,
    required String createdAt,
    required int totalAmount,
    required int discountAmount,
    required int paidAmount,
    required String invoiceId,
    required int balanceDueAmount,
    required List<ProductSaleInfoEntity> products,
    @Default(PaymentMethod.cash) PaymentMethod paymentMethod,
    int? staffId,
    String? staffName,
  }) = _SaleDetailsEntity;
}

@freezed
abstract class ProductSaleInfoEntity with _$ProductSaleInfoEntity {
  const factory ProductSaleInfoEntity({
    required int id,
    required int productId,
    required int variantId,
    required String name,
    String? variantAttribute,
    required int quantity,
    required int price,
    required int subtotal,
    String? image,
    String? color,
    String? category,
    String? model,
    MainServiceType? mainServiceType,
  }) = _ProductSaleInfoEntity;
}
