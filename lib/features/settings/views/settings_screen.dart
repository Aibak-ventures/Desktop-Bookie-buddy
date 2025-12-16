import 'package:booking_application/core/app_dependencies.dart';
import 'package:booking_application/core/enums/shop_based_enums.dart';
import 'package:booking_application/core/extensions/context_extensions.dart';
import 'package:booking_application/core/extensions/number_extensions.dart';
import 'package:booking_application/core/navigation/app_routes.dart';
import 'package:booking_application/core/view_model/user_cubit.dart';
import 'package:booking_application/features/profile/view/widgets/custom_profile_tile.dart';
import 'package:booking_application/features/settings/view_models/cubit_add_button_default_action/add_button_default_action_cubit.dart';
import 'package:booking_application/features/settings/view_models/cubit_product_reserve_days/product_reserve_days_cubit.dart';
import 'package:booking_application/features/settings/views/widgets/settings_add_button_default_action_section.dart';
import 'package:booking_application/features/settings/views/widgets/settings_product_reserve_day_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final userCubit = context.read<UserCubit>();
    final user = userCubit.state;
    final shopRole = user?.shopRole ?? ShopRole.staff;
    final isOwner = shopRole.isOwner;
    final isCustomWorkFeatureEnabled = userCubit.hasFeature(
      AppPremiumFeatures.customizationWork,
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) {
            final initialCoolingDays =
                user?.shopSettings.coolingPeriodDuration ?? 0;
            return ProductReserveDaysCubit(
              repository: getIt.get(),
              initialDays: initialCoolingDays,
            );
          },
        ),
        BlocProvider(
          create: (_) {
            final action = user?.shopSettings.addButtonDefaultAction;
            return AddButtonDefaultActionCubit(
              initialAction: action ?? AddButtonDefaultAction.booking,
              repository: getIt.get(),
            );
          },
        ),
      ],

      child: Scaffold(
        appBar: AppBar(title: const Text('Settings')),
        body: ListView(
          padding: 12.padding,
          children: [
            CustomProfileTile(
              icon: Icons.password,
              title: 'Change Account Password',
              onTap: () =>
                  context.pushNamed(AppRoutes.changeAccountPassword.name),
            ),
            5.height,
            if (shopRole.isOwner)
              CustomProfileTile(
                icon: Icons.lock_person_outlined,
                title: 'Change Secret Password',
                onTap: () =>
                    context.pushNamed(AppRoutes.changeSecretPassword.name),
              ),
            5.height,
            CustomProfileTile(
              icon: Icons.key_rounded,
              title: 'Manage Secret Password',
              onTap: () {
                final passwordSettings = user?.passwordSettings;
                if (passwordSettings?.isEmpty ?? true) {
                  context.showSnackBar('No password settings available');
                  return;
                }
                context.pushNamed(
                  AppRoutes.manageSecretPassword.name,
                  extra: passwordSettings,
                );
              },
            ),
            10.height,
            SettingsProductReserveDaySection(isOwner: isOwner),
            10.height,
            SettingsAddButtonDefaultActionSection(
              isOwner: isOwner,
              isCustomWorkFeatureEnabled: isCustomWorkFeatureEnabled,
            ),
          ],
        ),
      ),
    );
  }
}
