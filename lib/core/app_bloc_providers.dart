import 'package:bookie_buddy_web/features/auth/view_model/bloc_auth/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocProviders {
  static List<BlocProvider> providers = [
    BlocProvider(
      create: (context) => AuthBloc(),
    ),
  ];
}
