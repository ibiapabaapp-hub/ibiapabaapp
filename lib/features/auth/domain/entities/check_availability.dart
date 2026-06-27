class CheckAvailability {
  final AvailabilityField field;
  final String value;
  final bool available;

  const CheckAvailability({
    required this.available,
    required this.field,
    required this.value,
  });
}

enum AvailabilityField {
  slug,
  email,
  phoneNumber;

  String get value {
    switch (this) {
      case AvailabilityField.slug:
        return 'slug';
      case AvailabilityField.email:
        return 'email';
      case AvailabilityField.phoneNumber:
        return 'phone_number';
    }
  }

  static AvailabilityField fromApi(String value) {
    switch (value) {
      case 'slug':
        return AvailabilityField.slug;
      case 'email':
        return AvailabilityField.email;
      case 'phone_number':
        return AvailabilityField.phoneNumber;
      default:
        throw ArgumentError('Unknown AvailabilityField: $value');
    }
  }
}