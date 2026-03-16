import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/product/domain/models/transfer_product_history_model/transfer_product_history_model.dart';
import 'package:bookie_buddy_web/features/product/domain/repositories/i_product_repository.dart';

class GetTransferProductHistoryUseCase {
  final IProductRepository _repository;
  GetTransferProductHistoryUseCase(this._repository);

  Future<PaginationModel<TransferProductHistoryModel>> call({
    required int shopId,
    required int page,
  }) =>
      _repository.getTransferProductHistory(shopId: shopId, page: page);
}
