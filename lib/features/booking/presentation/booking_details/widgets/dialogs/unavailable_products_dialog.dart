import 'package:bookie_buddy_core/core/common/entities/unavailable_products_entity/unavailable_products_entity.dart';
import 'package:bookie_buddy_core/core/constants/enums/main_service_type_enums.dart';
import 'package:bookie_buddy_core/features/product/domain/entities/product_info_entity/product_info_entity.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_network_image.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/features/booking/presentation/all_booking/bloc/booking_details_drawer_cubit/booking_details_drawer_cubit.dart';
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/bloc/booking_details_bloc/booking_details_bloc.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Names the products behind an insufficient-stock conflict, the window they
/// are unavailable for, and the booking already holding them.
class UnavailableProductsDialog {
  UnavailableProductsDialog._();

  /// The booked items the conflict actually points at, matched on variant id.
  /// Empty means this dialog has nothing to show and the caller should fall
  /// back to a plain message.
  static List<ProductInfoEntity> matchingItems(
    UnavailableProductsEntity conflict,
    List<ProductInfoEntity> bookedItems,
  ) => bookedItems
      .where(
        (item) =>
            conflict.unavailableProducts.any((id) => id == item.variantId),
      )
      .toList();

  static Future<void> show({
    required BuildContext context,
    required UnavailableProductsEntity conflict,
    required List<ProductInfoEntity> unavailableItems,
  }) async {
    final drawerCubit = context.read<BookingDetailsDrawerCubit>();
    final bookingDetailsBloc = context.read<BookingDetailsBloc>();
    final dateFrom = conflict.dateFrom;
    final dateTo = conflict.dateTo;

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        icon: const Icon(
          Icons.warning_amber_rounded,
          color: Colors.orange,
          size: 30,
        ),
        title: const Text(
          'Unavailable Products',
          style: TextStyle(fontSize: 18, fontWeight: .w600),
        ),
        content: SizedBox(
          width: 560,
          child: Column(
            mainAxisSize: .min,
            crossAxisAlignment: .start,
            children: [
              Text(
                'The product is booked for another customer on that date '
                '${_formatWindow(dateFrom, dateTo)}:',
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
              if (conflict.bookingInvoiceId != null &&
                  conflict.bookingId != null) ...[
                const SizedBox(height: 8),
                Text.rich(
                  TextSpan(
                    text: 'Already booked under ',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    children: [
                      TextSpan(
                        text: conflict.bookingInvoiceId,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.blue,
                          fontWeight: .w600,
                          decoration: .underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(dialogContext).pop();
                            // Swap the drawer over to the conflicting booking
                            // — opening it alone would leave the previous
                            // booking's details on screen.
                            drawerCubit.openDrawer(conflict.bookingId!);
                            bookingDetailsBloc.add(
                              BookingDetailsEvent.fetchBookingDetails(
                                conflict.bookingId!,
                              ),
                            );
                          },
                      ),
                      const TextSpan(text: ' (View Booking)'),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 16),
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: unavailableItems.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (context, index) =>
                      _UnavailableProductRow(product: unavailableItems[index]),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('OK', style: TextStyle(fontWeight: .w500)),
          ),
        ],
      ),
    );
  }

  static String _formatWindow(String? from, String? to) {
    if (from == null) return '';
    if (to == null) return from.formatToUiDate();
    return '${from.formatToUiDate()} - ${to.formatToUiDate()}';
  }
}

class _UnavailableProductRow extends StatelessWidget {
  const _UnavailableProductRow({required this.product});

  final ProductInfoEntity product;

  @override
  Widget build(BuildContext context) {
    final mainServiceType = product.mainServiceType;
    final imageUrl = product.thumbnailImage ?? product.productImage;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: .start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              height: 60,
              width: 60,
              child: imageUrl == null || imageUrl.isEmpty
                  ? Container(
                      color: AppColors.purple.withValues(alpha: 0.1),
                      child: const Icon(Icons.inventory_2_outlined, size: 20),
                    )
                  : CustomNetworkImage(imageUrl: imageUrl),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(fontSize: 16, fontWeight: .w600),
                  maxLines: 2,
                  overflow: .ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '${mainServiceType.categoryFieldLabel}: ${product.category?.isNotEmpty == true ? product.category : '-'}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                Text(
                  mainServiceType == null ||
                          mainServiceType.isSingleVariantProductType
                      ? 'Model: ${product.model ?? '-'}'
                      : '${mainServiceType.variantAttributeLabel}: ${product.variantAttribute ?? '-'}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Text(
            product.amount.toCurrency(),
            style: const TextStyle(
              fontSize: 15,
              fontWeight: .w600,
              color: AppColors.purple,
            ),
          ),
        ],
      ),
    );
  }
}
