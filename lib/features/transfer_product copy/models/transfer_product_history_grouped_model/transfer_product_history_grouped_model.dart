import 'package:bookie_buddy_web/features/transfer_product%20copy/models/transfer_product_history_model/transfer_product_history_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transfer_product_history_grouped_model.freezed.dart';

@freezed
class TransferProductHistoryGroupedModel
    with _$TransferProductHistoryGroupedModel {
  const factory TransferProductHistoryGroupedModel({
    required String date,
    required List<TransferProductHistoryModel> transferProductHistoryList,
  }) = _TransferProductHistoryGroupedModel;
}
