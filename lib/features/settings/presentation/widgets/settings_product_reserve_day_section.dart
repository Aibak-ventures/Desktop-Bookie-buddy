import 'package:bookie_buddy_web/features/settings/presentation/bloc/product_reserve_days_cubit/product_reserve_days_cubit.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/common/widgets/dialogs/show_custom_alert_dialog.dart';
import 'package:bookie_buddy_web/core/common/widgets/global_loading_overlay.dart';
import 'package:bookie_buddy_web/core/view_model/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsProductReserveDaySection extends StatelessWidget {
  const SettingsProductReserveDaySection({super.key, required this.isOwner});

  final bool isOwner;

  @override
  Widget build(
    BuildContext context,
  ) =>
      BlocConsumer<ProductReserveDaysCubit, ProductReserveDaysState>(
        listener: (context, state) {
          if (state.status.isSaving) {
            GlobalLoadingOverlay.show(context, text: 'Saving...');
          } else {
            GlobalLoadingOverlay.hide();
          }

          if (state.status.isSuccess) {
            context
                .showSnackBar('Product cooling end days updated successfully');
            context.read<UserCubit>().loadUserData();
          } else if (state.status.isFailure) {
            context.showSnackBar(
              state.error ?? 'Failed to update product cooling end days',
              isError: true,
            );
          }
        },
        buildWhen: (p, c) =>
            p.selectedDays != c.selectedDays || p.status != c.status,
        builder: (context, state) => ListTile(
          title: Text(
            'Product Maintenance / Cooling End Date',
            style: TextStyle(color: AppColors.blackShade, fontSize: 17.sp),
          ),
          subtitle: Text(
            'Extra days after a booking before the product becomes available again.',
            style: TextStyle(fontSize: 11.sp, color: AppColors.grey),
          ),
          trailing: DropdownButton<int>(
            value: state.selectedDays,
            underline: const SizedBox(),
            dropdownColor: AppColors.white,
            items: const ['0', '1', '2', '3', '4', '5', '6']
                .map(
                  (number) => DropdownMenuItem(
                    value: int.parse(number),
                    enabled: isOwner,
                    child: Text(number),
                  ),
                )
                .toList(),
            onChanged: state.status.isSaving
                ? null
                : (value) {
                    if (value != null && value != state.selectedDays) {
                      _showProductReserveDaysDialog(context, value);
                    }
                  },
          ),
        ),
      );

  Future<void> _showProductReserveDaysDialog(
    BuildContext context,
    int selectedDays,
  ) async =>
      showCustomAlertDialog(
        context: context,
        title: 'Set Product Reserve Days',
        content:
            'This will set the number of days to reserve the product after booking. The product will not be available for other bookings during this period.',
        onConfirm: () =>
            context.read<ProductReserveDaysCubit>().save(selectedDays),
        confirmText: 'Save',
      );
}
