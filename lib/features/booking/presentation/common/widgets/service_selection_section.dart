import 'package:bookie_buddy_web/features/booking/presentation/common/booking_form/booking_type_enum.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/product_list_table_widget.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_selected_entity/product_selected_entity.dart';
import 'package:flutter/material.dart';

class ServiceSelectionSection extends StatelessWidget {
  final ValueNotifier<List<ProductSelectedEntity>> selectedProductsNotifier;
  final Widget searchBar;
  final BookingType selectedBookingType;
  final int effectiveRentalDays;
  final int manualExtraRentalDays;
  final FocusNode clientNameFocusNode;
  final VoidCallback onIncrementRentalDays;
  final VoidCallback onDecrementRentalDays;
  final bool showDayControls;
  final ValueNotifier<int?>? focusTargetProductKey;
  final VoidCallback? onNavigateToClientDetails;

  const ServiceSelectionSection({
    super.key,
    required this.selectedProductsNotifier,
    required this.searchBar,
    required this.selectedBookingType,
    required this.effectiveRentalDays,
    required this.manualExtraRentalDays,
    required this.clientNameFocusNode,
    required this.onIncrementRentalDays,
    required this.onDecrementRentalDays,
    this.showDayControls = true,
    this.focusTargetProductKey,
    this.onNavigateToClientDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ValueListenableBuilder<List<ProductSelectedEntity>>(
            valueListenable: selectedProductsNotifier,
            builder: (context, products, _) {
              return Text(
                'Select Products (${products.length})',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade800,
                ),
              );
            },
          ),
          const SizedBox(height: 5),
          searchBar,
          const SizedBox(height: 5),
          Expanded(
            child: ProductListTableWidget(
              selectedProductsNotifier: selectedProductsNotifier,
              selectedBookingType: selectedBookingType,
              effectiveRentalDays: effectiveRentalDays,
              manualExtraRentalDays: manualExtraRentalDays,
              clientNameFocusNode: clientNameFocusNode,
              onIncrementRentalDays: onIncrementRentalDays,
              onDecrementRentalDays: onDecrementRentalDays,
              showDayControls: showDayControls,
              focusTargetProductKey: focusTargetProductKey,
              onNavigateToClientDetails: onNavigateToClientDetails,
            ),
          ),
        ],
      ),
    );
  }
}
