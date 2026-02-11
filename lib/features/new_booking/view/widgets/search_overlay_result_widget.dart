import 'dart:developer';
import 'package:bookie_buddy_web/core/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/core/enums/payment_method_enums.dart';
import 'package:bookie_buddy_web/core/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/core/enums/shop_based_enums.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/navigation/app_routes.dart';
import 'package:bookie_buddy_web/core/ui/widgets/client_search_name_field.dart';
import 'package:bookie_buddy_web/core/ui/widgets/staff_search_name_field.dart';
import 'package:bookie_buddy_web/core/view_model/user_cubit.dart';
import 'package:flutter/services.dart';
import 'package:bookie_buddy_web/core/models/client_request_model/client_request_model.dart';
import 'package:bookie_buddy_web/core/models/product_info_model/product_info_model.dart';
import 'package:bookie_buddy_web/core/models/product_model/product_model.dart';
import 'package:bookie_buddy_web/core/models/product_model/product_variant_model.dart';
import 'package:bookie_buddy_web/core/models/services_model/services_model.dart'
    show ServicesModel;
import 'package:bookie_buddy_web/core/repositories/booking_repository.dart';
import 'package:bookie_buddy_web/core/repositories/product_repository.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/dialogs/show_discard_dialog.dart';
import 'package:bookie_buddy_web/core/view_model/bloc_service/service_bloc.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_client/client_cubit.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_staff_search/staff_search_cubit.dart';
import 'package:bookie_buddy_web/features/add_booking/models/additional_charges_model/additional_charges_model.dart';
import 'package:bookie_buddy_web/features/add_booking/models/request_booking_model/request_booking_model.dart';
import 'package:bookie_buddy_web/features/add_booking/models/request_sales_model/request_sales_model.dart';
import 'package:bookie_buddy_web/features/new_booking/view/widgets/booking_calendar_widget.dart';
import 'package:bookie_buddy_web/features/new_booking/view/widgets/booking_document_upload_section.dart';
import 'package:bookie_buddy_web/features/new_booking/view/widgets/product_customization_widget.dart';
import 'package:bookie_buddy_web/features/select_product_booking/models/product_selected_model/product_selected_model.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view/select_product_screen.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view/view_model/bloc_select_product/select_product_bloc.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view/view_model/cubit_selected_products/selected_products_cubit.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view/widgets/select_product_dialog.dart';
import 'package:bookie_buddy_web/features/new_booking/helpers/booking_validation_helper.dart';
import 'package:bookie_buddy_web/features/new_booking/helpers/booking_text_field_builder.dart';
import 'package:bookie_buddy_web/features/new_booking/models/document_file_model.dart';

import 'package:bookie_buddy_web/features/new_booking/view/widgets/variant_chip.dart';
import 'package:bookie_buddy_web/features/new_booking/view/widgets/new_booking_app_bar.dart';
import 'package:bookie_buddy_web/src/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/generate_booking_pdf.dart';

import 'package:bookie_buddy_web/features/sale_details/view/widgets/generate_sale_details_pdf.dart';
import 'package:bookie_buddy_web/core/repositories/sales_repository.dart';
// import 'package:bookie_buddy_web/features/main/cubit/user_cubit.dart';
import 'package:bookie_buddy_web/core/ui/widgets/global_loading_overlay.dart';

// Stateful widget for overlay search item with variant selection
class OverlaySearchItem extends StatefulWidget {
  final ProductModel product;
  final Function(ProductVariantModel) onAddProduct;

  const OverlaySearchItem({
    required this.product,
    required this.onAddProduct,
  });

  @override
  State<OverlaySearchItem> createState() => OverlaySearchItemState();
}

class OverlaySearchItemState extends State<OverlaySearchItem> {
  ProductVariantModel? selectedVariant;

  @override
  void initState() {
    super.initState();

    // No default selection - user must explicitly select a variant
    selectedVariant = null;
  }

