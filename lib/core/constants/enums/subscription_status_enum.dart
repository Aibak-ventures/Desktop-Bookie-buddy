enum SubscriptionStatus {
  active('active'),
  cancelled('cancelled'),
  suspended('suspended'),
  expired('expired');

  final String value;

  const SubscriptionStatus(this.value);

  static SubscriptionStatus fromJson(String? json) {
    if (json == null) return expired;
    return SubscriptionStatus.values.firstWhere(
      (e) => e.value == json,
      orElse: () => SubscriptionStatus.expired,
    );
  }

  static String toJson(SubscriptionStatus status) => status.value;

  bool get isActive => this == active;
  bool get isCancelled => this == cancelled;
  bool get isSuspended => this == suspended;
  bool get isExpired => this == expired;
}
