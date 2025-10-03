// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ledger_invoice_entry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LedgerInvoiceEntryModelImpl _$$LedgerInvoiceEntryModelImplFromJson(
  Map<String, dynamic> json,
) => _$LedgerInvoiceEntryModelImpl(
  type: LedgerType.fromString(json['type'] as String?),
  date: json['date'] as String,
  user: json['user'] as String? ?? 'Unknown',
  description: json['description'] as String,
  amount: (json['amount'] as num).toInt(),
  products:
      (json['items'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
);

Map<String, dynamic> _$$LedgerInvoiceEntryModelImplToJson(
  _$LedgerInvoiceEntryModelImpl instance,
) => <String, dynamic>{
  'type': _$LedgerTypeEnumMap[instance.type]!,
  'date': instance.date,
  'user': instance.user,
  'description': instance.description,
  'amount': instance.amount,
  'items': instance.products,
};

const _$LedgerTypeEnumMap = {
  LedgerType.all: 'all',
  LedgerType.payments: 'payments',
  LedgerType.expense: 'expense',
  LedgerType.pendings: 'pendings',
  LedgerType.security: 'security',
  LedgerType.bookings: 'bookings',
  LedgerType.sales: 'sales',
};
