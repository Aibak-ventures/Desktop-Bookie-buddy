import 'dart:developer';
import 'package:bookie_buddy_web/core/repositories/product_repository.dart';
import 'package:bookie_buddy_web/features/product_details/view_model/product_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final ProductRepository _repository;

  ProductDetailsCubit(this._repository)
      : super(const ProductDetailsState.initial());

  /// Load product details by ID
  Future<void> loadProductDetails(int productId) async {
    try {
      emit(const ProductDetailsState.loading());

      final response = await _repository.getProductInfo(productId);

      // response is already a ProductModel, not CustomResponseModel
      emit(ProductDetailsState.loaded(product: response));
    } catch (e) {
      log('Error loading product details: $e');
      emit(ProductDetailsState.error(
        message: 'An error occurred: ${e.toString()}',
      ));
    }
  }
}
