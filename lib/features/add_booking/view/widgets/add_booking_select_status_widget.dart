import 'package:bookie_buddy_web/core/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/core/enums/payment_method_enums.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_drop_down_field.dart';
import 'package:bookie_buddy_web/core/ui/widgets/premium_badge.dart';
// import 'package:bookie_buddy_web/core/ui/widgets/premium_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddBookingSelectStatusWidget extends StatelessWidget {
  const AddBookingSelectStatusWidget({
    super.key,
    required this.deliveryStatusNotifier,
    required this.paymentOptionNotifier,
    required this.isSharingPdfToWhatsAppNotifier,
    required this.advanceAmountController,
    required this.whatsAppNumber,
  });

  final ValueNotifier<DeliveryStatus> deliveryStatusNotifier;
  final ValueNotifier<PaymentMethod> paymentOptionNotifier;
  final ValueNotifier<bool> isSharingPdfToWhatsAppNotifier;
  final TextEditingController advanceAmountController;
  final String whatsAppNumber;

  @override
  Widget build(BuildContext context) => Column(
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
            builder: (context, selectedValue, _) => CustomDropDownField<String>(
              hintText: 'Delivery Status',
              selectedValue: selectedValue.name,
              prefixIcon: const Icon(Icons.bookmark),
              onChanged: (value) {
                if (value != null)
                  deliveryStatusNotifier.value =
                      DeliveryStatus.fromString(value);
              },
              items: DeliveryStatus.values
                  .where(
                    // Don't show returned status when creating a booking
                    (e) => e != DeliveryStatus.returned,
                  )
                  .map((e) => e.name)
                  .toList(),
            ),
          ),
          10.height,
          ValueListenableBuilder(
            valueListenable: advanceAmountController,
            builder: (context, textEditingValue, child) => textEditingValue
                    .text.isEmpty
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
                        builder: (context, selectedOption, child) => RadioGroup(
                          onChanged: (value) {
                            if (value != null)
                              paymentOptionNotifier.value = value;
                          },
                          groupValue: selectedOption,
                          child: Column(
                            children: [
                              RadioListTile<PaymentMethod>(
                                title: Text(PaymentMethod.gPay.name),
                                value: PaymentMethod.gPay,
                                activeColor: AppColors.purple,
                              ),
                              RadioListTile<PaymentMethod>(
                                title: Text(PaymentMethod.cash.name),
                                value: PaymentMethod.cash,
                                activeColor: AppColors.purple,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
          5.height,
          // ValueListenableBuilder<bool>(
          //   valueListenable: isSharingPdfToWhatsAppNotifier,
          //   builder: (context, shouldShare, _) => CheckboxListTile(
          //     title: const Text('Send Invoice to WhatsApp'),
          //     secondary: const PremiumBadge(),
          //     subtitle: whatsAppNumber.isNotEmpty
          //         ? Text(
          //             whatsAppNumber.toString(),
          //             style: TextStyle(fontSize: 12.sp, color: AppColors.grey),
          //           )
          //         : null,
          //     value: shouldShare,
          //     contentPadding: EdgeInsets.zero,
          //     onChanged: (value) {
          //       if (value != null) isSharingPdfToWhatsAppNotifier.value = value;
          //     },
          //     activeColor: AppColors.purple,
          //     controlAffinity: ListTileControlAffinity.leading, // checkbox at start
          //   ),
          // ),

          // Text(
          //   'Purchase Mode',
          //   style: TextStyle(
          //     color: AppColors.black,
          //     fontSize: 18.sp,
          //     fontWeight: FontWeight.w600,
          //   ),
          // ),
          // ValueListenableBuilder<PurchaseMode>(
          //   valueListenable: purchaseModeNotifier,
          //   builder: (context, selectedOption, child) => RadioGroup(
          //     onChanged: (value) {
          //       if (value != null) purchaseModeNotifier.value = value;
          //     },
          //     groupValue: selectedOption,
          //     child: Column(
          //       children: [
          //         RadioListTile<PurchaseMode>(
          //           title: Text(PurchaseMode.normal.name),
          //           value: PurchaseMode.normal,
          //           activeColor: AppColors.purple,
          //         ),
          //         RadioListTile<PurchaseMode>(
          //           title: Text(PurchaseMode.package.name),
          //           value: PurchaseMode.package,
          //           activeColor: AppColors.purple,
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      );
}
