import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_borders.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_text.dart';
import 'package:bookie_buddy_web/features/staff/view/add_staff_screen.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/ui/widgets/custom_appbar.dart';
import '../../../core/ui/widgets/custom_sized_box.dart';

class StaffListScreen extends StatelessWidget {
  const StaffListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: const Text(
          'Add Staff',
          style: TextStyle(color: Colors.white),
        ),
        shape: const LinearBorder(),
        icon: const Icon(
          Icons.person_add_alt_1_rounded,
          color: Colors.white,
        ),
        onPressed: () {
          context.push(const AddStaffScreen());
        },
        backgroundColor: AppColors.purple,
      ),
      appBar: CustomAppBar(
        'Add Booking',
        leadingIcon: const Icon(Icons.arrow_back_ios_new_rounded),
        onLeadingPressed: () {
          context.pop();
        },
      ),
      body: Padding(
        padding: 16.padding,
        child: Column(
          children: [
            const CustomSizedBoxHeight(0.02),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: SearchBar(
                hintText: 'Search here...',
                textStyle: WidgetStateProperty.all(
                    const TextStyle(color: Colors.white)),
                backgroundColor: WidgetStateProperty.all(AppColors.purple),
                hintStyle: WidgetStateProperty.all(
                    const TextStyle(color: Colors.white)),
                leading: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                shape: WidgetStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8))),
              ),
            ),
            const CustomSizedBoxHeight(0.05),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: 8.padding,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(AppBorders.radius9),
                          border: Border.all(color: AppColors.purple)),
                      child: ListTile(
                        title: const CustomText(
                          text: 'Suresh',
                          size: 0.04,
                          color: Colors.black,
                          weight: FontWeight.w500,
                        ),
                        subtitle: const CustomText(
                          text: '9867886734',
                          size: 0.03,
                          color: Colors.black,
                          weight: FontWeight.w500,
                        ),
                        trailing: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.more_vert_outlined)),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
