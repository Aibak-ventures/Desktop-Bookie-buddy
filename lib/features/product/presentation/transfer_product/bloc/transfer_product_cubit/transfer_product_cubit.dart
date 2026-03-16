import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bookie_buddy_web/features/product/domain/usecases/transfer_product_to_another_shop_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transfer_product_state.dart';
part 'transfer_product_cubit.freezed.dart';

class TransferProductCubit extends Cubit<TransferProductState> {
  final TransferProductToAnotherShopUseCase _transferProduct;

  TransferProductCubit({required TransferProductToAnotherShopUseCase transferProduct})
      : _transferProduct = transferProduct,
        super(const TransferProductState.initial());

  Future<void> transferProduct({
    required int fromVariantId,
    required int toShopId,
    required int transferQuantity,
    int? toProductId,
  }) async {
    emit(const TransferProductState.transferring());
    try {
      await _transferProduct(
        fromVariantId: fromVariantId,
        toShopId: toShopId,
        transferQuantity: transferQuantity,
        toProductId: toProductId,
      );
      emit(const TransferProductState.success(
        'Product transferred successfully',
      ));
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      emit(_Failure(e.toString()));
    }
  }
}
