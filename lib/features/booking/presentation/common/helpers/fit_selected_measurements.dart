import 'package:bookie_buddy_web/core/common/widgets/custom_snack_bar.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_selected_entity/product_selected_entity.dart';
import 'package:bookie_buddy_web/features/product/presentation/common/utils/fit_measurements_to_quantity.dart';
import 'package:flutter/foundation.dart';

/// Trims each line's people to its quantity and tells the user who was
/// removed. Run when the user moves on from the product list (to the
/// measurements, or to saving), not on every quantity change, so that
/// lowering and raising a quantity again loses nobody.
class SelectedMeasurementsFit {
  const SelectedMeasurementsFit._();

  static void apply(ValueNotifier<List<ProductSelectedEntity>> products) {
    final fitted = products.value.fitMeasurementsToQuantity();
    final message = fitted.removalMessage;
    if (message == null) return;

    products.value = fitted.lines;
    CustomSnackBar(
      message: message,
      title: 'Measurements removed',
      isError: false,
      duration: const Duration(seconds: 6),
    );
  }
}
