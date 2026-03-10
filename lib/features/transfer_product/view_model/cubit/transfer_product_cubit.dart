import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/core/repositories/product_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transfer_product_state.dart';
part 'transfer_product_cubit.freezed.dart';

class TransferProductCubit extends Cubit<TransferProductState> {
  final ProductRepository _repository = getIt.get<ProductRepository>();

  TransferProductCubit() : super(const TransferProductState.initial());

  Future<void> transferProduct({
    required int fromVariantId,
    required int toShopId,
    required int transferQuantity,
    int? toProductId,
  }) async {
    emit(const TransferProductState.transferring());
    try {
      await _repository.transferProductToAnotherShop(
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
