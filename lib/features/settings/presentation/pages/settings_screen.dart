import 'package:bookie_buddy_web/core/constants/enums/shop_based_enums.dart';
import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/features/auth/domain/usecases/change_account_password_usecase.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/view_model/user_cubit.dart';
import 'package:bookie_buddy_web/features/auth/presentation/pages/reset_password_screen.dart';
import 'package:bookie_buddy_web/features/auth/presentation/bloc/reset_password_bloc/reset_password_bloc.dart';
import 'package:bookie_buddy_web/features/profile/presentation/widgets/custom_profile_tile.dart';
import 'package:bookie_buddy_web/features/settings/presentation/bloc/manage_password_settings_bloc/manage_password_settings_bloc.dart';
import 'package:bookie_buddy_web/features/settings/presentation/bloc/add_button_default_action_cubit/add_button_default_action_cubit.dart';
import 'package:bookie_buddy_web/features/settings/presentation/bloc/product_reserve_days_cubit/product_reserve_days_cubit.dart';
import 'package:bookie_buddy_web/features/settings/presentation/pages/manage_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    // final shopRole = user?.shopRole ?? ShopRole.staff;
    // final isOwner = shopRole.isOwner;
    // final isCustomWorkFeatureEnabled = user?.hasFeature(
    //       AppPremiumFeatures.customizationWork,
    //     ) ??
    //     false;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) {
            final initialCoolingDays =
                user?.shopSettings.coolingPeriodDuration ?? 0;
            return ProductReserveDaysCubit(
              updateShopSettings: getIt.get(),
              initialDays: initialCoolingDays,
            );
          },
        ),
        BlocProvider(
          create: (_) {
            final action = user?.shopSettings.addButtonDefaultAction ??
                AddButtonDefaultAction.booking;
            return AddButtonDefaultActionCubit(
              initialAction: action,
              updateShopSettings: getIt.get(),
            );
          },
        ),
      ],
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(title: const Text('Settings')),
          body: ListView(
            padding: 12.padding,
            children: [
              CustomProfileTile(
                icon: Icons.password,
                title: 'Change Account Password',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BlocProvider(
                            create: (context) => ResetPasswordBloc(
                              changePassword:
                                  getIt<ChangeAccountPasswordUseCase>(),
                            ),
                            child: const ResetPasswordScreen(),
                          )));
                },
              ),
              5.height,
//               if (shopRole.isOwner)
//                 CustomProfileTile(
//                   icon: Icons.lock_person_outlined,
//                   title: 'Change Secret Password',
//                   // onTap: () =>
//                   //     context.pushNamed(AppRoutes.changeSecretPassword.name),
//                   onTap: () {
//   Navigator.of(context).push(
//     MaterialPageRoute(
//       builder: (_) => BlocProvider(
//           create: (context) => SecretPasswordBloc(repository: getIt.get()),
//           child: const ChangeSecretPasswordScreen(),
//         ),
//     ),
//   );
// }

//                 ),
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
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) =>
                          ManagePasswordSettingsBloc(getIt.get())
                            ..add(ManagePasswordSettingsEvent.load(
                                passwordSettings ?? [])),
                      child: const ManagePasswordScreen(),
                    ),
                  ));
                },
              ),
              // 10.height,
              // SettingsProductReserveDaySection(isOwner: isOwner),
              // 10.height,
              // SettingsAddButtonDefaultActionSection(
              //   isOwner: isOwner,
              //   isCustomWorkFeatureEnabled: isCustomWorkFeatureEnabled,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
