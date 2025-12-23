// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_activity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ShopActivityModelImpl _$$ShopActivityModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ShopActivityModelImpl(
      id: (json['id'] as num).toInt(),
      action: json['action'] as String,
      message: json['message'] as String,
      userName: json['user_name'] as String,
      userId: (json['user_id'] as num).toInt(),
      createdAt: json['created_at'] as String,
      bookingId: (json['booking_id'] as num?)?.toInt(),
      saleId: (json['sale_id'] as num?)?.toInt(),
      clientId: (json['client_id'] as num?)?.toInt(),
      productId: (json['product_id'] as num?)?.toInt(),
      expenseId: (json['expense_id'] as num?)?.toInt(),
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$ShopActivityModelImplToJson(
        _$ShopActivityModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'action': instance.action,
      'message': instance.message,
      'user_name': instance.userName,
      'user_id': instance.userId,
      'created_at': instance.createdAt,
      'booking_id': instance.bookingId,
      'sale_id': instance.saleId,
      'client_id': instance.clientId,
      'product_id': instance.productId,
      'expense_id': instance.expenseId,
      'metadata': instance.metadata,
    };
