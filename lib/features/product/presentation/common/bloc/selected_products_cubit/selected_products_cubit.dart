import 'dart:developer';

import 'package:bookie_buddy_shared/core/features/booking/domain/entities/person_measurements_entity/person_measurements_entity.dart';
import 'package:bookie_buddy_shared/core/features/product/domain/entities/product_info_entity/product_info_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_selected_entity/product_selected_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'selected_products_cubit.freezed.dart';
part 'selected_products_state.dart';

class SelectedProductsCubit extends Cubit<SelectedProductsState> {
  SelectedProductsCubit() : super(const _Selected([]));

  void loadPreSelected(List<ProductSelectedEntity>? preSelected) {
    final selected = preSelected ?? [];
    log(
      'SelectedProductsCubit: Loading pre-selected products: ${selected.length}',
    );

    emit(_Selected(selected));
  }

  void addSelectedProduct(
    ProductInfoEntity product,
    int? amount,
    int quantity,
  ) {
    log(
      'SelectedProductsCubit: Adding product - ${product.name}, amount: $amount, quantity: $quantity',
    );

    final currentState = state as _Selected;

    // Re-selecting a variant (e.g. to change its quantity) must not wipe the
    // measurements already entered for it. They are kept as they are, even
    // when the quantity drops below the number of people, so raising it again
    // brings everyone back. They are only trimmed once the user moves on (see
    // `fitMeasurementsToQuantity`).
    final previous = currentState.selectedProductsWithAmount
        .where((model) => model.variant.variantId == product.variantId)
        .firstOrNull;

    final selected = ProductSelectedEntity(
      variant: product,
      amount: amount ?? 0,
      quantity: quantity,
      peopleMeasurements: previous?.peopleMeasurements ?? const [],
    );

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

    log(
      'SelectedProductsCubit: Updated list length after removal: ${newList.length}',
    );

    emit(s.copyWith(selectedProductsWithAmount: newList));
  }

  void updateProductMeasurements(
    int productId,
    List<PersonMeasurementsEntity> peopleMeasurements,
  ) {
    log(
      'SelectedProductsCubit: Updating measurements for product ID: $productId',
    );

    final s = state as _Selected;
    final newList = s.selectedProductsWithAmount.map((model) {
      if (model.variant.variantId == productId) {
        return model.copyWith(peopleMeasurements: peopleMeasurements);
      }
      return model;
    }).toList();

    log('SelectedProductsCubit: Updated measurements for product');

    emit(s.copyWith(selectedProductsWithAmount: newList));
  }
}
