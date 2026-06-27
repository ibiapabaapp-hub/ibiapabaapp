import 'package:ibiapabaapp/shared/models/city.dart';

enum BusinessDataStatus { initial, responding, completed, error }

class BusinessDataState {
  final BusinessDataStatus status;
  final List<City> cities;
  final String? errorMessage;

  BusinessDataState({
    this.errorMessage,
    required this.status,
    required this.cities,
  });

  factory BusinessDataState.initial({List<City>? cities}) => BusinessDataState(
    status: BusinessDataStatus.initial,
    cities: cities ?? [],
  );

  BusinessDataState copyWith({
    BusinessDataStatus? status,
    List<City>? cities,
    String? errorMessage,
    bool clearError = false,
  }) {
    return BusinessDataState(
      status: status ?? this.status,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      cities: cities ?? this.cities,
    );
  }
}
