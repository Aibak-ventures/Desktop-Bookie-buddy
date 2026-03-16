import 'dart:developer';

import 'package:bookie_buddy_web/features/product/domain/models/product_model/product_model.dart';
import 'package:bookie_buddy_web/features/product/domain/usecases/add_product_variants_usecase.dart';
import 'package:bookie_buddy_web/features/product/domain/usecases/delete_product_usecase.dart';
import 'package:bookie_buddy_web/features/product/domain/usecases/get_product_info_usecase.dart';
import 'package:bookie_buddy_web/features/product/domain/usecases/update_variant_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_info_event.dart';
part 'product_info_state.dart';
part 'product_info_bloc.freezed.dart';

class ProductInfoBloc extends Bloc<ProductInfoEvent, ProductInfoState> {
  final GetProductInfoUseCase _getProductInfo;
  final DeleteProductUseCase _deleteProduct;
  final UpdateVariantUseCase _updateVariant;
  final AddProductVariantsUseCase _addProductVariants;

  ProductInfoBloc({
    required GetProductInfoUseCase getProductInfo,
    required DeleteProductUseCase deleteProduct,
    required UpdateVariantUseCase updateVariant,
    required AddProductVariantsUseCase addProductVariants,
  })  : _getProductInfo = getProductInfo,
        _deleteProduct = deleteProduct,
        _updateVariant = updateVariant,
        _addProductVariants = addProductVariants,
        super(const _Loading()) {
    on<_LoadProductInfo>(_onLoadProductInfo);
    on<_DeleteProduct>(_onDeleteProduct);

    on<_UpdateVariant>(_onUpdateVariant);
    on<_AddProductVariants>(_onAddProductVariants);
  }

  Future<void> _onLoadProductInfo(
    _LoadProductInfo event,
    Emitter<ProductInfoState> emit,
  ) async {
    if (state is! _Loading) emit(const _Loading());
    try {
      final productInfo = await _getProductInfo(event.productId);
      emit(_Loaded(productInfo));
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      emit(_Error(e.toString()));
    }
  }

  Future<void> _onDeleteProduct(
    _DeleteProduct event,
    Emitter<ProductInfoState> emit,
  ) async {
    try {
      await _deleteProduct(
        productId: event.productId,
        variantId: event.variantId,
      );
      emit(
        _Success(
          'Product${event.variantId != null ? ' variant' : ''} deleted successfully',
          event.variantId == null,
        ),
      );
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      emit(_Failure(e.toString()));
    }
  }

  Future<void> _onUpdateVariant(
    _UpdateVariant event,
    Emitter<ProductInfoState> emit,
  ) async {
    try {
      await _updateVariant(
        productId: event.productId,
        variantId: event.variantId,
        updatedAttribute: event.updatedAttribute,
        updatedStock: event.updatedStock,
      );
      emit(const _Success('Product variant updated successfully'));
      add(_LoadProductInfo(event.productId));
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      emit(_Failure(e.toString()));
    }
  }

  Future<void> _onAddProductVariants(
    _AddProductVariants event,
    Emitter<ProductInfoState> emit,
  ) async {
    try {
      await _addProductVariants(
        productId: event.productId,
        attribute: event.attribute,
        stock: event.stock,
      );
      emit(const _Success('Product variant added successfully'));
      add(_LoadProductInfo(event.productId));
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      emit(_Failure(e.toString()));
    }
  }

  ProductModel? getProductInfo() {
    if (state is _Loaded) {
      return (state as _Loaded).productInfo;
    }
    return null;
  }
}
