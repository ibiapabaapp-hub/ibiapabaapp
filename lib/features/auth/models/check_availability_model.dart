import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'check_availability.dart';

part 'check_availability_model.g.dart';

@JsonSerializable()
class CheckAvailabilityModel extends Equatable implements CheckAvailability {
  @JsonKey(
    fromJson: _availabilityFieldFromApi,
    toJson: _availabilityFieldToApi,
  )
  @override
  final AvailabilityField field;

  @override
  final String value;

  @override
  final bool available;

  const CheckAvailabilityModel({
    required this.field,
    required this.value,
    required this.available,
  });

  factory CheckAvailabilityModel.fromJson(Map<String, dynamic> json) =>
      _$CheckAvailabilityModelFromJson(json);

  Map<String, dynamic> toJson() => _$CheckAvailabilityModelToJson(this);

  @override
  List<Object?> get props => [field, value, available];
}

AvailabilityField _availabilityFieldFromApi(String value) =>
    AvailabilityField.fromApi(value);
String _availabilityFieldToApi(AvailabilityField field) => field.value;
