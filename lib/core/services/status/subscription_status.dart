enum SubscriptionStatus { active, expired, cancelled, demo }

extension SubscriptionStatusExt on SubscriptionStatus {
  String get name => toString().split('.').last;

  static SubscriptionStatus fromString(String value) {
    return SubscriptionStatus.values.firstWhere(
      (e) => e.name.toLowerCase() == value.toLowerCase(),
      orElse: () => SubscriptionStatus.active,
    );
  }
}
