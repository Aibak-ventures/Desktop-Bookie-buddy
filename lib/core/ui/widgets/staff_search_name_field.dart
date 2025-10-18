import 'package:bookie_buddy_web/core/app_input_validators.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/models/staff_model/staff_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_staff_search/staff_search_cubit.dart';
// import 'package:bookie_buddy_web/features/add_booking/view_model/cubit/staff_search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class StaffSearchNameField extends StatelessWidget {
  const StaffSearchNameField({super.key, required this.nameController});
  final TextEditingController nameController;
  @override
  Widget build(
    BuildContext context,
  ) => BlocBuilder<StaffSearchCubit, StaffSearchState>(
    builder: (context, state) => TypeAheadField<StaffModel>(
      itemBuilder: (context, staff) =>
          ListTile(title: Text(staff.name), subtitle: Text(staff.phoneNumber)),
      onSelected: (selectedStaff) {
        context.read<StaffSearchCubit>().selectStaff(selectedStaff);
        nameController.text = selectedStaff.name;
        debugPrint(
          'Selected staff: ${selectedStaff.id}, ${selectedStaff.name}',
        );
      },
      debounceDuration: const Duration(milliseconds: 100),
      hideWithKeyboard: false,
      suggestionsCallback: (search) {
        final staffs = state.staffs;
        if (search.isEmpty) return staffs;
        return staffs
            .where(
              (staff) =>
                  staff.name.toLowerCase().contains(search.toLowerCase()),
            )
            .toList();
      },
      controller: nameController,
      builder: (context, controller, focusNode) => CustomTextField(
        focusNode: focusNode,
        controller: controller,
        hintText: 'Search or select staff',
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,

        prefixIcon: const Icon(Icons.person),
        suffixIcon: ValueListenableBuilder(
          valueListenable: controller,
          builder: (context, searchValue, child) => searchValue.text.isEmpty
              ? const SizedBox.shrink()
              : IconButton(
                  onPressed: () {
                    controller.clear();
                    context.read<StaffSearchCubit>().clearSelectedStaff();
                  },
                  icon: const Icon(Icons.clear),
                ),
        ),
        validator: AppInputValidators.name,
      ),
      decorationBuilder: (context, child) => DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: 10.radiusBorder,
          border: BoxBorder.all(color: AppColors.grey300),
          boxShadow: [
            BoxShadow(
              color: AppColors.grey300,
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: child,
      ),
      emptyBuilder: (context) => const SizedBox(
        height: 100,
        child: Center(child: Text('No staff found')),
      ),
      errorBuilder: (context, error) =>
          SizedBox(height: 100, child: Center(child: Text(error.toString()))),
      loadingBuilder: (context) => const Padding(
        padding: EdgeInsets.all(8.0),
        child: CircularProgressIndicator(),
      ),
    ),
  );
}
