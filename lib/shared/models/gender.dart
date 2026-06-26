// ignore_for_file: constant_identifier_names

enum Gender {
  male,
  female,
  non_binary,
  prefer_not_to_say;

  String get value {
    switch (this) {
      case Gender.male:
        return 'male';
      case Gender.female:
        return 'female';
      case Gender.non_binary:
        return 'non_binary';
      case Gender.prefer_not_to_say:
        return 'prefer_not_to_say';
    }
  }

  static Gender fromString(String value) {
    switch (value.toLowerCase()) {
      case 'male':
        return Gender.male;
      case 'female':
        return Gender.female;
      case 'non_binary':
        return Gender.non_binary;
      case 'prefer_not_to_say':
        return Gender.prefer_not_to_say;
      default:
        throw ArgumentError('Invalid gender: $value');
    }
  }
}
