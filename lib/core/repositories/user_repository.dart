import 'dart:developer';

import 'package:bookie_buddy_web/core/models/user_model/user_model.dart';
import 'package:bookie_buddy_web/core/services/auth_service.dart';
import 'package:bookie_buddy_web/core/services/user_service.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UserRepository {
  final UserService _userService;

  UserRepository(
    this._userService,
  );

  Future<UserModel> fetchUserData() async {
    try {
      return await _userService.fetchUserData();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logOut() async {
    try {
      await AuthService.clearUserSession();

      // await SharedPreferenceHelper.clearAll();
      await CachedNetworkImageProvider.defaultCacheManager.emptyCache();
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
    }
  }
}
