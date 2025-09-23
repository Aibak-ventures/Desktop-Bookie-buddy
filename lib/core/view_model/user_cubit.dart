import 'dart:developer';

import 'package:bookie_buddy_web/core/app_dependencies.dart';
import 'package:bookie_buddy_web/core/models/user_model/user_model.dart';
import 'package:bookie_buddy_web/core/repositories/user_repository.dart';
import 'package:bookie_buddy_web/core/storage/shared_preference_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserModel?> {
  final UserRepository _repository = getIt.get<UserRepository>();
  UserCubit() : super(null);

  Future<void> loadUserData() async {
    try {
      final user = await _repository.fetchUserData();

      if (user.shopId != null)
        await SharedPreferenceHelper.setShopId(user.shopId!);
      emit(user);
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
    }
  }

  Future<void> loadUserIfNot() async {
    if (state == null) {
      await loadUserData();
    }
  }

  Future<void> logOut() async {
    try {
      await _repository.logOut();
      emit(null);
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
    }
  }
}
