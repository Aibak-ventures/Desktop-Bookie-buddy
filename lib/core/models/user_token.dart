class UserToken {
  final String accessToken;
  final String refreshToken;
  final DateTime expiresAt;
  final String tokenType;

  const UserToken({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAt,
    this.tokenType = 'Bearer',
  });

  /// Check if the access token is expired
  bool get isExpired {
    return DateTime.now().isAfter(expiresAt.subtract(const Duration(minutes: 5)));
  }

  /// Check if the access token is still valid
  bool get isValid {
    return !isExpired;
  }

  /// Get the authorization header value
  String get authorizationHeader {
    return '$tokenType $accessToken';
  }

  /// Create UserToken from JSON
  factory UserToken.fromJson(Map<String, dynamic> json) {
    return UserToken(
      accessToken: json['access_token'] ?? json['accessToken'] ?? '',
      refreshToken: json['refresh_token'] ?? json['refreshToken'] ?? '',
      expiresAt: DateTime.fromMillisecondsSinceEpoch(
        (json['expires_at'] ?? json['expiresAt'] ?? 0) * 1000,
      ),
      tokenType: json['token_type'] ?? json['tokenType'] ?? 'Bearer',
    );
  }

  /// Convert UserToken to JSON
  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'expires_at': expiresAt.millisecondsSinceEpoch ~/ 1000,
      'token_type': tokenType,
    };
  }

  /// Create a copy with updated values
  UserToken copyWith({
    String? accessToken,
    String? refreshToken,
    DateTime? expiresAt,
    String? tokenType,
  }) {
    return UserToken(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      expiresAt: expiresAt ?? this.expiresAt,
      tokenType: tokenType ?? this.tokenType,
    );
  }

  @override
  String toString() {
    return 'UserToken(accessToken: ${accessToken.length > 10 ? '${accessToken.substring(0, 10)}...' : accessToken}, refreshToken: ${refreshToken.length > 10 ? '${refreshToken.substring(0, 10)}...' : refreshToken}, expiresAt: $expiresAt, tokenType: $tokenType)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserToken &&
        other.accessToken == accessToken &&
        other.refreshToken == refreshToken &&
        other.expiresAt == expiresAt &&
        other.tokenType == tokenType;
  }

  @override
  int get hashCode {
    return accessToken.hashCode ^
        refreshToken.hashCode ^
        expiresAt.hashCode ^
        tokenType.hashCode;
  }
}
