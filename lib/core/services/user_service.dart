import 'dart:developer';

import 'package:bookie_buddy_web/config/dio_client/dio_config.dart';
import 'package:bookie_buddy_web/core/models/user_model/user_model.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_snack_bar.dart';

class UserService {
  Future<UserModel> fetchUserData() async {
    try {
      // final response = await DioClient.dio.get("/api/profile");
      final response = await DioClient.dio.get("/api/v3/auth/profile/");
      log('status code: ${response.statusCode}, data: ${response.data}');
      if (response.statusCode == 200) {
        return UserModel.fromJson(
          response.data['user'] == null ? response.data : response.data['user'],
        );
      } else {
        CustomSnackBar(
          message: response.data['error'] ??
              response.data['message'] ??
              'Failed to fetch user',
        );
        throw 'Failed to fetch user: ${response.data}';
      }
    } catch (e, stack) {
      log('Error in userLogin: $e', stackTrace: stack);
      rethrow;
    }
  }
}
