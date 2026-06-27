enum CategoryEntity {
  city,
  business,
  event;

  String get name {
    switch (this) {
      case CategoryEntity.city:
        return 'city';
      case CategoryEntity.business:
        return 'business';
      case CategoryEntity.event:
        return 'event';
    }
  }
}
