import 'package:bookie_buddy_web/core/constants/enums/shop_based_enums.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/dialogs/show_custom_alert_dialog.dart';
import 'package:bookie_buddy_web/core/ui/widgets/global_loading_overlay.dart';
import 'package:bookie_buddy_web/core/view_model/user_cubit.dart';
import 'package:bookie_buddy_web/features/settings/view_models/cubit_add_button_default_action/add_button_default_action_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsAddButtonDefaultActionSection extends StatelessWidget {
  const SettingsAddButtonDefaultActionSection({
    super.key,
    required this.isOwner,
    required this.isCustomWorkFeatureEnabled,
  });

  final bool isOwner;
  final bool isCustomWorkFeatureEnabled;

  @override
  Widget build(
    BuildContext context,
  ) => BlocConsumer<AddButtonDefaultActionCubit, AddButtonDefaultActionState>(
    listener: (context, state) {
      if (state.status.isSaving) {
        GlobalLoadingOverlay.show(context, text: 'Saving...');
      } else {
        GlobalLoadingOverlay.hide();
      }

      if (state.status.isSuccess) {
        context
          ..showSnackBar('Add button default action updated successfully')
          ..read<UserCubit>().loadUserData();
      } else if (state.status.isFailure) {
        context.showSnackBar(
          state.error ?? 'Failed to update add button default action',
          isError: true,
        );
      }
    },
    buildWhen: (p, c) => p.action != c.action || p.status != c.status,
    builder: (context, state) => DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
        child: RadioGroup(
          groupValue: state.action,
          onChanged: (value) {
            if (value != null && isOwner) {
              _showConfirmDefaultActionButtonSelectionDialog(context, value);
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8.w, top: 4.h, bottom: 4.h),
                child: Text(
                  'Add(+) Button Default Action',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.blackShade,
                  ),
                ),
              ),
              ...AddButtonDefaultAction.values
                  .where((feature) {
                    // Filter out custom work option if the feature is not enabled
                    if (!feature.isCustomWork) return true;
                    return isCustomWorkFeatureEnabled;
                  })
                  .map(
                    (action) => RadioListTile<AddButtonDefaultAction>(
                      dense: true,
                      title: Text(action.label),
                      subtitle: action == AddButtonDefaultAction.ask
                          ? const Text('Show a choice every time')
                          : null,
                      value: action,
                    ),
                  ),
              if (!isOwner)
                Padding(
                  padding: EdgeInsets.only(
                    left: 16.w,
                    right: 12.w,
                    bottom: 6.h,
                  ),
                  child: Text(
                    'Only the shop owner can change this.',
                    style: TextStyle(fontSize: 11.sp, color: AppColors.grey),
                  ),
                ),
            ],
          ),
        ),
      ),
    ),
  );

  Future<void> _showConfirmDefaultActionButtonSelectionDialog(
    BuildContext context,
    AddButtonDefaultAction newAction,
  ) async => showCustomAlertDialog(
    context: context,
    title: 'Confirm Default Action',
    content:
        'Set the Add button default action to "${newAction.label}"?\n\nThis will apply for everyone in this shop. You can change it again later.',
    onConfirm: () => context
        .read<AddButtonDefaultActionCubit>()
        .saveDefaultAction(newAction),
    confirmText: 'Save',
  );
}
