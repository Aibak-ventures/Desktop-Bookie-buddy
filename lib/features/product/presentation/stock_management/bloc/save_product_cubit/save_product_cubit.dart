import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bookie_buddy_web/features/product/domain/models/product_request_model/product_request_model.dart';
import 'package:bookie_buddy_web/features/product/domain/usecases/save_product_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'save_product_state.dart';
part 'save_product_cubit.freezed.dart';

class SaveProductCubit extends Cubit<SaveProductState> {
  final SaveProductUseCase _saveProduct;

  SaveProductCubit({required SaveProductUseCase saveProduct})
      : _saveProduct = saveProduct,
        super(const _Initial());

  Future<void> saveProduct({
    required ProductRequestModel product,
  }) async {
    emit(const _Submitted());
    try {
      log('SaveProductCubit: Saving product with ID: ${product.productId}');
      log('SaveProductCubit: Product name: ${product.name}');
      log('SaveProductCubit: Is editing: ${product.productId != null}');

      await _saveProduct(product: product);

      emit(const _Success());
    } catch (e, stackTrace) {
      log('SaveProductCubit: Error - $e', stackTrace: stackTrace);
      emit(_Error(e.toString()));
    }
  }
}
