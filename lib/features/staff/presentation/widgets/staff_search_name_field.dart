import 'package:bookie_buddy_web/utils/app_input_validators.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/features/staff/domain/models/staff_model/staff_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';

import 'package:bookie_buddy_web/features/staff/presentation/bloc/staff_search_cubit/staff_search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class StaffSearchNameField extends StatelessWidget {
  const StaffSearchNameField({
    super.key,
    required this.nameController,
    this.errorText,
  });
  final TextEditingController nameController;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StaffSearchCubit, StaffSearchState>(
      builder: (context, state) {
        return TypeAheadField<StaffModel>(
          controller: nameController,
          debounceDuration: const Duration(milliseconds: 150),
          hideWithKeyboard: false,
          hideOnUnfocus: true,
          hideOnSelect: true,
          suggestionsCallback: (search) {
            final staffs = state.staffs;
            if (search.isEmpty) return staffs;
            return staffs
                .where(
                    (s) => s.name.toLowerCase().contains(search.toLowerCase()))
                .toList();
          },
          onSelected: (staff) {
            context.read<StaffSearchCubit>().selectStaff(staff);
            nameController.text = staff.name;
          },
          builder: (context, controller, focusNode) => TextFormField(
            focusNode: focusNode,
            controller: controller,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            style: const TextStyle(
              fontSize: 13,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              errorText: errorText,
              hintText: 'Search or select staff',
              hintStyle: const TextStyle(
                fontSize: 13,
                color: Color(0xFF8C8C8C),
                fontFamily: 'Inter',
              ),
              prefixIcon: const Icon(Icons.person, size: 16),
              suffixIcon: ValueListenableBuilder(
                valueListenable: controller,
                builder: (_, value, __) => value.text.isEmpty
                    ? const SizedBox.shrink()
                    : IconButton(
                        icon: const Icon(Icons.clear, size: 14),
                        onPressed: () {
                          controller.clear();
                          context.read<StaffSearchCubit>().clearSelectedStaff();
                        },
                      ),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    const BorderSide(color: Color(0xFFE0E0E0), width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    const BorderSide(color: Color(0xFFE0E0E0), width: 1.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    const BorderSide(color: AppColors.purple, width: 1.5),
              ),
            ),
            validator: AppInputValidators.name,
          ),
          itemBuilder: (context, staff) => ListTile(
            dense: true,
            // visualDensity: const VisualDensity(vertical: -3),
            title: Text(staff.name, style: const TextStyle(fontSize: 14)),
            subtitle: Text(
              staff.phoneNumber,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            ),
          ),
          decorationBuilder: (context, child) => DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: 8.radiusBorder,
              border: BoxBorder.all(color: AppColors.grey300),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: child,
          ),
          emptyBuilder: (_) => const SizedBox(
            height: 70,
            child: Center(
              child: Text('No staff found', style: TextStyle(fontSize: 11)),
            ),
          ),
          errorBuilder: (_, error) => SizedBox(
            height: 70,
            child: Center(
                child: Text(error.toString(),
                    style: const TextStyle(fontSize: 11))),
          ),
          loadingBuilder: (_) => const Padding(
            padding: EdgeInsets.all(4),
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        );
      },
    );
  }
}
