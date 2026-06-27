enum AccountType {
  personal,
  business;

  String get value {
    switch (this) {
      case AccountType.personal:
        return 'personal';
      case AccountType.business:
        return 'business';
    }
  }

  static AccountType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'personal':
        return AccountType.personal;
      case 'business':
        return AccountType.business;
      default:
        throw ArgumentError('Invalid account type: $value');
    }
  }
}
