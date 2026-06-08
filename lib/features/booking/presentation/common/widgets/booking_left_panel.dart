import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/product_customization_widget.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_selected_entity/product_selected_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/measurement_value_entity/measurement_value_entity.dart';
import 'package:flutter/material.dart';

class BookingLeftPanel extends StatelessWidget {
  final Widget dateSection;
  final Widget serviceSection;
  final bool showCustomization;
  final List<ProductSelectedEntity> customizationProducts;
  final VoidCallback onBackFromCustomization;
  final void Function(
    ProductSelectedEntity product,
    List<MeasurementValueEntity> measurements,
  ) onSaveCustomization;

  const BookingLeftPanel({
    super.key,
    required this.dateSection,
    required this.serviceSection,
    required this.showCustomization,
    required this.customizationProducts,
    required this.onBackFromCustomization,
    required this.onSaveCustomization,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        dateSection,
        const SizedBox(height: 16),
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            switchInCurve: Curves.easeInOut,
            switchOutCurve: Curves.easeInOut,
            transitionBuilder: (Widget child, Animation<double> animation) {
              final offsetAnimation = Tween<Offset>(
                begin: child.key == const ValueKey('customization')
                    ? const Offset(1.0, 0.0)
                    : const Offset(-1.0, 0.0),
                end: Offset.zero,
              ).animate(animation);
              return SlideTransition(position: offsetAnimation, child: child);
            },
            child: showCustomization
                ? ProductCustomizationWidget(
                    key: const ValueKey('customization'),
                    onBack: onBackFromCustomization,
                    onSaveForProduct: onSaveCustomization,
                    selectedProducts: customizationProducts,
                  )
                : Container(
                    key: const ValueKey('products'),
                    child: serviceSection,
                  ),
          ),
        ),
      ],
    );
  }
}
