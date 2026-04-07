import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/check_availability.dart';

part 'check_availability_model.freezed.dart';
part 'check_availability_model.g.dart';

@freezed
abstract class CheckAvailabilityModel
    with _$CheckAvailabilityModel
    implements CheckAvailability {
  const factory CheckAvailabilityModel({
    @JsonKey(
      fromJson: _availabilityFieldFromApi,
      toJson: _availabilityFieldToApi,
    )
    required AvailabilityField field,
    required String value,
    required bool available,
  }) = _CheckAvailabilityModel;

  factory CheckAvailabilityModel.fromJson(Map<String, dynamic> json) =>
      _$CheckAvailabilityModelFromJson(json);
}

AvailabilityField _availabilityFieldFromApi(String value) =>
    AvailabilityField.fromApi(value);
String _availabilityFieldToApi(AvailabilityField field) => field.value;
