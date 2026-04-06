import 'package:bookie_buddy_web/features/booking/domain/entities/additional_charges_entity/additional_charges_entity.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/add_additional_charge_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdditionalChargesListWidget extends StatelessWidget {
  const AdditionalChargesListWidget({
    super.key,
    required this.additionalChargesNotifier,
  });

  final ValueNotifier<List<AdditionalChargesEntity>> additionalChargesNotifier;

  @override
  Widget build(
    BuildContext context,
  ) => ValueListenableBuilder<List<AdditionalChargesEntity>>(
    valueListenable: additionalChargesNotifier,
    builder: (context, selectedValue, _) => selectedValue.isEmpty
        // ? const Center(child: Text('No additional charges'))
        ? const SizedBox()
        : ListView.builder(
            shrinkWrap: true,
            primary: false,
            padding: EdgeInsets.zero,
            itemCount: selectedValue.length,
            itemBuilder: (context, index) {
              final charge = selectedValue[index];
              return Container(
                margin: EdgeInsets.only(bottom: 8.h),
                padding: (15, 6).padding,
                decoration: BoxDecoration(
                  color: AppColors.grey300.withValues(alpha: 0.7),
                  borderRadius: 8.radiusBorder,
                  border: Border.all(color: AppColors.grey300),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            charge.name ?? '',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Amount: ${charge.amount?.toCurrency() ?? 0}',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.grey600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.edit_outlined,
                        // color: AppColors.black,
                      ),
                      onPressed: () {
                        showAddAdditionalChargeDialog(
                          context: context,
                          additionalChargesNotifier: additionalChargesNotifier,
                          existingCharge: charge,
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: AppColors.redTomato),
                      onPressed: () {
                        final newList = List<AdditionalChargesEntity>.from(
                          selectedValue,
                        )..removeAt(index);
                        additionalChargesNotifier.value = newList;
                      },
                    ),
                  ],
                ),
              );
            },
          ),
  );
}
