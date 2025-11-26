import 'package:bookie_buddy_web/core/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/models/booking_details_model/booking_details_model.dart';
import 'package:bookie_buddy_web/core/ui/widgets/customization_expansion_tile.dart';
import 'package:bookie_buddy_web/core/ui/widgets/product_simple_details_tile.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/sections/booking_details_details_column.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/sections/booking_details_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingDetailsProductSection extends StatelessWidget {
  const BookingDetailsProductSection({super.key, required this.booking});

  final BookingDetailsModel booking;

  @override
  Widget build(BuildContext context) => BookingDetailsSection(
        title: '',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
              itemCount: booking.bookedItems.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final product = booking.bookedItems[index];

                return Column(
                  children: [
                    ProductSimpleDetailsTile(
                      name: product.name,
                      quantity: product.quantity,
                      category: product.category,
                      color: product.color,
                      image: product.image,
                      model: product.model,
                      variantAttribute: product.variantAttribute,
                      mainServiceType: product.mainServiceType,
                      amount: product.amount,
                    ),
                    if ((product.mainServiceType.isDress ||
                            product.mainServiceType.isVehicle) &&
                        product.measurements.isNotEmpty)
                      CustomizationExpansionTile(
                        expansionTitle: product.mainServiceType.isVehicle
                            ? 'More Details'
                            : null,
                        measurements: product.measurements,
                        isButtonVisible: false,
                        trailingWidget: product.measurements.isNotEmpty
                            ? 5.height
                            : Padding(
                                padding: 10.padding,
                                child: const Text('No measurements'),
                              ),
                      ),
                  ],
                );
              },
            ),
            if (booking.description != null && booking.description!.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(
                  // top: 16.w,
                  left: 16.w,
                  right: 16.w,
                  bottom: 20.w,
                ),
                child: BookingDetailsDetailsColumn(
                  label: 'Note',
                  value: booking.description!,
                ),
              ),
          ],
        ),
      );
}
