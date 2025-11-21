import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/dialogs/add_additional_charge_dialog.dart';
import 'package:bookie_buddy_web/core/ui/widgets/additional_charges_list_widget.dart';
import 'package:bookie_buddy_web/features/add_booking/models/additional_charges_model/additional_charges_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddAdditionalChargesWidget extends StatelessWidget {
  const AddAdditionalChargesWidget({
    super.key,
    required this.additionalChargesNotifier,
  });

  final ValueNotifier<List<AdditionalChargesModel>> additionalChargesNotifier;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                'Additional Charges',
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  showAddAdditionalChargeDialog(
                    context: context,
                    additionalChargesNotifier: additionalChargesNotifier,
                  );
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          2.height,
          AdditionalChargesListWidget(
            additionalChargesNotifier: additionalChargesNotifier,
          ),
        ],
      );
}
