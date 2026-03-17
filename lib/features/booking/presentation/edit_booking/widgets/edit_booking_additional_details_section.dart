import 'package:bookie_buddy_web/utils/app_input_validators.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/features/booking/presentation/edit_booking/widgets/edit_booking_section_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditBookingAdditionalDetailsSection extends StatelessWidget {
  const EditBookingAdditionalDetailsSection({
    super.key,
    required this.securityAmountController,
    required this.discountAmountController,
  });

  final TextEditingController securityAmountController;
  final TextEditingController discountAmountController;

  @override
  Widget build(BuildContext context) => EditBookingSectionColumn(
        title: 'Additional',
        child: Column(
          spacing: 15.w,
          children: [
            CustomTextField(
              controller: securityAmountController,
              validator: (value) => AppInputValidators.isEmpty(value)
                  ? null
                  : AppInputValidators.amount(
                      value,
                      allowZero: true,
                      fieldName: 'Security',
                    ),
              label: 'Security Amount (Optional)',
              hintText: 'Enter Security',
              keyboardType: TextInputType.number,
            ),
            CustomTextField(
              controller: discountAmountController,
              validator: (value) => AppInputValidators.isEmpty(value)
                  ? null
                  : AppInputValidators.amount(
                      value,
                      allowZero: true,
                      fieldName: 'Discount',
                    ),
              label: 'Discount Amount (Optional)',
              hintText: 'Enter Discount',
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      );
}
