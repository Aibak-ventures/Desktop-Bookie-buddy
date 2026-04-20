// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AccountModel _$AccountModelFromJson(Map<String, dynamic> json) =>
    _AccountModel(
      id: (json['id'] as num).toInt(),
      accountName: json['name'] as String,
      accountType: AccountType.fromJson(json['account_type'] as String),
      accountNumber: json['account_number'] as String?,
      description: json['description'] as String?,
      isActive: json['is_active'] as bool,
      isDefault: json['is_default'] as bool,
      createdAt: json['created_at'] as String,
      currentBalance: (json['current_balance'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$AccountModelToJson(_AccountModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.accountName,
      'account_type': AccountType.toJson(instance.accountType),
      'account_number': instance.accountNumber,
      'description': instance.description,
      'is_active': instance.isActive,
      'is_default': instance.isDefault,
      'created_at': instance.createdAt,
      'current_balance': instance.currentBalance,
    };
