class Favorite {
  final String? id;
  final String accountId;
  final String? cityId;
  final String? eventId;
  final String? businessId;

  Favorite({
    this.id,
    required this.accountId,
    required this.cityId,
    required this.eventId,
    required this.businessId,
  });
}
