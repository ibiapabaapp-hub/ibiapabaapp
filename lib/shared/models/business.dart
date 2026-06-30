enum ReachLevel { local, regional }

class Business {
  final String id;
  final String name;
  final String slug;
  final String? bio;
  final String? avatar;
  final ReachLevel maxReachLevel;
  final List<String> tags;
  final DateTime createdAt;

  Business({
    required this.id,
    required this.slug,
    required this.name,
    this.bio,
    this.avatar,
    required this.maxReachLevel,
    required this.tags,
    required this.createdAt,
  });
}
