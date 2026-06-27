import 'package:acanthis/acanthis.dart';

class FieldRefinement<T extends Enum> {
  final bool Function(Map<String, dynamic> data) validator;
  final String message;
  final T field;

  FieldRefinement({
    required this.validator,
    required this.message,
    required this.field,
  });
}

abstract class BaseValidator<T extends Enum> {
  final Map<T, AcanthisType> fields;
  final List<FieldRefinement<T>> refinements;
  BaseValidator({required this.fields, this.refinements = const []});

  late final AcanthisMap schema = _buildSchema();

  AcanthisMap _buildSchema() {
    var objectSchema = object(
      fields.map((key, value) => MapEntry(key.name, value)),
    );

    for (var ref in refinements) {
      objectSchema =
          objectSchema.refine(
                onCheck: (data) => ref.validator(data),
                error: ref.message,
                name: ref.field.name,
              )
              as AcanthisMap;
    }

    return objectSchema;
  }

  bool isFieldValid(T field, dynamic value) {
    final fieldSchema = fields[field];
    if (fieldSchema == null) return false;
    return fieldSchema.tryParse(value).success;
  }

  String? validateField(T field, dynamic value) {
    final fieldSchema = fields[field];
    if (fieldSchema == null) return null;

    final result = fieldSchema.tryParse(value);

    if (!result.success && result.errors.isNotEmpty) {
      return result.errors.values.first;
    }
    return null;
  }

  bool validateAll(Map<String, dynamic> data) {
    return schema.parse(data).success;
  }
}

extension AcanthisStringTrim on AcanthisString {
  AcanthisString trim() {
    return transform((value) => value.trim()) as AcanthisString;
  }
}
