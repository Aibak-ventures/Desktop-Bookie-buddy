import 'package:bookie_buddy_web/core/app_dependencies.dart';
import 'package:bookie_buddy_web/core/enums/shop_based_enums.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/models/user_model/user_model.dart';
import 'package:bookie_buddy_web/core/navigation/app_routes.dart';
import 'package:bookie_buddy_web/core/repositories/auth_repository.dart';
import 'package:bookie_buddy_web/core/view_model/user_cubit.dart';
import 'package:bookie_buddy_web/features/change_password/repository/change_password_repository.dart';
import 'package:bookie_buddy_web/features/change_password/view/change_secret_password_screen.dart';
import 'package:bookie_buddy_web/features/change_password/view/reset_password_screen.dart';
import 'package:bookie_buddy_web/features/change_password/view_model/bloc_reset_password/reset_password_bloc.dart';
import 'package:bookie_buddy_web/features/change_password/view_model/bloc_secret_password/secret_password_bloc.dart';
import 'package:bookie_buddy_web/features/profile/view/widgets/custom_profile_tile.dart';
import 'package:bookie_buddy_web/features/settings/view_models/bloc_manage_password_settings/manage_password_settings_bloc.dart';
import 'package:bookie_buddy_web/features/settings/view_models/cubit_add_button_default_action/add_button_default_action_cubit.dart';
import 'package:bookie_buddy_web/features/settings/view_models/cubit_product_reserve_days/product_reserve_days_cubit.dart';
import 'package:bookie_buddy_web/features/settings/views/manage_password_screen.dart';
import 'package:bookie_buddy_web/features/settings/views/widgets/settings_add_button_default_action_section.dart';
import 'package:bookie_buddy_web/features/settings/views/widgets/settings_product_reserve_day_section.dart';
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
    final isCustomWorkFeatureEnabled = user?.hasFeature(
          AppPremiumFeatures.customizationWork,
        ) ??
        false;

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
            final action = user?.shopSettings.addButtonDefaultAction ??
                AddButtonDefaultAction.booking;
            return AddButtonDefaultActionCubit(
              initialAction: action,
              repository: getIt.get(),
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
                onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BlocProvider(
          create: (context) => ResetPasswordBloc(
          authRepository: getIt<AuthRepository>(),
          changePasswordRepository: getIt<ChangePasswordRepository>(),
          ),
          child: const ResetPasswordScreen(),
        )));
                  },
              ),
              5.height,
              // if (shopRole.isOwner)
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
                    builder: (context) =>BlocProvider(
            create: (context) => ManagePasswordSettingsBloc(getIt.get())
              ..add(ManagePasswordSettingsEvent.load(passwordSettings ?? [])),
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
