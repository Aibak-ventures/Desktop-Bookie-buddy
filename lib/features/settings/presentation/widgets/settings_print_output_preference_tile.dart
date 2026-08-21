import 'package:bookie_buddy_web/core/common/entities/shop_settings_entity/shop_settings_entity.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_drop_down_field.dart';
import 'package:bookie_buddy_web/core/constants/enums/print_output_preference_enum.dart';
import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/features/auth/presentation/bloc/user_cubit/user_cubit.dart';
import 'package:bookie_buddy_web/features/settings/presentation/widgets/settings_list_tile.dart';
import 'package:bookie_buddy_web/features/shop/domain/entities/update_shop_settings_request_entity/update_shop_settings_request_entity.dart';
import 'package:bookie_buddy_web/features/shop/domain/usecases/update_shop_settings_usecase.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// "Print" button behavior across the app (booking/sale detail, etc.):
/// thermal receipt, PDF invoice, or ask every time — a suffix dropdown
/// showing the current selection, matching mobile's
/// `SettingsPrintOutputPreferenceSection` (same title/subtitle copy, same
/// disabled-for-staff dropdown), rather than mobile's on-row-tap picker
/// dialog. The row itself isn't a tap target — [SettingsListTile.onTap] is
/// left unset — since the dropdown is its own control.
///
/// NOTE: `printOutputPreference` on [ShopSettingsEntity] is a speculative
/// field — see its doc — so this PUTs the *entire* shop-settings object
/// (via [UpdateShopSettingsUseCase]) to `shop-settings/update-settings`
/// and treats the round-trip as unverified until backend confirms it.
class SettingsPrintOutputPreferenceTile extends StatefulWidget {
  const SettingsPrintOutputPreferenceTile({
    required this.shopSettings,
    this.isStaff = false,
  });

  final ShopSettingsEntity shopSettings;

  /// Staff accounts can't change this shop-wide setting — matches mobile,
  /// which disables the same control for staff (see
  /// `SettingsPrintOutputPreferenceSection`).
  final bool isStaff;

  @override
  State<SettingsPrintOutputPreferenceTile> createState() =>
      _SettingsPrintOutputPreferenceTileState();
}

class _SettingsPrintOutputPreferenceTileState
    extends State<SettingsPrintOutputPreferenceTile> {
  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    final preference = widget.shopSettings.printOutputPreference;
    final locked = widget.isStaff || _saving;

    return SettingsListTile(
      icon: Icons.receipt_long_rounded,
      iconColor: AppColors.aquamarineMedium,
      iconBackground: AppColors.aquamarineMedium.withValues(alpha: 0.15),
      title: 'Default print action',
      subtitle: _saving
          ? 'Saving…'
          : 'Select the default print action for this shop.',
      trailing: SizedBox(
        width: 170,
        child: CustomDropDownField<PrintOutputPreference>(
          hintText: '',
          enabled: !locked,
          selectedValue: preference,
          items: PrintOutputPreference.values,
          itemLabelBuilder: (item) => item.label,
          onChanged: (selected) {
            if (selected == null || selected == preference) return;
            _confirmAndApply(selected);
          },
        ),
      ),
    );
  }

  Future<void> _confirmAndApply(PrintOutputPreference selected) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Change print output?'),
        content: Text(
          'Every print action across the shop will default to '
          '"${selected.label}" until changed again. Continue?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    final userCubit = context.read<UserCubit>();
    setState(() => _saving = true);
    try {
      await getIt<UpdateShopSettingsUseCase>()(
        UpdateShopSettingsRequestEntity(printOutputPreference: selected),
      );

      if (mounted) {
        context.showSnackBar(
          'Print output preference saved to "${selected.label}".',
        );
      }

      // Settings/booking screens read this off the cached UserCubit
      // snapshot, so refetch it now — same pattern Tax & Compliance uses.
      await userCubit.loadUserData();
    } catch (e) {
      if (mounted) {
        context.showSnackBar('Failed to save print output: $e', isError: true);
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}
