import 'package:bookie_buddy_web/core/common/entities/user_entity/user_entity.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/theme/app_text_styles.dart';
import 'package:bookie_buddy_web/features/auth/presentation/bloc/user_cubit/user_cubit.dart';
import 'package:bookie_buddy_web/features/printer/presentation/print/pages/qz_print_screen.dart';
import 'package:bookie_buddy_web/features/settings/presentation/widgets/settings_list_group.dart';
import 'package:bookie_buddy_web/features/settings/presentation/widgets/settings_list_tile.dart';
import 'package:bookie_buddy_web/features/settings/presentation/widgets/settings_print_output_preference_tile.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Settings hub. Currently hosts Tax & Compliance; more settings sections
/// (shop details, password, notifications, etc.) can be added as further
/// [SettingsListGroup]s later.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<UserCubit, UserEntity?>(
        builder: (context, user) {
          // final canManageTax = user?.shopDetails.shopRole != ShopRole.staff;
          final isStaff = user?.shopDetails.shopRole.isStaff ?? false;
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Settings', style: AppTextStyles.display),
                    const SizedBox(height: 4),
                    Text(
                      'Manage how your shop is configured.',
                      style: AppTextStyles.bodySecondary,
                    ),
                    const SizedBox(height: 28),
                    // _SettingsGroup(
                    //   title: 'Business',
                    //   children: [
                    //     _SettingsTile(
                    //       icon: Icons.percent_rounded,
                    //       iconColor: AppColors.purple,
                    //       iconBackground: AppColors.purpleLight,
                    //       title: 'Tax & Compliance',
                    //       subtitle: 'Manage tax rules applied to this shop',
                    //       onTap: () async {
                    //         final userCubit = context.read<UserCubit>();
                    //         final hasChanges = await context.push<bool>(
                    //           BlocProvider(
                    //             create: (context) => TaxAndComplianceCubit(
                    //               getTaxConfigurations: getIt(),
                    //               createTaxConfiguration: getIt(),
                    //               updateTaxConfiguration: getIt(),
                    //             )..loadTaxConfigurations(),
                    //             child: TaxAndComplianceScreen(
                    //               canManage: canManageTax,
                    //             ),
                    //           ),
                    //         );
                    //         // Booking/sales screens read tax config off the
                    //         // cached UserCubit.shopDetails snapshot, so a
                    //         // rule created/edited/toggled here won't be seen
                    //         // by them until that snapshot is refetched.
                    //         if (hasChanges ?? false) {
                    //           await userCubit.loadUserData();
                    //         }
                    //       },
                    //     ),
                    //   ],
                    // ),
                    SettingsListGroup(
                      title: 'Printer Settings',
                      children: [
                        SettingsListTile(
                          icon: Icons.print_rounded,
                          iconColor: AppColors.aquamarineMedium,
                          iconBackground: AppColors.aquamarineMedium.withValues(
                            alpha: 0.15,
                          ),
                          title: 'Printer Setup',
                          subtitle: 'Connect or change your default printer',
                          onTap: () => context.push(const QzPrintScreen()),
                        ),
                        if (user != null)
                          SettingsPrintOutputPreferenceTile(
                            shopSettings: user.shopSettings,
                            isStaff: isStaff,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