  @override
  Widget build(BuildContext context) {
    final price = widget.product.price ?? 0;
    final variants = widget.product.variants;
    // Define min width preventing squeeze/overflow
    const double minRowWidth = 700;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: LayoutBuilder(builder: (context, constraints) {
        final isOverflowing = constraints.maxWidth < minRowWidth;

        final content = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Container(
                width: 50,
                height: 40,
                color: Colors.grey.shade100,
                child: widget.product.image != null &&
                        widget.product.image!.isNotEmpty
                    ? Image.network(
                        widget.product.image!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Icon(
                          Icons.image_outlined,
                          size: 20,
                          color: Colors.grey.shade400,
                        ),
                      )
                    : Icon(Icons.image_outlined,
                        size: 20, color: Colors.grey.shade400),
              ),
            ),
            const SizedBox(width: 10),

            // Product Info - Fixed width
            SizedBox(
              width: 180,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    widget.product.color ?? 'color',
                    style: const TextStyle(
                        color: Color(0xFF707070),
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),
            // Divider
            Container(
              width: 1,
              height: 30,
              color: const Color(0xFFA6A6A6),
            ),
            const SizedBox(width: 12),

            // Variants or Details Section
            if (widget.product.mainServiceType.isMultiVariantProductType)
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: variants.isNotEmpty
                      ? SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: variants.map((variant) {
                              final isSelected =
                                  selectedVariant?.id == variant.id;
                              return Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: SelectableVariantChip(
                                  text: variant.attribute,
                                  isSelected: isSelected,
                                  onTap: () {
                                    setState(() {
                                      selectedVariant = variant;
                                    });
                                  },
                                ),
                              );
                            }).toList(),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              )
            else
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.product.category != null &&
                        widget.product.category!.isNotEmpty)
                      Text(
                        'Category: ${widget.product.category}',
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    if (widget.product.model != null &&
                        widget.product.model!.isNotEmpty)
                      Text(
                        'Model: ${widget.product.mainServiceType.productNameLabel}',
                        style: TextStyle(
                            fontSize: 11, color: Colors.grey.shade600),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    if ((widget.product.category == null ||
                            widget.product.category!.isEmpty) &&
                        (widget.product.model == null ||
                            widget.product.model!.isEmpty))
                      Text(
                        widget.product.description ?? '-',
                        style: const TextStyle(fontSize: 12),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),

            const SizedBox(width: 12),
            // Divider
            Container(
              width: 1,
              height: 30,
              color: const Color(0xFFA6A6A6),
            ),
            const SizedBox(width: 12),

            // Price section
            SizedBox(
              width: 90,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'rent price',
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade600),
                  ),
                  Text(
                    '₹$price',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),
            // Add button
            GestureDetector(
              onTap: selectedVariant != null
                  ? () => widget.onAddProduct(selectedVariant!)
                  : null,
              child: Container(
                width: 90,
                height: 36,
                decoration: BoxDecoration(
                  color: selectedVariant != null
                      ? const Color(0xFF6132E4)
                      : Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.add, size: 18, color: Colors.white),
                    SizedBox(width: 4),
                    Text(
                      'Add',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: isOverflowing
              ? const AlwaysScrollableScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          child: SizedBox(
            width: isOverflowing ? minRowWidth : constraints.maxWidth,
            child: content,
          ),
        );
      }),
    );
  }
}

// Selectable variant chip widget
class SelectableVariantChip extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectableVariantChip({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isShortText = text.length <= 3;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: isShortText ? 33 : null,
        height: 33,
        padding:
            isShortText ? null : const EdgeInsets.symmetric(horizontal: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: isShortText ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: isShortText ? null : BorderRadius.circular(8),
          color: isSelected ? AppColors.purpleLight : const Color(0xFFF8F7FF),
          border: Border.all(
            color: isSelected ? const Color(0xFF6132E4) : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
