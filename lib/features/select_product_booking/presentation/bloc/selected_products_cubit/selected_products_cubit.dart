import 'dart:developer';

import 'package:bookie_buddy_web/features/product/domain/models/product_info_model/product_info_model.dart';
import 'package:bookie_buddy_web/features/select_product_booking/domain/models/product_selected_model/product_selected_model.dart';
import 'package:bookie_buddy_web/features/booking/domain/models/measurement_value_model/measurement_value_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'selected_products_state.dart';
part 'selected_products_cubit.freezed.dart';

class SelectedProductsCubit extends Cubit<SelectedProductsState> {
  SelectedProductsCubit() : super(const _Selected([]));

  void loadPreSelected(List<ProductSelectedModel>? preSelected) {
    final selected = preSelected ?? [];
    log('SelectedProductsCubit: Loading pre-selected products: ${selected.length}');

    emit(_Selected(selected));
  }

  void addSelectedProduct(ProductInfoModel product, int? amount, int quantity) {
    log('SelectedProductsCubit: Adding product - ${product.name}, amount: $amount, quantity: $quantity');

    final selected = ProductSelectedModel(
      variant: product,
      amount: amount ?? 0,
      quantity: quantity,
    );
    final currentState = state as _Selected;

    final newList = currentState.selectedProductsWithAmount
        .where((model) => model.variant.variantId != selected.variant.variantId)
        .toList();

    final updatedList = [...newList, selected];
    log('SelectedProductsCubit: Updated list length: ${updatedList.length}');

    emit(_Selected(updatedList));
  }

  void removeSelectedProduct(int productId) {
    log('SelectedProductsCubit: Removing product with ID: $productId');

    final s = state as _Selected;
    final newList = s.selectedProductsWithAmount
        .where((model) => model.variant.variantId != productId)
        .toList();

    log('SelectedProductsCubit: Updated list length after removal: ${newList.length}');

    emit(s.copyWith(selectedProductsWithAmount: newList));
  }

  void updateProductMeasurements(
      int productId, List<MeasurementValueModel> measurements) {
    log('SelectedProductsCubit: Updating measurements for product ID: $productId');

    final s = state as _Selected;
    final newList = s.selectedProductsWithAmount.map((model) {
      if (model.variant.variantId == productId) {
        return model.copyWith(measurements: measurements);
      }
      return model;
    }).toList();

    log('SelectedProductsCubit: Updated measurements for product');

    emit(s.copyWith(selectedProductsWithAmount: newList));
  }
}
