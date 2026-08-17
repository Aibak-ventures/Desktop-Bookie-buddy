import 'package:bookie_buddy_web/core/common/entities/shop_settings_entity/shop_settings_entity.dart';
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
/// thermal receipt, PDF invoice, or ask every time.
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
    final locked = widget.isStaff;
    return SettingsListTile(
      icon: Icons.receipt_long_rounded,
      iconColor: AppColors.aquamarineMedium,
      iconBackground: AppColors.aquamarineMedium.withValues(alpha: 0.15),
      title: 'Print Output',
      subtitle: _saving
          ? 'Saving…'
          : locked
          ? 'When you print: ${preference.label} (staff can\'t change setting)'
          : 'When you print: ${preference.label}',
      onTap: (_saving || locked) ? () {} : () => _pickPreference(preference),
    );
  }

  Future<void> _pickPreference(PrintOutputPreference current) async {
    final selected = await showDialog<PrintOutputPreference>(
      context: context,
      builder: (dialogContext) =>
          _PrintOutputPreferenceDialog(current: current),
    );
    if (selected == null || selected == current || !mounted) return;

    final userCubit = context.read<UserCubit>();
    setState(() => _saving = true);
    try {
      await getIt<UpdateShopSettingsUseCase>()(
        UpdateShopSettingsRequestEntity(printOutputPreference: selected),
      );

      context.showSnackBar(
        'Print output preference saved to "${selected.label}".',
      );

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

class _PrintOutputPreferenceDialog extends StatelessWidget {
  const _PrintOutputPreferenceDialog({required this.current});

  final PrintOutputPreference current;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Print Output'),
      content: RadioGroup(
        groupValue: current,
        onChanged: (value) => Navigator.of(context).pop(value),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final option in PrintOutputPreference.values)
              RadioListTile<PrintOutputPreference>(
                contentPadding: EdgeInsets.zero,
                title: Text(option.label),
                value: option,
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
