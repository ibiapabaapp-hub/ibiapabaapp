enum EntityType {
  city,
  event,
  business;

  String get pathSegment {
    switch (this) {
      case EntityType.city:
        return 'cities';
      case EntityType.event:
        return 'events';
      case EntityType.business:
        return 'businesses';
    }
  }
}
