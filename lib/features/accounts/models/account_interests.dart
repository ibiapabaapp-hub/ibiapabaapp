class Interest {
  const Interest({required this.id, required this.name});

  final String id;
  final String name;

  factory Interest.fromJson(Map<String, dynamic> json) {
    return Interest(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
    );
  }

  static Map<String, dynamic> toMap(Interest interest) => {
    'id': interest.id,
    'name': interest.name,
  };
}

class AccountInterests {
  final List<Interest> businesses;
  final List<Interest> events;

  AccountInterests({required this.businesses, required this.events});

  factory AccountInterests.empty() {
    return AccountInterests(businesses: [], events: []);
  }
}
