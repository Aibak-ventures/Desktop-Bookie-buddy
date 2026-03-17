import 'package:bookie_buddy_web/features/booking/domain/models/measurement_value_model/measurement_value_model.dart';
import 'package:bookie_buddy_web/features/select_product_booking/models/product_selected_model/product_selected_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_booking_products_state.dart';
part 'add_booking_products_cubit.freezed.dart';

class AddBookingProductsCubit extends Cubit<AddBookingProductsState> {
  AddBookingProductsCubit()
      : super(const AddBookingProductsState(<ProductSelectedModel>[]));

  void setAll(List<ProductSelectedModel> products) {
    print(
        'AddBookingProductsCubit.setAll: Setting ${products.length} products');
    for (int i = 0; i < products.length; i++) {
      print('Setting product $i: ${products[i].variant.name}');
    }
    emit(AddBookingProductsState(List<ProductSelectedModel>.from(products)));
    print(
        'AddBookingProductsCubit.setAll: Emitted state with ${state.products.length} products');
  }

  void addOrReplace(ProductSelectedModel product) {
    final list = List<ProductSelectedModel>.from(state.products)
      ..removeWhere((p) => p.variant.variantId == product.variant.variantId)
      ..add(product);
    emit(AddBookingProductsState(list));
  }

  void removeByVariantId(int? variantId) {
    final list = List<ProductSelectedModel>.from(state.products)
      ..removeWhere((p) => p.variant.variantId == variantId);
    emit(AddBookingProductsState(list));
  }

  void updateProductMeasurements(
    int? variantId,
    List<MeasurementValueModel> measurements,
  ) {
    final list = state.products.map((e) {
      if (e.variant.variantId == variantId) {
        return ProductSelectedModel(
          variant: e.variant,
          amount: e.amount,
          measurements: measurements,
          quantity: e.quantity,
        );
      }
      return e;
    }).toList();
    emit(AddBookingProductsState(list));
  }

  void clear() => emit(const AddBookingProductsState(<ProductSelectedModel>[]));
}
