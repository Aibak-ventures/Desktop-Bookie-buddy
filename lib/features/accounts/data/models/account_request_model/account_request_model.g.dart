// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AccountRequestModel _$AccountRequestModelFromJson(Map<String, dynamic> json) =>
    _AccountRequestModel(
      accountName: json['name'] as String?,
      accountNumber: json['account_number'] as String?,
      accountType: json['account_type'] == null
          ? AccountType.bank
          : AccountType.fromJson(json['account_type'] as String),
      description: json['description'] as String?,
      isActive: json['is_active'] as bool?,
      isDefault: json['is_default'] as bool?,
    );

Map<String, dynamic> _$AccountRequestModelToJson(
  _AccountRequestModel instance,
) => <String, dynamic>{
  'name': ?instance.accountName,
  'account_number': ?instance.accountNumber,
  'account_type': AccountType.toJson(instance.accountType),
  'description': ?instance.description,
  'is_active': ?instance.isActive,
  'is_default': ?instance.isDefault,
};
