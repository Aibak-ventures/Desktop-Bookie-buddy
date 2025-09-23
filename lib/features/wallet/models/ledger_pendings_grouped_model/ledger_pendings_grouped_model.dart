import 'package:bookie_buddy_web/features/wallet/models/pending_model/ledger_pending_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ledger_pendings_grouped_model.freezed.dart';
part 'ledger_pendings_grouped_model.g.dart';

@freezed
class LedgerPendingsGroupedModel with _$LedgerPendingsGroupedModel {
  const factory LedgerPendingsGroupedModel({
    required String date,
    required List<LedgerPendingModel> pendings,
  }) = _LedgerPendingsGroupedModel;

  factory LedgerPendingsGroupedModel.fromJson(Map<String, dynamic> json) =>
      _$LedgerPendingsGroupedModelFromJson(json);
}
