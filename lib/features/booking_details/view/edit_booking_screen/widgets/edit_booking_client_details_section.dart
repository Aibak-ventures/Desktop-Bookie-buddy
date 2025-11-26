import 'package:bookie_buddy_web/core/app_input_validators.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/client_select_widget.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditBookingClientDetailsSection extends StatelessWidget {
  const EditBookingClientDetailsSection({
    super.key,
    required this.clientNameController,
    required this.clientPhone1Controller,
    required this.clientPhone2Controller,
    required this.clientAddressController,
    required this.isClientSearchEnabledNotifier,
  });

  final TextEditingController clientNameController;
  final TextEditingController clientPhone1Controller;
  final TextEditingController clientPhone2Controller;
  final TextEditingController clientAddressController;
  final ValueNotifier<bool> isClientSearchEnabledNotifier;

  @override
  Widget build(BuildContext context) => Column(
        spacing: 15.w,
        children: [
          ClientSelectWidget(
            nameController: clientNameController,
            phone1Controller: clientPhone1Controller,
            phone2Controller: clientPhone2Controller,
            isClientSearchEnabledNotifier: isClientSearchEnabledNotifier,
            textStyle: TextStyle(color: AppColors.grey600, fontSize: 16.sp),
          ),
          CustomTextField(
            controller: clientAddressController,
            validator: AppInputValidators.address,
            label: 'Place',
          ),
        ],
      );
}
