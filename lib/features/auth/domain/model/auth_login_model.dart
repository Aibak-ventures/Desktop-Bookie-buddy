import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_login_model.freezed.dart';
part 'auth_login_model.g.dart';

@freezed
class AuthLoginModel with _$AuthLoginModel {
  const factory AuthLoginModel({
    required String phone,
    required String password,
    @Default('fcm_device_token_123456') String deviceToken,
    @Default('android') String platform,
  }) = _AuthLoginModel;

  factory AuthLoginModel.fromJson(Map<String, dynamic> json) =>
      _$AuthLoginModelFromJson(json);
}
