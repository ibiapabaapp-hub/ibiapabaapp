import 'package:acanthis/acanthis.dart' as acanthis;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:ibiapabaapp/core/validation/base_validator.dart';

enum AuthFields {
  name,
  email,
  username,
  password,
  confirmPassword,
  birthDate,
  phoneNumber,
}

class AuthValidator extends BaseValidator<AuthFields> {
  final String countryCode;
  final int minDigits;

  AuthValidator({this.countryCode = '+55', this.minDigits = 11})
    : super(
        fields: {
          // ─── name ──────────────────────────────────────────────────────────
          AuthFields.name: acanthis.string().trim().pattern(
            RegExp(r'^[A-Za-zÀ-ÖØ-öø-ÿ]+(?:[\s-][A-Za-zÀ-ÖØ-öø-ÿ]+)+$'),
            message: 'Informe seu nome e sobrenome',
          ),

          // ─── email ─────────────────────────────────────────────────────────
          AuthFields.email: acanthis.string().trim().email(
            message: 'E-mail inválido',
          ),

          // ─── username ──────────────────────────────────────────────────────
          AuthFields.username: acanthis
              .string()
              .trim()
              .min(4, message: 'Mínimo de 4 caracteres')
              .max(30, message: 'Máximo de 30 caracteres')
              .pattern(
                RegExp(r'^[a-z0-9._]+$'),
                message:
                    'Use apenas letras minúsculas, números, ponto ou underline',
              )
              // para caracteres nas extremidades
              .refine(
                onCheck: (v) =>
                    !v.startsWith('.') &&
                    !v.endsWith('.') &&
                    !v.startsWith('_') &&
                    !v.endsWith('_'),
                error: 'Não comece ou termine com "." ou "_"',
                name: 'username',
              )
              // para caracteres consecutivos
              .refine(
                onCheck: (v) =>
                    !v.contains('..') &&
                    !v.contains('__') &&
                    !v.contains('._') &&
                    !v.contains('_.'),
                error: 'Não use pontos ou underlines consecutivos',
                name: 'username',
              ),

          // ─── password ──────────────────────────────────────────────────────
          AuthFields.password: acanthis
              .string()
              .trim()
              .min(8, message: 'No mínimo 8 caracteres')
              .pattern(
                RegExp(r'[A-Z]'),
                message: 'Inclua pelo menos 1 letra maiúscula',
              )
              .pattern(RegExp(r'[0-9]'), message: 'Inclua pelo menos 1 número')
              .pattern(
                RegExp(r'[!@#$%^&*(),.?":{}|<>]'),
                message: 'Inclua um caractere especial',
              ),

          // ─── confirmPassword ───────────────────────────────────────────────
          AuthFields.confirmPassword: acanthis.string().trim(),

          // ─── birthDate ─────────────────────────────────────────────────────
          AuthFields.birthDate: acanthis
              .string()
              .trim()
              .pattern(
                RegExp(r'^\d{2}/\d{2}/\d{4}$'),
                message: 'Data inválida (DD/MM/AAAA)',
              )
              .refine(
                onCheck: (v) {
                  try {
                    final parts = v.split('/');
                    final date = DateTime(
                      int.parse(parts[2]),
                      int.parse(parts[1]),
                      int.parse(parts[0]),
                    );
                    final today = DateTime.now();
                    var age = today.year - date.year;
                    if (today.month < date.month ||
                        (today.month == date.month && today.day < date.day)) {
                      age--;
                    }
                    return age >= 16;
                  } catch (_) {
                    return false;
                  }
                },
                error: 'Você deve ter pelo menos 16 anos',
                name: 'birthDate',
              ),

          // ─── phoneNumber ───────────────────────────────────────────────────
          AuthFields.phoneNumber: acanthis
              .string()
              .trim()
              .refine(
                onCheck: (value) {
                  final digits = value.replaceAll(RegExp(r'\D'), '');
                  if (countryCode == '+55') return digits.length >= 11;
                  return digits.length >= minDigits;
                },
                error: countryCode == '+55'
                    ? 'Informe DDD + número'
                    : 'Número muito curto',
                name: 'phoneNumber',
              )
              .refine(
                onCheck: (value) {
                  final digits = value.replaceAll(RegExp(r'\D'), '');
                  final fullNumber = '$countryCode$digits';
                  return RegExp(r'^\+[1-9][0-9]{6,14}$').hasMatch(fullNumber);
                },
                error: 'Formato internacional (E.164) inválido',
                name: 'phoneNumber',
              ),
        },
        refinements: [
          // ─── comparação de senhas ──────────────────────────────────────────
          FieldRefinement(
            field: AuthFields.confirmPassword,
            message: 'As senhas não coincidem',
            validator: (data) =>
                data[AuthFields.password.name] ==
                data[AuthFields.confirmPassword.name],
          ),
        ],
      );
}

final selectedCountryProvider = StateProvider<(String, int)>(
  (ref) => ('+55', 11),
);

final authValidatorProvider = Provider<AuthValidator>((ref) {
  final (code, min) = ref.watch(selectedCountryProvider);
  return AuthValidator(countryCode: code, minDigits: min);
});
