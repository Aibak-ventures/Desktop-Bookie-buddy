import 'package:bookie_buddy_web/core/constants/enums/payment_method_enums.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_selected_entity/product_selected_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sales_request_entity.freezed.dart';

@freezed
abstract class SalesRequestEntity with _$SalesRequestEntity {
  const factory SalesRequestEntity({
    int? id,
    int? staffId,
    String? clientPhone,
    String? address,
    String? saleDate,
    List<ProductSelectedEntity>? products,
    bool? stockCountDecrease,
    String? description,
    int? discountAmount,
    int? paidAmount,
    PaymentMethod? paymentMethod,
    @Default(false) bool sendPdfToWhatsApp,
  }) = _SalesRequestEntity;
}
