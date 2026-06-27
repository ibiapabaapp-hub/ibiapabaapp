import 'package:json_annotation/json_annotation.dart';
import 'package:ibiapabaapp/shared/models/gender.dart';

class GenderConverter implements JsonConverter<Gender, String> {
  const GenderConverter();

  @override
  Gender fromJson(String json) {
    return Gender.fromString(json);
  }

  @override
  String toJson(Gender object) {
    return object.value;
  }
}
