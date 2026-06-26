import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:ibiapabaapp/features/auth/validation/auth_validator.dart';

class NameField extends ConsumerWidget {
  final FTextFieldControl nameControl;
  const NameField({super.key, required this.nameControl});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authValidator = ref.watch(authValidatorProvider);
    return FTextFormField(
      label: const Text('Nome'),
      control: nameControl,
      hint: 'Seu nome e sobrenome',
      autovalidateMode: AutovalidateMode.onUnfocus,
      validator: (v) => authValidator.validateField(AuthFields.name, v),
    );
  }
}
