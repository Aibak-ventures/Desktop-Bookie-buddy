import 'package:bookie_buddy_core/core/constants/enums/booking_status_enums.dart';
import 'package:bookie_buddy_core/core/constants/enums/main_service_type_enums.dart';
import 'package:bookie_buddy_core/features/product/domain/entities/product_info_entity/product_info_entity.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_network_image.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/utils/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';

/// Dialogs backing the return / partial-return flow on booking details.
///
/// Mirrors the mobile flow: confirm return → (optionally) pick which items came
/// back → confirm the expected return date for the items still out.

/// Step 1 — asks whether *all* items came back, with an explicit physical-check
/// confirmation. [onPartialReturn] is only offered when there is more than one
/// item still out.
void showReturnConfirmationDialog(
  BuildContext context, {
  required MainServiceType? mainServiceType,
  required VoidCallback onAllReturned,
  required VoidCallback onPartialReturn,
  bool isPartialReturnButtonVisible = true,
}) {
  bool isConfirmed = false;
  final productNameLabel = mainServiceType.productNameLabel;
  final returnSpecificName = DeliveryStatus.returned.getServiceSpecificName(
    mainServiceType,
  );

  showDialog(
    context: context,
    builder: (ctx) => StatefulBuilder(
      builder: (ctx, setState) => AlertDialog(
        title: Text(
          'Confirm $productNameLabel ${mainServiceType.returnActionLabel}',
        ),
        content: SizedBox(
          width: 420,
          child: Column(
            mainAxisSize: .min,
            crossAxisAlignment: .start,
            children: [
              Text(mainServiceType.allItemsReturnedQuestion),
              const SizedBox(height: 10),
              Text(
                '⚠️ This action cannot be undone. $returnSpecificName ${productNameLabel}s will become available for booking again.',
                style: const TextStyle(color: Colors.deepOrange, fontSize: 13),
              ),
              const SizedBox(height: 15),
              const Divider(),
              CheckboxListTile(
                value: isConfirmed,
                onChanged: (value) =>
                    setState(() => isConfirmed = value ?? false),
                contentPadding: EdgeInsets.zero,
                controlAffinity: .leading,
                title: Text(
                  mainServiceType.physicalCheckConfirmationLabel,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: .w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          if (isPartialReturnButtonVisible)
            OutlinedButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                onPartialReturn();
              },
              child: Text('Partial ${mainServiceType.returnActionLabel}'),
            ),
          ElevatedButton(
            // locked until the physical check is confirmed
            onPressed: isConfirmed
                ? () {
                    Navigator.of(ctx).pop();
                    onAllReturned();
                  }
                : null,
            child: Text('All $returnSpecificName'),
          ),
        ],
      ),
    ),
  );
}

/// Step 2 — checklist of the items still out; the caller receives the returned
/// and the still-not-returned ids.
void showPartialReturnProductSelector(
  BuildContext context, {
  required MainServiceType? mainServiceType,
  required Iterable<ProductInfoEntity> products,
  required void Function(
    List<int> returnedProductIds,
    List<int> notReturnedProductIds,
  )
  onReturnConfirmed,
}) {
  final returned = <int>{};
  final productNameLabel = mainServiceType.productNameLabel;

  showDialog(
    context: context,
    builder: (ctx) => StatefulBuilder(
      builder: (ctx, setState) => AlertDialog(
        title: Text(
          'Select ${DeliveryStatus.returned.getServiceSpecificName(mainServiceType)} ${productNameLabel}s',
        ),
        content: SizedBox(
          width: 480,
          child: Column(
            mainAxisSize: .min,
            crossAxisAlignment: .start,
            children: [
              Text(
                mainServiceType.productCheckInstructionLabel,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: .min,
                    children: products
                        .map(
                          (product) => CheckboxListTile(
                            value: returned.contains(product.id),
                            onChanged: (val) => setState(() {
                              if (val == true) {
                                returned.add(product.id);
                              } else {
                                returned.remove(product.id);
                              }
                            }),
                            controlAffinity: .trailing,
                            contentPadding: EdgeInsets.zero,
                            secondary: _ProductThumbnail(product: product),
                            title: Text(
                              product.name,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: .w500,
                              ),
                            ),
                            subtitle: Text(
                              _productSubtitle(product),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Back'),
          ),
          ElevatedButton(
            // disabled until at least one item is checked
            onPressed: returned.isEmpty
                ? null
                : () {
                    Navigator.of(ctx).pop();
                    onReturnConfirmed(
                      returned.toList(),
                      products
                          .map((e) => e.id)
                          .where((id) => !returned.contains(id))
                          .toList(),
                    );
                  },
            child: Text(
              'Confirm (${returned.length} ${mainServiceType.returnCountUnitLabel})',
            ),
          ),
        ],
      ),
    ),
  );
}

/// Step 3 — confirm (or move) the expected return date for the items that are
/// still out.
void showReturnDateUpdateDialog(
  BuildContext context, {
  required MainServiceType? mainServiceType,
  required String currentReturnDate,
  required void Function(DateTime selectedDate) onConfirmed,
}) {
  final today = DateTime.now().dateOnly;
  final currentReturn = currentReturnDate.parseToDateTime();
  DateTime selectedDate = currentReturn;
  final returnLabel = mainServiceType.returnLabel.toLowerCase();

  showDialog(
    context: context,
    builder: (ctx) => StatefulBuilder(
      builder: (ctx, setState) {
        final returnDay = selectedDate.dateOnly;
        final isPast = returnDay.isBefore(today);
        final isToday = returnDay.isSameDay(today);
        return AlertDialog(
          title: Text('Update ${mainServiceType.returnDateLabel} (Optional)'),
          content: SizedBox(
            width: 420,
            child: Column(
              mainAxisSize: .min,
              crossAxisAlignment: .start,
              children: [
                if (isPast) ...[
                  Text(
                    '⚠️ The scheduled $returnLabel date has already passed.',
                    style: const TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Please confirm the actual $returnLabel date before continuing.',
                  ),
                ] else if (isToday) ...[
                  Text(
                    'This booking is scheduled for $returnLabel today.',
                    style: const TextStyle(color: Colors.green, fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  const Text('Confirm the date or update it if needed.'),
                ] else
                  Text(
                    'There is still time before the scheduled $returnLabel date.',
                    style: const TextStyle(color: Colors.blue, fontSize: 13),
                  ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: ctx,
                      initialDate: selectedDate,
                      firstDate: currentReturn,
                      // allow up to 1 year out — anchored past the current
                      // return date so a far-future booking can't produce a
                      // lastDate that precedes firstDate
                      lastDate:
                          (currentReturn.isAfter(today) ? currentReturn : today)
                              .add(const Duration(days: 365)),
                    );
                    if (picked == null) return;
                    setState(() => selectedDate = picked);
                  },
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Expected ${mainServiceType.returnDateLabel}',
                      border: const OutlineInputBorder(),
                      suffixIcon: const Icon(Icons.calendar_today, size: 18),
                    ),
                    child: Text(selectedDate.format()),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                onConfirmed(selectedDate);
              },
              child: const Text('Confirm Date'),
            ),
          ],
        );
      },
    ),
  );
}

String _productSubtitle(ProductInfoEntity product) {
  final parts = <String>[
    'Qty: ${product.quantity}',
    if (product.category != null && product.category!.isNotEmpty)
      product.category!,
    if (product.model != null && product.model!.isNotEmpty) product.model!,
    if (product.color != null && product.color!.isNotEmpty) product.color!,
  ];
  return parts.join(' • ');
}

class _ProductThumbnail extends StatelessWidget {
  const _ProductThumbnail({required this.product});

  final ProductInfoEntity product;

  @override
  Widget build(BuildContext context) {
    final imageUrl = product.thumbnailImage ?? product.productImage;
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: SizedBox(
        width: 40,
        height: 40,
        child: imageUrl == null || imageUrl.isEmpty
            ? Container(
                color: AppColors.purple.withValues(alpha: 0.1),
                child: const Icon(Icons.inventory_2_outlined, size: 18),
              )
            : CustomNetworkImage(imageUrl: imageUrl),
      ),
    );
  }
}
