import 'package:bloc/bloc.dart';
import 'package:bookie_buddy_web/core/models/product_info_model/product_info_model.dart';
import 'package:bookie_buddy_web/features/select_product_booking/models/product_selected_model/product_selected_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'selected_products_state.dart';
part 'selected_products_cubit.freezed.dart';

class SelectedProductsCubit extends Cubit<SelectedProductsState> {
  SelectedProductsCubit() : super(const _Selected([]));

  void loadPreSelected(List<ProductSelectedModel>? preSelected) {
    final selected = preSelected ?? [];

    emit(_Selected(selected));
  }

  void addSelectedProduct(
    ProductInfoModel product,
    int? amount,
    int quantity,
  ) {
    final selected = ProductSelectedModel(
      variant: product,
      amount: amount ?? 0,
      quantity: quantity,
    );
    final currentState = state as _Selected;
    emit(
      _Selected([
        ...currentState.selectedProductsWithAmount,
        selected,
      ]),
    );
  }

  void removeSelectedProduct(int productId) {
    final s = state as _Selected;
    final newList = s.selectedProductsWithAmount.where(
      (model) {
        return model.variant.variantId != productId;
      },
    ).toList();

    emit(s.copyWith(selectedProductsWithAmount: newList));
  }
}
