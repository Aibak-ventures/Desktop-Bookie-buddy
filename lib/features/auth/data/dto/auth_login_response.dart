import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_login_response.freezed.dart';
part 'auth_login_response.g.dart';

@freezed
class AuthLoginResponse with _$AuthLoginResponse {
  const factory AuthLoginResponse({
    required String status,
    required String message,
    required AuthLoginData data,
    @Default('') String devMessage,
  }) = _AuthLoginResponse;

  factory AuthLoginResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthLoginResponseFromJson(json);
}

@freezed
class AuthLoginData with _$AuthLoginData {
  const factory AuthLoginData({
    required String refresh,
    required String access,
  }) = _AuthLoginData;

  factory AuthLoginData.fromJson(Map<String, dynamic> json) =>
      _$AuthLoginDataFromJson(json);
}
