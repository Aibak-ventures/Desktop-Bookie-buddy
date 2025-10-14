import 'package:bookie_buddy_web/core/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/core/enums/payment_method_enums.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_drop_down_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddBookingSelectStatusWidget extends StatelessWidget {
  const AddBookingSelectStatusWidget({
    required this.deliveryStatusNotifier,
    required this.paymentOptionNotifier,
    required this.advanceAmountController,
    super.key,
  });

  final ValueNotifier<DeliveryStatus> deliveryStatusNotifier;
  final ValueNotifier<PaymentMethod> paymentOptionNotifier;
  final TextEditingController advanceAmountController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5,
      children: [
        Text(
          'Delivery Status',
          style: TextStyle(
            color: AppColors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        2.height,
        ValueListenableBuilder<DeliveryStatus>(
          valueListenable: deliveryStatusNotifier,
          builder: (context, selectedValue, _) {
            return CustomDropDownField<String>(
              hintText: 'Delivery Status',
              selectedValue: selectedValue.name,
              prefixIcon: const Icon(
                Icons.bookmark,
              ),
              onChanged: (value) {
                if (value != null)
                  deliveryStatusNotifier.value =
                      DeliveryStatus.fromString(value);
              },
              items: DeliveryStatus.values
                  .map(
                    (e) => e.name,
                  )
                  .toList(),
            );
          },
        ),
        10.height,
        ValueListenableBuilder(
            valueListenable: advanceAmountController,
            builder: (context, textEditingValue, child) {
              return textEditingValue.text.isEmpty
                  ? const SizedBox()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Payment Options',
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        ValueListenableBuilder<PaymentMethod>(
                          valueListenable: paymentOptionNotifier,
                          builder: (context, selectedOption, child) => Column(
                            children: [
                              RadioListTile<PaymentMethod>(
                                title: Text(PaymentMethod.gPay.name),
                                value: PaymentMethod.gPay,
                                activeColor: AppColors.purple,
                                groupValue: selectedOption,
                                onChanged: (value) {
                                  if (value != null)
                                    paymentOptionNotifier.value = value;
                                },
                              ),
                              RadioListTile<PaymentMethod>(
                                title: Text(PaymentMethod.cash.name),
                                value: PaymentMethod.cash,
                                activeColor: AppColors.purple,
                                groupValue: selectedOption,
                                onChanged: (value) {
                                  if (value != null)
                                    paymentOptionNotifier.value = value;
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
            }),
  
      ],
    );
  }
}
