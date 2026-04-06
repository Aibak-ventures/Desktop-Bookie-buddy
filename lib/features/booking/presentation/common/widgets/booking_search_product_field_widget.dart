import 'package:bookie_buddy_web/features/booking/presentation/common/booking_form/booking_form_controllers.dart';
import 'package:flutter/material.dart';

class BookingSearchProductFieldWidget extends StatelessWidget {
  final BookingFormControllers form;
  final VoidCallback onSearchChanged;
  final VoidCallback showProductFilterDialog;

  const BookingSearchProductFieldWidget({
    super.key,
    required this.form,
    required this.onSearchChanged,
    required this.showProductFilterDialog,
  });

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: form.searchLayerLink,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            // Search TextField
            Expanded(
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: TextField(
                  controller: form.serviceSearchController,
                  style: const TextStyle(
                    fontSize: 13,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search products',
                    hintStyle: const TextStyle(
                      fontSize: 13,
                      fontFamily: 'Inter',
                      color: Color(0xFF8C8C8C),
                    ),
                    prefixIcon: const Icon(Icons.search, size: 18),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                  ),
                  onChanged: (value) {
                    onSearchChanged();
                    if (value.isEmpty) {
                      form.removeSearchOverlay();
                    }
                  },
                ),
              ),
            ),
            const SizedBox(width: 8),
            // Filter Button
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: IconButton(
                onPressed: () {
                  form.removeSearchOverlay();
                  showProductFilterDialog();
                },
                icon: const Icon(Icons.tune, size: 20),
                color: const Color(0xFF6132E4),
                tooltip: 'Filter products',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
