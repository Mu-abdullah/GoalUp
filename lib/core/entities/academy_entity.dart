import '../services/status/subscription_status.dart';

class AcademyEntity {
  final String? id;
  final String? name;
  final String? logo;
  final String? city;
  final String? activeTo;
  final SubscriptionStatus? subscriptionStatus;
  AcademyEntity({
    this.subscriptionStatus,
    this.activeTo,
    this.id,
    this.name,
    this.logo,
    this.city,
  });
}
