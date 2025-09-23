import 'package:bookie_buddy_web/core/app_input_validators.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/ui/widgets/custom_appbar.dart';
import '../../../core/ui/widgets/custom_button.dart';
import '../../../core/ui/widgets/custom_sized_box.dart';
import '../../../core/ui/widgets/custom_textfield.dart';

class AddStaffScreen extends StatelessWidget {
  const AddStaffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        'Add Staff',
        leadingIcon: const Icon(Icons.arrow_back_ios_new_rounded),
        onLeadingPressed: () {
          context.pop();
        },
      ),
      body: Padding(
        padding: 16.padding,
        child: Column(
          children: [
            const CustomSizedBoxHeight(0.03),
            const CustomTextField(
              keyboardType: TextInputType.text,
              hintText: 'Name',
              prefixIcon: Icon(
                Icons.person,
                color: AppColors.purple,
              ),
              controller: null,
              validator: AppInputValidators.name,
            ),
            const CustomSizedBoxHeight(0.03),
            const CustomTextField(
              hintText: 'Phone Number',
              keyboardType: TextInputType.number,
              prefixIcon: Icon(
                Icons.phone,
                color: AppColors.purple,
              ),
              controller: null,
              validator: AppInputValidators.phoneNumber,
            ),
            const CustomSizedBoxHeight(0.1),
            CustomElevatedButton(
              onPressed: () {},
              text: 'Add Staff',
            )
          ],
        ),
      ),
    );
  }
}
