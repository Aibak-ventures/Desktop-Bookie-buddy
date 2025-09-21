class LoginRequest {
  final String phone;
  final String password;

  const LoginRequest({
    required this.phone,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'password': password,
    };
  }
}

class LoginResponse {
  final String status;
  final String message;
  final LoginData data;
  final String? devMessage;

  const LoginResponse({
    required this.status,
    required this.message,
    required this.data,
    this.devMessage,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: LoginData.fromJson(json['data'] ?? {}),
      devMessage: json['dev_message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.toJson(),
      'dev_message': devMessage,
    };
  }
}

class LoginData {
  final String access;
  final String refresh;

  const LoginData({
    required this.access,
    required this.refresh,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      access: json['access'] ?? '',
      refresh: json['refresh'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access': access,
      'refresh': refresh,
    };
  }
}

class RefreshTokenRequest {
  final String refresh;

  const RefreshTokenRequest({
    required this.refresh,
  });

  Map<String, dynamic> toJson() {
    return {
      'refresh': refresh,
    };
  }
}

class RefreshTokenResponse {
  final String access;

  const RefreshTokenResponse({
    required this.access,
  });

  factory RefreshTokenResponse.fromJson(Map<String, dynamic> json) {
    return RefreshTokenResponse(
      access: json['access'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access': access,
    };
  }
}

class ChangePasswordRequest {
  final String oldPassword;
  final String newPassword;
  final bool logoutFromAllDevices;

  const ChangePasswordRequest({
    required this.oldPassword,
    required this.newPassword,
    required this.logoutFromAllDevices,
  });

  Map<String, dynamic> toJson() {
    return {
      'old_password': oldPassword,
      'new_password': newPassword,
      'logout_from_all_devices': logoutFromAllDevices,
    };
  }
}

class SecretLoginRequest {
  final String password;

  const SecretLoginRequest({
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'password': password,
    };
  }
}

class SecretLoginResponse {
  final bool success;
  final String message;

  const SecretLoginResponse({
    required this.success,
    required this.message,
  });

  factory SecretLoginResponse.fromJson(Map<String, dynamic> json) {
    return SecretLoginResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
    };
  }
}

class ApiErrorResponse {
  final String? error;
  final String? message;
  final Map<String, dynamic>? details;

  const ApiErrorResponse({
    this.error,
    this.message,
    this.details,
  });

  factory ApiErrorResponse.fromJson(Map<String, dynamic> json) {
    return ApiErrorResponse(
      error: json['error'],
      message: json['message'],
      details: json['details'],
    );
  }

  String get errorMessage {
    return error ?? message ?? 'An unexpected error occurred';
  }
}
