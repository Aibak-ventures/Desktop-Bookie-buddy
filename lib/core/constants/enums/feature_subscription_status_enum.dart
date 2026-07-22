enum FeatureSubscriptionStatus {
  active('active'),
  expired('expired');

  final String value;

  const FeatureSubscriptionStatus(this.value);

  static FeatureSubscriptionStatus fromJson(String? json) {
    if (json == null) return expired;
    return FeatureSubscriptionStatus.values.firstWhere(
      (e) => e.value == json,
      orElse: () => FeatureSubscriptionStatus.expired,
    );
  }

  static String toJson(FeatureSubscriptionStatus status) => status.value;

  bool get isActive => this == active;
  bool get isExpired => this == expired;
}
