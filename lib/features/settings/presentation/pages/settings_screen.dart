import 'package:bookie_buddy_web/core/common/entities/user_entity/user_entity.dart';
import 'package:bookie_buddy_web/core/constants/enums/shop_based_enums.dart';
import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/theme/app_text_styles.dart';
import 'package:bookie_buddy_web/features/auth/presentation/bloc/user_cubit/user_cubit.dart';
import 'package:bookie_buddy_web/features/tax_and_compliance/presentation/cubit/tax_and_compliance_cubit.dart';
import 'package:bookie_buddy_web/features/tax_and_compliance/presentation/pages/tax_and_compliance_screen.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Settings hub. Currently hosts Tax & Compliance; more settings sections
/// (shop details, password, notifications, etc.) can be added as further
/// [_SettingsGroup]s later.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<UserCubit, UserEntity?>(
        builder: (context, user) {
          final canManageTax = user?.shopDetails.shopRole != ShopRole.staff;
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
                    _SettingsGroup(
                      title: 'Business',
                      children: [
                        _SettingsTile(
                          icon: Icons.percent_rounded,
                          iconColor: AppColors.purple,
                          iconBackground: AppColors.purpleLight,
                          title: 'Tax & Compliance',
                          subtitle: 'Manage tax rules applied to this shop',
                          onTap: () async {
                            final userCubit = context.read<UserCubit>();
                            final hasChanges = await context.push<bool>(
                              BlocProvider(
                                create: (context) => TaxAndComplianceCubit(
                                  getTaxConfigurations: getIt(),
                                  createTaxConfiguration: getIt(),
                                  updateTaxConfiguration: getIt(),
                                )..loadTaxConfigurations(),
                                child: TaxAndComplianceScreen(
                                  canManage: canManageTax,
                                ),
                              ),
                            );
                            // Booking/sales screens read tax config off the
                            // cached UserCubit.shopDetails snapshot, so a
                            // rule created/edited/toggled here won't be seen
                            // by them until that snapshot is refetched.
                            if (hasChanges ?? false) {
                              await userCubit.loadUserData();
                            }
                          },
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

class _SettingsGroup extends StatelessWidget {
  const _SettingsGroup({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 10),
          child: Text(
            title.toUpperCase(),
            style: AppTextStyles.subheading.copyWith(
              color: AppColors.grey600,
              letterSpacing: 0.6,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.greyBorder),
            boxShadow: [AppColors.softShadow],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              for (var i = 0; i < children.length; i++) ...[
                if (i > 0) Divider(height: 1, color: AppColors.greyBorder),
                children[i],
              ],
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        mouseCursor: SystemMouseCursors.click,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconBackground,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTextStyles.subheading),
                    const SizedBox(height: 2),
                    Text(subtitle, style: AppTextStyles.bodySecondary),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: AppColors.grey400,
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
