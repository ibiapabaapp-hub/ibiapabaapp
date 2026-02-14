import 'package:ibiapabaapp/features/auth/domain/entities/check_availability.dart';

class CheckAvailabilityParser {
  static CheckAvailability fromJson(Map<String, dynamic> json) {
    return CheckAvailability(
      field: json['field'] as String,
      value: json['value'] as String,
      available: json['available'] as bool,
    );
  }
}
