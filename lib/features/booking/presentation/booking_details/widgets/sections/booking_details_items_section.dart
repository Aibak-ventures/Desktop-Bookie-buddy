import 'package:bookie_buddy_shared/core/core/constants/enums/booking_status_enums.dart';
import 'package:bookie_buddy_shared/core/core/constants/enums/main_service_type_enums.dart';
import 'package:bookie_buddy_shared/ui/theme/status_ui_extensions.dart';
import 'package:bookie_buddy_shared/core/features/booking/domain/entities/booking_details_entity/booking_details_entity.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_shared/core/features/product/domain/entities/product_info_entity/product_info_entity.dart';
import 'package:bookie_buddy_web/core/common/widgets/product_details_card.dart';
import 'package:flutter/material.dart';

/// Item details section for [BookingDetailsDrawer].
class BookingDetailsItemsSection extends StatelessWidget {
  final BookingDetailsEntity booking;

  const BookingDetailsItemsSection({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    // Per-item return badges only matter while the booking is still running
    // and part of it has already come back — otherwise the booking-level
    // status already says everything.
    final showProductDeliveryStatus =
        !booking.deliveryStatus.isCancelled &&
        !booking.deliveryStatus.isReturned &&
        booking.bookingStatus.isUpcoming &&
        booking.bookedItems.any((item) => item.deliveryStatus.isReturned);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Item details',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          ...booking.bookedItems.map(
            (item) => ProductDetailsCard(
              name: item.name,
              imageUrl: item.productImage,
              specs: _specsOf(item),
              amount: item.amount.toCurrency(),
              quantity: item.quantity,
              peopleMeasurements: item.peopleMeasurements,
              badge: showProductDeliveryStatus
                  ? _ProductDeliveryStatusBadge(status: item.deliveryStatus)
                  : null,
            ),
          ),
          // Location details — shown once if any item is a vehicle
          if (booking.bookedItems.any(
                (item) => item.mainServiceType.isVehicle,
              ) &&
              (booking.otherDetails.locationStart != null ||
                  booking.otherDetails.locationFrom != null ||
                  booking.otherDetails.locationTo != null)) ...[
            Container(
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: Colors.blue.shade700,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Location Details',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.blue.shade800,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (booking.otherDetails.locationStart != null) ...[
                    Row(
                      children: [
                        Text(
                          'Start',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            booking.otherDetails.locationStart!,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                  ],
                  if (booking.otherDetails.locationFrom != null) ...[
                    Row(
                      children: [
                        Text(
                          'From',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            booking.otherDetails.locationFrom!,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                  ],
                  if (booking.otherDetails.locationTo != null) ...[
                    Row(
                      children: [
                        Text(
                          'To',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            booking.otherDetails.locationTo!,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
          // Notes
          if (booking.description != null &&
              booking.description!.isNotEmpty) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.amber.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.note_alt_outlined,
                        size: 16,
                        color: Colors.amber.shade700,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Notes',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.amber.shade800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    booking.description!,
                    style: const TextStyle(fontSize: 12, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Short facts about a booked item's variant, for [ProductDetailsCard].
List<String> _specsOf(ProductInfoEntity item) => [
  if (item.mainServiceType.isMultiVariantProductType &&
      item.variantAttribute != null)
    '${item.mainServiceType.variantAttributeLabel}: ${item.variantAttribute}',
  if (item.color != null) 'Colour: ${item.color}',
  if (item.category != null && item.category!.isNotEmpty)
    '${item.mainServiceType.categoryFieldLabel}: ${item.category}',
];

/// Small "Returned" / "Not Returned" pill shown against an individual booked
/// item during a partial return.
class _ProductDeliveryStatusBadge extends StatelessWidget {
  const _ProductDeliveryStatusBadge({required this.status});

  final ProductDeliveryStatus status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: status.color.shade100.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        status.name,
        style: TextStyle(color: status.color, fontSize: 11, fontWeight: .w600),
      ),
    );
  }
}
