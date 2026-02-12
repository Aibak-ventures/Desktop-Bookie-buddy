import 'dart:developer';

import 'package:bookie_buddy_web/core/enums/secret_password_locations_enum.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_button.dart';
import 'package:bookie_buddy_web/core/view_model/user_cubit.dart';
import 'package:bookie_buddy_web/features/settings/view_models/bloc_manage_password_settings/manage_password_settings_bloc.dart';
import 'package:bookie_buddy_web/features/settings/views/widgets/manage_password_settings_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ManagePasswordScreen extends StatelessWidget {
  const ManagePasswordScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final userState = context.read<UserCubit>().state;
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Secret Password')),
      body: BlocListener<ManagePasswordSettingsBloc, ManagePasswordSettingsState>(
        listenWhen: (p, c) =>
            p.status != c.status &&
            (c.status == ManagePwdSettingsStatus.success ||
                c.status == ManagePwdSettingsStatus.failure),
        listener: (context, state) {
          if (state.status == ManagePwdSettingsStatus.failure &&
              state.error != null) {
            log('Manage Password Settings Failure: ${state.error}');
            context.showSnackBar(state.error!, isError: true);
          } else if (state.status == ManagePwdSettingsStatus.success) {
            context.read<UserCubit>().loadUserData();
            log('Manage Password Settings Success: ${state.message}');
            NavigatorX(context)
              
              .pop();
            if (state.message != null) {
              context.showSnackBar(state.message!);
            }
          }
        },
        child: Padding(
          padding: 12.padding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ListView(
                  children: [
                    const _BannerGuidance(),
                    BlocBuilder<
                      ManagePasswordSettingsBloc,
                      ManagePasswordSettingsState
                    >(
                      buildWhen: (p, c) => p.settings != c.settings,
                      builder: (context, state) {
                        final list = state.settings.isEmpty
                            ? state.original
                            : state.settings;
                        return list.isEmpty
                            ? SizedBox(
                                height: 0.4.heightR,
                                child: const Center(
                                  child: Text('No Password Settings'),
                                ),
                              )
                            : Column(
                                children: list
                                    .where(
                                      (e) => //C
                                          e.location !=
                                          SecretPasswordLocations
                                              .monthlyGrossView,
                                    )
                                    .map(
                                      (setting) => ManagePasswordSettingsTile(
                                        setting: setting,
                                        isEnabled:
                                            userState?.shopRole?.isOwner ??
                                            false,
                                        onChanged: (newVal) {
                                          if (newVal != null) {
                                            context
                                                .read<
                                                  ManagePasswordSettingsBloc
                                                >()
                                                .add(
                                                  ManagePasswordSettingsEvent.updateRole(
                                                    newRole: newVal,
                                                    target: setting,
                                                  ),
                                                );
                                          }
                                        },
                                      ),
                                    )
                                    .toList(),
                              );
                      },
                    ),
                  ],
                ),
              ),
              if (userState?.shopRole?.isOwner ?? false)
                BlocBuilder<
                  ManagePasswordSettingsBloc,
                  ManagePasswordSettingsState
                >(
                  buildWhen: (p, c) =>
                      p.status != c.status || p.hasChanges != c.hasChanges,
                  builder: (context, state) {
                    final hasChanges = state.hasChanges;
                    final isSaving =
                        state.status == ManagePwdSettingsStatus.saving;
                    final canSave = hasChanges && !isSaving;
                    return Padding(
                      padding: 10.paddingVertical,
                      child: Opacity(
                        opacity: canSave ? 1.0 : 0.6,
                        child: CustomElevatedButton(
                          text: hasChanges
                              ? (isSaving ? 'Saving...' : 'Save Changes')
                              : 'No Changes',
                          isLoading: isSaving,
                          onPressed: () {
                            if (!canSave) return; // guard
                            context.read<ManagePasswordSettingsBloc>().add(
                              const ManagePasswordSettingsEvent.save(),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BannerGuidance extends StatelessWidget {
  const _BannerGuidance();

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.w),
    margin: EdgeInsets.only(bottom: 14.h),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: 10.radiusBorder,
      border: Border.all(color: Colors.blueGrey.shade100),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 4.r,
          offset: Offset(0, 2.h),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.info_outline, size: 20.sp, color: Colors.blueGrey),
        8.width,
        Expanded(
          child: Text(
            'Set which roles can use the secret password for restricted actions.\n'
            '• Grant access only to trusted roles (e.g., Staff, Manager, Owner).\n'
            '• Used to quickly approve protected actions (like edits or overrides).\n'
            '• You can change these permissions anytime; updates apply immediately.',
            style: TextStyle(fontSize: 13.sp, height: 1.3),
          ),
        ),
      ],
    ),
  );
}
